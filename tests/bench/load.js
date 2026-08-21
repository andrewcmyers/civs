// Offer a CIVS poll a stream of votes at a fixed rate, and report how well
// it kept up.
//
// The workload is open, in the sense of Schroeder, Wierman and
// Harchol-Balter's "Open Versus Closed: A Cautionary Tale" (NSDI '06):
// voters arrive at a rate that owes nothing to how the server is coping.
// The generator waits -k*ln(U), for U drawn from [0,1), between issuing
// one request and issuing the next -- a Poisson process of rate 1/k --
// and it issues each one whether or not the ones before it have come
// back. Nothing here waits for a reply before deciding to send the next
// request. That is the whole point: a closed generator, which sends again
// only once its previous request has finished, throttles itself exactly
// when the server slows down, and so can never show a server falling
// over. This one can, and does.
//
// One rate is measured per run; run-bench walks the rate upwards across
// runs. Exit status is 0 if the poll kept up, 3 if it did not, 1 if the
// benchmark itself went wrong.
//
// Usage:
//   node load.js --url URL --id E_xxx [options]
//
//   --url URL          the vote script, e.g. http://127.0.0.1:8000/vote.pl
//   --id E_xxx         the poll to vote in
//   --akey KEY         its authorization key, if it has one
//   --rate R           arrivals per second (this is 1/k)
//   --duration SECS    how long to measure (default 20)
//   --warmup SECS      how long to run before measuring (default 3)
//   --choices N        choices per question (default 5)
//   --questions N      questions in the poll (default 1)
//   --mode MODE        vote (cast a ballot), ballot (fetch the form only),
//                      or session (fetch the form, then cast) -- default vote
//   --timeout SECS     give up on a request after this long (default 30)
//   --max-inflight N   call it over when this many are outstanding (default 512)
//   --ip-base N        first voter address, if several runs share a poll
//   --summary FILE     append one tab-separated row of results to FILE
//   --quiet            print the summary line only
//   --check            put runs already taken back through the judgement
//                      below and report whether it still calls them what
//                      they were; needs no server and votes in nothing

'use strict';

const http = require('http');
const { URL } = require('url');

const opt = {
    url: '', id: '', akey: '', rate: 10, duration: 20, warmup: 3,
    choices: 5, questions: 1, mode: 'vote', timeout: 30,
    'max-inflight': 512, 'ip-base': 0, summary: '', quiet: false, check: false,
};
for (let i = 2; i < process.argv.length; i++) {
    const name = process.argv[i].replace(/^--/, '');
    if (!(name in opt)) die(`unknown option ${process.argv[i]}`);
    if (typeof opt[name] === 'boolean') opt[name] = true;
    else if (typeof opt[name] === 'number') opt[name] = Number(process.argv[++i]);
    else opt[name] = process.argv[++i];
}
if (!opt.check && (!opt.url || !opt.id)) die('both --url and --id are needed');
if (!(opt.rate > 0)) die('--rate must be above zero');
if (!['vote', 'ballot', 'session'].includes(opt.mode)) die(`unknown mode ${opt.mode}`);

const target = opt.check ? null : new URL(opt.url);
// Each arrival is a voter turning up, so each gets a connection of its
// own rather than borrowing one that an earlier voter left open. There is
// no ceiling on how many may be open at once: an open workload that
// queued behind a socket limit would be a closed one wearing a disguise.
const agent = new http.Agent({ keepAlive: false, maxSockets: Infinity });

// The mean wait between arrivals: the k of -k*ln(U).
const k = 1 / opt.rate;

const t0 = () => Number(process.hrtime.bigint()) / 1e6;   // ms, monotonic
const started = t0();
const warmup_ends = started + opt.warmup * 1000;
const window_ends = warmup_ends + opt.duration * 1000;

