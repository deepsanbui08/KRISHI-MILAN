
        // Selecting elements
const loginToggle = document.getElementById('login-toggle');
const signupToggle = document.getElementById('signup-toggle');
const loginForm = document.getElementById('login-form');
const signupForm = document.getElementById('signup-form');

// Event listener for login button
loginToggle.addEventListener('click', function() {
    // Show login form and hide sign-up form
    loginForm.style.display = 'block';
    signupForm.style.display = 'none';
    
    // Toggle button active class
    loginToggle.classList.add('active');
    signupToggle.classList.remove('active');
});

// Event listener for sign-up button
signupToggle.addEventListener('click', function() {
    // Show sign-up form and hide login form
    signupForm.style.display = 'block';
    loginForm.style.display = 'none';

    // Toggle button active class
    signupToggle.classList.add('active');
    loginToggle.classList.remove('active');
});
