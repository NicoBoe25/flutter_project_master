import 'package:flutter_project_master/question.dart';

class Quiz {
   int _id = 1 ;
   String _name;

  List<Question> _list_questions = <Question>[] ;

   Quiz(this._id,this._name){
     this.addAll();
   }

  Quiz.createQuiz( this._id , this._list_questions, this._name );


   int get id => _id;
   List<Question> get list_questions => _list_questions;
   String get name => _name;

   set name(String value) {
     _name = value;
   }

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
     _list_questions.add(new Question.createQuestion4Options("Everest", "Le mont le plus haut du monde", "Lhotse", "Everest", "Morond", "K2"));
     _list_questions.add(new Question.createQuestion4Options("Danube", "Le fleuve le plus long d'Europe", "Volga", "Rhone", "Danube", "Po"));
     _list_questions.add(new Question.createQuestion4Options("Pacifique", "L océan le plus grand du monde", "Indien", "Arctique", "Pacifique", "Atlantique"));
     _list_questions.add(new Question.createQuestion4Options("Franche-Comte", "La plus belle région de France", "Bretagne", "Franche-Comte", "Limousin", "Centre"));
   }


}