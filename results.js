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
