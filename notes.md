# TODOs
- Terminal
    - maxTerminalWidth ersetzen durch tatsächliche Terminal width
- ctf-cards
    - Titel + kurze Beschreibung des CTFs in dem runden Image
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
- Taskfile oder Makefile für easy Setup
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
        - Sidebar um an bestimmte Stelle von Post zu springen
            => diese "scrollt automatisch mit"
        - Hintergrund Image des CTFs
    - Suchfilter und Filteroption nach Jahr
    - Archievements
- About
    - Resumee/CV (oder nur Teile davon)
        - Englisch/Deutsch
        => was muss man beachten wenn man sein CV online stellt
    - Ask me anything - Chatbot
    - Bild von mir als Hintergrund
    - Kurze Beschreibung
        - Hobbies
        - KITCTF studying @KIT
- Help Button links unten um auf "Tutorial" page zu kommen
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

# Security
- Fetched ctf favicon sanitzen wegen XSS vector

# Fix
- Writeups in Datenbank verschieben anstatt .md files einzulesen
    => kein Potenzial mehr für Path Traversals
    => Brakeman ignore Test wieder rausnehmen (/config/brakeman.ignore)
- keine Warnung bei Terminal Hyperlinks + Weiterleitung im gleichen Fenster
- taskbar-label haben nicht beim ersten Mal Laden opacity-1 erst sobald transitionend beim Ausklappen der Taskbar
- Responsiveness
    => aus irgendeinem Grund werden einige Sachen in prod größer gerendert
    => Terminal
    - Smartphone
        - Terminal Shell nur mit $ und directory Kram weg
        - Zeilenumbruch beim Schreiben
        - Task Bar unten anstatt auf der Seite
        - Sidebar für Nav füllt kompletten Bildschirm aus
- @import "rouge" fixen
- Rouge
    - Rouge Theme dynamisch laden zB mit rouge.css.erb
        <%= Rouge::Themes::ThankfulEyes.render %>
