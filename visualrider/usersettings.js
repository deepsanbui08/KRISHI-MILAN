document.addEventListener('DOMContentLoaded', () => {
    const saveButton = document.getElementById('save-settings');
    const voiceFeedback = document.getElementById('voice-feedback');
    const soundAlerts = document.getElementById('sound-alerts');
    const brightnessControl = document.getElementById('brightness-control');

    // Save settings function
    saveButton.addEventListener('click', () => {
        const settings = {
            voiceFeedback: voiceFeedback.checked,
            soundAlerts: soundAlerts.checked,
            brightness: brightnessControl.value
        };
        alert('Settings saved: ' + JSON.stringify(settings));
    });

    // Back to home button functionality
    const goBackButton = document.getElementById('go-back');
    goBackButton.addEventListener('click', () => {
        window.location.href = 'home.html';  // Navigate back to the home page
    });
});
