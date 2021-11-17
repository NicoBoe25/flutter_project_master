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
var _quizes = Quiz(1, "a");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Quizes'),
    ),
    body:ListView.builder(
    itemCount: _quizes.list_quizes.length,
    itemBuilder: (BuildContext context, int index) {

    final item = _quizes.list_quizes[index];
    return Dismissible(
        key: Key(item),
        background: Container(
          child: Icon(
            Icons.delete,
            size: 40,
            color: Colors.white,
          ),
          color: Colors.cyan,
        ),
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



















