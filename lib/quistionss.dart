final String tableQuestions = 'questions';

class QuestionFields{
  static final String id = '_id';
  static final String name = '_name';
  static final String reponse = '_reponse';
  static final String question = '_question';
  static final String option1 = '_option1';
  static final String option2 = '_option2';
  static final String option3 = '_option3';
  static final String option4 = '_option4';
}

class Question{
  int _id;
  int _nameQuiz ;
  String _reponse;
  String _question;

  String _option1;
  String _option2;
  String? _option3;
  String? _option4;

  Question(this._id, this._nameQuiz, this._reponse, this._question , this._option1 , this._option2 );

  //Question.createQuestion2Options(this._reponse, this._question, this._option1, this._option2 , this._idQuiz);
  //Question.createQuestion4Options(this._reponse, this._question, this._option1, this._option2,this._option3, this._option4 , this._idQuiz);


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get nameQuiz => _nameQuiz;

  set nameQuiz(int value) {
    _nameQuiz = value;
  }

  String get reponse => _reponse;
  set reponse(String value) {
    _reponse = value;
  }

  String get question => _question;
  set question(String value) {
    _question = value;
  }

  String get option4 => _option4 ?? "";
  set option4(String value) {
    _option4 = value;
  }

  String get option3 => _option3 ?? "";
  set option3(String value) {
    _option3 = value;
  }

  String get option2 => _option2 ?? "";
  set option2(String value) {
    _option2 = value;
  }

  String get option1 => _option1 ?? "";
  set option1(String value) {
    _option1 = value;
  }


}