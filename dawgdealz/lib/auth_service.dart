import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:navigation/main.dart';

class AuthService {

  Future<void> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Attempt to create a new user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


      // Navigate to the home page after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavDemo(title: 'DawgDealz'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth errors
      String errorMessage;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email address is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak. Please choose a stronger one.';
          break;
        default:
          errorMessage = 'Please ensure that your password is at least 6 characters.';
      }

      // Show the error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      // Handle other potential exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred. Please try again.')),
      );
    }
  }


  Future<void> signin({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    // Attempt to sign in the user
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Navigate to the next screen
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavDemo(title: 'DawgDealz')),
      );
    }
  } on FirebaseAuthException catch (e) {
    String errorMessage;

    // Handle Firebase authentication errors
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'No user found with this email. Please check and try again.';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password. Please try again.';
        break;
      case 'invalid-email':
        errorMessage = 'The email address is invalid.';
        break;
      default:
        errorMessage = 'An unknown error occurred. Please try again.';
    }

    // Display error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  } catch (e) {
    // Handle other potential exceptions
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('An unexpected error occurred. Please try again.')),
    );
  }
}

}
