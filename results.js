function newSettings() {
    document.changeSettings.submit();
}

function setup() {
    // don't need the "update" button if we have JavaScript
    // working.
    var button = document.getElementById("recomplete");
    button.parentNode.removeChild(button);
}
