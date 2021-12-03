import 'package:flutter/material.dart';
import 'package:flutter_project_master/designCards/questioncard.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_project_master/database/questiondatabase.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'ajouterquestion.dart';


class DetailQuiz extends StatefulWidget {
  final int quizId;//on prend l'id du quie comme clé obligatoir , pour voir les questions d'un quiz qu'on appuie au-dessus

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

  Future refreshQuiz() async {//pour actualiser la page surtot pour voir les questions ajoutés ou modifiés
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
            ? CircularProgressIndicator()//on attendant le chargement des questiond de la BDD
            : listequestion.isEmpty
            ? Text(
          'No Questions',
          style: TextStyle(color: Colors.blue, fontSize: 24),
        )
            : buildQuestion(),
      ),
      floatingActionButton: FloatingActionButton(//le burrion d'ajoute d'une nouvelle question
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AjouterQuestionPage(quizId: widget.quizId)),//on prend l'id de quiz actuel pour ajouter les question à CE QUIZ
          );

          refreshQuiz();
        },
      )
  );

  Widget buildQuestion() => StaggeredGridView.countBuilder(//on a décidé de changer le style de liste view à un grid view
      padding: EdgeInsets.all(10),
      itemCount: listequestion.length,//comme une liste view en prendr la nombre de question existants
      staggeredTileBuilder: (index) => StaggeredTile.fit(4),
      crossAxisCount: 4,
      itemBuilder: (context, index) {
        final questions = listequestion[index];

        return GestureDetector(// pour chaque question dans la liste on a la possibilité de la modifier en appuiant au-dessus pour aller à la page AjouterQuestionPage
            onTap: () async {
          if (isLoading) return;

          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AjouterQuestionPage( quizId: widget.quizId ,question: questions)//on prende en parametre l'id du quiz et la question qu'on modifie
        ));

        refreshQuiz();
      },
          onDoubleTap: () async {
            await QuestionDatabase.instance.delete(questions.id!);//on supprime une question on appuie deux fois au-dessus

            Navigator.of(context).pop();
            refreshQuiz();

          },
          child: QuestionCardWidget(question: questions, index: index),

        );
      }
  );
}