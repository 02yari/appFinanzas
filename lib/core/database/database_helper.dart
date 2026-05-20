import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Instancia única de la base de datos.
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  // Obtiene o crea la base de datos.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('finanzas.db');
    return _database!;
  }

  // Inicializa la base de datos.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 6,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  // Crea las tablas.
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transacciones(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tipo TEXT NOT NULL,
        monto REAL NOT NULL,
        descripcion TEXT NOT NULL,
        categoria TEXT NOT NULL,
        fecha TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE gastos_fijos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        monto REAL NOT NULL,
        dia INTEGER NOT NULL,
        activo INTEGER NOT NULL DEFAULT 1,
        ultimo_mes_generado TEXT
      )
    ''');
  }

  // Actualiza la base si ya existía.
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE transacciones ADD COLUMN categoria TEXT DEFAULT "Otros gastos"',
      );
    }

    if (oldVersion < 4) {
      await db.execute(
        'ALTER TABLE transacciones ADD COLUMN fecha TEXT DEFAULT ""',
      );
    }

    if (oldVersion < 6) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS gastos_fijos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT NOT NULL,
          monto REAL NOT NULL,
          dia INTEGER NOT NULL,
          activo INTEGER NOT NULL DEFAULT 1,
          ultimo_mes_generado TEXT
        )
      ''');
    }
  }

  // Inserta una transacción.
  Future<int> insertarTransaccion(Map<String, dynamic> data) async {
    final db = await instance.database;

    return await db.insert(
      'transacciones',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obtiene todas las transacciones.
  Future<List<Map<String, dynamic>>> obtenerTransacciones() async {
    final db = await instance.database;

    return await db.query(
      'transacciones',
      orderBy: 'id DESC',
    );
  }

  // Elimina una transacción.
  Future<int> eliminarTransaccion(int id) async {
    final db = await instance.database;

    return await db.delete(
      'transacciones',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Inserta un gasto fijo mensual.
  Future<int> insertarGastoFijo(Map<String, dynamic> data) async {
    final db = await instance.database;

    return await db.insert(
      'gastos_fijos',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obtiene todos los gastos fijos.
  Future<List<Map<String, dynamic>>> obtenerGastosFijos() async {
    final db = await instance.database;

    return await db.query(
      'gastos_fijos',
      orderBy: 'dia ASC',
    );
  }

  // Actualiza un gasto fijo.
  Future<int> actualizarGastoFijo(int id, Map<String, dynamic> data) async {
    final db = await instance.database;

    return await db.update(
      'gastos_fijos',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Elimina un gasto fijo.
  Future<int> eliminarGastoFijo(int id) async {
    final db = await instance.database;

    return await db.delete(
      'gastos_fijos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Borra todos los movimientos. Útil para pruebas.
  Future<int> borrarTransacciones() async {
    final db = await instance.database;
    return await db.delete('transacciones');
  }
}