let arrivals = 0;         // requests issued, warmup included
let in_flight = 0;
let max_in_flight = 0;
let over = false;         // the max-inflight ceiling was reached
const measured = [];      // { due, sent, done, ok, why }
const lags = [];          // how late each arrival was issued
const occupancy = [];     // { at, n } sampled through the run

// -- the arrival process ---------------------------------------------------

// The wait before the next arrival: -k*ln(U). U comes off Math.random(),
// which yields [0,1); it is taken from the other end so that the zero it
// can return becomes the one that ln cannot take rather than an infinite
// wait. The distribution is the same either way.
function next_wait() {
    return -k * Math.log(1 - Math.random()) * 1000;
}

let due = started;
let timer = null;

function tick() {
    const now = t0();
    // Every arrival whose moment has passed goes now. The timer's
    // millisecond granularity, and any moment this process spends busy,
    // can put several arrivals in the past at once; issuing them together
    // keeps the schedule itself exponential and honest, and the lateness
    // is recorded below rather than hidden.
    while (due <= now && !over) {
        launch(due, now - due);
        due += next_wait();
    }
    if (over || t0() >= window_ends) { finish(); return; }
    timer = setTimeout(tick, Math.max(0, due - t0()));
}

function launch(due_at, lag) {
    const n = arrivals++;
    // Warmup arrivals are made but not counted: they are there to get the
    // server's caches and the poll's data files into the state a run of
    // this length settles into.
    const counts = due_at >= warmup_ends;
    if (counts) lags.push(lag);
    in_flight++;
    if (in_flight > max_in_flight) max_in_flight = in_flight;
    if (in_flight >= opt['max-inflight'] && !over) {
        over = true;
        over_why = `${in_flight} requests outstanding at once`;
    }
    const record = { due: due_at, sent: t0(), done: 0, ok: false, why: '' };
    if (counts) measured.push(record);
    vote(n + opt['ip-base'], (ok, why) => {
        record.done = t0();
        record.ok = ok;
        record.why = why;
        in_flight--;
        if (draining && in_flight === 0) report();
    });
}

let over_why = '';
let draining = false;
// Where the measurement window actually ended. It is the window that was
// asked for, unless the run was called off early for having too much
// outstanding, in which case what was measured is the shorter stretch.
let window_end_actual = window_ends;

const sampler = setInterval(() => {
    occupancy.push({ at: t0(), n: in_flight });
}, 100);

function finish() {
    if (draining) return;
    draining = true;
    window_end_actual = Math.min(t0(), window_ends);
    if (timer) clearTimeout(timer);
    clearInterval(sampler);
    // Wait for what is still outstanding: a request that arrived inside
    // the measurement window belongs to it however late it finishes, and
    // dropping the slow ones would flatter the tail of the distribution.
    if (in_flight === 0) report();
    else setTimeout(() => { if (!reported) report(); },
                    (opt.timeout + 1) * 1000);
}

// -- one voter -------------------------------------------------------------

// Every arrival is a voter who has not been seen before, so each gets an
// address of its own. CIVS knows a public poll's voters by their address
// and turns away a second ballot from one it has already recorded, and it
// takes that address from the headers a reverse proxy would have set --
// which is what lets one machine stand in for a great many voters.
function address(n) {
    return `10.${(n >> 16) & 255}.${(n >> 8) & 255}.${n & 255}`;
}

// A ballot: every choice ranked, in an order of this voter's own, so that
// the pairwise tallies the server keeps are actually stirred rather than
// having the same entries incremented every time.
function ranking() {
    const rank = [];
    for (let i = 0; i < opt.choices; i++) rank.push(i + 1);
    for (let i = rank.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [rank[i], rank[j]] = [rank[j], rank[i]];
    }
    return rank;
}

function vote(n, done) {
    const ip = address(n);
    if (opt.mode === 'ballot') {
        get_form(ip, (ok, why) => done(ok, why));
        return;
    }
    const cast = () => cast_question(ip, 0, '', done);
    if (opt.mode === 'session') get_form(ip, (ok, why) => ok ? cast() : done(ok, why));
    else cast();
}

