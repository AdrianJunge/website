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

class RandomTyped extends Typed {
    async typewrite(chars, curString, curStrPos) {
        if (!this.el) return;
        const randomSpeed = Math.floor(Math.random() * 50) + 25;
        await new Promise(r => setTimeout(r, randomSpeed));
        super.typewrite(chars, curString, curStrPos);
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const el = document.getElementById('typing');
    if (!el) return;

    const phrases = [
        'Discover here my CTF writeups & projects',
        'Web and occasionally PWN player',
        'CTF enthusiast',
        'Your browser knows everything - XSLeaks just politely ask',
        'I love breaking stuff so others can fix it',
        'I write to deepen my understanding, and maybe it actually helps others along the way',
        'If it runs, I poke it',
        'I like puzzles that crash systems',
        'Teaching machines to misbehave',
        // 'Currently learning: <TODO>'
    ];

    new RandomTyped(el, {
        strings: phrases,
        typeSpeed: 100,
        backSpeed: 50,
        backDelay: 2000,
        startDelay: 600,
        loop: true,
        smartBackspace: true,
        showCursor: true,
        cursorChar: '|',
        shuffle: true,
    });
});
