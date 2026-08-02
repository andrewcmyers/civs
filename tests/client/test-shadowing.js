// Inline event handlers resolve names against a scope chain of
// [element, owning form, document, global]. A form finds its controls by
// id as well as by name, so any control whose id or name matches a
// function called from an inline handler shadows that function and the
// call fails with "... is not a function". jsdom does not implement the
// form named getter, so this cannot be caught by clicking things -- it
// has to be checked statically.
const fs = require('fs');
const { JSDOM } = require('jsdom');

const doc = new JSDOM(fs.readFileSync(process.argv[2], 'utf8')).window.document;
let fails = 0;

// Every function name called from an inline handler anywhere on the page.
const called = new Set();
for (const e of doc.querySelectorAll('*')) {
    for (const a of e.attributes) {
        if (!/^on/i.test(a.name)) continue;
        for (const m of a.value.matchAll(/([A-Za-z_$][\w$]*)\s*\(/g)) {
            called.add(m[1]);
        }
    }
}

// Everything a form's named getter can reach: listed elements, by id or name.
const shadows = new Map();
for (const f of doc.forms) {
    for (const e of f.elements) {
        for (const key of [e.id, e.getAttribute('name')]) {
            if (key) shadows.set(key, e.tagName.toLowerCase() +
                (e.id === key ? ' id=' : ' name=') + key);
        }
    }
}
// Elements with an id are also reachable as window.<id>.
const globals = new Map();
for (const e of doc.querySelectorAll('[id]')) globals.set(e.id, e.tagName.toLowerCase());

console.log('functions called from inline handlers:');
console.log('  ' + [...called].sort().join(', '));

for (const fn of [...called].sort()) {
    if (shadows.has(fn)) {
        fails++;
        console.log('FAIL: ' + fn + '() is shadowed by a form control: ' + shadows.get(fn));
    } else if (globals.has(fn)) {
        fails++;
        console.log('FAIL: ' + fn + '() is shadowed by element id=' + fn);
    } else {
        console.log('  ok: ' + fn + '() is not shadowed');
    }
}

console.log(fails ? '\n' + fails + ' FAILED' : '\nno shadowed handler names');
process.exit(fails ? 1 : 0);
