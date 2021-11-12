import 'package:flutter_project_master/question.dart';

class Quiz {
   int _id = 1 ;
   List<Question> _list_questions = <Question>[] ;

   Quiz(this._id){
     this.addAll();
   }

  Quiz.createQuiz( this._id , this._list_questions );

   int get id => _id;
   List<Question> get list_questions => _list_questions;

   set id(int value) {
     _id = value;
   }
   set list_questions(List<Question> value) {
     _list_questions = value;
   }


   Question remove(int index) {
     return _list_questions.removeAt(index) ;
   }

   void add (Question siteName) {
     _list_questions.add(siteName) ;
   }

   void insert (int position, Question question) {
     _list_questions.insert(position, question) ;
   }

   void addAll(){
     _list_questions.add(new Question.createQuestion4Options("Amazone", "Le fleuve le plus long du monde", "Nil", "Amazone", "Gange", "Danube"));
     _list_questions.add(new Question.createQuestion4Options("Amazone", "Le fleuve le plus gros débit du monde", "Gange", "Amazone", "Mississipi", "Congo"));
     _list_questions.add(new Question.createQuestion4Options("Everest", "Le mont le plus haut du monde", "Mont-Blanc", "Amazone", "Gange", "Danube"));
     _list_questions.add(new Question.createQuestion4Options("Amazone", "Le fleuve le plus long du monde", "Nil", "Amazone", "Gange", "Danube"));
     _list_questions.add(new Question.createQuestion4Options("Amazone", "Le fleuve le plus long du monde", "Nil", "Amazone", "Gange", "Danube"));
     _list_questions.add(new Question.createQuestion4Options("Amazone", "Le fleuve le plus long du monde", "Nil", "Amazone", "Gange", "Danube"));
   }

}