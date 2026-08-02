// Exercise the multi-question create page in a real DOM.
const fs = require('fs');
const { JSDOM } = require('jsdom');

let html = fs.readFileSync(process.argv[2], 'utf8');
// The two external scripts are not on disk here; create_header is the only
// thing the page uses from them.
html = html.replace(/<script src="[^"]*"><\/script>/g, '')
           .replace(/<script src="ezdom.js"><\/script>/g, '');
html = html.replace('<body>',
    '<body><script>function create_header(a,b){var d=document.createElement("div");return d}</script>');

const alerts = [];
const dom = new JSDOM(html, { runScripts: 'dangerously' });
const w = dom.window, d = w.document;
w.alert = m => alerts.push(m);

let fails = 0, checks = 0;
function ck(name, cond, extra) {
    checks++;
    if (!cond) { fails++; console.log('FAIL: ' + name + (extra ? '  [' + extra + ']' : '')); }
    else console.log('  ok: ' + name);
}
function names() {
    return [...d.querySelectorAll('#questions [name]')].map(e => e.name);
}
function headers() {
    return [...d.querySelectorAll('.question_header')].map(e => e.textContent);
}
function tags() {
    return [...d.querySelectorAll('#questions .question_title')].map(e => e.value);
}
function post() {
    const fd = new w.FormData(d.forms.CreateElection);
    return [...fd.keys()].filter(k => /choices|num_winners|question_title|num_questions/.test(k));
}
function dupIds() {
    const seen = {}, dups = [];
    for (const e of d.querySelectorAll('[id]')) {
        if (seen[e.id]) dups.push(e.id); else seen[e.id] = 1;
    }
    return dups;
}
// Every for= and aria-labelledby= must point at exactly one existing id.
function brokenRefs() {
    const bad = [];
    for (const a of ['for', 'aria-labelledby']) {
        for (const e of d.querySelectorAll('[' + a + ']')) {
            const v = e.getAttribute(a);
            if (d.querySelectorAll('[id="' + v + '"]').length !== 1) bad.push(a + '=' + v);
        }
    }
    return bad;
}

console.log('\n== initial state (one question) ==');
ck('one question block', d.querySelectorAll('#questions .question').length === 1);
ck('not multi', !d.getElementById('question_area').classList.contains('multi'));
ck('js class set', d.getElementById('question_area').classList.contains('js'));
ck('num_questions = 1', d.getElementById('num_questions').value === '1');
ck('unprefixed field names',
   JSON.stringify(names()) === JSON.stringify(
       ['question_title', 'choices', 'choices_file', 'num_winners',
        'proportional', 'rating_interpretation', 'rating_interpretation']), names());
ck('no duplicate ids', dupIds().length === 0, dupIds());
ck('no broken label refs', brokenRefs().length === 0, brokenRefs());

console.log('\n== add a second question ==');
d.forms.CreateElection.elements.title.value = 'Lunch plans';
d.getElementById('choices_0').value = 'Pizza\nTacos';
w.add_question();
ck('two blocks', d.querySelectorAll('#questions .question').length === 2);
ck('multi class set', d.getElementById('question_area').classList.contains('multi'));
ck('headers renumbered', JSON.stringify(headers()) === '["Question 1","Question 2"]', headers());
ck('q1 seeded from poll title',
   d.getElementById('question_title_0').value === 'Lunch plans');
ck('second block prefixed',
   JSON.stringify(names().slice(7)) === JSON.stringify(
       ['q1_question_title', 'q1_choices', 'q1_choices_file', 'q1_num_winners',
        'q1_proportional', 'q1_rating_interpretation',
        'q1_rating_interpretation']), names());
ck('second block ids retargeted', !!d.getElementById('choices_1'));
ck('cloned fields cleared', d.getElementById('choices_1').value === '');
ck('cloned num_winners = 1', d.getElementById('num_winners_1').value === '1');
ck('no duplicate ids', dupIds().length === 0, dupIds());
ck('no broken label refs', brokenRefs().length === 0, brokenRefs());
ck('num_questions = 2', d.getElementById('num_questions').value === '2');

console.log('\n== proportional representation is per question ==');
ck('each question has its own checkbox',
   d.querySelectorAll('.question .proportional').length === 2);
ck('and its own panel', d.querySelectorAll('.question .prcontrol').length === 2);
ck('both panels start hidden',
   [...d.querySelectorAll('.prcontrol')].every(e => e.style.display === 'none'));
d.getElementById('proportional_1').checked = true;
w.update_conditional_visibility();
ck('ticking one shows only its panel',
   d.querySelector('#question_0 .prcontrol').style.display === 'none' &&
   d.querySelector('#question_1 .prcontrol').style.display === 'block');
d.getElementById('proportional_1').checked = false;
w.update_conditional_visibility();
ck('unticking hides it again',
   d.querySelector('#question_1 .prcontrol').style.display === 'none');

console.log('\n== per-question preview is scoped ==');
d.getElementById('choices_1').value = 'Yes\nNo';
w.preview_choices(d.getElementById('choices_1'));
const rendered = [...d.querySelectorAll('.rendered_choices')].map(e => e.innerHTML);
ck('only block 2 rendered', rendered[0] === '' && /<li>Yes<\/li>/.test(rendered[1]), rendered);

console.log('\n== add two more, remove the middle one ==');
w.add_question(); w.add_question();
ck('four blocks', d.querySelectorAll('#questions .question').length === 4);
// Tag each block so it can be followed through reordering.
[...d.querySelectorAll('#questions .question')].forEach((b, i) =>
    b.querySelector('.question_title').value = 'tag' + i);
