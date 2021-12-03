import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'ajouterquiz.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'package:flutter/material.dart';

class QuestionFormWidget extends StatelessWidget {
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String answer;
  // final ValueChanged<int> onChangedId;
  final ValueChanged<String> onChangedQuestion;
  final ValueChanged<String> onChangedOption1;
  final ValueChanged<String> onChangedOption2;
  final ValueChanged<String> onChangedOption3;
  final ValueChanged<String> onChangedOption4;
  final ValueChanged<String> onChangedAnswer;

  const QuestionFormWidget({
    Key? key,
    this.question = '',
    this.option1 = '',
    this.option2 = '',
    this.option3 = '',
    this.option4 = '',
    this.answer = '',

    //required this.onChangedId,
    required this.onChangedQuestion,
    required this.onChangedOption1,
    required this.onChangedOption2,
    required this.onChangedOption3,
    required this.onChangedOption4,
    required this.onChangedAnswer,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            SafeArea(
                child: (
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Question" ,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (title) =>
                            title != null && title.isEmpty ? 'veuillez saisir une question ' : null,
                            onChanged: onChangedQuestion,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "option 1 ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (title) =>
                            title != null && title.isEmpty ? 'veuillez saisir une option ' : null,
                            onChanged: onChangedOption1,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "option 2 ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (title) =>
                            title != null && title.isEmpty ? 'veuillez saisir une deuxième  option ' : null,
                            onChanged: onChangedOption2,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "option 3 ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            onChanged: onChangedOption3 ,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "option 4 ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            onChanged: onChangedOption4,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "answer ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (title) {

                            if(title != null && title.isEmpty){
                              return "veuillez saisir une answer";}

                              if(title.toString().toLowerCase() !=  option1.toString().toLowerCase()
                                  && title.toString().toLowerCase() !=  option2.toString().toLowerCase()
                                  && title.toString().toLowerCase() !=  option3.toString().toLowerCase()
                                  && title.toString().toLowerCase() !=  option4.toString().toLowerCase())
                              {return "la réponse doit correspondre à une des options";}

                              },
                            onChanged: onChangedAnswer,
                          ),
                        ])
                )),
          ]),
    );
  }

  }




//question1!.question.toString() != null ? question1!.question : "Question"