import 'dart:core';

import 'package:budget_tracker_app/model/category_model.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();
  Database? db;
  String categoryTable = 'category';
  String categoryId = 'category_id';
  String categoryName = 'c_name';
  String categoryImage = 'c_image';

  //CREATE TABLE
  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();

    String path = "${dbPath}budget.db";
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        String query = '''CREATE TABLE $categoryTable(
         $categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
         $categoryName TEXT NOT NULL,
         $categoryImage INT NOT NULL
      );
      ''';

        await db.execute(query).then(
          (value) {
            Logger().i('Category table created...!!');
          },
        ).onError(
          (error, _) {
            Logger().e('Category table not created...', error: error);
          },
        );
      },
    );
  }

  //Insert Record
  Future<int?> insertCategory({
    required String name,
    required int image,
  }) async {
    await initDB();
    String insertQuery =
        "INSERT INTO $categoryTable ($categoryName,$categoryImage) VALUES(?,?);";
    List arg = [name, image];
    return await db?.rawInsert(insertQuery, arg);
  }

  //FETCH RECORDS
  Future<List<CategoryModel>> fetchCategory() async {
    await initDB();
    String fetchQuery = "SELECT * FROM $categoryTable;";

    List<Map<String, dynamic>>? res = await db?.rawQuery(fetchQuery);
    return res!.map((e) => CategoryModel.fromMap(m1: e)).toList();
  }

  //LIVE SEARCH
  Future<List<CategoryModel>> liveSearchCategory(
      {required String search}) async {
    await initDB();
    String searchQuery =
        "SELECT * FROM $categoryTable WHERE $categoryName LIKE '%$search%';";
    List<Map<String, dynamic>> res = await db?.rawQuery(searchQuery) ?? [];
    return res.map((e) => CategoryModel.fromMap(m1: e)).toList();
  }

  Future<int?> updateCategory({required CategoryModel model}) async {
    await initDB();
    String updateQuery =
        "UPDATE $categoryTable SET $categoryName = ?,$categoryImage=? WHERE $categoryId = ${model.id}";
    List arg = [model.name, model.image];
    return await db?.rawUpdate(updateQuery, arg);
  }

  Future<int?> deleteCategory({required int id}) async {
    await initDB();
    String updateQuery = "DELETE FROM $categoryTable WHERE $categoryId = $id";
    return await db?.rawUpdate(updateQuery);
  }
}
