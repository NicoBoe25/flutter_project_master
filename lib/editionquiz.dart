import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/ajouterquiz.dart';
import 'package:flutter_project_master/quizcards.dart';
import 'package:flutter_project_master/ajouterquestion.dart';
import 'package:flutter_project_master/quizdetail.dart';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';


import 'ajouterquiz.dart';
import 'quizwid.dart';




class EditionQuiz extends StatefulWidget {
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

    this.quizes = await QuizDatabase.instance.readAllQuizes();

    setState(() => isLoading = false);
  }

  Future getWebXMLQuiz() async {
    List<Quiz> quizToAdd;
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

  parseXMLToListQuiz(var reponse) async{
    List<Quiz> test = [];
    String source = Utf8Decoder().convert(reponse.bodyBytes);
    var parse = XmlDocument.parse(source);
    print("------------------------------------------");
    var root = parse.rootElement;
    if(root.name.toString()=="Quizzs"){
      var listQuiz = root.findAllElements('Quizz');
      for(var quizzzz in listQuiz){
        print(quizzzz.attributes.first.value);
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