import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_prioritizer/constants.dart';
import 'package:todo_prioritizer/elements/progressbar_small.dart';

// ignore: must_be_immutable
class TaskCard extends StatelessWidget {
  TaskCard({
    this.theme = bright,
    this.category = "",
    this.accentColor = Colors.black,
    this.priority = "",
    this.taskName = "Task Name Example",
    this.deadline,
    this.progress = "30",
  });

  Color theme;
  Color accentColor;
  String category;
  String priority;
  String taskName;
  String deadline;
  String progress;

  bool isHighPriority() {
    if (double.parse(priority) >= 80) {
      return true;
    }
    return false;
  }

  Color checkCategoryColor() {
    if (category == "One") {
      return detailColor;
    }
    return accentColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: theme == dark && isHighPriority() == false
              ? darkCard
              : brightCard,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: isHighPriority() == false
                  ? Colors.black.withOpacity(0.03)
                  : Colors.black.withOpacity(0),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(-2, 3), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: checkCategoryColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskName,
                      style: cardTitleTextStyle.copyWith(
                        color: theme == dark && isHighPriority() == false
                            ? brightText
                            : darkText,
                      ),
                    ),
                    ProgressBar(
                      percent: double.parse(progress),
                      accentColor: accentColor,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  deadline != null ? deadline : "",
                  style: cardDeadlineTextStyle.copyWith(
                    color: theme == dark && isHighPriority() == false
                        ? Colors.white70
                        : darkText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
