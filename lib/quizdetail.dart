import 'package:flutter/material.dart';
import 'package:flutter_project_master/questioncard.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_project_master/database/questiondatabase.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'ajouterquestion.dart';


class DetailQuiz extends StatefulWidget {
  final int quizId;

  const DetailQuiz({
    Key? key,
    required this.quizId,
  }) : super(key: key);

  @override
  _AjouteQuestionPageState createState() => _AjouteQuestionPageState();
}

class _AjouteQuestionPageState extends State<DetailQuiz> {
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
            MaterialPageRoute(builder: (context) => AjouterQuestionPage(quizId: widget.quizId)),
          );

          refreshQuiz();
        },
      )
  );

  Widget buildQuestion() => StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(10),
      itemCount: listequestion.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(4),
      crossAxisCount: 4,
      itemBuilder: (context, index) {
        final questions = listequestion[index];

        return GestureDetector(
            onTap: () async {
          if (isLoading) return;

          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AjouterQuestionPage( quizId: widget.quizId ,question: questions)
        ));

        refreshQuiz();
      },
          onDoubleTap: () async {
            await QuestionDatabase.instance.delete(questions.id!);

            Navigator.of(context).pop();
            refreshQuiz();

          },
          child: QuestionCardWidget(question: questions, index: index),

        );
      }
  );
}