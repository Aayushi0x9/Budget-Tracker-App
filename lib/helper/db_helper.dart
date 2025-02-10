import 'dart:core';

import 'package:budget_tracker_app/model/category_model.dart';
import 'package:budget_tracker_app/model/spend_model.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();
  Database? db;

  //Category Table Attributes
  String categoryTable = 'category';
  String categoryId = 'category_id';
  String categoryName = 'c_name';
  String categoryImage = 'c_image';

  // Spending Table Attributes
  String spendingTable = "spending";
  String spendId = "spend_id";
  String spendingDesc = "spend_desc";
  String spendAmount = "spend_amount";
  String spendMode = "spend_mode";
  String spendDate = "spend_date";
  String spendCategoryId = "spend_category_id";

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
        String query2 = '''CREATE TABLE $spendingTable (
          $spendId INTEGER PRIMARY KEY AUTOINCREMENT,
          $spendingDesc TEXT NOT NULL,
          $spendAmount NUMERIC NOT NULL,
          $spendMode TEXT NOT NULL,
          $spendDate TEXT NOT NULL,
          $spendCategoryId INTEGER NOT NULL
        );''';

        await db.execute(query2);
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

  //insert spendaDetails
  Future<int?> insertSpending({required SpendingModel model}) async {
    await initDB();

    String query =
        "INSERT INTO $spendingTable ($spendingDesc,$spendAmount,$spendMode,$spendDate,$spendCategoryId) VALUES(?, ?, ?, ?, ?);";

    List args = [
      model.desc,
      model.amount,
      model.mode,
      model.date,
      model.categoryId,
    ];

    return await db?.rawInsert(query, args);
  }

  //FETCH RECORDS
  Future<List<CategoryModel>> fetchCategory() async {
    await initDB();
    String fetchQuery = "SELECT * FROM $categoryTable;";

    List<Map<String, dynamic>>? res = await db?.rawQuery(fetchQuery);
    return res!.map((e) => CategoryModel.fromMap(m1: e)).toList();
  }

  //Fetch Spending
  Future<List<SpendingModel>> fetchSpending() async {
    await initDB();

    String query = "SELECT *  FROM $spendingTable;";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return res
        .map(
          (e) => SpendingModel.formMap(data: e),
        )
        .toList();
  }

  Future<CategoryModel> fetchSingleCategory({required int id}) async {
    await initDB();

    String query = "SELECT * FROM $categoryTable WHERE category_id = $id;";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return CategoryModel(
        id: res[0]['category_id'],
        name: res[0][categoryName],
        image: res[0][categoryImage]);
    // index: res[0][categoryImageIndex]);
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

  Future<int?> updateSpending({
    required SpendingModel model,
  }) async {
    if (db == null) await initDB();
    String query2 =
        "UPDATE $spendingTable SET $spendAmount = ?, $spendDate = ?, $spendingDesc = ?, $spendMode = ? WHERE $spendId = ${model.id}";
    List values = [
      model.amount,
      model.date,
      model.desc,
      model.mode,
    ];
    return await db?.rawUpdate(query2, values);
  }

  Future<int?> deleteCategory({required int id}) async {
    await initDB();
    String updateQuery = "DELETE FROM $categoryTable WHERE $categoryId = $id";
    return await db?.rawUpdate(updateQuery);
  }

  Future<int?> deleteSpending({required int id}) async {
    if (db == null) await initDB();
    String query = "DELETE FROM $spendingTable WHERE $spendId = $id";
    return await db?.rawDelete(query);
  }
}
