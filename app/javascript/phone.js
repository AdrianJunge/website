setTimeout(() => {
    const statusElement = document.getElementById('status');
    statusElement.classList.add('animate-change-text');
    statusElement.textContent = 'PWNED!';
}, 1000);
