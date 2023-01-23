// requires ezdom.js

var create_header = function(title, language) {
  let translations = {
    en: {
        CIVS_logo: "CIVS logo",
        Condorcet_Internet_Voting_Service: "Condorcet Internet Voting Service",
        About_CIVS: "About CIVS",
        Public_polls: "Public polls",
        Activate_user: "Activate user",
        Create_new_poll: "Create a poll",
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
    },
    uk: {
        CIVS_logo: "CIVS logo",
        Condorcet_Internet_Voting_Service: "Служба Інтернет-голосування Condorcet",
        About_CIVS: "About CIVS",
        Public_polls: "Public polls",
        Activate_user: "Активувати користувача",
        Create_new_poll: "Створіть опитування",
        Security_and_privacy: "Безпека та конфіденційність",
        FAQ: "FAQ"
    },
    ta: {
        CIVS_logo: "CIVS logo",
        Condorcet_Internet_Voting_Service: "Condorcet இணைய வாக்களிப்பு சேவை",
        About_CIVS: "About CIVS",
        Public_polls: "Public polls",
        Activate_user: "பயனரை இயக்கவும்",
        Create_new_poll: "வாக்கெடுப்பை உருவாக்கவும்",
        Security_and_privacy: "பாதுகாப்பு மற்றும் தனியுரிமை",
        FAQ: "FAQ"
    },
    hi: {
        CIVS_logo: "CIVS logo",
        Condorcet_Internet_Voting_Service: "कोंडोरसेट इंटरनेट मतदान सेवा",
        About_CIVS: "About CIVS",
        Public_polls: "Public polls",
        Activate_user: "उपयोगकर्ता को सक्रिय करें",
        Create_new_poll: "एक जनमत बनाएँ",
        Security_and_privacy: "सुरक्षा और गोपनीयता",
        FAQ: "FAQ"
    },
    ko: {
        CIVS_logo: "CIVS logo",
        Condorcet_Internet_Voting_Service: "콩도르세 인터넷 투표 서비스",
        About_CIVS: "About CIVS",
        Public_polls: "Public polls",
        Activate_user: "사용자 활성화",
        Create_new_poll: "설문조사 만들기",
        Security_and_privacy: "보안 및 개인정보 보호",
        FAQ: "FAQ"
    },
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
