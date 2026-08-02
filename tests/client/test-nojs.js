// With scripting disabled the page must degrade to the single-question
// form it has always been: no header, no question-text field, no remove
// button, no add button, and legacy field names.
const fs = require('fs');
const { JSDOM } = require('jsdom');

// style.css is a separate file, separately cached, and can be stale or
// missing when the page is not. Nothing that must stay hidden may depend
// on it, so it is deliberately not supplied here.
let html = fs.readFileSync(process.argv[2], 'utf8')
    .replace(/<script(?![^>]*\btype=)[\s\S]*?<\/script>/g, '');  // no scripting

const d = new JSDOM(html).window;
const doc = d.document;
let fails = 0;
function ck(name, cond, extra) {
    if (!cond) { fails++; console.log('FAIL: ' + name + (extra ? '  [' + extra + ']' : '')); }
    else console.log('  ok: ' + name);
}
function disp(sel) {
    const e = doc.querySelector(sel);
    return e ? d.getComputedStyle(e).display : '(missing)';
}

ck('question header hidden', disp('.question_header') === 'none', disp('.question_header'));
ck('question text field hidden', disp('.question_title_row') === 'none', disp('.question_title_row'));
ck('gutter controls hidden', disp('.question_controls') === 'none', disp('.question_controls'));
ck("no question border", d.getComputedStyle(doc.querySelector('.question')).borderLeftWidth !== '3px');
ck('add button hidden', disp('.add_question_row') === 'none', disp('.add_question_row'));
ck('choices still visible', disp('.choices') !== 'none', disp('.choices'));
// The restore offer is useless without scripting, and its buttons would do
// nothing; it must not appear even if the stylesheet never arrives.
ck('no offer to restore a draft', disp('#draft_notice') === 'none',
   disp('#draft_notice'));
ck('num_winners still visible', disp('.num_winners') !== 'none', disp('.num_winners'));

const posted = [...doc.querySelectorAll('#questions [name]')].map(e => e.name);
ck('legacy field names only',
   JSON.stringify(posted) === JSON.stringify(
       ['question_title', 'choices', 'choices_file', 'num_winners',
        'proportional', 'rating_interpretation', 'rating_interpretation']), posted);
// question_title posts empty, which is what create_election already ignores.
ck('question_title posts empty',
   doc.querySelector('[name=question_title]').value === '');

console.log(fails ? '\n' + fails + ' FAILED' : '\nno-JS degradation ok');
process.exit(fails ? 1 : 0);
