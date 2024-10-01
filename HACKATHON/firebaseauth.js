
  // Import the functions you need from the SDKs you need
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.13.1/firebase-app.js";
  import { getAnalytics } from "https://www.gstatic.com/firebasejs/10.13.1/firebase-analytics.js";
  // TODO: Add SDKs for Firebase products that you want to use
  // https://firebase.google.com/docs/web/setup#available-libraries

  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  const firebaseConfig = {
    apiKey: "AIzaSyCOJtYHU0HENHOvCy1tzoCP_vZ7VzuYw10",
    authDomain: "login-form-d3978.firebaseapp.com",
    projectId: "login-form-d3978",
    storageBucket: "login-form-d3978.appspot.com",
    messagingSenderId: "135277669955",
    appId: "1:135277669955:web:b5ec13f8c49a12cf6faef6",
    measurementId: "G-EMXLKBQ4KG"
  };

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
  const signUp=document.getElementById('submitSignUp'); 
  signUp.addEventListener('click', (event)=>{ 
    event.preventDefault(); 
    const email=document.getElementById('rEmail').value; 
    const password=document.getElementById('rPassword').value; 
    const firstName=document.getElementById('fName').value; 
    const lastName=document.getElementById('lName').value;

    const auth=getAuth();
    const db=getFirestore();
    createUserWithEmailAndPassword (auth, email, password)
    then((userCredential)=> {
        const user=userCredential.user;
        const userData={
            email: email,
            firstName: firstName,
            lastName:lastName
        };
    })
    