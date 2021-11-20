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
/*Widget buildNotes() => ListeView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: notes.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final note = notes[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteDetailPage(noteId: note.id!),
          ));

          refreshNotes();
        },
        child: NoteCardWidget(note: note, index: index),
      );
    },
  );*/


/*floatingActionButton: FloatingActionButton(
            child: Icon(Icons.save),
            onPressed: () async {
              await DatabaseHelper.instance.add(Quiz(name: textController.text),);
              setState(() {
                textController.clear();
              });
            }
        ),*/
//  );
// }
//}

/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'classObject/quiz.dart';

class EditionQuiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PlayEditionQuiz();
  }
}
class PlayEditionQuiz extends State<EditionQuiz> {
  List<Quiz> list_quizes = List<Quiz>.filled(0,Quiz(0,"test"),growable: true);

  void _removeQuiz(int index) {
    setState(() {
      list_quizes.remove(index);
    });
  }
  void _cancelDeleteQuiz(Quiz item){
    addNewQuiz(item.name);
  }

  void addNewQuiz(String s) {
    setState(() {
      list_quizes.add(Quiz(list_quizes.length,s));
    });
  }

  int launchAddFonction(){
    list_quizes.add(Quiz(1, "test1"));
    list_quizes.add(Quiz(2, "test2"));
    list_quizes.add(Quiz(3, "test3"));
    return list_quizes.length;
  }


  Widget build(BuildContext ctx){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizes'),
      ),
      body:ListView.builder(

          itemCount: launchAddFonction(),
          itemBuilder: (BuildContext context, int index) {

            final item = list_quizes[index];
            return Dismissible(
                key: Key(item.name),
                background: Container(
                  child: Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.white,
                  ),
                  color: Colors.cyan,
                ),
                onDismissed: (direction) {
                  _removeQuiz(index);
                  var snackBar = SnackBar(
                      content: Text('Suppression du quiz $item'),
                      action: SnackBarAction(
                          label: 'Annulation suppression',
                          onPressed: () {
                            setState(() {
                              _cancelDeleteQuiz(item);
                            });
                          })
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Card(
                    child: ListTile(
                        title: Text(
                          list_quizes[index].name,
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          var snackBar =
                          SnackBar(content: Text('$item'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        })));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Ajouter un grand site'),
                  content: TextField(
                      decoration: InputDecoration(
                          hintText: "Saisissez le nom du grand site"),
                      onSubmitted: (value) {
                        setState(() {
                          addNewQuiz(value);
                        });
                        Navigator.of(context).pop();
                      }),
                );
              });
        },
        tooltip: 'ajouter un grand site',
        child: Icon(Icons.add),
      ),
    );
  }
}*/


}
