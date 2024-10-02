document.addEventListener('DOMContentLoaded', function() {
    const languageSelector = document.getElementById('language-selector');

    // Check local storage for saved language
    const savedLanguage = localStorage.getItem('selectedLanguage');
    if (savedLanguage) {
        languageSelector.value = savedLanguage;
        changeLanguage(savedLanguage);
    }

    // Button event listeners to redirect based on user type
    document.getElementById('retailer-btn').addEventListener('click', function() {
        redirectToNextScreen('Retailer');
    });

    document.getElementById('customer-btn').addEventListener('click', function() {
        redirectToNextScreen('Customer');
    });
    
    document.getElementById('farmer-btn').addEventListener('click', function() {
        redirectToNextScreen('Farmer');
    });

    // Function to handle redirection logic based on user type
    function redirectToNextScreen(userType) {
        switch (userType) {
            case 'Retailer':
                window.location.href = 'retailer_login.html'; // Redirect to Retailer login page
                break;
            case 'Customer':
                window.location.href = 'customer_login.html'; // Redirect to Customer login page
                break;
            case 'Farmer':
                window.location.href = 'farmer_login.html'; // Redirect to Farmer login page
                break;
            default:
                console.error('Unknown user type:', userType);
        }
    }

    // Change language when selector value changes
    languageSelector.addEventListener('change', function() {
        const selectedLanguage = languageSelector.value;
        localStorage.setItem('selectedLanguage', selectedLanguage);
        changeLanguage(selectedLanguage);
    });

    // Example function to simulate language change logic
    function changeLanguage(language) {
        // You could implement logic to change language here if needed
        console.log(`Language changed to: ${language}`);
    }
});
