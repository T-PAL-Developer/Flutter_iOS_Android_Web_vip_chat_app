const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.myFunction = functions.firestore
    .document("chat_rooms/{chats}/chats/{message}")
    .onCreate((snapshot, context) => {
    // console.log(snapshot.data());
      return admin.messaging().sendToTopic("chat_rooms", {
        notification: {
          title: "VIP CHAT",
          body: "You have a new message",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
          sound: "default",
        },
      });
    });
