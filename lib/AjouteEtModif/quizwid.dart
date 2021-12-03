import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class QuizFormWidget extends StatelessWidget {//on modifie le nom d'un quiz
  final String? name;
  final ValueChanged<String> onChangedName;//pour prendre en compte le nouveau nom du quiz

  const QuizFormWidget({
    Key? key,
    this.name = '',
    required this.onChangedName,//ces obligatoir de les prendre en paramétre quand on fait appel à cette class est c'est pour prendre les valeurs en compte sinon les valeurs seront pas enregistrés
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
                          Spacer(), //2/6
                          Text(
                            "créer Quiz",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(flex: 1), // 1/6
                          Text("le nom du quiz : ",style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          Spacer(), // 1/6
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Quiz Nom",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            validator: (name) =>//verification que le nom n'est pas vide
                            name != null && name.isEmpty ? 'veuillez saisir un nom de quiz ' : null,
                            onChanged: onChangedName,
                          ),
                          Spacer(flex: 2),

                        ])
                )),
          ]),
    );


  }



}