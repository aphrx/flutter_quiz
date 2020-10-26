import 'dart:async';
import 'package:flutter_quiz/database/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

abstract class DB{
  static Database _db;
  static int get _version => 1;

  static Future<void> init() async {
    try {
      String _path = await getDatabasesPath();
      String _dbpath = p.join(_path, 'quiz3.db');
      _db = await openDatabase(_dbpath, version: _version, onCreate: _onCreate);
    }
    catch(ex){
      print(ex);
    }
  }

  static FutureOr<void> _onCreate(Database db, int version) async{
    print("created");
    await db.execute('CREATE TABLE quizzes (id INTEGER PRIMARY KEY NOT NULL, name STRING, duration INTEGER, questionNo INTEGER)');
    await db.execute('CREATE TABLE questions (id INTEGER PRIMARY KEY NOT NULL, questionId INTEGER, question STRING, correctAnswer STRING, wrongAnswerA STRING, wrongAnswerB STRING, wrongAnswerC STRING)'); 
  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
    await _db.query(table);

  static Future<List<Map<String, dynamic>>> queryQuestions(String table, Model item) async =>
    await _db.query(table, where: 'questionId = ?', whereArgs: [item.id]);

  static Future<int> insert(String table, Model item) async =>
    await _db.insert(table, item.toMap());

  static Future<int> delete(String table, Model item) async =>
    await _db.delete(table, where: 'id = ?', whereArgs: [item.id]);

  static Future<int> update(String table, Model model) async => await _db
    .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);
}