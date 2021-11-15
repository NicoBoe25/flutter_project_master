import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/quizz.dart';

class Playquiz extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new letsDoQuiz();
  }



}
class letsDoQuiz extends State<Playquiz> {
var _quizes = Quizz();


  void _remove(int index) {
    setState(() {
      _quizes.remove(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Quizes'),
    ),
    body:ListView.builder(
    itemCount: _quizes.list_quizes.length,
    itemBuilder: (BuildContext context, int index) {

    final item = _quizes.list_quizes[index];
    return Dismissible(
    key: Key(item),
    background: Container(
    child: Icon(
    Icons.delete,
    size: 40,
    color: Colors.white,
    ),
    color: Colors.cyan,
    ),
    onDismissed: (direction) {
    _remove(index);
    var snackBar = SnackBar(
    content: Text('Suppression du grand site $item'),
    action: SnackBarAction(
    label: 'Annulation suppression',
    onPressed: () {
    setState(() {
    _quizes.add(item);
    });
    }
    )
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
    child: Card(
    child: ListTile(
    title: Text(
    _quizes.list_quizes[index],
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
                          _quizes.add(value);
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



















