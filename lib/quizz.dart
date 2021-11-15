
import 'package:flutter_project_master/question.dart';
import 'dart:core';
class Quizz {
  //String _name;


  Quizz(){
      this._addAll();
  }
  List<String> _list_quizes = List<String>.filled(0,"",growable: true) ;


  List<String> get list_quizes => _list_quizes;

  /*set name(String value) {
    _name = value;
  }

  String get name => _name;*/
  String remove(int index) {
    return _list_quizes.removeAt(index) ;
  }


  void add (String quizName) {
    _list_quizes.add(quizName) ;
  }

  void _addAll(){
    _list_quizes.add("animale quiz");
    _list_quizes.add("general quiz");
    _list_quizes.add("franch quiz");

  }



}