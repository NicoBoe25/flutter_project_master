import 'package:flutter/material.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/notewid.dart';

//import 'package:sqflite_database_example/widget/note_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
class AddEditNotePage extends StatefulWidget {
  final Quiz? quiz;

  const AddEditNotePage({
    Key? key,
    this.quiz,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();

  late int id;
  late String name;




  @override
  void initState() {
    super.initState();


    id = widget.quiz?.id ?? 0;
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
      child: NoteFormWidget(
        id: id,
        name: name,
        //onChangedId: (id) => setState(() => this.id = id),
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
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.quiz != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.quiz!.copy(

      id: id,
      name: name,
    );

    await QuizDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Quiz(
      name: name,
      id: id,

    );

    await QuizDatabase.instance.create(note);
  }
}