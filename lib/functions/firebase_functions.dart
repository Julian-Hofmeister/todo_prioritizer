import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_prioritizer/screens/main_screen.dart';

class FirebaseFunctions {
  final _auth = FirebaseAuth.instance;

  // ignore: missing_return
  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        print("hello? $user");
        return user;
      } else {
        print("not found");
        return false;
      }
    } catch (e) {
      print(e);
      print("hello!");
      return false;
    }
  }

  bool checkAccount(context) {
    if (getCurrentUser() != null) {
      return true;
    }
    return false;
  }

  Future<void> login({context, email, password}) async {
    try {
      final existingUser = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(
        "$email, $password, $existingUser",
      );
      if (existingUser != null) {
        Navigator.pushReplacementNamed(context, MainScreen.id);
      }
    } catch (e) {
      print("Error was $e");
      // Navigator.pushReplacementNamed(context, RegistrationScreen.id);
    }
  }

  Future<void> registration({context, email, password}) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        Navigator.pushReplacementNamed(context, MainScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }
}
