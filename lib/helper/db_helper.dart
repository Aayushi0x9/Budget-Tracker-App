import 'dart:core';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();
  Database? db;
  String categoryTable = 'category';
  String categoryName = 'c_name';
  String categoryImage = 'c_image';

  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = "${dbPath}budget.db";
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        String query = '''
      CREATE TABLE $categoryTable(category_id INTEGER PRYMARY KEY AUTOINCREMENT,
      $categoryName Text NOT NULL,
      $categoryImage BLOB NOT NULL
     
      )
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
    required Uint8List image,
  }) async {
    await initDB();
    String insertQuery =
        "INSERT INTO $categoryTable ($categoryName,$categoryImage) VALUES(?,?);";
    List arg = [name, image];
    return await db?.rawInsert(insertQuery, arg);
  }
}
