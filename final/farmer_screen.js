// Access the device's camera
const video = document.getElementById('video');
const canvas = document.getElementById('canvas');
const captureBtn = document.getElementById('capture-btn');
const capturedImage = document.getElementById('captured-image');
const manualUploadForm = document.getElementById('manual-upload-form');
const videoSection = document.getElementById('video-section');
const toggleCameraBtn = document.getElementById('toggle-camera-btn');
const imageInput = document.getElementById('image-input');

// Start camera stream
navigator.mediaDevices.getUserMedia({ video: true })
    .then((stream) => {
        video.srcObject = stream;
    })
    .catch((error) => {
        console.error('Error accessing camera:', error);
    });

// Capture the image when the button is clicked
captureBtn.addEventListener('click', () => {
    const context = canvas.getContext('2d');
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;
    context.drawImage(video, 0, 0, canvas.width, canvas.height);
    
    // Convert canvas image to data URL and display it
    const dataUrl = canvas.toDataURL('image/png');
    capturedImage.src = dataUrl;
    capturedImage.style.display = 'block';

    // Simulate sending the image for crop identification
    identifyCrop(dataUrl);
});

// Function to send image to the crop identification API
function identifyCrop(imageData) {
    console.log('Identifying crop from image...');
    
    // Example: Call crop identification API (replace this with actual API integration)
    setTimeout(() => {
        const identifiedCrop = 'Wheat';  // Example crop name
        document.getElementById('result').innerHTML = `<h3>Identified Crop: ${identifiedCrop}</h3>`;
    }, 2000);

    // Uncomment and modify the code below for actual API integration:
    /*
    const apiKey = 'YOUR_API_KEY'; // Replace with your API key
    const apiUrl = 'https://example-crop-identification-api.com/identify'; // Replace with actual API URL

    fetch(apiUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${apiKey}`
        },
        body: JSON.stringify({
            image: imageData
        })
    })
    .then(response => response.json())
    .then(data => {
        const identifiedCrop = data.cropName; // API returns crop name
        document.getElementById('result').innerHTML = `<h3>Identified Crop: ${identifiedCrop}</h3>`;
    })
    .catch(error => {
        console.error('Error identifying crop:', error);
    });
    */
}

// Handle manual crop upload
document.getElementById('manual-upload-btn').addEventListener('click', function(event) {
    event.preventDefault();
    const cropName = document.getElementById('crop-name').value;
    const quantity = document.getElementById('quantity').value;
    const price = document.getElementById('price').value;

    console.log('Manual Upload:', { cropName, quantity, price });
    alert('Crop details uploaded successfully!');

    // Clear the form
    document.getElementById('crop-name').value = '';
    document.getElementById('quantity').value = '';
    document.getElementById('price').value = '';
});

// Handle image selection from storage
imageInput.addEventListener('change', (event) => {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            capturedImage.src = e.target.result;
            capturedImage.style.display = 'block';
            identifyCrop(e.target.result); // Send the selected image for identification
        };
        reader.readAsDataURL(file);
    }
});

// Toggle Camera Section Visibility
toggleCameraBtn.addEventListener('click', function() {
    if (videoSection.style.display === 'none') {
        videoSection.style.display = 'flex';
        toggleCameraBtn.innerText = 'Hide Camera';
    } else {
        videoSection.style.display = 'none';
        toggleCameraBtn.innerText = 'Use Camera to Scan Crop';
    }
});
