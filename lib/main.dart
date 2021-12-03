import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_master/playquizz/playquiz.dart';


import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import 'classObject/question.dart';
import 'classObject/quiz.dart';
import 'database/questiondatabase.dart';
import 'database/quizdatabase.dart';
import 'AjouteEtModif/editionquiz.dart';

import 'dart:convert';

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
    getWebXMLQuiz();
    return _AllMyQuizs();
  }

/**
 * Recupère xml data
 * Envoi au parseur
 */
Future getWebXMLQuiz() async {
  final url = Uri.parse(
      'https://dept-info.univ-fcomte.fr/joomla/images/CR0700/Quizzs.xml');
  var reponse = await http.get(url);
  if (reponse.statusCode == 200) {
    try{
      await parseXMLToListQuiz(reponse);
    }catch(Exception){
      print("Error parse xml");
    }
  }else{
    print("try again");
  }
}

/**
 * Parseur data xml to string
 * Ajout dans la base de données
 */
parseXMLToListQuiz(var reponse) async{
  List<Quiz> listQuizFinale = [];
  List<Question> listQuestionFinale = [];
  int incrementQuestion = 0;
  int incrementQuiz = 0;

  String source = Utf8Decoder().convert(reponse.bodyBytes);
  var parse = XmlDocument.parse(source);

  var listQuiz = parse.findAllElements('Quizz');

  //Boucle des Quiz
  for(var quiz in listQuiz){
    var listQuestion = quiz.findAllElements('Question');

    //Boucle des Questions
    for(var question in listQuestion){
      String strQuestion = question.children.first.toString();
      var nodePropositions = question.getElement('Propositions');
      var nodeNombrePropo = nodePropositions!.getElement('Nombre');

      var nbReponse = int.parse(nodeNombrePropo!.attributes.first.value);

      List<String> listStrPropositions = [];

      //Boucle des propositions
      for(var propos in nodePropositions.findAllElements('Proposition') ){
        listStrPropositions.add(propos.text);
      }

      var nodeAnswer = question.getElement('Reponse');

      var idAnswer = int.parse(nodeAnswer!.attributes.first.value);

      var answer = listStrPropositions[idAnswer-1];

      switch(nbReponse){
        case 3:
          listQuestionFinale.add(Question(
              id: incrementQuestion,
              question: strQuestion,
              option1: listStrPropositions[0],
              option2: listStrPropositions[1],
              option3: listStrPropositions[2],
              option4: '',
              idquiz: incrementQuiz,
              answer: answer));
          break;
        case 4:
          listQuestionFinale.add(Question(
              id: incrementQuestion,
              question: strQuestion,
              option1: listStrPropositions[0],
              option2: listStrPropositions[1],
              option3: listStrPropositions[2],
              option4: listStrPropositions[3],
              idquiz: incrementQuiz,
              answer: answer));
          break;
        default:
          listQuestionFinale.add(Question(
              id: incrementQuestion,
              question: strQuestion,
              option1: listStrPropositions[0],
              option2: listStrPropositions[1],
              option3: '',
              option4: '',
              idquiz: incrementQuiz,
              answer: answer));
      }
      incrementQuestion++;
    }
    listQuizFinale.add(Quiz(id: incrementQuiz,name: quiz.attributes.first.value.toString()));
    incrementQuiz++;
  }
  //Ajout dans les bases de données
  QuizDatabase.instance.readAllQuizes().then((List<Quiz> listeQuiz){
    if(listeQuiz.isEmpty){
      for (Quiz qu in listQuizFinale) {
        qu.id = (qu.id! + listeQuiz.length);
        QuizDatabase.instance.create(qu);
      }
      QuestionDatabase.instance.readAllQuestion().then((List<Question> listeQuestion) {
        for(Question q in listQuestionFinale){
          q.id = q.id! + listeQuestion.length;
          q.idquiz = q.idquiz! + listeQuiz.length;
          QuestionDatabase.instance.create(q);
        }
      });
    }
  });

  }//fin parse
}

class _AllMyQuizs extends State<MyQuizs> {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/backg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FittedBox(
                    child: GestureDetector(
                      onTap: () {
                       startQuiz();
                          },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 25),
                        padding:
                        EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.amberAccent,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Jouer",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  FittedBox(
                    child: GestureDetector(
                      onTap: () {
                        startEditionQuiz();
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 25),
                        padding:
                        EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.amberAccent,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Gérer",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }


  /**
   * Lance la partie jouer
   */
  void startQuiz(){
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Playquiz()));
    });
  }

  /**
   * Lance la partie édition
   */
  void startEditionQuiz(){
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> EditionQuiz()));
    });
  }
}