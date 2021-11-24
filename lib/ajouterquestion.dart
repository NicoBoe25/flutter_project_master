import 'package:flutter/material.dart';
import 'package:flutter_project_master/database/questiondatabase.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/classObject/question.dart';
import 'package:flutter_project_master/questionswid.dart';

class AjouterQuestionPage extends StatefulWidget {
  final Question? question;
  final int quizId;
  //final Quiz? quiz;



  const AjouterQuestionPage({
    Key? key,
    this.question,
   // this.quiz,
    required this.quizId,


  }) : super(key: key);
  @override
  _AddEditQuestionPageState createState() => _AddEditQuestionPageState();
}

class _AddEditQuestionPageState extends State<AjouterQuestionPage> {
  final _formKey = GlobalKey<FormState>();

  //late int id;
  late String question;
  late String option1;
  late String option2;
  late String option3;
  late String option4;
  late String answer;
 late int idquiz;




  @override
  void initState() {
    super.initState();
    //  id = widget.quiz?.id ?? 0;
    question = widget.question?.question ?? '';
    option1 = widget.question?.option1 ?? '';
    option2 = widget.question?.option2 ?? '';
    option3 = widget.question?.option3 ?? '';
    option4 = widget.question?.option4 ?? '';
    answer = widget.question?.answer ?? '';
    idquiz = widget.question?.idquiz ?? widget.quizId;



  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: QuestionFormWidget(
        question: question,
        option1: option1,
        option2: option2,
        option3: option3,
        option4: option4,
        answer: answer,


        //onChangedId: (id) => setState(() => this.id = id),
        onChangedQuestion: (question) => setState(() => this.question = question),
        onChangedOption1: (option1) => setState(() => this.option1 = option1),
        onChangedOption2: (option2) => setState(() => this.option2 = option2),
        onChangedOption3: (option3) => setState(() => this.option3 = option3),
        onChangedOption4: (option4) => setState(() => this.option4 = option4),
        onChangedAnswer: (answer) => setState(() => this.answer = answer),


      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = question.isNotEmpty ;

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

  void addOrUpdateQuestion() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.question != null;

      if (isUpdating) {
        await updateQuestion();
      } else {
        await addQuestion();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateQuestion() async {
    final question1 = widget.question!.copy(

        question: question,
        option1: option1,
        option2: option2,
        option3: option3,
        option4: option4,
        answer: answer,
        //idquiz: widget.quizId



    );

    await QuestionDatabase.instance.update(question1);
  }

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