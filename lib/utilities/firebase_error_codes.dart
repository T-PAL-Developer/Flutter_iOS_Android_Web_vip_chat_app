import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void helperFirebaseAuthException(
    FirebaseAuthException e, BuildContext context) {
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
}

String categorizeErrorCode(String errorCode) {
  String errorMessage;
  switch (errorCode) {
    case "ERROR_INVALID_EMAIL":
      errorMessage = "Your email address appears to be malformed.";
      break;
    case "ERROR_INVALID_CREDENTIAL":
      errorMessage = "Your email address or password appears to be malformed.";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
      errorMessage = "Anonymous accounts are disabled.";
      break;
    case "ERROR_WEAK_PASSWORD":
      errorMessage = "Your password is too weak.";
      break;
    case "ERROR_USER_DISABLED":
      errorMessage =
          "Your account has been disabled. Please contact the support.";
      break;
    case "ERROR_USER_NOT_FOUND":
      errorMessage =
          "Your account does no longer exist. Please contact the support.";
      break;
    case "ERROR_REQUIRES_RECENT_LOGIN":
      errorMessage =
          "Changing the password requires a recent sign-in. Please sign out and back in. Then try again.";
      break;
    case "ERROR_WRONG_PASSWORD":
      errorMessage = "The password is not correct. Please try again.";
      break;
    case "ERROR_WEAK_PASSWORD":
      errorMessage = "Your password is too weak.";
      break;
    case "ERROR_EMAIL_ALREADY_IN_USE":
      errorMessage = "This email is already in use by a different account.";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
      errorMessage = "Too many requests. Try again later.";
      break;
    default:
      errorMessage = "An undefined error happened.";
  }
  return errorMessage;
}