function get_form(ip, done) {
    const query = `id=${encodeURIComponent(opt.id)}` +
                  (opt.akey ? `&akey=${encodeURIComponent(opt.akey)}` : '');
    request('GET', `${target.pathname}?${query}`, ip, null, (err, status, body) => {
        if (err) return done(false, err);
        if (status !== 200) return done(false, `status ${status}`);
        // The ballot form, whatever language it came out in.
        if (!/name="CastVote"/.test(body)) return done(false, page_trouble(body));
        done(true, '');
    });
}

// Answer question q, then the one after it, until the ballot is done. Each
// question is a POST of its own, as it is from a browser, and the receipt
// handed back by the first carries the ballot through the rest.
function cast_question(ip, q, receipt, done) {
    const fields = { id: opt.id, akey: opt.akey, key: '', q: String(q),
                     receipt: receipt, Vote: 'Submit' };
    ranking().forEach((r, i) => { fields['C' + i] = String(r) });
    const [type, body] = multipart(fields);
    request('POST', target.pathname, ip, { type, body }, (err, status, page) => {
        if (err) return done(false, err);
        if (status !== 200) return done(false, `status ${status}`);
        if (q + 1 < opt.questions) {
            const m = page.match(/id="midvote_receipt_text">([^<]*)</);
            if (!m) return done(false, page_trouble(page));
            return cast_question(ip, q + 1, m[1], done);
        }
        // The last question answered, the server thanks the voter and
        // hands over the receipt. The element holding it is named in the
        // markup rather than in any language, so this recognizes a vote
        // that was actually recorded without reading English.
        if (!/id="final_receipt_text">/.test(page)) return done(false, page_trouble(page));
        done(true, '');
    });
}

// A 200 that is not the page that was wanted is a poll refusing the vote,
// not a poll that was slow. Name what happened where it can be told, since
// a run whose votes were all turned away would otherwise look fast.
function page_trouble(body) {
    if (/id="ballot"/.test(body) && /name="CastVote"/.test(body)) return 'ballot returned unrecorded';
    // Every CIVS page opens with the service's name in an h1, so what the
    // page is actually about is the heading inside the contents, not the
    // first one on the page.
    const contents = body.slice(body.indexOf('class="contents"'));
    const heading = contents.match(/<h1>([^<]{1,60})/);
    if (heading) return 'refused: ' + heading[1].trim();
    const shouting = contents.match(/<(?:h2|p|b)>([^<]{1,60})/);
    if (shouting) return 'refused: ' + shouting[1].trim();
    return 'unrecognized page';
}

function multipart(fields) {
    const boundary = '----civsbench' + Math.random().toString(36).slice(2);
    let body = '';
    for (const [name, value] of Object.entries(fields)) {
        body += `--${boundary}\r\n`;
        body += `Content-Disposition: form-data; name="${name}"\r\n\r\n`;
        body += `${value}\r\n`;
    }
    body += `--${boundary}--\r\n`;
    return [`multipart/form-data; boundary=${boundary}`, Buffer.from(body)];
}

function request(method, path, ip, payload, done) {
    const headers = {
        Host: target.host,
        // CIVS takes the voter's address from the headers a reverse proxy
        // would have set, so this is how one machine votes as many.
        'X-Real-IP': ip,
        'Accept-Language': 'en-us',
        'User-Agent': 'civs-bench',
        Connection: 'close',
    };
    if (payload) {
        headers['Content-Type'] = payload.type;
        headers['Content-Length'] = payload.body.length;
    }
    const req = http.request(
        { host: target.hostname, port: target.port, method, path, headers, agent },
        res => {
            const chunks = [];
            res.on('data', c => chunks.push(c));
            res.on('end', () => done(null, res.statusCode, Buffer.concat(chunks).toString('utf8')));
        });
    req.setTimeout(opt.timeout * 1000, () => { req.destroy(new Error('timed out')) });
    req.on('error', e => done(e.message === 'timed out' ? 'timed out' : `connection: ${e.message}`, 0, ''));
    if (payload) req.write(payload.body);
    req.end();
}

