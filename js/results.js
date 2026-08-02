// A poll may ask several questions, and the results page then shows one
// block per question, each with its own settings form and its own details
// section. So these take the control that was used and work outwards from
// it, rather than looking for the one element of each kind on the page.

function question_block(elt) {
    return elt.closest('.question_results') || document;
}

function newSettings(control) {
    control.form.submit();
}

function setup() {
    // don't need the "update" buttons if we have JavaScript working.
    for (const button of document.querySelectorAll('.recomplete')) {
	button.parentNode.removeChild(button);
    }
}

function hide_details(button) {
    const block = question_block(button);
    block.querySelector('.details').style.display = "none";
    block.querySelector('.show_details').style.display = "block";
}

function show_details(button) {
    const block = question_block(button);
    block.querySelector('.details').style.display = "block";
    block.querySelector('.show_details').style.display = "none";
}

function edit_description() {
    var para = document.getElementById("description");
    var texta = document.getElementById("description_edit");
    para.style.display = 'none';
    texta.style.display = 'block';
    document.getElementById("edit_description_button").style.display = 'none';
    document.getElementById("save_description_button").style.display = 'block';
    texta.value = para.innerHTML;
}
function save_description() {
    var para = document.getElementById("description");
    var texta = document.getElementById("description_edit");
    para.innerHTML = texta.value;
    texta.style.display = 'none';
    para.style.display = 'block';
    document.getElementById("edit_description_button").style.display = 'block';
    document.getElementById("save_description_button").style.display = 'none';

    post_new_description(para.innerHTML);
}

function resendResultsLink() {
    post_to_url("resend_link@PERLEXT@",
	{ id: election_id, key: control_key },
	function(response) {
	    popup("resend_popup", "sent");
	},
	function(err) { alert(err); });
}

function post_new_description(desc) {
    post_to_url("edit_poll@PERLEXT@",
	{ id: election_id, key: control_key, description: desc },
	function(response) {
	    popup("save_popup", "saved");
	},
	function(err) { alert(err); });
}

function confirm_close(msg) {
    var code = prompt(msg)
    document.getElementsByName('confirmation')[0].value = code
    console.log("saw confirmation string: " + code)
    return code == 'close'
}
