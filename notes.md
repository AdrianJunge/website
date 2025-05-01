# Content
- xterm + flowbite css über CDN fetchen
- Landing Page anpassen
    - https://unbounce.com/landing-page-examples/best-landing-page-examples/
    - Images von KIT/KITCTF lieber wegpacken oder vlt als Emoji falls das irgendwie geht
    - Schrift größer
    - Writeups direkt verlinken bzw "latest content"
- about me als landing Page mit Welcome Message etc und kleines gif Terminal nav und shortcuts
    - Resumee/CV (oder nur Teile davon)
        - Englisch/Deutsch
        => was muss man beachten wenn man sein CV online stellt
    - Ask me anything - Chatbot (chat with me)
    - Bild von mir zB als Hintergrund oder als kleiner Bildkasten wie die anderen Bilder
    - "irgendwie noch etwas mehr Beschreibung als I'm Adrian. Irgendein Lebensmotto oder Slogan oder so"
- Impressum
- RSS Feed
    - Writeups
    - Blog
    ...
- Dynamischer Hintergrund
- CTF
    - Übersicht mit allen CTFs für die ich Writeups habe oder noch anfertigen möchte
        - PicoCTF
        - GlacierCTF
        - 0CTF
        - THM
        - OpenECSC
        - FaustCTF
        - HackluCTF
        - SaarCTF
        - SnakeCTF + Final
    - Writeup Overview
        - Sortieren nach Datum
    - Writeup
        - Hintergrund Image des CTFs
    - Suchfilter und Filteroption nach Jahr
    - Archievements
- Contact
    - Email Adresse
- Upcoming
    - Blog
        - Java Strings
    - Real World Exploitation (Bug Bounty/CVE)
    - Competitive Programming
    - Minigames (eigene App wie das Terminal)
        - TicTacToe vs AI
    - Tools
- Content Management
    - Admin Account
        - dieser kann neue Inhalte hochladen
    - Management
        - Writeups/Blogs erstellen/editieren/löschen
        - live Rendering des Markdowns

# Visuals
- Writeup padding-left-right etwas erhöhen, sodass der expand Button nicht mehr knapp drüber ist
- Redundantes bzw alles an CSS wie zB für die ganzen Buttons das Hoverzeug custom tailwindcss classes anlegen
    - alle Tailwind classes durchgehen und Redundanzen/Inkonsistenzen entfernen zB abgerundete Ecken immer 3xl bzw custom class anlegen
- Taskbar Icons sind klickbar auch wenn die Taskbar nicht expanded ist
- Fehler pages updaten
- Firefox
    - CSS fixen
## Terminal
- internal statt external links
    => keine Warnung bei Terminal Hyperlinks + Weiterleitung im gleichen Fenster
- Das Terminal könnte vllt von unten hochgeschoben werden, statt einfach so aufzuploppen
- localstore speichern ob Terminal gerade collapsed ist oder nicht => seitenübergreifend bleibt das Terminal auf

# Misc
- Orientieren an https://sky-lance.github.io/
- SEO (search engine optimization)
- kompletten boiler plate Code von Rails durchgehen und das rauswerfen was ich nicht brauche
- vurlo.de sichern und DNS einrichten
- Email einrichten für Domaine
    - Forwarding
    - als contact angeben in Terminal + Footer

# Security
- Fetched ctf favicon sanitzen wegen XSS vector mit DOMPurify

# Fix
- /ctf wenn man neben den geöffneten Kreis klickt soll der Kreis wieder minimiert werden
- Terminal nav button geht aus Bildschirm raus sobald zu klein
- tailwindcss flowbite plugin fixen
    => evtl neues Setup und Code übernehmen
- Terminal Height passt nicht ganz zum content - es wird was abgeschnitten
- Writeups in Datenbank verschieben anstatt .md files einzulesen
    => kein Potenzial mehr für Path Traversals
    => Brakeman ignore Test wieder rausnehmen (/config/brakeman.ignore)
- Heroku Warnings durchgehen und evtl fixen
