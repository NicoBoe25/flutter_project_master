class Question{
  bool _reponse;
  String _question;

  Question(this._reponse, this._question);

  String get question => _question;
  bool get reponse => _reponse;

  set question(String value) {    _question = value;  }
  set reponse(bool value) {    _reponse = value;  }

}