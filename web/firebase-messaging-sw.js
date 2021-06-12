importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyCYA16zvmt3IWLKv3r8TnHZ0C-06-ExLwQ",
    authDomain: "vip-chatt.firebaseapp.com",
    projectId: "vip-chatt",
    storageBucket: "vip-chatt.appspot.com",
    messagingSenderId: "58882026821",
    appId: "1:58882026821:web:8e03d475ed3153ea8ee22c",
    measurementId: "G-99T3T24Z4S"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});