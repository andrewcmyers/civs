// The create page keeps an unfinished form in local storage and offers it
// back on a later visit. Each visit is a fresh page over a shared storage,
// which is what these checks reproduce.
const fs = require('fs');
const { JSDOM } = require('jsdom');

const source = fs.readFileSync(process.argv[2], 'utf8')
    .replace(/<script src="[^"]*"><\/script>/g, '')
    .replace('<body>',
        '<body><script>function create_header(){return document.createElement("div")}</script>');

let fails = 0, checks = 0;
function ck(name, cond, extra) {
    checks++;
    if (!cond) { fails++; console.log('FAIL: ' + name + (extra !== undefined ? '  [' + extra + ']' : '')); }
    else console.log('  ok: ' + name);
}

// Each jsdom instance gets its own empty localStorage, so what a visit
// left behind has to be carried into the next one by hand. It must be
// seeded before the page's scripts run, since the offer is made on load.
const url = 'https://civs.example/create_poll.html';
let disk = {};
function visit(previous) {
    if (previous) {
        disk = {};
        for (let i = 0; i < previous.localStorage.length; i++) {
            const k = previous.localStorage.key(i);
            disk[k] = previous.localStorage.getItem(k);
        }
    }
    const dom = new JSDOM(source, {
        runScripts: 'dangerously', url: url, storageQuota: 10000000,
        beforeParse(window) {
            for (const k of Object.keys(disk)) {
                window.localStorage.setItem(k, disk[k]);
            }
        }
    });
    dom.window.alert = () => {};
    return dom.window;
}
function notice_shown(w) {
    return w.document.getElementById('draft_notice').style.display === 'block';
}
function stored(w) {
    return w.localStorage.getItem('civs.create_poll.v1');
}
function set(w, name, value) {
    const e = w.document.forms.CreateElection.elements[name];
    if (e.type === 'checkbox') { e.checked = value; } else { e.value = value; }
    e.dispatchEvent(new w.Event('input', { bubbles: true }));
}
// Saving is debounced, so the timer has to be let run.
function settle(w) { w.eval('save_pending && (clearTimeout(save_pending), save_draft())'); }

console.log('\n== a first visit with nothing saved ==');
let w = visit();
ck('no offer when storage is empty', !notice_shown(w));
ck('nothing written just by opening the page', stored(w) === null, stored(w));

console.log('\n== filling the form in ==');
set(w, 'title', 'Lunch');
set(w, 'name', 'Tester');
set(w, 'email_addr', 'tester@example.invalid');
set(w, 'choices', 'Pizza\nTacos');
set(w, 'restrict_results', true);
set(w, 'result_addrs', 'boss@example.invalid');
w.add_question();
set(w, 'q1_question_title', 'How shall we travel?');
set(w, 'q1_choices', 'Walk\nBus');
settle(w);
const saved = JSON.parse(stored(w));
ck('a draft was written', saved !== null);
ck('it records both questions', saved.questions === 2, saved.questions);
ck('it records text fields', saved.fields.title === 'Lunch');
ck('it records checkboxes', saved.fields.restrict_results === true);
ck('it records the second question', saved.fields.q1_choices === 'Walk\nBus');
ck('it records when it was saved', typeof saved.saved === 'number');

console.log('\n== the next visit offers it back ==');
w = visit(w);
ck('the offer appears', notice_shown(w));
ck('it says when the draft was saved',
   /An unfinished poll form was saved in this browser on .+\./.test(
       w.document.getElementById('draft_notice_text').textContent),
   w.document.getElementById('draft_notice_text').textContent);
ck('the form is not filled in until asked',
   w.document.forms.CreateElection.elements.title.value === '');
ck('and still has one question', w.document.querySelectorAll('#questions .question').length === 1);

console.log('\n== restoring ==');
w.restore_draft();
ck('the offer goes away', !notice_shown(w));
ck('both questions are back', w.document.querySelectorAll('#questions .question').length === 2);
ck('text fields are back', w.document.forms.CreateElection.elements.title.value === 'Lunch');
ck('checkboxes are back', w.document.forms.CreateElection.elements.restrict_results.checked === true);
ck('the second question is back',
   w.document.forms.CreateElection.elements.q1_choices.value === 'Walk\nBus');
ck('the panel its checkbox controls is showing again',
   w.document.getElementById('rrcontrol').style.display === 'block',
   w.document.getElementById('rrcontrol').style.display);
ck('previews were redrawn',
   /<li>Pizza<\/li>/.test(w.document.querySelector('.rendered_choices').innerHTML));
ck('the draft is still there after restoring', stored(w) !== null);

console.log('\n== submitting discards it ==');
ck('the form validates', w.validate() === true);
ck('the draft is gone', stored(w) === null);
w = visit(w);
ck('the next visit makes no offer', !notice_shown(w));

console.log('\n== discarding without restoring ==');
set(w, 'title', 'Something');
settle(w);
ck('a draft was written', stored(w) !== null);
w = visit(w);
ck('the offer appears', notice_shown(w));
w.discard_saved_draft();
ck('the offer goes away', !notice_shown(w));
ck('the draft is gone', stored(w) === null);

console.log('\n== emptying the form clears the draft ==');
set(w, 'title', 'Temporary');
settle(w);
ck('a draft was written', stored(w) !== null);
set(w, 'title', '');
settle(w);
ck('an empty form leaves nothing behind', stored(w) === null, stored(w));

console.log('\n== damaged or unreadable storage ==');
w = visit(w);
w.localStorage.setItem('civs.create_poll.v1', 'not json {{{');
const w2 = visit(w);
ck('a corrupt draft is ignored rather than thrown', !notice_shown(w2));
ck('the form still works', w2.validate() === false);

console.log('\n' + (fails ? fails + ' FAILED' : 'all ' + checks + ' checks passed'));
process.exit(fails ? 1 : 0);
