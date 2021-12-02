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

  int idquiz;
  Quiz quiz;

  List<Question> questionList = [];
  late Question question;
  int idquestion = 0;
  late List<String> propositionList;

  List<Color> listCouleur = [
    Colors.lightGreen,
    Colors.lightBlue,
    Colors.amberAccent,    Colors.pinkAccent,

  ];
  int score = 0;

  bool isAnwserShown = false;

  _QuestionPageState(this.idquiz,this.quiz, this.questionList){
    question = questionList.first;
    createListeProposition();
  }
  void incScore(){
    setState(() {
      if(!this.isAnwserShown){
        score++;
      }
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
        this.isAnwserShown = false;
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
                Container(
                  margin: EdgeInsets.all(50),
                  child: ElevatedButton(
                    child: Text('Afficher la Reponse', style: TextStyle(fontSize: 20.0),),
                    onPressed: () {showAnwser(question);},
                  ),
                ),
                Container(
                  child: Visibility(
                      visible: isAnwserShown,
                      child: Text('La reponse est : '+ question.answer,
                      style: TextStyle(fontSize: 16.0, color: Colors.deepOrangeAccent),)
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

  void showAnwser(Question question) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState){
        return AlertDialog(
          title: Text('Etes vous sur de voir la réponse?',
              style: TextStyle(color: Colors.black, fontSize: 20.0)),
          content:
                Text(
                    'Oui pour voir la réponse, sinon appuyer sur Fermer'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () =>
                  anwserShown(),
              child:
              Text('Oui', style: TextStyle(fontSize: 18.0)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // this line dismisses the dialog
              child: Text('Fermer', style: TextStyle(fontSize: 18.0)),
            )
          ],
        );
      })
    );
  }

  anwserShown(){
    setState(() {
      isAnwserShown = true;
    });
  }

}
