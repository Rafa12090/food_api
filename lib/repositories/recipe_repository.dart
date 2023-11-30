

import 'package:spoonacular_app/databases/recipe_database.dart';
import 'package:spoonacular_app/models/recipe.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class RecipeRepository {
  Future insert(Recipe recipe) async {
    Database db = await RecipeDatabase().openDb();
    db.insert(RecipeDatabase().tableName, recipe.toMap());
  }

  Future delete(int id) async {
    Database db = await RecipeDatabase().openDb();
    db.delete(RecipeDatabase().tableName, where: 'id =?', whereArgs: [id]);
  }

  Future<bool> isFavorite(Recipe recipe) async {
    Database db = await RecipeDatabase().openDb();
    final maps = await db.query(RecipeDatabase().tableName, where: 'id =?', whereArgs: [recipe.id]);
    return maps.isNotEmpty;
  }

  Future update(Recipe recipe) async {
    Database db = await RecipeDatabase().openDb();
    db.update(RecipeDatabase().tableName, recipe.toMap(), where: 'id =?', whereArgs: [recipe.id]);
  }

  Future<List<Recipe>> getAll() async {
    Database db = await RecipeDatabase().openDb();
    final maps = await db.query(RecipeDatabase().tableName);
    return maps.map((map) => Recipe.fromMap(map)).toList();
  }

  Future<int?> getCount() async {
    Database db = await RecipeDatabase().openDb();
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${RecipeDatabase().tableName}'));
  }

}
