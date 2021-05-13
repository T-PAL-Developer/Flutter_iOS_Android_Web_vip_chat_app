import 'package:flutter/material.dart';

//TEST USER
const String test_id = 'Anonymous user';
const String test_avatarURL =
    'https://firebasestorage.googleapis.com/v0/b/vip-chatt.appspot.com/o/user_image%2FFu2d3jPaZbdv9PDIdlQEzqU4pho1?alt=media&token=e1ff37fe-932e-4904-9c89-82eac0553ecc';

// FONTS
const kFontSourceSansPro = 'SourceSansPro';
const kFontBungeeShade = 'BungeeShade';

// THEME COLORS
const kPrimaryColor = Colors.lightBlueAccent;
const kBackgroundColor = Color(0xFF303030);
final kGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [Colors.pink, Colors.purpleAccent]),
  borderRadius: BorderRadius.circular(30.0),
);
const kWhiteTextStyle = TextStyle(color: Colors.white);
const kFloatingActionButtonThemeData = FloatingActionButtonThemeData(
  backgroundColor: kPrimaryColor,
);
const kTextTheme = TextTheme(
  bodyText2: TextStyle(
      color: Colors.black54, fontSize: 14, fontWeight: FontWeight.normal),
);
final kElevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    primary: kPrimaryColor,
    onPrimary: Colors.black,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  ),
);
const kIconThemeData = IconThemeData(
  color: Colors.black,
);
const kAppBarTheme = AppBarTheme(
  iconTheme: IconThemeData(
    color: Colors.black, //change your color here
  ),
);

// APPBAR
const kAppBarTextStyle = TextStyle(
    fontFamily: kFontBungeeShade,
    fontWeight: FontWeight.bold,
    color: Colors.black);

// DRAWER
const kAnimatedDrawerMenuTextStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  fontSize: 17,
);

// BUTTONS
const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontFamily: kFontSourceSansPro,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

// MESSAGE CONTAINER
const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);

const kBodyBackgroundContainerDecoration = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Colors.blue, Colors.white, Colors.red]),
);

const kBodyBackgroundContainerDecorationReverse = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Colors.blue, Colors.white, Colors.red]),
);
