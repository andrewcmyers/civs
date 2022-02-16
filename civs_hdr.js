// requires ezdom.js

var create_header = function(title, language) {
  let translations = {
    en: {
        CIVS_logo: "CIVS logo",
        Condorcet_Internet_Voting_Service: "Condorcet Internet Voting Service",
        About_CIVS: "About CIVS",
        Public_polls: "Public polls",
        Activate_user: "Activate user",
        Create_new_poll: "Create new poll",
        Security_and_privacy: "Security and privacy",
        FAQ: "FAQ"
    },
    de: {
        CIVS_logo: "CIVS logo",
        Condorcet_Internet_Voting_Service: "Condorcet Internet Voting Service",
        About_CIVS: "Über CIVS",
        Public_polls: "Öffentliche Umfragen",
        Activate_user: "Benutzer aktivieren",
        Create_new_poll: "Neue Umfrage erstellen",
        Security_and_privacy: "Sicherheit und Privatsphäre",
        FAQ: "FAQ"
    },
    fr: {
        CIVS_logo: "Logo CIVS",
        Condorcet_Internet_Voting_Service: "Service de Vote Internet Condorcet (CIVS)",
        About_CIVS: "CIVS",
        Public_polls: "Les sondages publics",
        Activate_user: "Activer l'utilisateur",
        Create_new_poll: "Créer un sondage",
        Security_and_privacy: "Sécurité et confidentialité",
        FAQ: "FAQ"
    },
    es: {
        CIVS_logo: "logotipo de CIVS",
        Condorcet_Internet_Voting_Service: "Internet Condorcet Servicio de Votación (CIVS)",
        About_CIVS: "CIVS",
        Public_polls: "Encuestas públicas",
        Activate_user: "Activar usuario",
        Create_new_poll: "Crear encuesta",
        Security_and_privacy: "Seguridad y privacidad",
        FAQ: "FAQ"
    }
  }
  let lang = translations[language || 'en']

  return div({className: "banner"},
                div({className: "bannerpart", id: "bannericon"},
                    img({width: 113, src: "@CIVSURL@/images/check-civs.png",
                         style: "border: none", alt: lang.CIVS_logo})),
        div({className: "bannerpart"}, h1(lang.Condorcet_Internet_Voting_Service)),
        div({className: "bannerpart", id: "bannermenu"},
            a({href: "@CIVSHOME@"}, lang.About_CIVS), br(),
            a({href: "@CIVSURL@/publicized_polls.html"}, lang.Public_polls), br(),
            a({href: "@CIVSBINURL@/opt_in@PERLEXT@"}, lang.Activate_user), br(),
            a({href: "@CIVSURL@/civs_create.html"}, lang.Create_new_poll), br(),
            a({href: "@CIVSURL@/sec_priv.html"}, lang.Security_and_privacy), br(),
            a({href: "@CIVSURL@/faq.html"}, lang.FAQ), br()),
        br(),
        div({className: 'pagetitle'}, h2(title)))
}
