import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_project_master/classObject/quiz.dart';

import 'dart:io';


/*class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes (
  ${NoteFields.id} $idType,
  ${NoteFields.isImportant} $boolType,
  ${NoteFields.number} $integerType,
  ${NoteFields.title} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType
  )
''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
*/

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

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableQuizs, quiz.toJson());
    return quiz.copy(id: id);
  }

  Future<Quiz> readNote(int id) async {
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
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

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
