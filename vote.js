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
	rank[i] = s.selectedIndex + 1;
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
var have_rank = new Array;

function scan_ranks() {
    var i;
    for (i = 1; i <= num_choices+1; i++) have_rank[i] = false;
    for (i = 0; i < num_choices; i++) have_rank[rank[i]] = true;
}

function min_selected_rank() {
    var cur = num_choices + 1;
    num_selected = 0;
    for (var i = 0; i < num_choices; i++) {
	if (selected[i]) {
	    num_selected++;
	    if (rank[i] < cur) {
		cur = rank[i];
		//alert("new min rank " + cur + " at " + i);
	    }
	}
    }
    return cur;
}

function max_selected_rank() {
    var cur = 1;
    num_selected = 0;
    for (var i = 0; i < num_choices; i++) {
	if (selected[i]) {
	    num_selected++;
	    if (rank[i] > cur) {
		cur = rank[i];
		//alert("new max rank " + cur + " at " + i);
	    }
	}
    }
    return cur;
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

function do_move_up () {
    var min_rank = min_selected_rank();
    if (num_selected < 1) {
	alert("No choices were selected. "+
	      "Click (or shift-click) to select choices");
	return false;
    }
    if (min_rank == 1) return;
    var new_rank = min_rank - 1;
    scan_ranks();
    var collision = false;
    if (have_rank[new_rank]) { // skip over unused ranks
	collision = true;
    } else while (!have_rank[new_rank - 1] && new_rank > 1 ) {
	new_rank = new_rank - 1;
    }
    for (var i = 0; i < num_choices; i++) {
	if (selected[i]) {
	    set_rank(i, new_rank);
	} else if (collision && rank[i] == new_rank) {
	    set_rank(i, rank[i] + 1);
	}
    }
    sort_rows();
}

function do_move_down () {
    var max_rank = max_selected_rank();
    if (num_selected < 1) {
	alert("No choices were selected. "+
	      "Click (or shift-click) to select choices");
	return false;
    }
    if (max_rank == num_choices + 1) return;
    var new_rank = max_rank + 1;
    scan_ranks();
    var collision = false;
    if (have_rank[new_rank]) { // skip over unused ranks
	collision = true;
    } else while (!have_rank[new_rank + 1] &&
     	          new_rank < num_choices) {
	new_rank = new_rank + 1;
    }
    for (var i = 0; i < num_choices; i++) {
	if (selected[i]) {
	    set_rank(i, new_rank);
	} else if (collision && rank[i] == new_rank) {
	    set_rank(i, rank[i] - 1);
	}
    }
    sort_rows();
}

function do_move_top() {
    var min_rank = min_selected_rank();
    if (min_rank <= cur_top) cur_top = 1;
    scan_ranks();
    var collision = have_rank[min_rank];
    for (var i = 0; i < num_choices; i++) {
	if (selected[i]) {
	    set_rank(i, cur_top);
	} else if (collision && rank[i] >= cur_top && rank[i] < min_rank) {
	    set_rank(i, rank[i] + 1);
	}
    }
    cur_top++;
    sort_rows();
}
function do_move_bottom() {
    var max_rank = max_selected_rank();
    if (max_rank >= cur_bot) cur_bot = num_choices;
    scan_ranks();
    var collision = have_rank[max_rank];
    for (var i = num_choices-1; i >= 0; i--) {
	if (selected[i]) {
	    if (rank[i] >= cur_bot) cur_bot = num_choices;
	    set_rank(i, cur_bot);
	} else if (collision && rank[i] <= cur_bot && rank[i] > max_rank) {
	    set_rank(i, rank[i] - 1);
	}
    }
    cur_bot--;
    sort_rows();
}
