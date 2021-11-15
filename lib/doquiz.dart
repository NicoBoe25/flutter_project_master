import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/quiz.dart';

/*class DoQuiz extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new letsDoQuizs();
  }

  Quiz quiz1 = new Quiz(1, "geoquiz");
  Quiz quiz2 = new Quiz(2, "geoquiz");
  Quiz quiz3 = new Quiz(3, "geoquiz");
  Quiz quiz4 = new Quiz(4, "geoquiz");

  List<Quiz> list_quizes = List<Quiz>[];
  list_quizes.add(quiz1);

  var myListQuiz = List.filled(4, null, growable: false);
  myListQuiz;
}
class letsDoQuizs extends State<DoQuiz> {



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
        itemCount: _quizes.list_questions.length,
        itemBuilder: (BuildContext context, int index) {

         final item = _quizes.list_questions[index];
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
    _quizes.list_questions[index],
    textAlign: TextAlign.center,
    ),
    onTap: () {
    var snackBar =
    SnackBar(content: Text('$item'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    })));
    }),
    }
        )

    
  }
}













*/





/*class DoQuiz extends StatefulWidget {

  @override
  _letsDoQuizs createState() {
    return _letsDoQuizs();
  }

  class _letsDoQuizs extends State<DoQuiz> {


  }
}*/