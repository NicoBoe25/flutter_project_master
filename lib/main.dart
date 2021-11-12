import 'package:flutter/material.dart';

void main() {
  runApp(MyQuiz());
}

class MyQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: MyQuizs(),
    );
  }
}

class MyQuizs extends StatefulWidget {
  @override
  _AllMyQuizs createState() {
    return _AllMyQuizs();

  }

}
class _AllMyQuizs extends State<MyQuizs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quizer'),
        ),
        body: Center(child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(150),
            child: ElevatedButton(
              child: Text('Jouer', style: TextStyle(fontSize: 20.0),),
              onPressed: () {},
            ),
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

