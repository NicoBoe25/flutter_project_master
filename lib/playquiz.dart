import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/quiz.dart';

class Playquiz extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return new LetsDoQuiz();
  }



}

class LetsDoQuiz extends State<Playquiz> {
  late List<Quiz> quiz;


  Future refreshQuizes() async {

    this.quiz = await QuizDatabase.instance.readAllQuiz();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Quizes'),
    ),
    body:ListView.builder(
    itemCount: quiz.length,
    itemBuilder: (BuildContext context, int index) {

    final item = refreshQuizes();
        child: Card(
            child: ListTile(
                title: Text(
                  _quizes.list_quizes[index],
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  var snackBar =
                  SnackBar(content: Text('$item'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                })));
    }),
    );


  }
}



















