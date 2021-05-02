import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vip_chat_app/screens/chat_room_screen.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'screens/group_chat_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'services/auth.dart';

void main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();

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
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(),
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
          ),
          primaryColor: kPrimaryColor,
          backgroundColor: kBackgroundColor,
          scaffoldBackgroundColor: kBackgroundColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: kPrimaryColor,
          ),
          textTheme: TextTheme(
            bodyText2: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
        ),
        initialRoute:
            // ChatRoomScreen.id,
            _auth.currentUser != null ? GroupChatScreen.id : WelcomeScreen.id,
        routes: {
          ChatRoomScreen.id: (context) => ChatRoomScreen(auth: Auth()),
          WelcomeScreen.id: (context) => WelcomeScreen(auth: Auth()),
          GroupChatScreen.id: (context) => GroupChatScreen(auth: Auth()),
        },
      ),
    );
  }
}
