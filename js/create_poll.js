// Poll creation: form validation, previews, polls that ask more than one
// question, and keeping an unfinished form between visits.
//
// The page that loads this is generated once per language, so the text
// this script shows and the settings it obeys are not in here. They come
// from create_poll_config, which html/create_poll.html.base defines just
// before loading this file.

const text = create_poll_config.text

function trim(str) {
    return str.replace(/^\s+|\s+$/g, '')
}
function validateEmail(str)   // element to be validated
{
    str = trim(str);  // value of field with whitespace trimmed off
    const email = /^[^@]+@[^@.]+\.[^@]*\w\w$/
    return email.test(str);
}

// Always reach form controls through .elements. Looking them up
// directly on the form finds properties of the form itself first, so
// e.g. CreateElection.title is the title attribute and
// CreateElection.name is "CreateElection", not those input fields.
function field(name) {
    return document.forms.CreateElection.elements[name]
}

function validate() {
    let numerrs = 0;
    const errs = new Array;
    if (!validateEmail(field('email_addr').value)) {
        errs[numerrs++] = text.invalid_supervisor_email;
    }
    // Each question is checked separately, including whether it uses
    // proportional representation.
    const blocks = questions();
    for (let q = 0; q < blocks.length; q++) {
        const block = blocks[q];
        // Only say which question when there is more than one.
        const where = (blocks.length > 1)
            ? text.question_number + ' ' + (q + 1) + ': ' : '';
        const nwin = block.querySelector('.num_winners').value;
        if (!(nwin >= 1)) {
            errs[numerrs++] = where + text.must_have_at_least_one_winner;
        }
        if (block.querySelector('.proportional').checked && !(nwin > 1)) {
            errs[numerrs++] = where +
                text.proportional_needs_more_winners;
        }
        if (block.querySelector('.choices').value == '' &&
            block.querySelector('.choices_file').value == '') {
            errs[numerrs++] = where +
                text.must_have_two_choices;
        }
        if (blocks.length > 1 &&
            trim(block.querySelector('.question_title').value) == '') {
            errs[numerrs++] = where + text.each_question_needs_text;
        }
    }
    if (field('restrict_results').checked) {
        const rs = field('result_addrs').value;
        const ra = rs.split(/[\r\n]+/g);
        let nr = 0;
        for (let i = 0; i < ra.length; i++) {
            if (ra[i] == '') continue;
            if (!validateEmail(ra[i])) {
                errs[numerrs++] =
                    text.results_recipient_invalid + ' ' + ra[i];
            } else {
                nr++;
            }
        }
        if (nr == 0) {
            errs[numerrs++] =
                text.no_users_can_see_results;
        }
    }
    if (numerrs == 0) {
        // The form is on its way; there is nothing left to come back
        // to. Note that a poll the server goes on to reject is not
        // recoverable from the draft, only from the back button.
        discard_draft();
        return true;
    }
    if (numerrs == 1) {
        alert(errs[0]);
    } else {
        let msg = 'Errors:\n';
        for (let i = 0; i < numerrs; i++) {
            msg += (i+1);
            msg += '. ';
            msg += errs[i];
            msg += "\n";
        }
        alert(msg);
    }
    return false;
}

function render_text(prefix, ta_id, span_id, clss) {
    const span = document.getElementById(span_id);
    const ta = document.getElementById(ta_id);
    span.innerHTML = prefix + '<div class="' + clss + '">' + ta.value + "</div>";
    return 1;
}

function render_list(ta, span) {
    const names = ta.value.split(/[\r\n]+/g);
    let html = "";
    for (let i = 0; i < names.length; i++) {
        if (names[i] != "")
            html = html + "<li>" + names[i] + "</li>";
    }
    span.innerHTML = "<ul>" + html + "</ul>";
    return 1;
}

function show(id, visible) {
    document.getElementById(id).style.display = visible ? 'block' : 'none'
}

// Show or hide the panels that only apply given some other setting.
// The controls call this rather than revealing their own panel, so
// that clearing a setting hides its panel again; the calls this
// replaces only ever revealed, so a panel once shown stayed shown
// even after the box that brought it up was unticked.
function update_conditional_visibility() {
    const is_public = field('public').value == 'yes'
    const publicized = is_public && field('publicize').checked
    show('publicize_div', is_public)
    show('no_IP_check_div', is_public)
    show('restrict_results_div', !publicized)
    show('reveal_voters_div', !publicized)
    show('rrcontrol', !publicized && field('restrict_results').checked)
    show('reveal_voters_sub', !publicized && field('ballot_reporting').checked)
    // Proportional representation is settled question by question, so
    // each question has its own checkbox and its own panel beneath it.
    for (const block of questions()) {
        block.querySelector('.prcontrol').style.display =
            block.querySelector('.proportional').checked ? 'block' : 'none'
    }
}
function preview_description() {
    render_text('<h2>Poll description</h2>',
                'description',
                'rendered_description',
                'description')
}
// The argument is any element inside the question being previewed:
// there is one set of these controls per question, so they cannot be
// found by id.
function preview_choices(elt) {
    const block = question_of(elt)
    render_list(block.querySelector('.choices'),
                block.querySelector('.rendered_choices'))
}