// -- what came of it -------------------------------------------------------

// Decide what a run showed, from the facts it gathered. This is kept
// apart from the reporting of it so that --check can put runs already
// taken back through it.
//
//   arrived      votes that arrived during the measurement window
//   recorded     of those, the ones the server had recorded by the time
//                the window closed
//   window       how long the window was, in seconds
//   first_third,
//   last_third   mean number of votes in the system over the opening and
//                closing thirds of the window
//   completed    requests that finished, however they finished
//   failed       of those, the ones the poll refused or that never
//                reached it
//   lost         requests that never finished at all
//   over         whether the run was called off for having too many
//                requests outstanding at once
function judge(f) {
    // Whatever arrived inside the window and had not finished when it
    // closed is the shortfall in votes recorded and the growth of the
    // backlog at once: nothing leaves the system except by completing, so
    // the two are one number seen from either end. There is therefore
    // only one question to ask about keeping up, and asking it twice --
    // once of the throughput and once of the queue -- would be to convict
    // a run on a single piece of evidence counted as two. Since a queue
    // near capacity wanders up and down a good deal, whichever of the two
    // were read the more loosely would then decide every case.
    const deficit = f.arrived - f.recorded;
    // A server that is keeping up perfectly well still has work in hand:
    // about as much as it had when the window opened, since at a rate of
    // lambda with responses taking R there are always around lambda*R
    // requests being worked on, and the window closing on them is no
    // reflection on the server. Allow that much, a twentieth of the
    // window's arrivals for the wandering of a random arrival process,
    // and a few requests so that a short run is not condemned by two or
    // three of them.
    const allowance = 0.05 * f.arrived + f.first_third + 3;
    // A handful of arrivals says nothing about a rate: the arrival
    // process is random, and over a short window the luck of the draw
    // swamps anything the server did. Below this many, only outright
    // failure -- requests refused, or too many outstanding to go on -- is
    // judged.
    const enough = f.arrived >= 30;

    const reasons = [];
    if (f.over) reasons.push(f.over_why);
    if (enough && !f.over && deficit > allowance)
        reasons.push(`recorded ${(f.recorded / f.window).toFixed(1)} of the ` +
                     `${(f.arrived / f.window).toFixed(1)} votes/s arriving, ` +
                     `leaving ${deficit} unfinished when the window closed`);
    if (f.failed > f.completed * 0.01)
        reasons.push(`${f.failed} of ${f.completed} requests failed`);
    if (f.lost) reasons.push(`${f.lost} never finished`);

    const sustained = reasons.length === 0;
    // A queue that rose through a window the server nonetheless kept up
    // with is not a failure, but it is where the failure will be: say so,
    // rather than either ignoring it or calling the run lost over it.
    const rising = f.last_third > f.first_third * 1.5 + 2;
    return { enough, sustained, reasons, near: sustained && enough && rising };
}


function pct(sorted, p) {
    if (!sorted.length) return 0;
    const i = Math.min(sorted.length - 1, Math.floor(p / 100 * sorted.length));
    return sorted[i];
}
function mean(a) { return a.length ? a.reduce((x, y) => x + y, 0) / a.length : 0 }

