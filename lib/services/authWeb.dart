import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login_web/flutter_facebook_login_web.dart';

class AuthWeb {
  final _fb = FacebookLoginWeb();

  Future<User> signInWithFacebook(FirebaseAuth firebaseAuth) async {
    try {
// Log in
      final result = await _fb.logIn(['email', 'publicProfile']);

// Check result status
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;

          final userCredential = await firebaseAuth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token),
          );
          return userCredential.user;

        case FacebookLoginStatus.cancelledByUser:
          // User cancel log in
          throw FirebaseAuthException(
            code: 'ERROR_ABORTED_BY_USER',
            message: 'Sign in aborted by user',
          );
        case FacebookLoginStatus.error:
          // Log in failed
          throw FirebaseAuthException(
            code: 'ERROR_FACEBOOK_LOGIN_FAILED',
            message: result.errorMessage,
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
