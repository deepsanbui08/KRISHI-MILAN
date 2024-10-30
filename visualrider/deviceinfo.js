document.addEventListener('DOMContentLoaded', () => {
    const refreshButton = document.getElementById('refresh-status');
    const batteryLevel = document.getElementById('battery-level');
    const deviceStatus = document.getElementById('device-status');
    const connectionStatus = document.getElementById('connection-status');
    const signalStrength = document.getElementById('signal-strength');

    // Simulate device data updates on refresh button click
    refreshButton.addEventListener('click', () => {
        batteryLevel.textContent = '90%';  // Example of new data
        deviceStatus.textContent = 'Active';
        connectionStatus.textContent = 'Disconnected';
        signalStrength.textContent = 'Weak';
        alert('Device info refreshed!');
    });

    // Back to home button functionality
    const goBackButton = document.getElementById('go-back');
    goBackButton.addEventListener('click', () => {
        window.location.href = 'home.html';  // Navigate back to the home page
    });
});
