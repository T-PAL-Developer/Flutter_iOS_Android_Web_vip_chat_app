import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vip_chat_app/screens/chat_screens/chat_room_screens/chat_room_screen.dart';
import 'package:vip_chat_app/screens/chat_screens/chat_room_screens/search_screen.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'screens/chat_screens/group_chat_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'services/auth.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          iconTheme: kIconThemeData,
          appBarTheme: kAppBarTheme,
          primaryColor: kPrimaryColor,
          backgroundColor: kBackgroundColor,
          scaffoldBackgroundColor: kBackgroundColor,
          floatingActionButtonTheme: kFloatingActionButtonThemeData,
          elevatedButtonTheme: kElevatedButtonThemeData,
          textTheme: kTextTheme,
        ),
        initialRoute:
            // ChatRoomScreen.id,
            _auth.currentUser != null ? GroupChatScreen.id : WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(auth: Auth()),
          GroupChatScreen.id: (context) => GroupChatScreen(auth: Auth()),
          ChatRoomScreen.id: (context) => ChatRoomScreen(auth: Auth()),
          SearchScreen.id: (context) => SearchScreen(auth: Auth()),
        },
      ),
    );
  }
}
