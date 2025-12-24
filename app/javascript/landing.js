import Typed from "typed.js";

document.addEventListener("DOMContentLoaded", function () {
	const menuIcons = document.querySelectorAll(".menu-icon");
	const taskbarLeft = document.getElementById("taskbar-left");

	menuIcons.forEach(function(menuIcon) {
		menuIcon.addEventListener("click", function () {
			menuIcons.forEach(icon => icon.classList.toggle('shift'));
			taskbarLeft.classList.toggle("expanded");
			taskbarLeft.classList.toggle("collapsed");
		});
	});
});

document.getElementById('taskbar-left').addEventListener('transitionend', function() {
    if (this.classList.contains('expanded')) {
        document.querySelectorAll('.taskbar-label').forEach(function(label) {
            label.style.whiteSpace = 'pre-wrap';
            label.style.opacity = '1';
        });
    }
});
document.getElementById('taskbar-left').addEventListener('transitionstart', function() {
	if (this.classList.contains('collapsed')) {
        document.querySelectorAll('.taskbar-label').forEach(function(label) {
            label.style.whiteSpace = 'nowrap';
            label.style.opacity = '0';
        });
    }
});

document.addEventListener("DOMContentLoaded", function () {
    const el = document.getElementById('typing');
    if (!el) return;

    const phrases = [
        'Welcome to my space!',
        'Explore my CTF writeups & projects',
        'Web and occasionally PWN player',
        'CTF enthusiast',
        'I love breaking stuff to fix it',
        'Hey, I\'m Adrian aka vurlo',
        'I write things that people read later',
        'If it runs, I poke it',
        'I like puzzles that crash things',
        'Teaching machines to misbehave',
        // 'Currently learning: <TODO>'
    ];

    new Typed(el, {
        strings: phrases,
        typeSpeed: 60,
        backSpeed: 30,
        backDelay: 1500,
        startDelay: 300,
        loop: true,
        smartBackspace: true,
        showCursor: true,
        cursorChar: '|',
        shuffle: true,
    });
});
