import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'package:flutter_project_master/classObject/quiz.dart';

class LaunchQuizQuestion extends StatefulWidget {

  int idquiz;
  List<Question> listQuestion = [];
  int idquestion = 0 ;

  LaunchQuizQuestion(this.idquiz){
    listQuestion = [
      const Question(
          question: 'Est ce que ca marche a 2 ?',
          option1: 'oui',
          option2: 'non',
          option3: '',
          option4: '',
          answer: 'oui'
      ),
      const Question(
          question: 'Est ce que ca marche a 3 ?',
          option1: 'oui',
          option2: 'non',
          option3: 'peut etre',
          option4: '',
          answer: 'peut etre'
      ),
      const Question(
          question: 'Est ce que ca marche a 4 ?',
          option1: 'oui',
          option2: 'non',
          option3: 'peut etre',
          option4: 'on ne c pas',
          answer: 'oui')
    ];
  }

// try avec bdd -> erreur parse Future<List<Question>> to List<Question>
  // int quizID;
  // int idQuestion = 0;
  //
  // late Future<List<Question>> questionFutureList;
  // late List<Question> questionList;
  // late Question questionToPlay;
  //
  // LaunchQuizQuestion(this.quizID){
  //   questionFutureList = QuestionDatabase.instance.readAllQuestionFromQuizId(quizID);
  //   questionList = questionFutureList as List<Question>;
  //   questionToPlay = questionList.first;
  // }

  @override
  State<StatefulWidget> createState() => _QuestionPageState(listQuestion);
}

class _QuestionPageState extends State<LaunchQuizQuestion> {

  List<Question> listQuestion;
  late Question question;
  late Quiz quiz;
  late List<String> propositionList;

  List<Color> listCouleur = [Colors.red, Colors.green, Colors.cyan, Colors.amber];
  int score = 0;
  int idquestion = 0;

  _QuestionPageState(this.listQuestion){
    question = listQuestion.elementAt(idquestion);
    createListeProposition();
  }
  void incScore(){
    setState(() {
      score++;
    });
  }

  checkAnswer(int index) {

    print("Proposition Choisie" + index.toString());
    nextQuestion();
  }

  void nextQuestion(){
      setState(() {
        idquestion++;
        if(listQuestion.length > idquestion) {
          question = listQuestion.elementAt(idquestion);
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
                margin: EdgeInsets.all(150),
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
                      onPressed: () => checkAnswer(index),

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
