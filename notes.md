# TODOs
- Redundantes CSS wie zB für die ganzen Buttons das Hoverzeug custom tailwindcss classes anlegen
    - alle Tailwind classes durchgehen und Redundanzen/Inkonsistenzen entfernen zB abgerundete Ecken immer 3xl bzw custom class anlegen
- SEO (search engine optimization)
- Orientieren an https://sky-lance.github.io/
- about me als landing Page mit Welcome Message etc und kleines gif Terminal nav und shortcuts
    - Resumee/CV (oder nur Teile davon)
        - Englisch/Deutsch
        => was muss man beachten wenn man sein CV online stellt
    - Ask me anything - Chatbot (chat with me)
    - Bild von mir zB als Hintergrund oder als kleiner Bildkasten wie die anderen Bilder
    - "irgendwie noch etwas mehr Beschreibung als I'm Adrian. Irgendein Lebensmotto oder Slogan oder so"
- Fehler pages updaten
- kompletten boiler plate Code von Rails durchgehen und das rauswerfen was ich nicht brauche
- vurlo.de sichern und DNS einrichten
- Email einrichten für Domaine
    - Forwarding
    - als contact angeben in Terminal + Footer
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
- Font size für Handy anpassen - ist zu klein
    => vgl mit medium blogs
- Firefox
    - CSS fixen
- Landing Page Footer nicht ganz unten und scrollbar
    - 100dvh
- Der Text ist zu klein auf mobile
- Auf Desktop ist alles etwas groß, auf mobile alles etwas zu klein (wird aber etwas gefixt vom viewport tag)
## Terminal
- internal statt external links
- Das Terminal könnte vllt von unten hochgeschoben werden, statt einfach so aufzuploppen
## Nav
- Back button mit Pfeil

# Security
- Fetched ctf favicon sanitzen wegen XSS vector

# Fix
- Terminal nav button geht aus Bildschirm raus sobald zu klein
- tailwindcss flowbite plugin fixen
    => evtl neues Setup und Code übernehmen
- Terminal Height passt nicht ganz zum content - es wird was abgeschnitten
- Writeups in Datenbank verschieben anstatt .md files einzulesen
    => kein Potenzial mehr für Path Traversals
    => Brakeman ignore Test wieder rausnehmen (/config/brakeman.ignore)
- keine Warnung bei Terminal Hyperlinks + Weiterleitung im gleichen Fenster
- taskbar-label haben nicht beim ersten Mal Laden opacity-1 erst sobald transitionend beim Ausklappen der Taskbar
- Heroku Warnings durchgehen und evtl fixen
