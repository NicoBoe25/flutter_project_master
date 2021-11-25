import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:flutter_project_master/passerquiz.dart';
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


import 'ajouterquiz.dart';
import 'quizwid.dart';




class Playquiz extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<Playquiz> {
  final textController = TextEditingController();

  late List<Quiz> quizes;
  late Quiz quiz;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

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
          : buildQuizes(),
    ),

  );

  Widget buildQuizes() => StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8),
      itemCount: quizes.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final quiz = quizes[index];

        return GestureDetector(
         /* onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PasserQuiz( quizId : quiz.id!)
            ));

            refreshQuizes();
          },*/
          child: QuizCardWidget(quiz: quiz, index: index),

        );
      }
  );

}