import 'package:flutter/material.dart';
import 'package:flutter_project_master/questioncard.dart';
import 'package:flutter_project_master/quizcards.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/database/questiondatabase.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'package:flutter_project_master/ajouterquiz.dart';

import 'ajouterquestion.dart';


class DetailQuiz extends StatefulWidget {
  final int quizId;

  const DetailQuiz({
    Key? key,
    required this.quizId,
  }) : super(key: key);

  @override
  _AjouteQestionPageState createState() => _AjouteQestionPageState();
}

class _AjouteQestionPageState extends State<DetailQuiz> {
  late Quiz quiz;
  late Question question;
  late List<Question> listequestion ;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshQuiz();
  }
  @override
  void dispose() {
    QuestionDatabase.instance.close();

    super.dispose();
  }

  Future refreshQuiz() async {
    setState(() => isLoading = true);

    this.listequestion = await QuestionDatabase.instance.readAllQuestionFromQuizId(widget.quizId);

    setState(() => isLoading = false);
  }

  @override


  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(
          'Questions',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : listequestion.isEmpty
            ? Text(
          'No Questions',
          style: TextStyle(color: Colors.blue, fontSize: 24),
        )
            : buildQuestion(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AjouterQuestionPage(quizId: widget.quizId!)),
          );

          refreshQuiz();
        },
      )
  );

  /* Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AjouterQuestionPage(quiz: quiz),
        ));
        refreshQuiz();
      });
  Widget deleteButton() => IconButton(
    icon: Icon(Icons.delete),
    onPressed: () async {
      await QuizDatabase.instance.delete(widget.quizId);
      Navigator.of(context).pop();
    },
  );*/
  Widget buildQuestion() => StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8),
      itemCount: listequestion.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final questions = listequestion[index];

        return GestureDetector(
         /*onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AjouterQuestionPage( quizId: widget.quizId)
            ));

            refreshQuiz();
          },*/

          child: QuestionCardWidget(question: questions, index: index),

        );
      }
  );



}