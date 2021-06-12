const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.myFunction = functions.firestore
    .document("chat_rooms/{message}")
    .onCreate((snapshot, context) => {
    // console.log(snapshot.data());
      return admin.messaging().sendToTopic("chat_rooms", {
        notification: {
          title: "title",
          body: "body",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      });
    });
