// A few useful tags. Add more!
var tags = [
    'ul', 'li', 'ol', 'p', 'b', 'i', 'em', 'table', 'tbody', 'tr', 'td', 'div',
    'span'
];

/* Append k as a child of n. Create a text node if k is a string.
 */
function app(n, k) {
    if (typeof k == "string")
	n.appendChild(document.createTextNode(k));
    else
	n.appendChild(k);
}

/* Create an HTML DOM element with children and, optionally, attributes.
 *   tag: the tag name, e.g. 'p', 'ul', etc.
 *   kids: either an array of elements or a single element.
 *         a 'kid' that is a string causes a text node child to be created.
 *   attributes: an object containing additional attributes to be copied to
 *      the node.
 */
function node(tag, kids, attributes) {
    var n = document.createElement(tag);
    if (kids.constructor == Array)
	for (var i in kids) app(n, kids[i]);
    else
	app(n, kids);
    if (attributes != undefined) {
	// if you get an error here, you probably forgot array brackets
	for (var prop in attributes) {
	    n[prop] = attributes[prop];
	}
    }
    return n;
}

/* Install a tag as a top-level function. 
 */
function install_tag(tag) {
// This must be done in a separate function to get the scoping of the
// captured variable 'tag' right.

    window[tag] = function(kids, attributes) {
	return node(tag, kids, attributes)
    }
}

for (var t in tags)
    install_tag(tags[t]);
