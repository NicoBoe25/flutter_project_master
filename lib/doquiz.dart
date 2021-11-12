import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoQuiz extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new letsDoQuizs();
  }
}
class letsDoQuizs extends State<DoQuiz> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quizer'),
        ),
        body: Center(child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(150),

              child: Text('', style: TextStyle(fontSize: 20.0),),

            ),

          Container(
            //margin: EdgeInsets.all(10),
            child: ElevatedButton(
              child: Text('Gérer', style: TextStyle(fontSize: 20.0),),
              onPressed: () {},
            ),
          ),
        ]
        ))

    );
  }
}



















/*class DoQuiz extends StatefulWidget {

  @override
  _letsDoQuizs createState() {
    return _letsDoQuizs();
  }

  class _letsDoQuizs extends State<DoQuiz> {


  }
}*/