let reported = false;
function report() {
    if (reported) return;
    reported = true;
    clearInterval(sampler);

    const done = measured.filter(r => r.done);
    const ok = done.filter(r => r.ok);
    const failed = done.filter(r => !r.ok);
    const lost = measured.filter(r => !r.done);

    // Response time is counted from the moment the voter meant to arrive,
    // not from the moment this process got round to the socket, so that
    // any delay of the generator's own is charged to the measurement
    // rather than quietly forgiven.
    const times = ok.map(r => r.done - r.due).sort((a, b) => a - b);
    const window = Math.max(0.001, (window_end_actual - warmup_ends) / 1000);
    // Completions inside the measurement window itself. Below capacity
    // this settles at the arrival rate; above it, it is the most the
    // server can manage, which is the number worth having.
    const inside = done.filter(r => r.done <= window_end_actual).length;
    const throughput = inside / window;
    // The rate the voters actually turned up at. Arrivals are a random
    // process, so over a short window this can sit some way off the rate
    // that was asked for, and holding the server to the nominal figure
    // would report a shortfall that was only the luck of the draw.
    const offered = measured.length / window;

    // How deep the queue was, through the window.
    const during = occupancy.filter(s => s.at >= warmup_ends && s.at <= window_end_actual);
    const third = Math.floor(during.length / 3);
    const first_third = mean(during.slice(0, third).map(s => s.n));
    const last_third = mean(during.slice(-third).map(s => s.n));

    const { enough, sustained, near, reasons } = judge({
        arrived: measured.length, recorded: inside, window: window,
        first_third: third > 0 ? first_third : 0,
        last_third: third > 0 ? last_third : 0,
        completed: done.length, failed: failed.length, lost: lost.length,
        over: over, over_why: over_why,
    });

    const lag_sorted = lags.slice().sort((a, b) => a - b);
    const why = {};
    for (const r of failed) why[r.why] = (why[r.why] || 0) + 1;

    if (!opt.quiet) {
        const s = [];
        s.push(`  offered ${opt.rate.toFixed(2)} votes/s  (mean wait k = ${(k * 1000).toFixed(1)} ms)`);
        s.push(`  arrivals ${measured.length} measured (${offered.toFixed(2)}/s), ${arrivals} issued in all`);
        s.push(`  completed ${ok.length} ok, ${failed.length} failed, ${lost.length} outstanding at the end`);
        s.push(`  throughput ${throughput.toFixed(2)} votes/s recorded during the window`);
        if (times.length) {
            s.push(`  response  mean ${mean(times).toFixed(0)} ms   median ${pct(times, 50).toFixed(0)}` +
                   `   p90 ${pct(times, 90).toFixed(0)}   p99 ${pct(times, 99).toFixed(0)}` +
                   `   max ${times[times.length - 1].toFixed(0)} ms`);
        }
        s.push(`  in system mean ${mean(during.map(x => x.n)).toFixed(1)}, most ${max_in_flight}` +
               `  (first third ${first_third.toFixed(1)}, last third ${last_third.toFixed(1)})`);
        s.push(`  generator issued arrivals a median of ${pct(lag_sorted, 50).toFixed(1)} ms late, ` +
               `at worst ${(lag_sorted.length ? lag_sorted[lag_sorted.length - 1] : 0).toFixed(0)} ms`);
        for (const [reason, n] of Object.entries(why)) s.push(`  ${n} x ${reason}`);
        if (!enough) s.push(`  too few arrivals to judge the rate; only failures were looked for`);
        if (sustained) {
            s.push(near
                ? `  VERDICT: kept up, but the backlog rose from ${first_third.toFixed(1)} to ` +
                  `${last_third.toFixed(1)} outstanding: the next rate may be too much`
                : '  VERDICT: kept up');
        } else {
            s.push(`  VERDICT: fell over -- ${reasons.join('; ')}`);
        }
        console.log(s.join('\n'));
    }

    if (opt.summary) {
        require('fs').appendFileSync(opt.summary, [
            opt.rate.toFixed(2), (k * 1000).toFixed(1), measured.length, ok.length,
            failed.length + lost.length, throughput.toFixed(2),
            mean(times).toFixed(0), pct(times, 50).toFixed(0), pct(times, 90).toFixed(0),
            pct(times, 99).toFixed(0), mean(during.map(x => x.n)).toFixed(1), max_in_flight,
            sustained ? (near ? 'kept-up (backlog rising)' : 'kept-up') : 'fell-over',
        ].join('\t') + '\n');
    }

    process.exit(sustained ? 0 : 3);
}

