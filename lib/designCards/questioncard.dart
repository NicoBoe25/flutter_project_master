import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/question.dart';

final _CardsColors = [// une liste des colors varieés por les grids
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
    required this.question,//on est obligés de prendre la question qui sera ajouter en style grid
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
              question.question,//sur la cart , on voit juste la question
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