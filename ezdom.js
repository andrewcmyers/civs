// Making it very convenient to create DOM nodes from JavaScript.
// by Andrew Myers, June 2013.
//
// For all tags listed in the array "tags" below, it creates functions
// with the same name that create DOM nodes. For example, the p() function
// creates a DOM node corresponding to HTML <p>...</p>.
//
// Each function accepts an optional first argument that is a map from
// attribute names to values. The optional second and following arguments
// may either be DOM nodes, strings, numbers, or arrays. Strings and numbers
// are converted to text nodes; arrays are flattened as though each element
// in the array was provided as an argument.
//
// Example: p({className: "short"}, em("this"), a({href: "http://"}, "link"))
// The result is equivalent to:
//          <p class="short"><em>this</em><a href="http://">link</a></p>

// A few useful tags. More could be added.
var tags = [
    'ul', 'li', 'ol', 'p', 'b', 'i', 'em', 'table', 'thead', 'tbody', 'tr',
    'td', 'th', 'div', 'span', 'h1', 'h2', 'h3', 'h4', 'a', 'br', 'input',
    'blockquote', 'select', 'option', 'sup', 'sub', 'strong', 'pre', 'canvas',
    'button', 'img', 'hr'
]

/* Append the second and following arguments as children of node n,
   creating text nodes for arguments that are strings or numbers
   and flattening array arguments recursively.
   Return n.
 */
function app(n) {
  for (var i = 1; i < arguments.length; i++) {
    var k = arguments[i]
    if (typeof k == "string") {
	n.appendChild(document.createTextNode(k))
    } else if (typeof k == "number") {
        n.appendChild(document.createTextNode(k.toString()))
    } else if (k.constructor == Array) {
        for (var j in k) {
	    app(n, k[j])
        }
    } else {
	n.appendChild(k)
    }
  }
  return n
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
    var n = document.createElement(tag),
        firstkid = 1
        attr = arguments[1]
    if (attr != undefined && attr.constructor == Object) {
	for (var prop in attr)
	    n[prop] = attr[prop]
	firstkid = 2
    }
    for (var i = firstkid; i < arguments.length; i++)
	app(n, arguments[i])
    return n
}

/* Install a tag as a top-level function. 
 */
function install_tag(tag) {
    window[tag] = function(args) {
	var nargs = new Array(tag)
	nargs.length = arguments.length+1
	for (var i = 0; i < arguments.length; i++) {
	    nargs[i+1] = arguments[i]
	}
	return node.apply(node, nargs)
    }
}

for (var t in tags) {
    install_tag(tags[t])
}
