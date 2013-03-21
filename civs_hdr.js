// requires ezdom.js
function create_header(title) {
    return table({className: "banner", width: "100%", cellSpacing: 0, cellPadding: 7},
                   tbody(tr(td(h1("Condorcet Internet Voting Service")),
		             td({width: "0%", nowrap: true, vAlign: "top", align: "right"},
			        a({href: "@CIVSHOME@"}, "About CIVS"), br(),
			        a({href: "@CIVSURL@/publicized_polls.html"}, "Public polls"), br(),
				a({href: "@CIVSURL@/civs_create.html"}, "Create new poll"), br(),
				a({href: "@CIVSURL@/sec_priv.html"}, "Security and privacy"), br(),
				a({href: "@CIVSURL@/faq.html"}, "FAQ"), br()
			     )),
                         tr(td({colSpan: 2}, h2({align: "center"}, title)))
		   ));
}
