// Making it very convenient to create DOM nodes from JavaScript.
// Andrew Myers, June 2013.

// A few useful tags. More could be added.
var tags = [
    'ul', 'li', 'ol', 'p', 'b', 'i', 'em', 'table', 'thead', 'tbody', 'tr',
    'td', 'th', 'div', 'span', 'h1', 'h2', 'h3', 'h4', 'a', 'br', 'input',
    'blockquote', 'select', 'option', 'sup', 'sub', 'strong', 'pre', 'canvas',
    'button', 'img'
];

/* Appends the second and following arguments as children of n.
   Creates a text node for arguments that are strings or numbers.
   Returns n.
 */
function app(n) {
  for (var i = 1; i < arguments.length; i++) {
    var k = arguments[i];
    if (typeof k == "string") {
	n.appendChild(document.createTextNode(k));
    } else if (typeof k == "number") {
        n.appendChild(document.createTextNode(k.toString()))
    } else if (k.constructor == Array) {
        for (i in k) {
	    app(n, k[i]);
        }
    } else {
	n.appendChild(k);
    }
  }
  return n;
}

/* Create an HTML DOM element with children and, optionally, attributes.
 *   tag: the tag name, e.g. 'p', 'ul', etc.
 *   attributes: an object containing additional attributes to be copied to
 *      the node.
 *   kids: a variable length sequence of element arguments. Arguments may be
 *         strings, in which case a text node is created. An argument that is
 *         an array causes all of its contained elements to be inserted.
 */
function node(tag) {
    var n = document.createElement(tag);
    var firstkid = 1;
    var attr = arguments[1];
    if (attr != undefined && attr.constructor == Object) {
	for (var prop in attr)
	    n[prop] = attr[prop];
	firstkid = 2;
    }
    for (var i = firstkid; i < arguments.length; i++)
	app(n, arguments[i]);
    return n;
}

/* Install a tag as a top-level function. 
 */
function install_tag(tag) {
// This must be done in a separate function to get the scoping of the
// captured variable 'tag' right.

    window[tag] = function(args) {
	var nargs = new Array(tag);
	nargs.length = arguments.length+1;
	for (var i = 0; i < arguments.length; i++) {
	    nargs[i+1] = arguments[i];
	}
	return node.apply(node, nargs);
    }
}

for (var t in tags)
    install_tag(tags[t]);
