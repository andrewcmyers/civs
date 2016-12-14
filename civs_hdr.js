// requires ezdom.js
function create_header(title) {
    return div({className: "banner"},
                div({className: "bannerpart"}, img({width: 113, src: "@CIVSURL@/images/check-civs.png",
                       style: "border: none"})),
                div({className: "bannerpart"}, h1("Condorcet Internet Voting Service")),
		div({className: "bannerpart", id: "bannermenu"},
                    a({href: "@CIVSHOME@"}, "About CIVS"), br(),
                    a({href: "@CIVSURL@/publicized_polls.html"}, "Public polls"), br(),
                    a({href: "@CIVSURL@/civs_create.html"}, "Create new poll"), br(),
                    a({href: "@CIVSURL@/sec_priv.html"}, "Security and privacy"), br(),
                    a({href: "@CIVSURL@/faq.html"}, "FAQ"), br()
		), br(),
                div(h2({align: "center"}, title)))
}
