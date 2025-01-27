function typingEffect() {
	const pathsElement = document.querySelectorAll(".command-output");
	const typingCommand = document.querySelectorAll(".typing-command");
	const lastInput = document.getElementById("terminal-last-input");
	
	const textLength = typingCommand[0].textContent.length;
	typingCommand[0].style.setProperty('--steps', textLength + 1);

	setTimeout(function() {
		typingCommand[0].classList.remove('typing-command');
		pathsElement.forEach((path) => (path.style.visibility = "visible"));
		lastInput.style.visibility = "visible";
	}, 2000);
}

function minimizeTerminal() {
	const minimizeButton = document.getElementById("minimize-terminal");
	const closeButton = document.getElementById("close-terminal");
	const terminal = document.getElementById("terminal");
	const terminalTaskbarIcon = document.getElementById("terminal-taskbar-icon");
	const help = document.getElementById("help-taskbar-icon");
	
	minimizeButton.addEventListener("click", function () {
		terminal.classList.add("terminal-minimized");
	});
	closeButton.addEventListener("click", function () {
		terminal.classList.add("terminal-minimized");
	});
	
	terminalTaskbarIcon.addEventListener("click", function () {
		terminal.classList.toggle("terminal-minimized");
	});

	help.addEventListener('click', function () {
		help.classList.toggle('tooltip-visible');
	});
}

document.addEventListener('DOMContentLoaded', function() {
	typingEffect();
	minimizeTerminal();
});

  
document.addEventListener('click', function (e) {
	if (!e.target.closest('.tooltip-container')) {
		document.querySelectorAll('.tooltip-container').forEach(el => el.classList.remove('tooltip-visible'));
	}
});
