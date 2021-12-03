import 'package:flutter/material.dart';


class QuestionFormWidget extends StatelessWidget {//les modification ou l'ajoute d'un question s'appuie sur la question et ces options et la réponse
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String answer;

  final ValueChanged<String> onChangedQuestion;// on crée pour prendre en compte les valeurs corresponant et les mettre la case, voir la class ajouterquestion pour un exemple plus clear
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

    required this.onChangedQuestion,//on est obligés de les prendre en paramétre quand on fait appel à cette class est c'est pour prendre les valeurs en compte sinon les valeurs seront pas enregistrés
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
                            validator: (title) =>// la verification que les informations obligatoir pour une question sont pas vide , c'est la question  ici , et on fait la meme vérification pour les options 1 et 2 et pour la réponse aussi
                            title != null && title.isEmpty ? 'veuillez saisir une question ' : null,
                            onChanged: onChangedQuestion,//on utilise onChangedQuestion pour prendre la question écrite dans la case comme valeur pour la question
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
                            decoration: InputDecoration(//les optiions 3 et 4 ne sont pas obligatoir , chaque question doit avoir au moins deux options
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
                              return "veuillez saisir une answer";}// laréponse est obligatoir


                            //pour vérifier que la réponse correspond bien à une des options
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
