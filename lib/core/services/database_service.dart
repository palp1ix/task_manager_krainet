import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._privateConstructor();

  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;

  // Getter to access the database instance
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  // Initializes the database with basic configuration
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "app_database.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle database schema upgrades here
      },
    );
  }

  // Creates initial set of tables when database is first created
  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        category TEXT,
        date DATETIME,
        isCompleted BOOLEAN
      )
    ''');
  }

  // Allows dynamic creation of new tables after initial setup
  Future<void> createNewTable(String tableName, String schema) async {
    final db = await database;
    await db.execute('CREATE TABLE $tableName ($schema)');
  }
}
