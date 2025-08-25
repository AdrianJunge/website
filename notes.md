# Content
- Search bar for ctfs and writeups
- “My Challenges” Section adden zu CTF (unter Angabe bei welchem CTF das veröffentlicht wurde und Link zu meinem Writeup dazu)
    => Übersicht über meine Challenges
    => jeweils redirect zu bereits published Post
- Autoren auflisten auf Website für CTF
- xterm + flowbite css über CDN fetchen
- ctf tags clickable machen sodass gefiltert wird nach dem tag unter den writeups
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
    - Landing Page improvement
        - Text about me left aligned
        - Bild von mir zB als Hintergrund oder als kleiner Bildkasten wie die anderen Bilder
    - "irgendwie noch etwas mehr Beschreibung als I'm Adrian. Irgendein Lebensmotto oder Slogan oder so"
- Impressum
- Dynamischer Hintergrund
- RSS Feed
    - Blog
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
        - Codewhite bzw Deadsecctf webmiau exploit aufschlüsseln
        - Java Strings
        - Falls Wordpress CVE gefunden mit POP Chain diese ebenfalls im Blog veröffentlichen
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
- Writeups
    - Anstatt Screenshots, Challenge HTML embedden und so aussehen lassen als wäre es wie in einem eigenen Browserfenster
    => https://github.com/felixfbecker/dom-to-svg
- Redundantes bzw alles an CSS wie zB für die ganzen Buttons das Hoverzeug custom tailwindcss classes anlegen
    - alle Tailwind classes durchgehen und Redundanzen/Inkonsistenzen entfernen zB abgerundete Ecken immer 3xl bzw custom class anlegen
- Taskbar Icons sind klickbar auch wenn die Taskbar nicht expanded ist
- Fehler pages updaten
- Firefox
    - CSS fixen
- Scrolling out/in führt dazu dass "Table of content" Überschrift zu klein ist/unproportional zum Rest
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
- table of contents - sobald zu einer section gescrollt wird dessen title die ganze Box ausfüllt wird die Box nochmal größer
- Terminal nav button geht aus Bildschirm raus sobald zu klein
- tailwindcss flowbite plugin fixen
    => evtl neues Setup und Code übernehmen
- Terminal Height passt nicht ganz zum content - es wird was abgeschnitten
- Writeups und paths für ctf file zips in Datenbank verschieben anstatt .md files einzulesen
    => kein Potenzial mehr für Path Traversals
    => Brakeman ignore Test wieder rausnehmen (config/brakeman.ignore)
- Pipeline aufsetzen, welche automatisch neue oder edited Markdown Writeups zu HTML parsed, sodass nicht bei jedem Request unnötig neu geparsed wird
- Heroku Warnings durchgehen und evtl fixen
