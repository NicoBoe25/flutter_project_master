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

  void addNewQuiz(String s) {
    setState(() {
      list_quizes.add(Quiz(list_quizes.length,s));
    });
  }


  Widget build(BuildContext ctx){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizes'),
      ),
      body:ListView.builder(
          itemCount: list_quizes.length,
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
                  var snackBar = SnackBar(
                      content: Text('Suppression du grand site $item'),
                      action: SnackBarAction(
                          label: 'Annulation suppression',
                          onPressed: () {
                            setState(() {
                              _removeQuiz(index);
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



