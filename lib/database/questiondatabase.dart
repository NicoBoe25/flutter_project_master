import 'package:flutter_project_master/classObject/question.dart';
import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class QuestionDatabase{
  QuestionDatabase._privateConstructor();
  static final QuestionDatabase instance = QuestionDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase('questions.db');

  Future<Database> _initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';



    await db.execute('''
    CREATE TABLE $tableQuestions (
  
    ${QuestionFields.id} $idType,
    ${QuestionFields.question} $textType,
    ${QuestionFields.option1} $textType,
    ${QuestionFields.option2} $textType,
    ${QuestionFields.option3} $textType,
    ${QuestionFields.option4} $textType,
    ${QuestionFields.answer} $textType,
    ${QuestionFields.idquiz}  ,
    FOREIGN KEY (${QuestionFields.idquiz}) REFERENCES $tableQuizs (${QuizFields.id}) ON DELETE CASCADE

    
    )
    ''');
  }

  Future<Question> create(Question question) async {
    final db = await instance.database;

    final id = await db.insert(tableQuestions, question.toJson());

    return question.copy(id: id);
  }

  Future<Question> readQuestion(int idQuestion) async {
    final db = await instance.database;

    final maps = await db.query(
      tableQuestions,
      columns: QuestionFields.values,
      where: '${QuestionFields.id} = ?',
      whereArgs: [idQuestion],
    );
    if(maps.isNotEmpty){
      return Question.fromJson(maps.first);
    }
    else{
      throw Exception('ID $idQuestion not found');
    }
  }

  Future<List<Question>> readAllQuestion() async {
    final db = await instance.database;

    final orderBy = '${QuestionFields.id} ASC';
    final result = await db.query(tableQuestions, orderBy: orderBy);

    return result.map((json) => Question.fromJson(json)).toList();
  }

  Future<List<Question>> readAllQuestionFromQuizId(int idquiz) async {
    final db = await instance.database;

    final maps = await db.query(
      tableQuestions,
      columns: QuestionFields.values,
      where: '${QuestionFields.idquiz} = ?',
      whereArgs: [idquiz],
      // where: '${QuestionFields.idquiz} = $idquiz ',
      //whereArgs: [idquiz],

    );
    if(maps.isNotEmpty){
      return maps.map((json) => Question.fromJson(json)).toList();
    }
    else{
      throw Exception('ID $idquiz not found');
    }
  }

  Future<int> update(Question question) async {
    final db = await instance.database;

    return db.update(
        tableQuestions,
        question.toJson(),
        where: '${QuestionFields.id} = ?',
        whereArgs: [question.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
        tableQuestions,
        where: '${QuestionFields.id} = ?',
        whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}