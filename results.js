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
