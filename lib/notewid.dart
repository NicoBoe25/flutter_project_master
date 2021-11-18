import 'package:flutter/material.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
//import 'package:sqflite_database_example/widget/note_form_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final int? id;
  final String? name;
 // final ValueChanged<int> onChangedId;
  final ValueChanged<String> onChangedName;

  const NoteFormWidget({
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
                      hintText: "Quiz Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                      validator: (title) =>
                      title != null && title.isEmpty ? 'veuillez saisir un nom de quiz ' : null,
                      onChanged: onChangedName,
                    ),

                  ])
                    )),
                  ]),
             );


  }



}
