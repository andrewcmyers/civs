// A few useful tags. Add more!
var tags = [
    'ul', 'li', 'ol', 'p', 'b', 'i', 'em', 'table', 'tbody', 'tr', 'td', 'div',
    'span', 'h1', 'h2', 'h3', 'h4', 'a', 'br'
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
function node(tag) {
    var n = document.createElement(tag);
    var firstkid = 1;
    var attr = arguments[1];
    //alert("in node with " + arguments.length + " arguments. tag: " + tag + ' attr: ' + attr);
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
	//alert('applying ' + tag + ' to ' + arguments.length + " args ") ;
	for (var i = 0; i < arguments.length; i++) {
	    //alert("arg " + (i+1) + " = " + arguments[i]);
	    nargs[i+1] = arguments[i];
	}
	//alert('applying node to ' + nargs + ' ' + nargs.length);
	return node.apply(node, nargs);
    }
}

for (var t in tags)
    install_tag(tags[t]);
