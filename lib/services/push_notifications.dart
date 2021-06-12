import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseCloudMessaging {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  fcmGetToken() async {
    _messaging.getToken();
  }

  fcmSubscribeToTopic() {
    _messaging.subscribeToTopic('chat_rooms');
  }

  fcmRequestPermission() async {
    await _messaging
        .requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    )
        .then((value) async {
      NotificationSettings settings = await _messaging.getNotificationSettings();
      print('User granted permission: ${settings.authorizationStatus}');
      return settings;
    });
  }

  fcmForegroundNotification() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
