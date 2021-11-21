import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_project_master/classObject/quiz.dart';


class QuizDatabase {

  QuizDatabase._privateConstructor();
  static final QuizDatabase instance = QuizDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase('quizes.db');

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
    final textType = 'TEXT NOT NULL';


    await db.execute('''
    CREATE TABLE $tableQuizs ( 
    ${QuizFields.id} $idType, 
    ${QuizFields.name} $textType
   )
    ''');
  }

  Future<Quiz> create(Quiz quiz) async {
    final db = await instance.database;

    final id = await db.insert(tableQuizs, quiz.toJson());
    return quiz.copy(id: id);
  }

  Future<Quiz> readQuiz(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableQuizs,
      columns: QuizFields.values,
      where: '${QuizFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Quiz.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Quiz>> readAllQuizes() async {
    final db = await instance.database;

    final orderBy = '${QuizFields.id} ASC';

    final result = await db.query(tableQuizs, orderBy: orderBy);

    return result.map((json) => Quiz.fromJson(json)).toList();
  }

  Future<int> update(Quiz quiz) async {
    final db = await instance.database;

    return db.update(
      tableQuizs,
      quiz.toJson(),
      where: '${QuizFields.id} = ?',
      whereArgs: [quiz.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableQuizs,
      where: '${QuizFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}