import 'package:flutter_project_master/classObject/quiz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuizDatabase{
  static final QuizDatabase instance = QuizDatabase._init();

  static Database? _database;

  QuizDatabase._init();

  Future<Database> get database async{
    if( _database != null) return _database!;

    _database = await _initDB('quiz.db');
    return _database!;
  }

// TODO: tu n'as psa besoin de regarder ça ;-)
  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();

    final path = join(dbpath,filepath);

    return await openDatabase(path,version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';

    await db.execute('''
    CREATE TABLE $tableQuiz (
    ${QuizFields.id} $idType,
    ${QuizFields.name} $textType,
    )
    ''');
  }

  Future<Quiz> create(Quiz quiz) async {
    final db = await instance.database;

    final id = await db.insert(tableQuiz, quiz.toJson());

    return quiz.copy(id: id);
  }

  Future<Quiz?> readQuiz(int idQuiz) async {
    final db = await instance.database;

    final maps = await db.query(
      tableQuiz,
      columns: QuizFields.values,
      where: '${QuizFields.id} = ?',
      whereArgs: [idQuiz],
    );
    if(maps.isNotEmpty){
      return Quiz.fromJson(maps.first);
    }
    else{
      throw Exception('ID $idQuiz not found');
    }
  }

  Future<List<Quiz>> readAllQuiz() async {
    final db = await instance.database;

    final orderBy = '${QuizFields.id} ASC';
    final result = await db.query(tableQuiz, orderBy: orderBy);

    return result.map((json) => Quiz.fromJson(json)).toList();
  }

  Future<int> update(Quiz quiz) async {
    final db = await instance.database;

    return db.update(
        tableQuiz,
        quiz.toJson(),
        where: '${QuizFields.id} = ?',
        whereArgs: [quiz.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
        tableQuiz,
        where: '${QuizFields.id} = ?',
        whereArgs: [id]
    );
  }


  Future _close() async {
    final db = await instance.database;

    db.close();
  }
}