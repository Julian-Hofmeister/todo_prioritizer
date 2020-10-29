import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_prioritizer/elements/background_painter.dart';
import 'package:todo_prioritizer/constants.dart';
import 'package:todo_prioritizer/elements/custom_floating_action_button.dart';
import 'package:todo_prioritizer/elements/custom_navigationbar.dart';
import 'package:todo_prioritizer/elements/custom_top_bar.dart';
import 'package:todo_prioritizer/elements/task_card.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:todo_prioritizer/functions/firebase_functions.dart';
import 'package:todo_prioritizer/screens/new_task_screen.dart';
import 'package:todo_prioritizer/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animations/animations.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  static const String id = "main_screen";

  Color accentColor = green;
  Color theme = bright;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final _scrollController = ScrollController();

  FirebaseUser loggedInUser;

  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print("hello? $user");
        return user;
      } else {
        print("not found");
        Navigator.pushReplacementNamed(context, RegistrationScreen.id);
        return null;
      }
    } catch (e) {
      print(e);
      Navigator.pushReplacementNamed(context, RegistrationScreen.id);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.accentColor,
      bottomNavigationBar: CustomNavigationBar(
        accentColor: widget.accentColor,
      ),
      body: Stack(
        children: [
          Hero(
            tag: "background_tag",
            child: CustomPaint(
              painter: ShapesPainter(y: 0, color: widget.theme),
              child: Container(),
            ),
          ),
          CustomFloatingActionButton(
            height: 350,
            icon: Icon(
              Icons.add,
              size: 30,
              color: widget.theme,
            ),
            backgroundColor: detailColor,
            action: () {
              Navigator.pushNamed(context, NewTaskScreen.id);
            },
          ),
          Hero(
            tag: "topBar_tag",
            child: CustomTopBar(
              theme: widget.theme,
            ),
          ),
          Positioned(
            top: 120,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "     80% To Do's",
                    style: titleTextStyle.copyWith(
                      color: widget.theme == bright ? darkText : brightText,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 - 230,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection("${loggedInUser.email}")
                            .orderBy("importance")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.orangeAccent,
                              ),
                            );
                          }
                          final task = snapshot.data.documents;
                          List<Widget> taskCards = [];
                          for (var task in task) {
                            final taskName = task.data['name'];
                            final taskDescription = task.data['description'];
                            final taskCategory = task.data['category'];
                            final taskDeadline = task.data['deadline'];
                            final taskImportance = task.data['importance'];
                            final taskProgress = task.data['progressValue'];

                            final taskCard = TaskCard(
                              taskName: taskName,
                              category: taskCategory,
                              deadline: taskDeadline,
                              priority: taskImportance.toString(),
                              progress: taskProgress.toString(),
                              accentColor: widget.theme,
                            );

                            if (taskImportance >= 80) {
                              taskCards.insert(0, taskCard);
                            }
                          }
                          return ScrollConfiguration(
                            behavior: ScrollBehavior()
                              ..buildViewportChrome(
                                  context, null, AxisDirection.down),
                            child: FadingEdgeScrollView.fromScrollView(
                              gradientFractionOnStart: 0.02,
                              child: ListView(
                                controller: _scrollController,
                                children: taskCards,
                              ),
                            ),
                          );
                          // return Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: taskCards,
                          // );
                        }),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 400,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "     20% To Do's",
                    style: titleTextStyle.copyWith(
                      color: widget.theme == bright ? darkText : brightText,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 - 50,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection("${loggedInUser.email}")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.orangeAccent,
                              ),
                            );
                          }
                          final task = snapshot.data.documents;
                          List<Widget> taskCards = [];
                          for (var task in task) {
                            final taskName = task.data['name'];
                            final taskDescription = task.data['description'];
                            final taskCategory = task.data['category'];
                            final taskDeadline = task.data['deadline'];
                            final taskImportance = task.data['importance'];
                            final taskProgress = task.data['progressValue'];

                            final taskCard = TaskCard(
                              taskName: taskName,
                              category: taskCategory,
                              deadline: taskDeadline,
                              priority: taskImportance.toString(),
                              progress: taskProgress.toString(),
                              accentColor: widget.theme,
                            );

                            if (taskImportance < 80) {
                              // if(taskImportance > taskCards[0])
                              taskCards.insert(0, taskCard);
                            }
                          }
                          return ScrollConfiguration(
                            behavior: ScrollBehavior()
                              ..buildViewportChrome(
                                  context, null, AxisDirection.down),
                            child: FadingEdgeScrollView.fromScrollView(
                              gradientFractionOnStart: 0.02,
                              child: ListView(
                                controller: _scrollController,
                                children: taskCards,
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
