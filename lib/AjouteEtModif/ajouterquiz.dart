import 'package:flutter/material.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/AjouteEtModif/quizwid.dart';

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
  void initState() {//la seul information à initializer ou à  modofier pour un quiz
    super.initState();


    name = widget.quiz?.name ?? '';
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: QuizFormWidget(//appele au class QuizFormWidget pour modifier le nom d'un quiz , on prend ses clé en  paramétre (le nom et le modif du nom)
        name: name,
        onChangedName: (name) => setState(() => this.name = name),//les mothode onChangedName est utilisé pour prendre le nouveau nom par setstate
      ),
    ),
  );

  Widget buildButton() {//save button pour ajouter le quiz sur la base de données par la fonctoion addOrUpdateQuiz ,le button est en grie jusqu'à l'utilisateur tap au moins un letter sur la case
    final isFormValid = name.isNotEmpty ;//case pas vide

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,//case vide n button save est en grie
        ),
        onPressed: addOrUpdateQuiz,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateQuiz() async {//on verifie le cas acutelle d'un quiz , s'il est déjà crée en BDD (!= null)on appele updateQuiz sinon cet un nouveau quiz et on appele addQuiz
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.quiz != null;// acutel quiz exist déjà

      if (isUpdating) {
        await updateQuiz();
      } else {
        await addQuiz();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateQuiz() async {//on prend le noueau nom de ce quiz , puis on fait appel à la fonction update avec le quiz en paramétres, la fonction update est en BDD de quizes
    final quiz = widget.quiz!.copy(

      name: name
    );

    await QuizDatabase.instance.update(quiz);
  }

  Future addQuiz() async {//on ajoute le noueau quiz , et on fait appel à la fonction creat en BDD de quizes
    final quiz = Quiz(
      name: name

    );

    await QuizDatabase.instance.create(quiz);
  }
}