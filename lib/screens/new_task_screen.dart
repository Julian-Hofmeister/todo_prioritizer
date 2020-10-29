import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_prioritizer/constants.dart';
import 'package:todo_prioritizer/elements/background_painter.dart';
import 'package:todo_prioritizer/elements/cusotm_slider_class.dart';
import 'package:todo_prioritizer/elements/custom_floating_action_button.dart';
import 'package:todo_prioritizer/elements/custom_input_decoration.dart';
import 'package:todo_prioritizer/elements/custom_top_bar.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:todo_prioritizer/functions/firebase_functions.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';

// ignore: must_be_immutable
class NewTaskScreen extends StatefulWidget {
  static const String id = "new_task_screen";

  Color accentColor = green;
  Color theme = bright;

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool isDeadline = false;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  String taskName;
  String taskDescription;
  String categoryValue;
  var selectedDate = DateTime.now();
  double importanceValue = 20;
  double progressValue = 10;

  FirebaseUser loggedInUser;
  String timestamp;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getTime() {
    timestamp = Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)
        .toString();
  }

  void createTask() {
    getCurrentUser();
    setState(() {
      getTime();

      _firestore.collection("${loggedInUser.email}").add({
        "name": taskName,
        "description": taskDescription,
        "category": categoryValue,
        "deadline": "${selectedDate.toLocal()}".split(' ')[0],
        "importance": importanceValue,
        "progressValue": progressValue,
        "timestamp": timestamp,
      });
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Scaffold(
        backgroundColor: widget.accentColor,
        bottomNavigationBar: BottomAppBar(
            color: detailColor,
            notchMargin: 0,
            child: SizedBox(
              height: 56,
              child: FlatButton(
                onPressed: () {
                  createTask();

                  print(taskName);
                  print(taskDescription);
                  print(categoryValue);
                  print("${selectedDate.toLocal()}".split(' ')[0]);
                  print(importanceValue);
                  print(progressValue);
                },
                child: Text(
                  "add to list",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )),
        body: Stack(
          children: [
            Hero(
              tag: "background_tag",
              child: CustomPaint(
                painter: ShapesPainter(y: -200, color: widget.theme),
                child: Container(),
              ),
            ),
            CustomFloatingActionButton(
              height: 150,
              icon: Icon(
                Icons.arrow_downward_rounded,
                size: 30,
                color: widget.theme,
              ),
              backgroundColor: detailColor,
              action: () {
                Navigator.pop(context);
              },
            ),
            Hero(
              tag: "topBar_tag",
              child: CustomTopBar(
                theme: widget.theme,
              ),
            ),
            Positioned(
              top: 220,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Text(
                              "New Task",
                              style: titleTextStyle.copyWith(
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    IgnoreFocusWatcher(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 36,
                        child: TextFormField(
                          controller: nameController,
                          onChanged: (text) {
                            taskName = text;
                          },
                          decoration: CustomInputDecoration("Task Name"),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    IgnoreFocusWatcher(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 36,
                        child: TextField(
                          onTap: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          controller: descriptionController,
                          onChanged: (text) {
                            taskDescription = text;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                          decoration: CustomInputDecoration("Description"),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: DropdownButton<String>(
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            isExpanded: true,
                            hint: Text(
                              "Category",
                            ),
                            value: categoryValue,
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            underline: Container(
                              height: 0,
                              color: Colors.white,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                categoryValue = newValue;
                              });
                            },
                            items: <String>['One', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate, // Refer step 1
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                                helpText: "Deadline",
                                builder: (context, child) {
                                  return Theme(
                                    child: child,
                                    data: ThemeData.dark().copyWith(
                                      colorScheme: widget.theme == dark
                                          ? ColorScheme.dark(
                                              primary: detailColor,
                                              surface: widget.accentColor,
                                            )
                                          : ColorScheme.dark(
                                              primary: detailColor,
                                              surface: widget.accentColor,
                                            ),
                                    ),
                                  );
                                },
                              );

                              if (picked != null && picked != selectedDate)
                                setState(() {
                                  isDeadline = true;
                                  selectedDate = picked;
                                });
                            },
                            child: DropdownButton(
                              underline: Container(
                                height: 0,
                                color: Colors.white,
                              ),
                              hint: isDeadline == false
                                  ? Text("Deadline")
                                  : Text(
                                      "${selectedDate.toLocal()}".split(' ')[0],
                                    ),
                              isExpanded: true,
                              iconDisabledColor: Colors.grey[700],
                              onChanged: (value) {},
                              items: [],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      width: MediaQuery.of(context).size.width - 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Importance",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                              valueIndicatorColor: detailColor,
                              trackShape: CustomTrackShape(),
                            ),
                            child: Slider(
                              value: importanceValue,
                              onChanged: (double newValue) {
                                setState(() {
                                  importanceValue = newValue;
                                });
                              },
                              min: 0,
                              max: 100,
                              activeColor: detailColor,
                              inactiveColor: Colors.grey.withOpacity(0.2),
                              label: "$importanceValue",
                              divisions: 5,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      width: MediaQuery.of(context).size.width - 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                              valueIndicatorColor: detailColor,
                              trackShape: CustomTrackShape(),
                            ),
                            child: Slider(
                              value: progressValue,
                              onChanged: (double newValue) {
                                setState(() {
                                  progressValue = newValue;
                                });
                              },
                              min: 0,
                              max: 100,
                              activeColor: detailColor,
                              inactiveColor: Colors.grey.withOpacity(0.2),
                              label: "${progressValue.round()}%",
                              divisions: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
