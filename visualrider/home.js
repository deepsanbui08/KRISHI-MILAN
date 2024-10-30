document.addEventListener('DOMContentLoaded', () => {
    const navigateButtons = document.querySelectorAll('.navigate-btn');

    navigateButtons.forEach(button => {
        button.addEventListener('click', (e) => {
            const link = e.target.getAttribute('data-link');
            window.location.href = link;  // Navigate to the respective page
        });
    });
});
