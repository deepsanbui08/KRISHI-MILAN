// script.js

document.addEventListener('DOMContentLoaded', function() {
    const languageSelector = document.getElementById('language-selector');
    const elementsToTranslate = document.querySelectorAll('Selection');

    // Check local storage for saved language
    const savedLanguage = localStorage.getItem('selectedLanguage');
    if (savedLanguage) {
        languageSelector.value = savedLanguage;
        changeLanguage(savedLanguage);
    }

    document.getElementById('retailer-btn').addEventListener('click', function() {
        window.location.href = 'login.html'; // Redirect to newpage.html
    });

    // document.getElementById('customer-btn').addEventListener('click', function() {
    //     window.location.href = 'login_page.html'; // Redirect to newpage.html
    // });
    
    // document.getElementById('farmer-btn').addEventListener('click', function() {
    //     window.location.href = 'login_page.html'; // Redirect to newpage.html
    // });

    // Change language when selector value changes
    languageSelector.addEventListener('change', function() {
        const selectedLanguage = languageSelector.value;
        localStorage.setItem('selectedLanguage', selectedLanguage);
        changeLanguage(selectedLanguage);
    });

    function changeLanguage(language) {
        elementsToTranslate.forEach(element => {
            const key = element.getAttribute('data-translate');
            fetchTranslation(key, language).then(translatedText => {
                element.textContent = translatedText;
            });
        });
    }

    function fetchTranslation(key, language) {
        const apiUrl = `https://api.example.com/translate?key=${key}&lang=${language}`; // Replace with actual API URL
        return fetch(apiUrl)
            .then(response => response.json())
            .then(data => data.translation)
            .catch(error => {
                console.error('Error fetching translation:', error);
                return key; // Fallback to key if API fails
            });
    }
    window.goToRegistration = function() {
        const selectedLanguage = document.getElementById("language-selector").value;
        // Implement language change logic if needed
        window.location.href = "registration.html";
    };
});

