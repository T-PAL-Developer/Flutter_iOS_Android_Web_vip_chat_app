import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:vip_chat_app/screens/chat_screen.dart';
import 'package:vip_chat_app/utilities/firebase_error_codes.dart';
import 'package:vip_chat_app/widgets/customized_big_animated_button.dart';
import 'package:vip_chat_app/widgets/customized_text_button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'auth_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key key, this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool _showSpinner = false;
  AnimationController _controller;
  Animation _animation;
  Animation _curvedAnimation;

  Future<void> _signInAnonymously() async {
    try {
      final authResult = await widget.auth.signInAnonymously();
      print('Anonymous sign in success! uid: ${authResult?.uid}');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.uid)
          .set({
        'username': 'Anonymous user',
      });
      if (authResult != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, ChatScreen.id, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      helperFirebaseAuthException(e, context);
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInQuad);
    _animation = DecorationTween(
            begin: kBodyBackgroundContainerDecorationReverse,
            end: kBodyBackgroundContainerDecoration)
        .animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget getLogo() {
    if (kIsWeb) {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
        child: TypewriterAnimatedTextKit(
          repeatForever: false,
          speed: Duration(milliseconds: 110),
          totalRepeatCount: 1,
          text: [
            ' YOURS',
            '  VIP',
            '  CHAT',
          ],
          textStyle: TextStyle(
              fontSize: 40.0,
              fontFamily: kFontBungeeShade,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          textAlign: TextAlign.start,
        ),
      );
    } else {
      return ColorizeAnimatedTextKit(
        totalRepeatCount: 1,
        speed: Duration(milliseconds: 250),
        // pause: Duration(milliseconds: 300),
        text: ['YOURS', 'VIP', 'CHAT'],
        textStyle: TextStyle(
          fontSize: 50.0,
          fontFamily: kFontBungeeShade,
          fontWeight: FontWeight.bold,
        ),
        colors: [
          Colors.black,
          Colors.black,
          Colors.blue,
          Colors.yellow,
          Colors.red,
        ],
        textAlign: TextAlign.start,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Container(
          width: double.infinity,
          decoration: _animation.value,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      width: _curvedAnimation.value * 70.0,
                      height: _curvedAnimation.value * 70.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  getLogo(),
                  SizedBox(height: 40.0),
                  CustomizedBigAnimatedButton(
                    title: 'Log In',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AuthScreen(
                          auth: widget.auth,
                          isLogin: true,
                        );
                      }));
                    },
                    gradientColors: [
                      Colors.pink,
                      Colors.purpleAccent,
                    ],
                  ),
                  CustomizedBigAnimatedButton(
                    title: 'Register',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AuthScreen(
                          auth: widget.auth,
                          isLogin: false,
                        );
                      }));
                    },
                    gradientColors: [
                      Colors.deepPurpleAccent,
                      Colors.teal,
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('- OR TRY -'),
                  ),
                  CustomizedTextButton(
                    title: 'as an Anonymous User',
                    color: Colors.blue,
                    fontFamily: kFontSourceSansPro,
                    fontSize: 17.0,
                    onPressed: () async {
                      setState(() {
                        _showSpinner = true;
                      });
                      await _signInAnonymously();
                      setState(() {
                        _showSpinner = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
