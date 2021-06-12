import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseCloudMessaging {
  fcmRequestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging
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
      NotificationSettings settings = await messaging.getNotificationSettings();
      print('User granted permission: ${settings.authorizationStatus}');
      return settings;
    });
  }

  fcmForegroundNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
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
