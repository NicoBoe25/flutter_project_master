
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/AjouteEtModif/ajouterquiz.dart';
import 'package:flutter_project_master/designCards/quizcards.dart';
import 'package:flutter_project_master/AjouteEtModif/quizdetail.dart';

import 'ajouterquiz.dart';

class EditionQuiz extends StatefulWidget {
  final int? quizId;//on prend l'id de quiz comme clé facultative , car il est crée par défault quand on ajoute un nouveau quiz , par contre onle prendre en compte en cas de modification d'un quiz

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

  Future refreshQuizes() async {// cette fonction est utilisée actualiser la page surtot pour voir les quizes ajoutés ou modifiés
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
          ? CircularProgressIndicator()//en cas d'existance des auizes en BDD
          : quizes.isEmpty//s'il y a pas de quiz , il affiche no quizes
          ? Text(
        'No Quizes',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildQuiz(),
    ),
    floatingActionButton: FloatingActionButton(// le button d'ajoute d'un quiz , nous envoit au page d'ajoute des quizes
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

  Widget buildQuiz() => StaggeredGridView.countBuilder(//on a décidé de changer le style de liste view à un grid view
      padding: EdgeInsets.all(10),
      itemCount: quizes.length,//comme une liste view en prendr la nombre de quizes existants
      staggeredTileBuilder: (index) => StaggeredTile.fit(4),
      crossAxisCount: 4,
      itemBuilder: (context, index) {
        final quiz = quizes[index];

        return GestureDetector(// pour chaque quiz dans la liste on a la possibilité de voir ses question en appuiant au-dessus pour aller à la page DetailQuiz
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailQuiz( quizId : quiz.id!)//on prende le quiz id pour spécifier qu'on veut voir les questions de le quiz qu'on appuie  au-dessus
            ));

            refreshQuizes();
          },
          onDoubleTap: () async {// on peut supprimer un quiz en appuiant deux fois au-dessus
            await QuizDatabase.instance.delete(quiz.id!);//appele à la fonction delet en BDD de quizes

            Navigator.of(context).pop();
            refreshQuizes();
          },
          onLongPress: () async {// pour modifier le nom d'un quiz , on appuie long temps
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddQuizPage(quizId : quiz.id! , quiz: quiz)),// on va à la page d'ajoute d'un quiz , et on prend le quiz qu'on appuie au-dessus , pour que cette page puisse savoir que ce quiz exist déjà et va à la méthode updateQuiz directemet
            );

            refreshQuizes();
          },
          child: QuizCardWidget(quiz: quiz, index: index),

        );
      }
  );

}