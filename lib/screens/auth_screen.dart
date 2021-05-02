import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:vip_chat_app/screens/group_chat_screen.dart';
import 'package:vip_chat_app/utilities/constantsFirebaseDB.dart';
import 'package:vip_chat_app/utilities/firebase_error_codes.dart';
import 'package:vip_chat_app/widgets/buttons/customized_gradient_icon_button.dart';
import 'package:vip_chat_app/widgets/buttons/customized_gradient_button.dart';
import 'package:vip_chat_app/widgets/buttons/customized_text_button.dart';
import 'package:vip_chat_app/widgets/customized_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vip_chat_app/widgets/user_image_picker.dart';

class AuthScreen extends StatefulWidget {
  static const String id = 'auth_screen';

  const AuthScreen({Key key, this.isLogin, @required this.auth})
      : super(key: key);
  final bool isLogin;
  final AuthBase auth;

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;
  bool _isLoginMode = false;
  bool _isForgotPasswordMode = false;
  String _username;
  String _email;
  String _password;
  Uint8List _userImageFile;

  void _pickedImage(Uint8List pickedImage) {
    _userImageFile = pickedImage;
  }

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLoginMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please pick an avatar image',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).errorColor,
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

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
    try {
      if (_isLoginMode) {
        final authResult = await widget.auth.signInWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );
        if (authResult != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, GroupChatScreen.id, (route) => false);
        }
      } else {
        final authResult = await widget.auth.createUserWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${authResult.uid}');

        await ref.putData(_userImageFile);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection(CollectionUsers.id)
            .doc(authResult.uid)
            .set({
          CollectionUsers.username: _username,
          CollectionUsers.email: _email,
          CollectionUsers.imageUrl: url,
        });
        if (authResult != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, GroupChatScreen.id, (route) => false);
        }
      }
    } on FirebaseAuthException catch (e) {
      helperFirebaseAuthException(e, context);
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      final authResult = await widget.auth.signInWithFacebook();
      print('Facebook sign in success! uid: ${authResult?.uid}');
      await FirebaseFirestore.instance
          .collection(CollectionUsers.id)
          .doc(authResult.uid)
          .set({
        CollectionUsers.username: authResult.displayName,
        CollectionUsers.email: authResult.email,
        CollectionUsers.imageUrl: authResult.photoURL,
      });
      if (authResult != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, GroupChatScreen.id, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      helperFirebaseAuthException(e, context);
    }
  }

  Future<bool> _resetPassword() async {
    try {
      await widget.auth.resetPassword(
        email: _email.trim(),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      helperFirebaseAuthException(e, context);
      return false;
    }
  }

  Future<void> _tryResetPassword() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      final resetCompleted = await _resetPassword();
      if (resetCompleted) {
        setState(() {
          _isForgotPasswordMode = !_isForgotPasswordMode;
        });
      }
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
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          decoration: kBodyBackgroundContainerDecoration,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: (_isForgotPasswordMode)
                  ? _buildForgotPasswordContent()
                  : _buildMainContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (_isLoginMode)
            ? _buildLogoImage()
            : UserImagePicker(
                pickedImageFileFunc: _pickedImage,
              ),
        SizedBox(height: 20.0),
        _buildForm(),
        if (_isLoginMode) _buildForgotPasswordBtn(),
        SizedBox(height: 19.0),
        CustomizedGradientButton(
          title: (_isLoginMode ? 'Log in' : 'Register'),
          onTap: _trySubmit,
          gradientColors: [
            Colors.pink,
            Colors.purpleAccent,
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('or sign in with'),
        ),
        CustomizedGradientIconButton(
          title: 'Facebook',
          onTap: () async {
            setState(() {
              _showSpinner = true;
            });
            await _signInWithFacebook();
            setState(() {
              _showSpinner = false;
            });
          },
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
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildForgotPasswordContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forgot password?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Enter your email and tap reset button',
              ),
            ),
            SizedBox(height: 20.0),
            Form(
              key: _formKey,
              child: _buildEmailTextField(),
            ),
            SizedBox(height: 10.0),
            CustomizedGradientButton(
              title: ('Reset'),
              onTap: _tryResetPassword,
              gradientColors: [
                Colors.pink,
                Colors.purpleAccent,
              ],
            ),
            SizedBox(height: 60.0),
          ],
        ),
        Positioned(
          bottom: 30,
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                _isForgotPasswordMode = !_isForgotPasswordMode;
              });
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black87,
            ),
            label: Text(
              'Back to login page',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: kFontSourceSansPro,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoImage() {
    return Hero(
      tag: 'logo',
      child: Container(
        height: 70.0,
        child: Image.asset('images/logo.png'),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (!_isLoginMode)
            CustomizedTextFormField(
              key: ValueKey('name'),
              icon: Icon(
                Icons.person,
                color: Colors.black45,
              ),
              hintText: 'Enter your nick',
              validator: (val) {
                return val.length > 3 ? null : "Enter 3+ characters";
              },
              onChanged: (value) {
                _username = value;
              },
            ),
          _buildEmailTextField(),
          CustomizedTextFormField(
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

  Widget _buildEmailTextField() {
    return CustomizedTextFormField(
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
          fontSize: 13,
          color: Colors.blue,
          fontWeight: FontWeight.w600,
          onPressed: () {
            setState(() {
              _isForgotPasswordMode = !_isForgotPasswordMode;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSignIpBtn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLoginMode = !_isLoginMode;
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
