
import 'package:flutter_project_master/classObject/question.dart';

final String tableQuizs = 'quizes';

class QuizFields {
  static final List<String> values = [
    /// Add all fields
    id, name ,
  ];

  static final String id = '_id';
  static final String name = 'name';


}

//List<QuestionFields> listeQestions = <QuestionFields>[] ;

class Quiz {
  final int? id;
  final String name;
  //final List<QuestionFields> listeQestions;
  const Quiz({
    this.id,
    required this.name, //required this.listeQestions,
  });


  Quiz copy({
    int? id,
    String? name,

  }) =>
      Quiz(
        id: id ?? this.id,
        name: name ?? this.name,
        //listeQestions : listeQestions ?? this.listeQestions,

      );

  static Quiz fromJson(Map<String, Object?> json) => Quiz(
    id: json[QuizFields.id] as int?,
    name: json[QuizFields.name]as String, //listeQestions: [],


  );

  Map<String, Object?> toJson() => {
    QuizFields.id: id,
    QuizFields.name: name,

  };
}
