import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/database/questiondatabase.dart';

class LaunchQuizQuestion extends StatefulWidget {

  int quizID;
  int idQuestion = 0;

  int score = 0;

  List<Question> questionList = [];
  late Question questionToPlay;

  LaunchQuizQuestion(this.quizID){
    questionList = QuestionDatabase.instance.readAllQuestionFromQuizId(quizID) as List<Question>;
    questionToPlay = questionList.first;

  }

  void incScore(){
    score++;
  }

  void nextQuestion(){
    idQuestion++;
  }


  @override
  State<StatefulWidget> createState() => _QuestionPageState(questionToPlay);

}

class _QuestionPageState extends State<LaunchQuizQuestion> {
  _QuestionPageState(Question questionToPlay){
    createListeProposition();
  }

  createListeProposition(){
    propositionList.add(question.option1);
    propositionList.add(question.option2);
    if(question.option3 == "" || question.option3 == null || question.option3 == "null"){
      propositionList.add(question.option3!);
    }
    if(question.option4 == "" || question.option4 == null || question.option4 == "null"){
      propositionList.add(question.option4!);
    }
  }

  late List<Question> questionList;
  late Question question;
  late Quiz quiz;
  late List<String> propositionList;

  List<Color> listCouleur = [Colors.red, Colors.green, Colors.cyan, Colors.amber];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(quiz.name),
        ),
        body: Center(child:
        Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(150),
                child: Text(
                  question.question,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                child: ListView.builder(
                  itemCount: propositionList.length,
                  itemBuilder: (BuildContext context, int index){
                    final item = propositionList[index];
                    return ElevatedButton(
                      key: Key(item),
                      child: Text(item),
                      style: ElevatedButton.styleFrom(
                        primary: listCouleur.elementAt(index)
                      ),
                      onPressed: checkAnswer(index),

                    );
                  },
                )
              ),
          ]
        )
      )
    );
  }

  checkAnswer(int index) {
    print("Proposition Choisie"+String.fromCharCode(index));
  }

}
