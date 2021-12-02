import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'package:flutter_project_master/database/questiondatabase.dart';
import 'package:flutter_project_master/playquizz/playquestion.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/quizcards.dart';


class Playquiz extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}
class _NotesPageState extends State<Playquiz> {
  final textController = TextEditingController();
  late List<Quiz> quizes;
  late Quiz quiz;
  bool isLoading = false;

  //Load For Play
  late List<Question> listAllQuestion;
  late List<List<Question>> listOfListQuestions = [[]];


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
    this.quizes = await QuizDatabase.instance.readAllQuizes();
    setState(() => isLoading = false);
    createListQuestion();
  }
  createListQuestion(){
    for(int i=0; i < quizes.length; i++ ){
      QuestionDatabase.instance.readAllQuestionFromQuizId(i).then((List<Question> value){
        listOfListQuestions.add(value);
      });
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
         onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LaunchQuizQuestion(quiz.id!,quiz, listOfListQuestions.elementAt(quiz.id!+1))
            ));

            refreshQuizes();
          },
          child: QuizCardWidget(quiz: quiz, index: index),

        );
      }
  );

}