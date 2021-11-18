import 'package:flutter/material.dart';
import 'ajouterquiz.dart';

import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
//import 'package:sqflite_database_example/widget/note_form_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class QuizFormWidget extends StatelessWidget {
  final int? id;
  final String? name;
  // final ValueChanged<int> onChangedId;
  final ValueChanged<String> onChangedName;

  const QuizFormWidget({
    Key? key,
    this.id = 0,
    this.name = '',
    //required this.onChangedId,
    required this.onChangedName,
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
                          Spacer(flex: 2), //2/6
                          Text(
                            "Let's creat a Quiz,",

                          ),
                          Text("Enter a name for the  quiz "),
                          Spacer(), // 1/6
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Question",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (title) =>
                            title != null && title.isEmpty ? 'veuillez saisir une question ' : null,
                            onChanged: onChangedName,
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
                            onChanged: onChangedName,
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
                            onChanged: onChangedName,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "option 3 ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "option 4 ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "answer ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (title) =>
                            title != null && title.isEmpty ? 'veuillez saisir une answer ' : null,
                            onChanged: onChangedName,
                          ),

                        ])
                )),
          ]),
    );


  }



}

/*TextFormField(
    decoration: InputDecoration(
    hintText: "option1",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'veuillez saisir une première option' : null,
    onChanged: onChangedName,
    ),
    TextFormField(
    decoration: InputDecoration(
    hintText: "option2",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'veuillez saisir une deuxième option' : null,
    onChanged: onChangedName,
    ),
    TextFormField(
    decoration: InputDecoration(
    hintText: "option3",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    ),
    ),
    TextFormField(
    decoration: InputDecoration(
    hintText: "option4",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    ),
    ),
    TextFormField(
    decoration: InputDecoration(
    hintText: "answer",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'veuillez saisir une answer' : null,
    onChanged: onChangedName,
    ),*/



