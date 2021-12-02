import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project_master/classObject/question.dart';

final _lightColors = [
  Colors.lightGreen,
  Colors.lightBlue,
  Colors.amberAccent,
  Colors.deepOrangeAccent,
  Colors.pinkAccent,
  Colors.tealAccent,
  Colors.purpleAccent
];

class QuestionCardWidget extends StatelessWidget {
  QuestionCardWidget({
    Key? key,
    required this.question,
    required this.index,
  }) : super(key: key);

  final Question question;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index];

    return Card(
      color: color,
      child: Container(
        padding: EdgeInsets.all(9),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              question.question,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets

}