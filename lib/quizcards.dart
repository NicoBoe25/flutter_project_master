import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/quiz.dart';

final _cardsColors = [
  Colors.lightGreen,
  Colors.lightBlue,
  Colors.amberAccent,
  Colors.deepOrangeAccent,
  Colors.pinkAccent,
  Colors.tealAccent,
  Colors.purpleAccent

];

class QuizCardWidget extends StatelessWidget {
  QuizCardWidget({
    Key? key,
    required this.quiz,
    required this.index,
  }) : super(key: key);

  final Quiz quiz;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _cardsColors[index];

    return Card(
      color: color,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              quiz.name,
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