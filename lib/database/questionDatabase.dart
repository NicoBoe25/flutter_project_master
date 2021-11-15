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

  Future _close() async {
    final db = await instance.database;

    db.close();
  }
}