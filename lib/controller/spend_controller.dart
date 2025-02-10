import 'package:budget_tracker_app/helper/db_helper.dart';
import 'package:budget_tracker_app/model/spend_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpendingController extends GetxController {
  String? mode;
  DateTime? dateTime;
  int? spendingIndex;
  int categoryId = 0;

  void getSpendingMode(String? value) {
    mode = value;
    update();
  }

  void getSpendingDate({required DateTime date}) {
    dateTime = date;
    update();
  }

  void getSpendingIndex({required int index, required int id}) {
    spendingIndex = index;
    categoryId = id;
    update();
  }

  void getDefaultValue() {
    mode = dateTime = spendingIndex = null;
    update();
  }

  Future<void> addSpendingData({required SpendingModel model}) async {
    int? res = await DBHelper.dbHelper.insertSpending(model: model);
    if (res != null) {
      Get.snackbar(
        "Inserted",
        "spending inserted....",
        backgroundColor: Colors.green.shade300,
      );
    } else {
      Get.snackbar(
        "Failed",
        "spending failed....",
        backgroundColor: Colors.red.shade300,
      );
    }
  }

  void updateSpending({required SpendingModel model}) async {
    int? res = await DBHelper.dbHelper.updateSpending(model: model);
    if (res != null) {
      DBHelper.dbHelper.fetchSpending();
      Get.snackbar('Updating Spending', 'Spending updated Completed',
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', 'failed',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    update();
  }

  Future<void> deleteSpending({required int id}) async {
    int? res = await DBHelper.dbHelper.deleteSpending(id: id);
    if (res != null) {
      DBHelper.dbHelper.fetchSpending();
      Get.snackbar('Deleting Spending', 'Spending delete Completed',
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', 'Failed Spending',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    update();
  }
}
