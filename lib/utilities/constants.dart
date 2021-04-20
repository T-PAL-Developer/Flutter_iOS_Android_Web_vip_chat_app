import 'package:flutter/material.dart';

const String test_id = 'Anonymous user';
const String test_avatarURL =
    'https://firebasestorage.googleapis.com/v0/b/vip-chatt.appspot.com/o/user_image%2FFu2d3jPaZbdv9PDIdlQEzqU4pho1?alt=media&token=e1ff37fe-932e-4904-9c89-82eac0553ecc';

const kFontSourceSansPro = 'SourceSansPro';
const kFontBungeeShade = 'BungeeShade';

const kAnimatedDrawerMenuTextStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  fontSize: 17,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontFamily: kFontSourceSansPro,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
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

final kGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [Colors.pink, Colors.purpleAccent]),
  borderRadius: BorderRadius.circular(30.0),
);
