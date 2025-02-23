document.querySelectorAll('.ctf-card').forEach(card => {
    card.addEventListener('click', function() {
        document.querySelectorAll('.ctf-card').forEach(otherCard => {
            otherCard.classList.remove('expanded');
            otherCard.style.transform = '';
        });

        if (!card.classList.contains('expanded')) {
            card.classList.add('expanded');

            const rect = card.getBoundingClientRect();
            const centerX = rect.left + rect.width / 2;
            const centerY = rect.top + rect.height / 2;
            const viewportWidth = window.innerWidth;
            const viewportHeight = window.innerHeight;

            const translateY = (viewportHeight / 2) - centerY;
            const translateX = (viewportWidth / 2) - centerX;

            const targetScale = viewportWidth / rect.width * 0.43;

            card.style.transform = `translate(${translateX}px, ${translateY}px) scale(${targetScale})`;
        } else {
            card.classList.remove('expanded');
            card.style.transform = 'translate(0, 0) scale(1)';
            card.style.transition = 'transform 0.2s ease-in-out';
        }
    });

    card.querySelectorAll('.ctf-button').forEach(button => {
        button.addEventListener('click', function(event) {
            event.stopPropagation();
        });
    });
});