function die(msg) {
    process.stderr.write(`load.js: ${msg}\n`);
    process.exit(1);
}

// -- the judgement, checked against runs already taken ---------------------

// Real runs, with what they plainly were. They are here because the rule
// above is the whole difference between a benchmark that finds where a
// poll gives way and one that stops at the first rate to make the queue
// wobble, and because the temptation, when a rate near the limit is
// called a failure, is to loosen a threshold until it is not. These say
// which way each run has to come out.
const RECORDED_RUNS = [
    // Everything arrived, everything was recorded, nothing failed, and
    // the queue rose on the way: a poll near its limit, not one that has
    // given way. This is the run that the rule above was written for.
    { was: 'kept up', near: true, note: 'near the limit, all 1474 recorded',
      f: { arrived: 1474, recorded: 1450, window: 20, first_third: 5.4,
           last_third: 14.9, completed: 1474, failed: 0, lost: 0, over: false } },
    // The same shape, a little further along, and still keeping up.
    { was: 'kept up', near: false, note: 'four workers at 56/s',
      f: { arrived: 844, recorded: 837, window: 15, first_third: 8.0,
           last_third: 13.2, completed: 844, failed: 0, lost: 0, over: false } },
    // Comfortable: the queue neither rose nor was ever deep.
    { was: 'kept up', near: false, note: 'eight workers at 80/s',
      f: { arrived: 796, recorded: 793, window: 10, first_third: 6.2,
           last_third: 7.0, completed: 796, failed: 0, lost: 0, over: false } },
    // Past capacity: a seventh of the votes that arrived were still
    // waiting when the window closed.
    { was: 'fell over', near: false, note: 'eight workers at 117/s',
      f: { arrived: 1350, recorded: 1186, window: 12, first_third: 23.4,
           last_third: 120.8, completed: 1350, failed: 15, lost: 0, over: false } },
    // Well past it, and refusing connections by then.
    { was: 'fell over', near: false, note: 'eight workers at 160/s',
      f: { arrived: 1547, recorded: 1197, window: 10, first_third: 202.8,
           last_third: 306.2, completed: 1547, failed: 347, lost: 0, over: false } },
    // Too short to say anything about a rate. Judged on failures alone,
    // and there were none, however far behind it looks.
    { was: 'kept up', near: false, note: 'twenty arrivals, badly behind',
      f: { arrived: 20, recorded: 8, window: 5, first_third: 1, last_third: 4,
           completed: 20, failed: 0, lost: 0, over: false } },
    // Called off for having too much outstanding, which needs no
    // arithmetic and no minimum number of arrivals.
    { was: 'fell over', near: false, note: 'called off, 512 outstanding',
      f: { arrived: 25, recorded: 5, window: 5, first_third: 40, last_third: 400,
           completed: 5, failed: 0, lost: 20, over: true,
           over_why: '512 requests outstanding at once' } },
];

function check() {
    let bad = 0;
    for (const run of RECORDED_RUNS) {
        const got = judge(run.f);
        const verdict = got.sustained ? 'kept up' : 'fell over';
        const ok = verdict === run.was && got.near === run.near;
        if (!ok) bad++;
        console.log(`  ${ok ? 'ok  ' : 'FAIL'}: ${run.note} -- ${verdict}` +
                    `${got.near ? ', backlog rising' : ''}` +
                    (ok ? '' : `  [wanted ${run.was}${run.near ? ', backlog rising' : ''}]`));
        if (!ok) for (const r of got.reasons) console.log(`        ${r}`);
    }
    console.log(bad ? `  ${bad} of ${RECORDED_RUNS.length} judged wrongly`
                    : `  all ${RECORDED_RUNS.length} judged as they were`);
    return bad === 0;
}

if (opt.check) process.exit(check() ? 0 : 1);

tick();
