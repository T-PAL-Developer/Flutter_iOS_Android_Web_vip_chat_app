import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vip_chat_app/constants.dart';
import 'package:vip_chat_app/screens/chat_screen.dart';
import 'package:vip_chat_app/widgets/customized_icon_animated_button.dart';
import 'package:vip_chat_app/widgets/customized_medium_animated_button.dart';
import 'package:vip_chat_app/widgets/customized_text_button.dart';
import 'package:vip_chat_app/widgets/customized_white_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AuthScreen extends StatefulWidget {
  static const String id = 'auth_screen';

  const AuthScreen({Key key, this.isLogin}) : super(key: key);
  final bool isLogin;

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;
  bool _isLoginMode;
  String _userName;
  String _email;
  String _password;

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      setState(() {
        _showSpinner = true;
      });
      _formKey.currentState.save();
      await _submitAuthForm();
      setState(() {
        _showSpinner = false;
      });
    }
  }

  Future<void> _submitAuthForm() async {
    UserCredential authResult;

    try {
      if (_isLoginMode) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: _email.trim(), password: _password.trim());
        if (authResult != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, ChatScreen.id, (route) => false);
        }
      } else {
        final authResult = await _auth.createUserWithEmailAndPassword(
            email: _email.trim(), password: _password.trim());
        if (authResult != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, ChatScreen.id, (route) => false);
        }
      }
    } on FirebaseAuthException catch (e) {
      var errorMessage = 'An error occurred. Please check your credentials.';
      if (e.message != null) {
        errorMessage = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).errorColor,
          duration: Duration(seconds: 5),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _isLoginMode = widget.isLogin;
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
                _buildForm(),
                if (_isLoginMode) _buildForgotPasswordBtn(),
                SizedBox(height: 19.0),
                CustomizedMediumAnimatedButton(
                  title: (_isLoginMode ? 'Log in' : 'Register'),
                  onTap: _trySubmit,
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

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (!_isLoginMode)
            CustomizedWhiteTextField(
              key: ValueKey('name'),
              icon: Icon(
                Icons.person,
                color: Colors.black45,
              ),
              hintText: 'Enter your nick',
              validator: (val) {
                return val.length > 3 ? null : "Enter 3+ characters";
              },
              onChanged: (value) {},
            ),
          CustomizedWhiteTextField(
            key: ValueKey('email'),
            keyboardType: TextInputType.emailAddress,
            icon: Icon(
              Icons.email,
              color: Colors.black45,
            ),
            hintText: 'Enter your e-mail',
            validator: (val) {
              return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val)
                  ? null
                  : "Please Enter Correct Email";
            },
            onChanged: (value) {
              _email = value;
            },
          ),
          CustomizedWhiteTextField(
            key: ValueKey('password'),
            icon: Icon(
              Icons.lock,
              color: Colors.black45,
            ),
            obscureText: true,
            hintText: 'Enter your password',
            validator: (val) {
              return val.length > 6 ? null : "Enter Password 6+ characters";
            },
            onChanged: (value) {
              _password = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      constraints: BoxConstraints(maxWidth: 400.0),
      child: Container(
        padding: EdgeInsets.only(right: 10.0),
        child: CustomizedTextButton(
          title: 'Forgot Password?',
          onPressed: () {},
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSignIpBtn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLoginMode = !_isLoginMode;
          print(_isLoginMode);
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: (_isLoginMode
                    ? 'Don\'t have an Account? '
                    : 'Already have an Account? '),
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: (_isLoginMode ? 'Sign up' : 'Sign In'),
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
}
