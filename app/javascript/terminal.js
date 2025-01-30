import "xterm";
import "xterm-addon-web-links";

//                                  _.
//                            _.-----'' \`
//                __..-----'''            \`.
//               <            \`.           \'
//               :.              \`.           \`
//                \`:.              \`.           \`-.
//                  \`: N  o         \`.            \`+.
//                    \`:. A  s  i      \`.  __.===::::;)
//    .         r   I   \`: c       ___.__>'::::::a:f/'
//         C          A   \`.  _,===:::=-'-=-"""''
//     i      d  t         '-/:::''
//                           ''
const fastFetchInfo = `
  _____                          _                                      
 |  __ \\                        | |                               ____  
 | |__) |   ___    __ _    ___  | |__      _ __ ___     ___      / __ \\ 
 |  _  /   / _ \\  / _\` |  / __| | '_ \\    | '_ \` _ \\   / _ \\    / / _\` |
 | | \\ \\  |  __/ | (_| | | (__  | | | |   | | | | | | |  __/   | | (_| |
 |_|  \\_\\  \\___|  \\__,_|  \\___| |_| |_|   |_| |_| |_|  \\___|    \\ \\__,_|
                                                                 \\____/ 
`
const aboutMe = `
\tDiscord:\t${createHyperlink('Discord', 'https://discord.com/users/305624492221267968')}
\tGitHub:\t\t${createHyperlink('GitHub', 'https://github.com/AdrianJunge/')}
\tLinkedin:\t${createHyperlink('Linkedin', 'https://www.linkedin.com/in/adrian-junge-998a63296/')}
`

const viewportHeight = window.innerHeight;
const fontSize = viewportHeight / 30;
const term = new Terminal({
    convertEol: true,
    fontSize: fontSize,
});  
const webLinksAddon = new WebLinksAddon.WebLinksAddon()

const COLORS = {
    reset: '\x1B[0m',         
    red: '\x1B[31m',          
    green: '\x1B[32m',        
    yellow: '\x1B[33m',       
    blue: '\x1B[34m',         
    magenta: '\x1B[35m',      
    cyan: '\x1B[36m',         
    white: '\x1B[37m',        
    bold: '\x1B[1m',          
};

function printMultiLineString(str=fastFetchInfo, color=COLORS.white) {
    const lines = str.split('\n');
    lines.forEach((line) => {
        term.writeln(colorize(line, color));
    });
}

function colorize(text, color) {
    return color + text + COLORS.reset;
}

function printLine(text, color=COLORS.blue) {
    term.write(colorize(text, color));
}

function createHyperlink(text, url) {
    return `\x1b]8;;${url}\x07${text}\x1b]8;;\x07`
}

const customOpenLink = (url) => {
    window.location.href = url;
}

function typeText(text, color, callback) {
    let i = 0;
    const interval = setInterval(() => {
        printLine(text.charAt(i), color);
        i++;
        if (i === text.length) {
            clearInterval(interval);
            if (callback) callback();
        }
    }, 100); 
}

function getTargetUrl(path) {
    let url;
    if (path === '~') {
        url = window.location.origin;
    } else if (path === '.') {
        url = window.location.href;
    } else if (path === '..') {
        url = window.location.origin + window.location.pathname.split('/').slice(0, -1).join('/');
    } else {
        url = window.location.href.endsWith("/") ? window.location.href + path : window.location.href + "/" + path;
    }
    return url
}

const initTerminal = () => {
    const terminalElement = document.getElementById('terminal');
    const pathsArray = JSON.parse(terminalElement.dataset.terminalText);
    
    term.open(terminalElement);
    webLinksAddon._openLink = customOpenLink;
    term.loadAddon(webLinksAddon);

    if (window.location.pathname === '/') {
        printMultiLineString(fastFetchInfo, COLORS.green);
        printMultiLineString(aboutMe, COLORS.bold);
    }

    printLine('adrian@my-space:~$ ', COLORS.red);
    typeText('ls -lah ~', COLORS.white, () => {
        generateLsOutput(pathsArray);
        printLine('\nadrian@my-space:~$ ', COLORS.red);
    });

    let inputBuffer = '';  

    term.onData(function(data) {
        if (data === '\r' || data === '\n') {
            const command = inputBuffer.trim();  
            inputBuffer = '';  

            if (command.startsWith('ls')) {
                generateLsOutput(pathsArray);
                printLine('\nadrian@my-space:~$ ', COLORS.red);
            }
            else if (command.startsWith('cd ')) {
                const target = command.substring(3).trim();
                
                if (pathsArray.includes(target)) {
                    let targetUrl;

                    targetUrl = getTargetUrl(target);

                    printLine(`\n  Changing to ${target}...\n`);
                    printLine(`\nadrian@my-space:~$ `, COLORS.red);
                    window.location.href = targetUrl;  
                } else {
                    printLine(`\n  Directory "${target}" not found.`, COLORS.white);
                    printLine(`\nadrian@my-space:~$ `, COLORS.red);
                }
            } else if (command === 'help') {
                printLine('\n  Available commands:');
                printLine('\n\t- help: Shows this help message');
                printLine('\n\t- ls: Lists the directories');
                printLine('\n\t- cd <directory>: Navigates to a directory');
                printLine('\n\t- clear: Clears the terminal');
                printLine('\nadrian@my-space:~$ ', COLORS.red);
            } else if (command === 'clear') {
                term.clear();
                printLine('\nadrian@my-space:~$ ', COLORS.red);
            } else {
                printLine(`\n  Command not recognized: ${command}`, COLORS.white);
                printLine(`\nadrian@my-space:~$ `, COLORS.red);
            }
        } else {
            inputBuffer += data;
            term.write(data);
        }
    });
};

function getFormattedDate() {
    const now = new Date();
    const formatted = new Intl.DateTimeFormat('en-US', {
      month: 'short', 
      day: 'numeric', 
      hour: '2-digit', 
      minute: '2-digit', 
      hour12: false
    }).format(now);
    return formatted.replace(',', '');
  }

function generateLsOutput(pathsArray) {
    pathsArray.forEach(path => {
        let pathDisplay = path;
        let hyperlink = '';
        let url = '';
        
        url = getTargetUrl(path);

        hyperlink = createHyperlink(pathDisplay, url);

        if (path === '~') {
            printLine(`\n  drwxrwxr-x  5 adrian adrian  4.0K ${getFormattedDate()}  ${hyperlink}   (home)`, COLORS.blue);
        } else if (path === '.') {
            printLine(`\n  drwxrwxr-x  5 adrian adrian  4.0K ${getFormattedDate()}  ${hyperlink}   (current)`, COLORS.blue);
        } else if (path === '..') {
            printLine(`\n  drwxrwxr-x  5 adrian adrian  4.0K ${getFormattedDate()}  ${hyperlink}  (parent)`, COLORS.blue);
        } else {
            printLine(`\n  drwxrwxr-x  5 adrian adrian  4.0K ${getFormattedDate()}  ${hyperlink}`, COLORS.blue);
        }
    });
}


document.addEventListener('DOMContentLoaded', initTerminal);
