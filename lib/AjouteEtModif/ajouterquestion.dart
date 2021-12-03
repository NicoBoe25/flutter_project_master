import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/database/questiondatabase.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'package:flutter_project_master/AjouteEtModif/questionswid.dart';

class AjouterQuestionPage extends StatefulWidget {
  final Question? question;//on prend la question (qu'on modifier ) comme clé
  final Quiz? quiz;
  final int quizId;// et on prend l'id de quiz auquel appartient la question qu'on modifier , comme clé aussi ,



  const AjouterQuestionPage({
    Key? key,
    this.question,
    this.quiz,
    required this.quizId,// l'id de quiz est obligatoir pour ajouter ou modifier la question pour un spésifique quiz (le quiz qu'on visualise actuellement )


  }) : super(key: key);
  @override
  _AddEditQuestionPageState createState() => _AddEditQuestionPageState();
}
class _AddEditQuestionPageState extends State<AjouterQuestionPage> {
  final _formKey = GlobalKey<FormState>();

  late String question;
  late String option1;
  late String option2;
  late String option3;
  late String option4;
  late String answer;
  late int idquiz;




  @override
  void initState() {//les informations initial à apporter pour une question
    super.initState();

    question = widget.question?.question ?? '';
    option1 = widget.question?.option1 ?? '';
    option2 = widget.question?.option2 ?? '';
    option3 = widget.question?.option3 ?? '';
    option4 = widget.question?.option4 ?? '';
    answer = widget.question?.answer ?? '';
    idquiz = widget.question?.idquiz ?? widget.quizId;//on prend l'id de quiz actuel



  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: QuestionFormWidget(//appele au class QuestionFormWidget pour modifier le continue de chaque case en les donnant les nouvelles informations d'une question
        question: question,
        option1: option1,
        option2: option2,
        option3: option3,
        option4: option4,
        answer: answer,

        onChangedQuestion: (question) => setState(() => this.question = question),//les mothodes tel que onChangedQuestion sont utilisés pour prendre les nouveuls valeurs et c'est par setstate
        onChangedOption1: (option1) => setState(() => this.option1 = option1),
        onChangedOption2: (option2) => setState(() => this.option2 = option2),
        onChangedOption3: (option3) => setState(() => this.option3 = option3),
        onChangedOption4: (option4) => setState(() => this.option4 = option4),
        onChangedAnswer: (answer) => setState(() => this.answer = answer),
      ),
    ),
  );

  /**
   * save button pour ajouter la question sur la base de données par la fonctoion addOrUpdateQuestion
   * le button est en grie jusqu'à l'utilisateur tap au moins un letter sur la case
   */
  Widget buildButton() {
    final isFormValid = question.isNotEmpty ;//case pas vide
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateQuestion,
        child: Text('Save'),
      ),
    );
  }

  /**
   * on verifie le cas acutelle d'une question
   * s'elle est déjà crée en BDD (!= null) ,on appele updateQuestion
   * sinon cette une nouvelle question et on appele addQuestion
   */

  void addOrUpdateQuestion() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final isUpdating = widget.question != null;// acutelle question exist déjà
      if (isUpdating) {
        await updateQuestion();
      } else {
        await addQuestion();
      }
      Navigator.of(context).pop();
    }
  }

  /**
   * on prend les nouveuls valeurs de cette question
   * ici on n'ajoute pas l'id de quiz car il est pas modifiable et déjà créé en fonction addQuestion
   * puis on fait appel à la fonction update avec la question en paramétres
   * la fonction update est en BDD de questions
   */

  Future updateQuestion() async {
    final question1 = widget.question!.copy(
        question: question,
        option1: option1,
        option2: option2,
        option3: option3,
        option4: option4,
        answer: answer,



    );

    await QuestionDatabase.instance.update(question1);
  }

  /**
   * on ajoute la nouvelle question
   * ici on ajoute aussi l'id de quiz à quelle cette question appartien et on fait appel à la fonction creat en BDD de quastions
   */

  Future addQuestion() async {
    final question1 = Question(
        question: question,
        option1: option1,
        option2: option2,
        option3: option3,
        option4: option4,
        answer: answer,
        idquiz: widget.quizId

    );

    await QuestionDatabase.instance.create(question1);
  }
}