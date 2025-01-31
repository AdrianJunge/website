document.addEventListener('click', function (e) {
	if (!e.target.closest('.tooltip-container')) {
		document.querySelectorAll('.tooltip-container').forEach(el => el.classList.remove('tooltip-visible'));
	}
});
