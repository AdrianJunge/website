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

document.addEventListener('DOMContentLoaded', function() {
	const pathsElement = document.querySelectorAll(".text-blue-400");
	const typingCommand = document.querySelectorAll(".typing-command");
	const lastInput = document.getElementById("terminal-last-input");
	
	setTimeout(function() {
		typingCommand[0].classList.remove('typing-command');
		pathsElement.forEach((path) => (path.style.visibility = "visible"));
		lastInput.style.visibility = "visible";
	}, 2000);
});
