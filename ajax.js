function fetch_content(id, url) {
    var node = document.getElementById(id);
    var req;

    if (window.XMLHttpRequest) { // Mozilla, Safari, ...
	req = new XMLHttpRequest();
	if (req.overrideMimeType) {
	    req.overrideMimeType('text/xml');
	}
    } else if (window.ActiveXObject) { // IE
	req = new ActiveXObject("Microsoft.XMLHTTP");
    }
    req.onreadystatechange = function() {
	if (req.readyState == 4) {
	    if (req.status == 200) {
		node.innerHTML = req.responseText;
	    } else {
		node.innerHTML = 'Could not read from ' + url + ': Error ' + req.status;
	    }
	}
    }
    if (!url.match(/^http:/)) {
	var prefix = location.href;
	url = prefix.replace(/\/[^\/]*$/, '/') + url;
    }
    req.open("GET", url, true);
    req.send(null);
}
