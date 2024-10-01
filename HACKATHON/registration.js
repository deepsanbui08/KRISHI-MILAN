// Function to simulate sending OTP
window.sendOTP = function(event) {
    event.preventDefault();
    const contact = document.getElementById("contact").value;
    
    if(contact) {
        alert("OTP has been sent to " + contact);
        document.getElementById("otp").style.display = "block";
        document.getElementById("submit-btn").innerText = "Verify OTP";
        document.getElementById("submit-btn").onclick = goToNextPage;
    }
};

// Function to redirect to the confirmation page after OTP verification
window.goToNextPage = function() {
    alert("OTP Verified. Proceeding to the next page...");
    window.location.href = "verification.html"; // Redirect to the confirmation page
};
