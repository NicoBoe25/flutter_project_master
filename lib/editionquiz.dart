import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/database/questiondatabase.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/ajouterquiz.dart';
import 'package:flutter_project_master/quizcards.dart';
import 'package:flutter_project_master/quizdetail.dart';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import 'ajouterquiz.dart';
import 'classObject/question.dart';

class EditionQuiz extends StatefulWidget {
  const EditionQuiz({Key? key}) : super(key: key);

  @override
  _QuizesPageState createState() => _QuizesPageState();
}

class _QuizesPageState extends State<EditionQuiz> {

  late List<Quiz> quizes;
  late Quiz quiz;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getWebXMLQuiz();
    refreshQuizes();
  }

  @override
  void dispose() {
    QuizDatabase.instance.close();

    super.dispose();
  }

  Future refreshQuizes() async {
    setState(() => isLoading = true);

    quizes = await QuizDatabase.instance.readAllQuizes();

    setState(() => isLoading = false);
  }

  Future getWebXMLQuiz() async {
    final url = Uri.parse(
        'https://dept-info.univ-fcomte.fr/joomla/images/CR0700/Quizzs.xml');
    var reponse = await http.get(url);
    if (reponse.statusCode == 200) {
      try{
        await parseXMLToListQuiz(reponse);
      }on Exception{
        print("Error parse xml");
    }
    }else{
      print("try again");
    }
  }

  parseXMLToListQuiz(var reponse) async{
    List<Quiz> listQuizFinale = [];
    List<Question> listQuestionFinale = [];
    int incrementQuestion = 0;
    int incrementQuiz = 0;
    String source = Utf8Decoder().convert(reponse.bodyBytes);
    var parse = XmlDocument.parse(source);
    print("------------------------------------------");

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

        //TODO: A Changer si on passe d'une String à un int
        var answer = listStrPropositions[idAnswer-1];

        switch(nbReponse){
          case 3:
            listQuestionFinale.add(Question(
                    id: incrementQuestion,
                    idquiz: incrementQuiz,
                    question: strQuestion,
                    option1: listStrPropositions[0],
                    option2: listStrPropositions[1],
                    option3: listStrPropositions[2],
                    answer: answer));
            break;
          case 4:
            listQuestionFinale.add(Question(
                id: incrementQuestion,
                idquiz: incrementQuiz,
                question: strQuestion,
                option1: listStrPropositions[0],
                option2: listStrPropositions[1],
                option3: listStrPropositions[2],
                option4: listStrPropositions[3],
                answer: answer));
            break;
          default:
            listQuestionFinale.add(Question(
                id: incrementQuestion,
                idquiz: incrementQuiz,
                question: strQuestion,
                option1: listStrPropositions[0],
                option2: listStrPropositions[1],
                answer: answer));
        }
        incrementQuestion++;
      }
      listQuizFinale.add(Quiz(id: incrementQuiz,name: quiz.attributes.first.value.toString()));
      incrementQuiz++;
    }
    List<Question> listeQuestion = QuestionDatabase.instance.readAllQuestion() as List<Question>;
    if(listeQuestion.isEmpty){
      for(Question q in listQuestionFinale){
        QuestionDatabase.instance.create(q);
      }
    }
    List<Quiz> listeQuiz = QuizDatabase.instance.readAllQuizes() as List<Quiz>;
    if(listeQuiz.isEmpty) {
      for (Quiz qu in listQuizFinale) {
        QuizDatabase.instance.create(qu);
      }
    }
  }



  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'Quizes',
        style: TextStyle(fontSize: 24),
      ),
    ),
    body: Center(
      child: isLoading
          ? CircularProgressIndicator()
          : quizes.isEmpty
          ? Text(
        'No Quizes',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildQuiz(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddQuizPage()),
        );

        refreshQuizes();
      },
    ),
  );

  Widget buildQuiz() => StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8),
      itemCount: quizes.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final quiz = quizes[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailQuiz( quizId : quiz.id!)
            ));

            refreshQuizes();
          },
          child: QuizCardWidget(quiz: quiz, index: index),

        );
      }
  );

}