// ignore: must_be_immutable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_prioritizer/constants.dart';
import 'package:todo_prioritizer/screens/login_screen.dart';

// ignore: must_be_immutable
class CustomTopBar extends StatelessWidget {
  CustomTopBar({this.theme});

  Color theme;

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Material(
        color: Colors.white.withOpacity(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _auth.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              },
              child: Icon(
                Icons.notes_rounded,
                color: detailColor,
                size: 30,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Hi, Julian!",
                  style: greetingTextStyle.copyWith(
                    fontFamily: "Roboto",
                    color: theme == bright ? darkText : brightText,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 20.8,
                  backgroundColor: theme == bright ? darkText : brightText,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: detailColor,
                    backgroundImage: AssetImage("images/profile/DSC02599.png"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