w.remove_question(d.querySelector('#question_1 .remove_question'));
ck('three blocks', d.querySelectorAll('#questions .question').length === 3);
ck('headers renumber 1..3',
   JSON.stringify(headers()) === '["Question 1","Question 2","Question 3"]', headers());
ck('indices are dense and in order',
   JSON.stringify([...d.querySelectorAll('#questions .question')].map(e => e.id)) ===
   '["question_0","question_1","question_2"]');
ck('the right block was removed', tags().join() === 'tag0,tag2,tag3', tags());
ck('no duplicate ids', dupIds().length === 0, dupIds());

console.log('\n== reordering ==');
ck('first question cannot move up',
   d.querySelector('#question_0 .move_up').disabled === true);
ck('last question cannot move down',
   d.querySelector('#question_2 .move_down').disabled === true);
w.move_question(d.querySelector('#question_2 .move_up'), -1);
ck('moved up one place', tags().join() === 'tag0,tag3,tag2', tags());
ck('indices follow display order',
   JSON.stringify([...d.querySelectorAll('#questions .question')].map(e => e.id)) ===
   '["question_0","question_1","question_2"]');
const block_names = n =>
    ['question_title', 'choices', 'choices_file', 'num_winners', 'proportional',
     'rating_interpretation', 'rating_interpretation']
    .map(f => (n === 0 ? f : 'q' + n + '_' + f)).join();
ck('field names follow display order',
   names().join() === [0, 1, 2].map(block_names).join(), names());
ck('values moved with the block',
   d.getElementById('question_title_1').value === 'tag3');
w.move_question(d.querySelector('#question_1 .move_down'), 1);
ck('moved back down', tags().join() === 'tag0,tag2,tag3', tags());
w.move_question(d.querySelector('#question_0 .move_down'), 1);
ck('index 0 can be moved off the top', tags().join() === 'tag2,tag0,tag3', tags());
ck('new first block took the unprefixed names',
   names().slice(0, 7).join() ===
       'question_title,choices,choices_file,num_winners,proportional,' +
       'rating_interpretation,rating_interpretation', names());
ck('new first block holds the right values',
   d.getElementById('question_title_0').value === 'tag2');
ck('no duplicate ids', dupIds().length === 0, dupIds());
ck('no broken label refs', brokenRefs().length === 0, brokenRefs());
ck('arrows re-disabled at the ends',
   d.querySelector('#question_0 .move_up').disabled === true &&
   d.querySelector('#question_2 .move_down').disabled === true &&
   d.querySelector('#question_1 .move_up').disabled === false);
ck('group is labelled by its header',
   d.getElementById('question_1').getAttribute('aria-labelledby') === 'question_header_1' &&
   !!d.getElementById('question_header_1'));

console.log('\n== what actually gets posted ==');
console.log('   ' + JSON.stringify(post()));

console.log('\n== validation ==');
d.forms.CreateElection.elements.email_addr.value = 'a@b.example';
// Start from a known state rather than whatever the reordering left behind.
for (const b of d.querySelectorAll('#questions .question')) {
    b.querySelector('.choices').value = '';
    b.querySelector('.question_title').value = '';
}
const nq = d.querySelectorAll('#questions .question').length;
alerts.length = 0;
ck('empty questions rejected', w.validate() === false);
console.log('   ' + JSON.stringify(alerts[0]));
ck('every question is named in the errors',
   [...Array(nq).keys()].every(i => alerts[0].includes('Question ' + (i + 1) + ':')),
   alerts[0]);
ck('uses translated choices message',
   /at least two choices/.test(alerts[0]), alerts[0]);

for (const b of d.querySelectorAll('#questions .question')) {
    b.querySelector('.choices').value = 'A\nB';
    b.querySelector('.question_title').value = 'Q?';
}
alerts.length = 0;
ck('valid multi-question form passes', w.validate() === true, alerts[0]);

for (const b of d.querySelectorAll('#questions .question')) {
    b.querySelector('.proportional').checked = true;
}
alerts.length = 0;
ck('proportional with 1 winner rejected per question', w.validate() === false);
ck('proportional error names every question',
   (alerts[0].match(/Question \d+: Proportional/g) || []).length === nq, alerts[0]);
for (const b of d.querySelectorAll('#questions .question')) {
    b.querySelector('.proportional').checked = false;
}

console.log('\n== single-question form is unchanged ==');
while (d.querySelectorAll('#questions .question').length > 1) {
    w.remove_question(d.querySelector('#questions .question:last-child .remove_question'));
}
ck('back to one block', d.querySelectorAll('#questions .question').length === 1);
ck('multi class cleared', !d.getElementById('question_area').classList.contains('multi'));
ck('posts legacy field names',
   JSON.stringify(post()) === JSON.stringify(
       ['question_title', 'choices', 'choices_file', 'num_winners', 'num_questions']), post());
alerts.length = 0;
ck('no question-text error when single', w.validate() === true, alerts[0]);

console.log('\n== max_questions cap ==');
// The cap comes from the MAX_QUESTIONS installation setting, which the
// runner substitutes; it is passed in here so that this checks the value
// actually reached the page rather than that it happens to be the default.
const cap = Number(process.argv[3]);
for (let i = 0; i < cap + 10; i++) w.add_question();
ck('capped at MAX_QUESTIONS (' + cap + ')',
   d.querySelectorAll('#questions .question').length === cap,
   d.querySelectorAll('#questions .question').length);
ck('add button disabled at cap', d.getElementById('add_question_button').disabled === true);

console.log('\n' + (fails ? fails + ' FAILED' : 'all ' + checks + ' checks passed'));
process.exit(fails ? 1 : 0);
