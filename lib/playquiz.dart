import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:flutter_project_master/database/quizdatabase.dart';



class Playquiz extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<Playquiz> {
  late List<Quiz> quizes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshQuizes();
  }

  @override
  void dispose() {
    QuizDatabase.instance.close();

    super.dispose();
  }

  Future refreshQuizes() async {
    setState(() => isLoading = true);

    this.quizes = await QuizDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(title: const Text('Quizes'),
       ),
       body: Center(
         child: FutureBuilder<List<Quiz>>(
             future: QuizDatabase.instance.readAllNotes(),
             builder: (BuildContext context,
                 AsyncSnapshot<List<Quiz>> snapshot) {
               if (!snapshot.hasData) {
                 return Center(child: Text('Loading...'));
               }
               return snapshot.data!.isEmpty ? Center(child: Text('No quizes in List.'))
                   : ListView(
                 children: snapshot.data!.map((quiz) {
                   return Center(
                     child: ListTile(
                       title: Text(quiz.name),
                     ),
                   );
                 }).toList(),
               );
             }),
       ),

     ),
   );
 }
}



















