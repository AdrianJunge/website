# TODOs
- Email einrichten für Domaine
- Precommit
- vurlo.de sichern und DNS einrichten
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
- Contact
    - Email Adresse
- Upcoming
    - Blog
        - Java Strings
    - Real World Exploitation (Bug Bounty/CVE)
    - Software Engineering
    - Minigames (eigene App wie das Terminal)
        - TicTacToe vs AI
    - Tools

# Fix
- noch mehr responsiveness
    => aus irgendeinem Grund werden einige Sachen in prod größer gerendert
    => Terminal
- Writeups in Datenbank verschieben anstatt .md files einzulesen
    => kein Potenzial mehr für Path Traversals
- @import "rouge" fixen
- keine Warnung bei Terminal Hyperlinks + Weiterleitung im gleichen Fenster
- Rouge
    - Rouge Theme dynamisch laden zB mit rouge.css.erb
        <%= Rouge::Themes::ThankfulEyes.render %>
