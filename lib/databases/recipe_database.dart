import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RecipeDatabase {
  final int version = 1;
  final String databaseName ='recipes.db';
  final String tableName ='recipes';

  Database? database;

  Future<Database> openDb() async {
    database ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (database, version) {
        database.execute(
          'CREATE TABLE $tableName(id int PRIMARY KEY, title TEXT, image TEXT, imageType TEXT)',
        );
      },
      version: version,
    );
    return database as Database;
  }

}