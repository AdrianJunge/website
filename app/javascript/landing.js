document.addEventListener('click', function (e) {
	if (!e.target.closest('.tooltip-container')) {
		document.querySelectorAll('.tooltip-container').forEach(el => el.classList.remove('tooltip-visible'));
	}
});

function toggleTaskbar(side) {
	const taskbar = document.getElementById(`taskbar-${side}`);
	const icons = document.getElementById(`taskbar-icons-${side}`);
  
	// Toggle class to open/close the taskbar
	taskbar.classList.toggle('expanded');
	
	// Toggle visibility of icons and text
	icons.classList.toggle('visible');
  }
  
  // Event listeners für das Burgermenü
  document.addEventListener('DOMContentLoaded', function () {
	const burgerMenuLeft = document.querySelectorAll('.taskbar-icon[data-burger="left"]');
	const burgerMenuRight = document.querySelectorAll('.taskbar-icon[data-burger="right"]');
  
	burgerMenuLeft.forEach(menu => {
	  menu.addEventListener('click', toggleTaskbar);
	});
	
	burgerMenuRight.forEach(menu => {
	  menu.addEventListener('click', toggleTaskbar);
	});
});

document.addEventListener("DOMContentLoaded", function () {
	const menuIcon = document.getElementById("menu-icon");
	const taskbarLeft = document.getElementById("taskbar-left");
  
	menuIcon.addEventListener("click", function () {
	  taskbarLeft.classList.toggle("expanded");
	  taskbarLeft.classList.toggle("collapsed");
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
		console.log("transitionstart collapsing")
        document.querySelectorAll('.taskbar-label').forEach(function(label) {
            label.style.whiteSpace = 'nowrap';
            label.style.opacity = '0';
        });
    }
});
