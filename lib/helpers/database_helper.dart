import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/estudiante.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('estudiantes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
      CREATE TABLE estudiantes (
        id $idType,
        nombres $textType,
        edad INTEGER NOT NULL,
        fecha $textType NOT NULL,
        pais $textType NOT NULL,
        ciudad $textType NOT NULL,
        valorCurso $realType NOT NULL,
        cuotaInicial $realType NOT NULL,
        cuotaMensual $realType NOT NULL
      )
    ''');
  }

  Future<int> insertEstudiante(Estudiante estudiante) async {
    final db = await instance.database;
    final id = await db.insert('estudiantes', estudiante.toMap());
    return id;
  }

  Future<List<Estudiante>> getEstudiantes() async {
    final db = await instance.database;
    final result = await db.query('estudiantes');
    return result.map((e) => Estudiante.fromMap(e)).toList();
  }
}
