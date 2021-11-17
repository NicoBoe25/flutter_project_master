import 'package:flutter/cupertino.dart';
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
}



