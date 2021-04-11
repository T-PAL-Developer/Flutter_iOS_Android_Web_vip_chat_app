import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:vip_chat_app/services/authWeb.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInAnonymously();
  Future<User> signInWithEmailAndPassword({String email, String password});
  Future<User> createUserWithEmailAndPassword({String email, String password});
  Future<User> signInWithFacebook();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fb = FacebookLogin();
  final _fbWeb = AuthWeb();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print('Error -> Exception details:\n $e');
      rethrow;
    }
  }

  @override
  Future<User> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
      return userCredential.user;
    } catch (e) {
      print('Error -> Exception details:\n $e');
      rethrow;
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      {String email, String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error -> Exception details:\n $e');
      rethrow;
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    if (kIsWeb) {
      return _fbWeb.signInWithFacebook(_firebaseAuth);
    } else {
      try {
// Log in
        final result = await _fb.logIn(permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ]);

// Check result status
        switch (result.status) {
          case FacebookLoginStatus.success:
            // Send access token to server for validation and auth
            final FacebookAccessToken accessToken = result.accessToken;
            // print('Access token: ${accessToken.token}');

            // Get profile data
            // final profile = await _fb.getUserProfile();
            // print('Hello, ${profile.name}! You ID: ${profile.userId}');

            // Get user profile image url
            // final imageUrl = await _fb.getProfileImageUrl(width: 100);
            // print('Your profile image: $imageUrl');

            // Get email (since we request email permission)
            // final email = await _fb.getUserEmail();
            // But user can decline permission
            // if (email != null) print('And your email is $email');

            final userCredential = await _firebaseAuth.signInWithCredential(
              FacebookAuthProvider.credential(accessToken.token),
            );
            return userCredential.user;

          case FacebookLoginStatus.cancel:
            // User cancel log in
            throw FirebaseAuthException(
              code: 'ERROR_ABORTED_BY_USER',
              message: 'Sign in aborted by user',
            );
          case FacebookLoginStatus.error:
            // Log in failed
            throw FirebaseAuthException(
              code: 'ERROR_FACEBOOK_LOGIN_FAILED',
              message: result.error.developerMessage,
            );
          default:
            throw UnimplementedError();
        }
      } catch (e) {
        print('Error -> Exception details:\n $e');
        rethrow;
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _fb.logOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Error -> Exception details:\n $e');
      rethrow;
    }
  }
}
