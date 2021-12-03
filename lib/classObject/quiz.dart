const String tableQuizs = 'quizes';

class QuizFields {
  static final List<String> values = [
    id, name
  ];

  static const String id = '_id';
  static const String name = 'name';


}


class Quiz {
  int? id;
  final String name;
  Quiz({
    this.id,
    required this.name
  });


  Quiz copy({
    int? id,
    String? name

  }) =>
      Quiz(
        id: id ?? this.id,
        name: name ?? this.name

      );

  static Quiz fromJson(Map<String, Object?> json) => Quiz(
    id: json[QuizFields.id] as int?,
    name: json[QuizFields.name]as String

  );

  Map<String, Object?> toJson() => {
    QuizFields.id: id,
    QuizFields.name: name

  };
}