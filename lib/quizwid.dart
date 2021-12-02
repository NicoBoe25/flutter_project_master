import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class QuizFormWidget extends StatelessWidget {
  final String? name;
  // final ValueChanged<int> onChangedId;
  final ValueChanged<String> onChangedName;

  const QuizFormWidget({
    Key? key,
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
                          Spacer(), // 1/6
                          Text("Enter a name for the  quiz "),
                          Spacer(), // 1/6
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Quiz Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (name) =>
                            name != null && name.isEmpty ? 'veuillez saisir un nom de quiz ' : null,
                            onChanged: onChangedName,
                          ),

                        ])
                )),
          ]),
    );


  }



}