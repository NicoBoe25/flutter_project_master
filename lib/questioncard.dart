import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/question.dart';

final _CardsColors = [
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
    final color = _CardsColors[index];

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

}