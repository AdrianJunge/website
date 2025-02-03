document.addEventListener('click', function (e) {
	if (!e.target.closest('.tooltip-container')) {
		document.querySelectorAll('.tooltip-container').forEach(el => el.classList.remove('tooltip-visible'));
	}
});

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
