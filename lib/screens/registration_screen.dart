import 'package:flutter/material.dart';
import 'package:todo_prioritizer/constants.dart';
import 'package:todo_prioritizer/elements/background_painter.dart';
import 'package:todo_prioritizer/elements/custom_input_decoration.dart';
import 'package:todo_prioritizer/functions/firebase_functions.dart';
import 'package:todo_prioritizer/screens/login_screen.dart';

// ignore: must_be_immutable
class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  Color accentColor = green;
  Color theme = bright;

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  String username;
  String email;
  String password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: widget.accentColor,
      bottomNavigationBar: BottomAppBar(
        color: detailColor,
        notchMargin: 0,
        child: SizedBox(
          height: 56,
          child: FlatButton(
            onPressed: () {
              firebaseFunctions.registration(
                context: context,
                email: email,
                password: password,
              );
            },
            child: Text(
              "Create New Account",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Hero(
            tag: "background_tag",
            child: CustomPaint(
              painter: ShapesPainter(y: -200, color: widget.theme),
              child: Container(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ScrollConfiguration(
              behavior: ScrollBehavior()
                ..buildViewportChrome(context, null, AxisDirection.down),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 240),
                    Text(
                      "Registration",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height:
                          80 - (MediaQuery.of(context).viewInsets.bottom * 0.2),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 36,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(
                                  "Username",
                                  style: titleTextStyle.copyWith(
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width - 36,
                          child: TextFormField(
                            onChanged: (text) {
                              username = text;
                            },
                            decoration: CustomInputDecoration("example"),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 36,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(
                                  "Email",
                                  style: titleTextStyle.copyWith(
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width - 36,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (text) {
                              email = text;
                            },
                            decoration:
                                CustomInputDecoration("example@mail.com"),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 36,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(
                                  "Password",
                                  style: titleTextStyle.copyWith(
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width - 36,
                          child: TextFormField(
                            obscureText: true,
                            onChanged: (text) {
                              password = text;
                            },
                            decoration: CustomInputDecoration("***"),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.id);
                              },
                              child: Container(
                                height: 15,
                                color: detailColor.withOpacity(0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