// ---------------------------------------------------------------
// Polls with more than one question.
//
// The first question uses the unprefixed field names ("choices",
// "num_winners", ...) that single-question polls have always posted,
// so a poll with one question submits exactly what it used to. Any
// further question posts the same names under a "q<N>_" prefix,
// mirroring the "q<N>." key prefix used in the poll database.
//
// Question indices are kept dense and in display order: index N is
// always the Nth question on the page. Structural changes
// reindex all the blocks.

// The MAX_QUESTIONS installation setting, which create_election
// enforces as well; this only spares the supervisor a round trip.
const max_questions = create_poll_config.max_questions

function question_of(elt) {
    return elt.closest('.question')
}

function questions() {
    return document.querySelectorAll('#questions .question')
}

// Reindex every question to its display position, retitle the headers,
// and show or hide controls that only make sense if there is more
// than one question.
function renumber_questions() {
    const blocks = questions()
    const multi = blocks.length > 1
    for (let i = 0; i < blocks.length; i++) {
        const b = blocks[i]
        set_question_index(b, i)
        b.querySelector('.question_header').textContent =
            text.question_number + ' ' + (i + 1)
        // Name each question group after its header, so that the
        // controls in it are announced with the question they act on.
        if (multi) {
            b.setAttribute('role', 'group')
            b.setAttribute('aria-labelledby', 'question_header_' + i)
        } else {
            b.removeAttribute('role')
            b.removeAttribute('aria-labelledby')
        }
        b.querySelector('.move_up').disabled = (i == 0)
        b.querySelector('.move_down').disabled = (i == blocks.length - 1)
    }
    document.getElementById('question_area').classList.toggle('multi', multi)
    document.getElementById('num_questions').value = blocks.length
    document.getElementById('add_question_button').disabled =
        blocks.length >= max_questions
}

// Move a question block to index n, rewriting the field names it
// posts under. Index 0 is the one that carries the unprefixed names.
// The ids have to be retargeted along with the attributes that refer
// to them, or duplicate ids would silently break the label and
// aria-labelledby associations.
function set_question_index(block, n) {
    block.id = 'question_' + n
    for (const e of block.querySelectorAll('[name]')) {
        const base = e.name.replace(/^q[0-9]+_/, '')
        e.name = (n == 0) ? base : 'q' + n + '_' + base
    }
    for (const e of block.querySelectorAll('[id], [for], [aria-labelledby]')) {
        for (const a of ['id', 'for', 'aria-labelledby']) {
            const v = e.getAttribute(a)
            if (v) { e.setAttribute(a, v.replace(/_[0-9]+$/, '_' + n)) }
        }
    }
}

// no_focus is set when restoring a draft, which adds several questions
// at once and should not send the caret chasing each one.
function add_question(no_focus) {
    const first = document.getElementById('question_0')
    if (questions().length >= max_questions) { return }
    // Going from one question to several: the first question now needs
    // text of its own. Seed it from the poll title, which is what a
    // single-question poll uses in place of a question.
    const first_title = first.querySelector('.question_title')
    if (trim(first_title.value) == '') {
        first_title.value = field('title').value
    }
    // Clone the first question rather than keeping a separate template
    // of the same markup, so that the two cannot drift apart.
    const block = first.cloneNode(true)
    for (const e of block.querySelectorAll('input[type=text], input[type=file], textarea')) {
        e.value = ''
    }
    block.querySelector('.num_winners').value = '1'
    block.querySelector('.rendered_choices').innerHTML = ''
    document.getElementById('questions').appendChild(block)
    renumber_questions()
    schedule_save()
    if (!no_focus) { block.querySelector('.question_title').focus() }
}

function remove_question(button) {
    if (questions().length <= 1) { return }
    const block = question_of(button)
    const neighbour = block.nextElementSibling || block.previousElementSibling
    block.parentNode.removeChild(block)
    renumber_questions()
    // Do not leave the keyboard stranded on the button just removed.
    // Once a single question is left its controls are hidden, so the
    // only thing still focusable is the add button.
    const next = (questions().length > 1 && neighbour)
        ? neighbour.querySelector('.remove_question')
        : document.getElementById('add_question_button')
    next.focus()
    schedule_save()
}

// Move a question one place earlier (delta -1) or later (delta 1).
function move_question(button, delta) {
    const block = question_of(button)
    const other = (delta < 0) ? block.previousElementSibling
                              : block.nextElementSibling
    if (!other) { return }
    block.parentNode.insertBefore((delta < 0) ? block : other,
                                  (delta < 0) ? other : block)
    renumber_questions()
    // Follow the question that moved, so that repeated presses keep
    // moving the same one. At either end that arrow is now disabled,
    // so fall back to the one pointing the other way.
    let arrow = block.querySelector((delta < 0) ? '.move_up' : '.move_down')
    if (arrow.disabled) {
        arrow = block.querySelector((delta < 0) ? '.move_down' : '.move_up')
    }
    arrow.focus()
    schedule_save()
}

