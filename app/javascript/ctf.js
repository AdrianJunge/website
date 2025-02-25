document.querySelectorAll('.ctf-card').forEach(card => {
    card.addEventListener('click', function () {
        document.querySelectorAll('.ctf-card').forEach(otherCard => {
            if (otherCard !== card) {
                otherCard.classList.remove('expanded');
                otherCard.style.transform = '';
                otherCard.style.zIndex = '';
            }
        });

        if (!card.classList.contains('expanded')) {
            card.classList.add('expanded');
            card.style.zIndex = '10';

            const rect = card.getBoundingClientRect();
            const centerX = rect.left + rect.width / 2;
            const centerY = rect.top + rect.height / 2;
            const viewportWidth = window.innerWidth;
            const viewportHeight = window.innerHeight;

            const translateY = (viewportHeight / 2) - centerY;
            const translateX = (viewportWidth / 2) - centerX;

            const minDimension = Math.min(rect.width, rect.height);
            const minViewport = Math.min(viewportWidth, viewportHeight);
            const targetScale = minViewport / minDimension * 0.9;

            card.style.transform = `translate(${translateX}px, ${translateY}px) scale(${targetScale})`;
            card.style.transition = 'transform 0.3s ease-in-out';
        } else {
            card.classList.remove('expanded');
            card.style.transform = '';

            requestAnimationFrame(() => {
                card.style.transition = 'transform 0.3s ease-in-out';
                card.style.transform = 'none';
            });

            setTimeout(() => {
                card.style.zIndex = '';
            }, 500);
        }
    });

    card.querySelectorAll('.ctf-button').forEach(button => {
        button.addEventListener('click', function (event) {
            event.stopPropagation();
        });
    });
});
