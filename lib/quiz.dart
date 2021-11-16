import 'dart:core';

final String tableQuiz = 'quizs';

class QuizFields{
  static final List<String> values = [
    id,name
  ];
  static final String id = '_id';
  static final String name = '_name';
}

class Quiz {

  int _id = 0;
  String _name = "";

  Quiz(this._id, this._name){
      this._addAll();
  }
  List<String> _list_quizes = List<String>.filled(0,"",growable: true) ;


  List<String> get list_quizes => _list_quizes;

  int get id => _id;

  set id(int value) {
    _id = value;
  }
  String get name => _name;

  set name(String value) {
    _name = value;
  }


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

  Quiz copy({
  int? id,
  String? name,
}) =>
      Quiz(
        id ?? this.id,
        name ?? this.name
      );

  Map<String, Object?> toJson() => {
    QuizFields.id: id,
    QuizFields.name: name
  };

  static Quiz fromJson(Map<String, Object?> json) => Quiz(
    json[QuizFields.id] as int,
    json[QuizFields.name] as String
  );



}