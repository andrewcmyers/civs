// fetch the contents from the URL "url".  Once successful, apply the function
// "cont()" to the contents. If unsuccessful, apply the function err(msg).
function read_from_url(url, cont, err, mimetype) {

    var undefined;
    if (mimetype == undefined) mimetype = 'text/xml';
    if (window.XMLHttpRequest) { // Mozilla, Safari, ...
        req = new XMLHttpRequest();
        if (req.overrideMimeType)
            req.overrideMimeType(mimetype);
    } else if (window.ActiveXObject) { // IE
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
    req.onreadystatechange = function() {
        if (req.readyState == 4) {
            if (req.status == 200) {
                cont(req.responseText)
            } else {
                err('Could not read from ' + url + ': Error ' + req.status);
            }
        }
    }
    if (!url.match(/^https?:/)) {
        var prefix = location.href;
        url = prefix.replace(/\/[^\/]*$/, '/') + url;
    }
    req.open("GET", url, true);
    req.send(null);
}

function post_to_url(url, params, cont, err, mimetype) {
    var undefined;
    if (mimetype == undefined) mimetype = 'text/xml';
    if (window.XMLHttpRequest) { // Mozilla, Safari, ...
        req = new XMLHttpRequest();
        if (req.overrideMimeType)
            req.overrideMimeType(mimetype);
    } else if (window.ActiveXObject) { // IE
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
    req.onreadystatechange = function() {
        if (req.readyState == 4) {
            if (req.status == 200) {
                cont(req.responseText)
            } else {
                err('Could not read from ' + url + ': Error ' + req.status);
            }
        }
    }
    if (!url.match(/^https?:/)) {
        var prefix = location.href;
        url = prefix.replace(/\/[^\/]*$/, '/') + url;
    }

    var data = new FormData();
    for (var prop in params) {
	data.append(prop, params[prop]);
    }

    req.open("POST", url, true);
    req.send(data);
}


// fetch the contents from the URL "url" into the DOM node with id attribute
// "id".  Once successful, apply the optionally provided function "cont()".
function fetch_content(id, url, cont) {
    var node = document.getElementById(id);
    read_from_url(url,
        function(responseText) {
            node.innerHTML = responseText;
            var undefined;
            if (cont != undefined) cont();
        },
        function(errmsg) {
            node.innerHTML = 'Could not read from ' + url +
                             ': Error ' + req.status;
        });
}
