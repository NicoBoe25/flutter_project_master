import 'package:flutter/material.dart';
import 'package:flutter_project_master/playquizz/playquiz.dart';
import 'editionquiz.dart';

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
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/backg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FittedBox(
                    child: GestureDetector(
                      onTap: () {
                       startQuiz();
                          },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 25),
                        padding:
                        EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.amberAccent,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Jouer",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  FittedBox(
                    child: GestureDetector(
                      onTap: () {
                        startEditionQuiz();
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 25),
                        padding:
                        EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.amberAccent,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Gérer",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }


  void startQuiz(){
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Playquiz()));
    });
  }

  void startEditionQuiz(){
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> EditionQuiz()));
    });
  }
  }


