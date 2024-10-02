document.addEventListener('DOMContentLoaded', function () {
    const otpForm = document.getElementById('otp-form');
    const otpInput = document.getElementById('otp-input');
    const message = document.getElementById('message');
    const resendBtn = document.getElementById('resend-btn');

    otpForm.addEventListener('submit', function (event) {
        event.preventDefault();
        const enteredOtp = otpInput.value;

        // Here you can add your logic to verify the OTP
        if (enteredOtp === "123456") { // Example check (replace with your logic)
            message.textContent = "OTP Verified Successfully!";
            message.style.color = "green";
            // Redirect to verification.html
            setTimeout(() => {
                window.location.href = "verification.html"; // Change to your next page
            }, 2000);
        } else {
            message.textContent = "Invalid OTP. Please try again.";
        }
    });

    resendBtn.addEventListener('click', function () {
        // Logic to resend OTP
        message.textContent = "OTP resent to your number";
        message.style.color = "green";
        otpInput.value = ""; // Clear the input field
    });
});
