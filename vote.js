var rows = new Array;
var rank = new Array;
var selected = new Array;
var preftable;
var prefsection;
var num_choices;

function sort_rows() {
    read_rows();
    //alert("sorting the rows of " + preftable);
    var permut = new Array;
    for (var i = 0; i < num_choices; i++) {
	permut[i] = i;
    }
    function compare(m,n) {
	if (rank[m] == rank[n]) return 0;
	if (rank[m] < rank[n]) return -1;
	if (rank[m] > rank[n]) return 1;
    }
    permut.sort(compare);
    diag = "";
    var newselected = new Array;
    for (var i = 0; i < permut.length; i++) {
	var j = permut[i];
	prefsection.appendChild(rows[j]);
	newselected[i] = selected[j];
	diag = diag + j;
    }
    selected = newselected;
    //alert("permutation: " + diag);
    read_rows();
}

// select the indicated row object. add is true
// if the user want to add to (or remove from)
// the current selection.
function select_row(row, add) {
    for (var i = 0; i < num_choices; i++) {
	if (!add) {
	    rows[i].className = null;
	    selected[i] = false;
	}
	if (rows[i] == row) {
	    selected[i] = !selected[i];
	    if (selected[i]) row.className = "selected";
	    else row.className = null;
	}
    }
}

function read_rows() {
    //alert("reading the rows, length = " + (preftable.rows.length - 1));
    for (var i = 0; i < num_choices; i++) {
	var row = rows[i] = preftable.rows[i+1];
	//alert("Row " + i + " = " + row + " parent = " + row.parentNode);
	var s = row.getElementsByTagName("select")[0];
	s.onchange = function() { sort_rows(); }
	rank[i] = Number(s.options[s.selectedIndex].value);
    }
}

var cur_top;
var cur_bot;

function setup() {
    var button = document.getElementById("sort_button");
    button.parentNode.removeChild(button);

    preftable = document.getElementById("preftable");
    prefsection = preftable.rows[0].parentNode;
    num_choices = preftable.rows.length - 1;

    document.CastVote.move_top.disabled = false;
    document.CastVote.move_up.disabled = false;
    document.CastVote.make_tie.disabled = false;
    document.CastVote.move_down.disabled = false;
    document.CastVote.move_bottom.disabled = false;

    cur_top = 1;
    cur_bot = num_choices;

    sort_rows();
}

var num_selected;

function min_selected_rank() {
    var min_rank = num_choices + 1;
    num_selected = 0;
    for (var i = 0; i < num_choices; i++) {
	if (selected[i]) {
	    num_selected++;
	    if (rank[i] < min_rank) {
		min_rank = rank[i];
		//alert("min rank " + min_rank + " at " + i);
	    }
	}
    }
    return min_rank;
}

function set_rank(i, r) {
    //alert("Setting rank of " + i + " to " + r);
    rank[i] = r;
    var s = rows[i].getElementsByTagName("select")[0];
    s.selectedIndex = r - 1;
}

function do_make_tie() {
    var min_rank = min_selected_rank();
    if (num_selected < 2) {
	alert("Not enough choices were selected. "+
	      "Shift-click to select two or more choices");
	return false;
    }
    for (var i = 0; i < num_choices; i++) {
	if (selected[i]) set_rank(i, min_rank);
    }
    sort_rows();
}

function do_move (delta) {
    var min_rank = min_selected_rank();
    if (num_selected < 1) {
	alert("No choices were selected. "+
	      "Click (or shift-click) to select choices");
	return false;
    }
    var new_rank = min_rank + delta;
    var collision = false;
    if (new_rank < 1) new_rank = 1;
    for (var i = 0; i < num_choices; i++) {
	if (selected[i]) {
	    set_rank(i, new_rank);
	} else {
	    if (!selected[i] && rank[i] == new_rank)
		collision = true;
	}
    }
    if (collision) { // shift things at that rank the other way
	for (var i = 0; i < num_choices; i++) {
	    if (!selected[i] && rank[i] == new_rank) {
		set_rank(i, rank[i] - delta);
	    }
	}
    }
    sort_rows();
}

function do_move_up () { do_move(-1); }
function do_move_down () { do_move(1); }

function do_move_top() {
    var min_rank = min_selected_rank();
    var collision = false;
    for (var i = 0; i < num_choices; i++) {
	if (selected[i]) {
	    if (rank[i] <= cur_top) { // already at top
		cur_top = 1;
	    }
	    set_rank(i, cur_top);
	} else {
	    if (!selected[i] && rank[i] == cur_top)
		collision = true;
	}
    }
    if (collision) { // shift things in between
	for (var i = 0; i < num_choices; i++) {
	    if (!selected[i] && rank[i] >= cur_top &&
		                rank[i] < min_rank) {
		set_rank(i, rank[i] + 1);
	    }
	}
    }
    cur_top++;
    sort_rows();
}
function do_move_bottom() {
    var min_rank = min_selected_rank();
    var collision = false;
    for (var i = 0; i < num_choices; i++) {
	if (selected[i]) {
	    if (rank[i] >= cur_bot) { // already at top
		cur_bot = num_choices;
	    }
	    set_rank(i, cur_bot);
	} else {
	    if (!selected[i] && rank[i] == cur_bot)
		collision = true;
	}
    }
    if (collision) { // shift things in between
	for (var i = 0; i < num_choices; i++) {
	    if (!selected[i] && rank[i] <= cur_bot &&
		                rank[i] > min_rank) {
		set_rank(i, rank[i] - 1);
	    }
	}
    }
    cur_bot--;
    sort_rows();
}
