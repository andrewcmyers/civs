function newSettings() {
    document.changeSettings.submit();
}

function setup() {
    // don't need the "update" button if we have JavaScript
    // working.
    var button = document.getElementById("recomplete");
    if (button != null)
	button.parentNode.removeChild(button);
}

function hide_details() {
    document.getElementById("details").style.display = "none";
    document.getElementById("show_details").style.display = "block";
}

function show_details() {
    document.getElementById("details").style.display = "block";
    document.getElementById("show_details").style.display = "none";
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

function clear(node) {
    if (node == undefined) return;
    while (node.firstChild) node.removeChild(node.firstChild);
}

function popup(id, msg) {
    var elem = document.getElementById(id);
    clear(elem);
    app(elem, msg);
    elem.style.display = 'inline';
    setTimeout(function() {
	document.getElementById(id).style.display = 'none';
    }, 1000);
}

function post_new_description(desc) {
    post_to_url("edit_poll@PERLEXT@",
	{ id: election_id, key: control_key, description: desc }, 
	function(response) {
	    popup("save_popup", "saved");
	},
	function(err) { alert(err); });
}
