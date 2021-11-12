import 'dart:collection';

import 'package:flutter_project_master/question.dart';

class Quiz {
   int _id  ;

   List<Question> _list_questions = <Question>[] ;


  Quiz( this._id , this._list_questions );

   set id(int value) {
     _id = value;
   }

   int get id => _id;

   List<Question> get list_questions => _list_questions;

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




}