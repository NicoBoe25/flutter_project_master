import 'package:flutter_project_master/quistionss.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuestionDatabase{
  static final QuestionDatabase instance = QuestionDatabase._init();

  static Database? _database;

  QuestionDatabase._init();

  Future<Database> get database async{
    if( _database != null) return _database!;

    _database = await _initDB('quiz.db');
    return _database!;
  }


  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();

    final path = join(dbpath,filepath);

    return await openDatabase(path,version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final intType = 'INTEGER';

    await db.execute('''
    CREATE TABLE $tableQuestions (
    ${QuestionFields.id} $idType,
    ${QuestionFields.name} $intType,
    
    ${QuestionFields.reponse} $textType,
    ${QuestionFields.question} $textType,
    
    ${QuestionFields.option1} $textType,
    ${QuestionFields.option2} $textType,
    ${QuestionFields.option3} $textType,
    ${QuestionFields.option4} $textType
    )
    ''');
  }

  Future<Question> create(Question question) async {
    final db = await instance.database;

    final id = await db.insert(tableQuestions, question.toJson());

    return question.copy(id: id);
  }

  Future<Question?> readQuestion(int idQuestion) async {
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
      where: '${QuestionFields.name} = ?',
      whereArgs: [idquiz],
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


    Future _close() async {
    final db = await instance.database;

    db.close();
  }
}