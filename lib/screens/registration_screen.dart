import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vip_chat_app/constants.dart';
import 'package:vip_chat_app/screens/chat_screen.dart';
import 'package:vip_chat_app/screens/login_screen.dart';
import 'package:vip_chat_app/widgets/customized_icon_animated_button.dart';
import 'package:vip_chat_app/widgets/customized_medium_animated_button.dart';
import 'package:vip_chat_app/widgets/customized_white_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool _showSpinner = false;
  String _email;
  String _password;

  Widget _buildSignIpBtn() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, LoginScreen.id),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Already have an Account? ',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Container(
          width: double.infinity,
          decoration: kBodyBackgroundContainerDecoration,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 70.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(height: 20.0),
                CustomizedWhiteTextField(
                  icon: Icon(
                    Icons.person,
                    color: Colors.black45,
                  ),
                  hintText: 'Enter your nick',
                  onChanged: (value) {},
                ),
                CustomizedWhiteTextField(
                  keyboardType: TextInputType.emailAddress,
                  icon: Icon(
                    Icons.email,
                    color: Colors.black45,
                  ),
                  hintText: 'Enter your e-mail',
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                CustomizedWhiteTextField(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.black45,
                  ),
                  obscureText: true,
                  hintText: 'Enter your password',
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                CustomizedWhiteTextField(
                  icon: Icon(
                    Icons.lock_outline,
                    color: Colors.black45,
                  ),
                  obscureText: true,
                  hintText: 'Confirm your password',
                  onChanged: (value) {},
                ),
                SizedBox(height: 19.0),
                CustomizedMediumAnimatedButton(
                  title: 'Register',
                  onTap: () async {
                    setState(() {
                      _showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: _email, password: _password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        _showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  gradientColors: [
                    Colors.pink,
                    Colors.purpleAccent,
                  ],
                ),
                Text('or use'),
                CustomizedIconAnimatedButton(
                  title: 'Facebook',
                  onTap: () {},
                  gradientColors: [
                    Colors.indigoAccent.shade400,
                    Colors.lightBlue,
                  ],
                  icon: FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 50.0),
                _buildSignIpBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
