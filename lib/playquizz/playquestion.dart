import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/database/questiondatabase.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';

class LaunchQuizQuestion extends StatefulWidget {

  int idquiz;

  List<Question> questionList;

  LaunchQuizQuestion(this.idquiz,this.questionList){
    // questionList = [
    //   const Question(
    //       question: 'Est ce que ca marche a 2 ?',
    //       option1: 'oui',
    //       option2: 'non',
    //       option3: '',
    //       option4: '',
    //       answer: 'oui'
    //   ),
    //   const Question(
    //       question: 'Est ce que ca marche a 3 ?',
    //       option1: 'oui',
    //       option2: 'non',
    //       option3: 'peut etre',
    //       option4: '',
    //       answer: 'peut etre'
    //   ),
    //   const Question(
    //       question: 'Est ce que ca marche a 4 ?',
    //       option1: 'oui',
    //       option2: 'non',
    //       option3: 'peut etre',
    //       option4: 'on ne c pas',
    //       answer: 'oui')
    // ];

// try avec bdd -> erreur parse Future<List<Question>> to List<Question>
  }

  @override
  State<StatefulWidget> createState() => _QuestionPageState(idquiz,questionList);
}

class _QuestionPageState extends State<LaunchQuizQuestion> {

  List<Question> questionList = [];
  int idquiz;

  late Question question;
  late Quiz quiz;
  late List<String> propositionList;
  late String quizName;

  List<Color> listCouleur = [Colors.red, Colors.green, Colors.cyan, Colors.amber];
  int score = 0;
  int idquestion = 0;


  _QuestionPageState(this.idquiz, this.questionList){
    question = questionList.first;
    createListeProposition();
  }
  void incScore(){
    setState(() {
      score++;
    });
  }

  checkAnswer(int index, String anwserChosen) {
    String message = "La bonne réponse était : "+question.answer;
    if(anwserChosen == question.answer){
      incScore();
      message = "Vous avez eu la bonne reponse !";
    }

    var snackBar =
    SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    nextQuestion();
  }

  void nextQuestion(){
      setState(() {
        idquestion++;
        if(questionList.length > idquestion) {
          question = questionList.elementAt(idquestion);
          createListeProposition();
        }
      });
  }

  createListeProposition(){
      propositionList = [];
      propositionList.add(question.option1);
      propositionList.add(question.option2);
      if(question.option3 != ''){
        propositionList.add(question.option3!);
        if(question.option4 != '') {
          propositionList.add(question.option4!);
        }
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(/*quiz.name*/ "Blabla"),
        ),
        body: Center(child:
        Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(50),
                child: Text(
                  question.question,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox(
                height: 250.0,
                child:  ListView.builder(
                  itemCount: propositionList.length,
                  itemBuilder: (BuildContext context, int index){
                    final item = propositionList[index];
                    return ElevatedButton(
                      key: Key(item),
                      child: Text(item),
                      style: ElevatedButton.styleFrom(
                          primary: listCouleur.elementAt(index)
                      ),
                      onPressed: () => checkAnswer(index,item),
                    );
                  },
                ),
              )
          ]
        )
      )
    );
  }



}
