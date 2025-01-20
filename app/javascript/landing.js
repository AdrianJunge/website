function addStars() {
	for (var i = 0; i < 250; i++) {
		var star =
		'<div class="star m-0" style="animation: twinkle ' +
		(Math.random() * 2 + 2) +
		's linear ' +
		(Math.random() * 0.1) +
		's infinite; top: ' +
		Math.random() * $(window).height() +
		'px; left: ' +
		Math.random() * $(window).width() +
		'px;"></div>';
		$('.homescreen').append(star);
	}
}

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
	
	minimizeButton.addEventListener("click", function () {
		terminal.classList.add("terminal-minimized");
	});
	closeButton.addEventListener("click", function () {
		terminal.classList.add("terminal-minimized");
	});
	
	terminalTaskbarIcon.addEventListener("click", function () {
		terminal.classList.remove("terminal-minimized");
	});
}

document.addEventListener('DOMContentLoaded', function() {
	typingEffect();
	minimizeTerminal();
});

addStars();
