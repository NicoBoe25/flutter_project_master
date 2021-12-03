
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/ajouterquiz.dart';
import 'package:flutter_project_master/quizcards.dart';
import 'package:flutter_project_master/quizdetail.dart';

import 'ajouterquiz.dart';

class EditionQuiz extends StatefulWidget {
  final int? quizId;

  const EditionQuiz({
    Key? key,
     this.quizId,
  }) : super(key: key);

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
    refreshQuizes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshQuizes() async {
    setState(() => isLoading = true);

    quizes = await QuizDatabase.instance.readAllQuizes();

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
      padding: EdgeInsets.all(10),
      itemCount: quizes.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(4),
      crossAxisCount: 4,
      itemBuilder: (context, index) {
        final quiz = quizes[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailQuiz( quizId : quiz.id!)
            ));

            refreshQuizes();
          },
          onDoubleTap: () async {
            await QuizDatabase.instance.delete(quiz.id!);

            Navigator.of(context).pop();
            refreshQuizes();
          },
          onLongPress: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddQuizPage(quizId : quiz.id! , quiz: quiz)),
            );

            refreshQuizes();
          },
          child: QuizCardWidget(quiz: quiz, index: index),

        );
      }
  );

}