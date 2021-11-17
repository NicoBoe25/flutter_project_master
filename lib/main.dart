import 'package:flutter/material.dart';
import 'package:flutter_project_master/database/questionDatabase.dart';
import 'package:flutter_project_master/database/quizDatabase.dart';
import 'package:flutter_project_master/playquiz.dart';
import 'package:flutter_project_master/quiz.dart';

void main() {
  runApp(MyQuiz());
}

class MyQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: MyQuizs(),
    );
  }
}

class MyQuizs extends StatefulWidget {
  @override
  _AllMyQuizs createState() {
    initBaseDiDonne();
    return _AllMyQuizs();

  }
  void initBaseDiDonne(){
    var idbquiz = QuizDatabase.instance;
    var dbQyiz = idbquiz.database;
    var dbQuestion = QuestionDatabase.instance.database;

    var _quiz1 =  Quiz(1 , "premier quiz");
    var _quiz2 = Quiz(2 , "deuxieme quiz");
    idbquiz.create(_quiz1);
    idbquiz.create(_quiz2);

  }
}
class _AllMyQuizs extends State<MyQuizs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quizer'),
        ),
        body: Center(child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(150),
            child: ElevatedButton(
              child: Text('Jouer', style: TextStyle(fontSize: 20.0),),
              onPressed: () {startQuiz();},
            ),
          ),
          Container(
            //margin: EdgeInsets.all(10),
            child: ElevatedButton(
              child: Text('Gérer', style: TextStyle(fontSize: 20.0),),
              onPressed: () {},
            ),
          ),
        ]
        ))

    );
  }

  void startQuiz(){
    setState(() {
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Playquiz()));


    });
  }


}

