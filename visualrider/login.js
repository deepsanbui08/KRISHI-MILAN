document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('login-form');
    const registrationForm = document.getElementById('registration-form');
    const voiceLoginButton = document.getElementById('voice-login-btn');
    const voiceFillButton = document.getElementById('voice-fill-btn');
    const showRegistrationButton = document.getElementById('show-registration-btn');
    const showLoginButton = document.getElementById('show-login-btn');
    const hardcodedUsername = 'admin';
    const hardcodedPassword = 'password';

    // Toggle between login and registration forms
    showRegistrationButton.addEventListener('click', () => {
        loginForm.classList.add('hidden');
        registrationForm.classList.remove('hidden');
    });

    showLoginButton.addEventListener('click', () => {
        registrationForm.classList.add('hidden');
        loginForm.classList.remove('hidden');
    });

    // Handle login submission
    loginForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const username = document.getElementById('login-username').value;
        const password = document.getElementById('login-password').value;
        validateLogin(username, password);
    });

    // Handle registration submission
    registrationForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const username = document.getElementById('register-username').value;
        const password = document.getElementById('register-password').value;
        alert(`Registered successfully!\nUsername: ${username}\nPassword: ${password}`);
        registrationForm.reset();
        loginForm.classList.remove('hidden');
        registrationForm.classList.add('hidden');
    });

    // Validate login
    function validateLogin(username, password) {
        if (username === hardcodedUsername && password === hardcodedPassword) {
            window.location.href = 'home.html'; // Redirect to home page
        } else {
            alert('Invalid login credentials');
        }
    }

    // Voice login functionality
    voiceLoginButton.addEventListener('click', () => {
        const recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
        recognition.lang = 'en-US';
        recognition.start();

        recognition.onresult = (event) => {
            const transcript = event.results[0][0].transcript.toLowerCase();
            console.log('Voice command: ', transcript);
            if (transcript.includes('admin') && transcript.includes('password one two three')) {
                validateLogin(hardcodedUsername, hardcodedPassword);
            } else {
                alert('Invalid login credentials (Voice)');
            }
        };

        recognition.onerror = (event) => {
            console.error('Voice recognition error: ', event.error);
            alert('Voice recognition error');
        };
    });

    // Voice fill functionality
    voiceFillButton.addEventListener('click', () => {
        const recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
        recognition.lang = 'en-US';
        recognition.start();

        recognition.onresult = (event) => {
            const transcript = event.results[0][0].transcript.toLowerCase();
            console.log('Voice command: ', transcript);
            const details = transcript.split(' ');

            if (details.length >= 2) {
                document.getElementById('register-username').value = details[0]; // Set first word as username
                document.getElementById('register-password').value = details[1]; // Set second word as password
            } else {
                alert('Please provide both username and password');
            }
        };

        recognition.onerror = (event) => {
            console.error('Voice recognition error: ', event.error);
            alert('Voice recognition error');
        };
    });
});
