const String tableQuestions = 'questions';

class QuestionFields{
  static final List<String> values = [
    /// Add all fields
    id, question, option1 , option2, option3,option4,answer , idquiz
  ];

  static const String id = '_id';
  static const String question = 'question';
  static const String option1 = 'option1';
  static const String option2 = 'option2';
  static const String option3 = 'option3';
  static const String option4 = 'option4';
  static const String answer = 'answer';
  static const String idquiz = '_idquiz';




}

class Question {
  final int? id;
  final String question;
  final String option1;
  final String option2;
  final String? option3;
  final String? option4;
  final String answer;
  final int? idquiz;





  const Question({
    this.id,
    required this.question,
    required this.option1,
    required this.option2,
    this.option3,
    this.option4,
    required this.answer,
    this.idquiz,



  });

  Question copy({
    int? id,
    String? question,
    String? option1,
    String? option2,
    String? option3,
    String? option4,
    String? answer,
    int? idquiz,




  }) =>
      Question(
        id: id ?? this.id,
        question: question ?? this.question,
        option1: option1 ?? this.option1,
        option2: option1 ?? this.option2,
        option3: option1 ?? this.option3,
        option4: option1 ?? this.option4,
        answer: option1 ?? this.answer,
        idquiz: idquiz ?? this.idquiz,


      );

  static Question fromJson(Map<String, Object?> json) => Question(
    id: json[QuestionFields.id] as int?,
    question: json[QuestionFields.question]as String,
    option1: json[QuestionFields.option1]as String,
    option2: json[QuestionFields.option2]as String,
    option3: json[QuestionFields.option3]as String,
    option4: json[QuestionFields.option4]as String,
    answer: json[QuestionFields.answer]as String,
    idquiz: json[QuestionFields.idquiz] as int?,



  );

  Map<String, Object?> toJson() => {
    QuestionFields.id: id,
    QuestionFields.question: question,
    QuestionFields.option1: option1,
    QuestionFields.option2: option2,
    QuestionFields.option3: option3,
    QuestionFields.option4: option4,
    QuestionFields.answer: answer,
    QuestionFields.idquiz: idquiz,




  };
}