// ---------------------------------------------------------------
// Keeping an unfinished form.
//
// Setting up a poll takes a while, and navigating away used to lose
// all of it, so what has been filled in is kept in the browser's local
// storage as it is typed. On a later visit the form does not fill
// itself in -- the draft holds the supervisor's own address and the
// voters' addresses, and silently reinstating those could be a
// surprise on a shared machine -- but offers to, and offers to throw
// the draft away. Submitting the form discards it.
//
// Files chosen for upload cannot be kept: a file input's value is not
// something a page is allowed to set.

const draft_key = 'civs.create_poll.v1'

// Local storage is absent or forbidden in some browsers and private
// modes. The form has to work regardless, so every use is guarded and
// failure just turns the feature off.
function draft_storage() {
    try {
        const s = window.localStorage
        s.setItem(draft_key + '.probe', '1')
        s.removeItem(draft_key + '.probe')
        return s
    } catch (e) {
        return null
    }
}

// Fields worth keeping: everything named except the buttons and the
// file inputs. Only the selected radio of each group is recorded.
function draft_fields() {
    const fields = {}
    for (const e of document.forms.CreateElection.elements) {
        if (!e.name) { continue }
        if (e.type == 'file' || e.type == 'submit' || e.type == 'button') {
            continue
        }
        if (e.type == 'checkbox') { fields[e.name] = e.checked }
        else if (e.type == 'radio') {
            if (e.checked) { fields[e.name] = e.value }
        } else { fields[e.name] = e.value }
    }
    return fields
}

// What an untouched form looks like, recorded at startup.
let pristine_fields = null

// Whether the form differs from a fresh one, and so is worth offering
// back. Comparing against the pristine state rather than looking for
// non-empty values matters because several fields start out filled in --
// the winner count, the public/private choice, the rating interpretation
// -- so merely opening the page would otherwise leave a draft behind.
function worth_saving(fields) {
    return pristine_fields === null ||
           JSON.stringify(fields) != pristine_fields
}

let save_pending = null

function save_draft() {
    const storage = draft_storage()
    if (!storage) { return }
    const fields = draft_fields()
    try {
        if (!worth_saving(fields)) {
            storage.removeItem(draft_key)
            return
        }
        storage.setItem(draft_key, JSON.stringify({
            saved: Date.now(),
            questions: questions().length,
            fields: fields
        }))
    } catch (e) {
        // A full or refused store is not worth interrupting the form
        // over; the draft simply is not kept.
    }
}

// Typing should not write to storage on every keystroke.
function schedule_save() {
    if (save_pending) { clearTimeout(save_pending) }
    save_pending = setTimeout(function () {
        save_pending = null
        save_draft()
    }, 500)
}

function discard_draft() {
    const storage = draft_storage()
    if (storage) {
        try { storage.removeItem(draft_key) } catch (e) { }
    }
}

function read_draft() {
    const storage = draft_storage()
    if (!storage) { return null }
    try {
        const raw = storage.getItem(draft_key)
        if (!raw) { return null }
        const draft = JSON.parse(raw)
        return (draft && draft.fields) ? draft : null
    } catch (e) {
        return null   // damaged or written by an older version
    }
}

function restore_draft() {
    const draft = read_draft()
    if (!draft) { return }
    const wanted = draft.questions || 1
    while (questions().length < wanted) { add_question(true) }
    while (questions().length > wanted) {
        remove_question(document.querySelector(
            '#questions .question:last-child .remove_question'))
    }
    for (const e of document.forms.CreateElection.elements) {
        if (!e.name || !(e.name in draft.fields)) { continue }
        if (e.type == 'file' || e.type == 'submit' || e.type == 'button') {
            continue
        }
        if (e.type == 'checkbox') { e.checked = draft.fields[e.name] }
        else if (e.type == 'radio') {
            e.checked = (e.value == draft.fields[e.name])
        } else { e.value = draft.fields[e.name] }
    }
    renumber_questions()
    update_conditional_visibility()
    preview_description()
    for (const block of questions()) {
        preview_choices(block.querySelector('.choices'))
    }
    hide_draft_notice()
}

function hide_draft_notice() {
    document.getElementById('draft_notice').style.display = 'none'
}

function discard_saved_draft() {
    discard_draft()
    hide_draft_notice()
}

// Offer a draft back, if one was left and the form is still untouched.
function offer_draft() {
    const draft = read_draft()
    if (!draft) { return }
    const when = new Date(draft.saved).toLocaleString()
    document.getElementById('draft_notice_text').textContent =
        text.draft_found.replace('%s', when)
    document.getElementById('draft_notice').style.display = 'block'
}

// Called once the form has been parsed.
function create_poll_init() {
    update_conditional_visibility()
    // Reveal the "add question" button only once scripting is known to
    // work, since without it the button would do nothing.
    document.getElementById('question_area').classList.add('js')
    renumber_questions()
    pristine_fields = JSON.stringify(draft_fields())
    // Keep what is typed, and offer back anything left from last time.
    document.forms.CreateElection.addEventListener('input', schedule_save)
    document.forms.CreateElection.addEventListener('change', schedule_save)
    offer_draft()
}
