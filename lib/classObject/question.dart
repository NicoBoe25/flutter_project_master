final String tableQuestions = 'questions';

class QuestionFields{
  static final List<String> values = [
    /// Add all fields
    //id,
    question, option1 , option2, option3,option4,answer
  ];

  //static final String id = '_id';
  static final String question = 'question';
  static final String option1 = 'option1';
  static final String option2 = 'option2';
  static final String option3 = 'option3';
  static final String option4 = 'option4';
  static final String answer = 'answer';



}

class Question {
  //final int? id;
  final String question;
  final String option1;
  final String option2;
  final String? option3;
  final String? option4;
  final String answer;



  const Question({
    // this.id,
    required this.question,
    required this.option1,
    required this.option2,
    this.option3,
    this.option4,
    required this.answer,


  });

  Question copy({
    //int? id,
    String? question,
    String? option1,
    String? option2,
    String? option3,
    String? option4,
    String? answer,



  }) =>
      Question(
        //id: id ?? this.id,
        question: question ?? this.question,
        option1: option1 ?? this.option1,
        option2: option1 ?? this.option2,
        option3: option1 ?? this.option3,
        option4: option1 ?? this.option4,
        answer: option1 ?? this.answer,

      );

  static Question fromJson(Map<String, Object?> json) => Question(
    //id: json[QuestionFields.id] as int?,
      question: json[QuestionFields.question]as String,
      option1: json[QuestionFields.option1]as String,
      option2: json[QuestionFields.option2]as String,
      option3: json[QuestionFields.option3]as String,
      option4: json[QuestionFields.option4]as String,
      answer: json[QuestionFields.answer]as String


  );

  Map<String, Object?> toJson() => {
    // QuestionFields.id: id,
    QuestionFields.question: question,
    QuestionFields.option1: option1,
    QuestionFields.option2: option2,
    QuestionFields.option3: option3,
    QuestionFields.option4: option4,
    QuestionFields.answer: answer,



  };/* static final List<String> values = [
    id, name, reponse,question,option1,option2,option3,option4
  ];

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

  Question.createQuestion3Options(this._id, this._nameQuiz,this._reponse, this._question, this._option1, this._option2, this._option3);
  Question.createQuestion4Options(this._id, this._nameQuiz,this._reponse, this._question, this._option1, this._option2,this._option3, this._option4 );

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

  Question copy({
    int? id,
    int? nameQuiz,
    String? reponse,
    String? question,

    String? option1,
    String? option2,
    String? option3,
    String? option4,
  }) =>
      Question.createQuestion4Options(
          id ?? this.id,
          nameQuiz ?? this.nameQuiz,
          reponse ?? this.reponse,
          question ?? this.question,
          option1 ?? this.option1,
          option2 ?? this.option2,
          option3 ?? this.option3,
          option4 ?? this.option4
      );
  Map<String, Object?> toJson() => {
    QuestionFields.id: id,
    QuestionFields.name: nameQuiz,
    QuestionFields.reponse: reponse,
    QuestionFields.question: question,
    QuestionFields.option1: option1,
    QuestionFields.option2: option2,
    QuestionFields.option3: option3,
    QuestionFields.option4: option4
  };


  static Question fromJson(Map<String, Object?> json) => Question.createQuestion4Options(
   json[QuestionFields.id] as int,
    json[QuestionFields.name] as int,
    json[QuestionFields.reponse] as String,
    json[QuestionFields.question] as String,
    json[QuestionFields.option1] as String,
    json[QuestionFields.option2] as String,
    json[QuestionFields.option3] as String,
    json[QuestionFields.option4] as String
  );

*/
}