import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/playquizz/showscore.dart';

class LaunchQuizQuestion extends StatefulWidget {

  int idquiz;
  List<Question> questionList;
  Quiz quiz;

  LaunchQuizQuestion(this.idquiz,this.quiz,this.questionList);

  @override
  State<StatefulWidget> createState() => _QuestionPageState(idquiz,quiz,questionList);
}

class _QuestionPageState extends State<LaunchQuizQuestion> {

  List<Question> questionList = [];
  int idquiz;

  late Question question;
  Quiz quiz;
  late List<String> propositionList;

  List<Color> listCouleur = [Colors.red, Colors.green, Colors.cyan, Colors.amber];
  int score = 0;
  int idquestion = 0;


  _QuestionPageState(this.idquiz,this.quiz, this.questionList){
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
        }else{
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ShowScore(quiz, score))
          );
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
            title: Text(quiz.name),
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
