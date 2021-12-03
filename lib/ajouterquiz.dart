import 'package:flutter/material.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/quizwid.dart';

class AddQuizPage extends StatefulWidget {
  final Quiz? quiz;
  final int? quizId;


  const AddQuizPage({
    Key? key,
    this.quiz,
    this.quizId,
  }) : super(key: key);
  @override
  _AddEditQuizPageState createState() => _AddEditQuizPageState();
}

class _AddEditQuizPageState extends State<AddQuizPage> {
  final _formKey = GlobalKey<FormState>();

  late String name;




  @override
  void initState() {
    super.initState();


    name = widget.quiz?.name ?? '';
  }

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: QuizFormWidget(
        name: name,
        onChangedName: (name) => setState(() => this.name = name),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = name.isNotEmpty ;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateQuiz,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateQuiz() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.quiz != null;

      if (isUpdating) {
        await updateQuiz();
      } else {
        await addQuiz();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateQuiz() async {
    final quiz = widget.quiz!.copy(

      name: name
    );

    await QuizDatabase.instance.update(quiz);
  }

  Future addQuiz() async {
    final quiz = Quiz(
      name: name

    );

    await QuizDatabase.instance.create(quiz);
  }
}