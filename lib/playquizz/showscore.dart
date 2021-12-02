import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/main.dart';

class ShowScore extends StatefulWidget {

  int score;
  Quiz quiz;

  ShowScore(this.quiz,this.score);

  @override
  ScorePageState createState() => ScorePageState(quiz,score);
}


class ScorePageState extends State<ShowScore>{

  int score;
  Quiz quiz;

  ScorePageState(this.quiz,this.score);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(quiz.name),
        ),
        body: Center(child:
        Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(50),
                child: Text('Votre score est de '+this.score.toString(),
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                child: Text('Home', style: TextStyle(fontSize: 20.0),),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyQuiz())
                  );
                },
              ),
            ]
        )
        )
    );

  }

}