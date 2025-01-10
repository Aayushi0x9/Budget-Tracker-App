import 'dart:core';

import 'package:budget_tracker_app/helper/db_helper.dart';
import 'package:budget_tracker_app/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  int? getCategorySelectedIndex;
  Future<List<CategoryModel>>? allCategory;

  List<Map<String, dynamic>> categoryList = [
    {
      'category': 'Groceries',
      'icon': Icons.local_grocery_store_outlined,
    },
    {
      'category': 'Rent',
      'icon': Icons.home_outlined,
    },
    {
      'category': 'Utilities',
      'icon': Icons.lightbulb_outline,
    },
    {
      'category': 'Transportation',
      'icon': Icons.directions_car_outlined,
    },
    {
      'category': 'Healthcare',
      'icon': Icons.local_hospital_outlined,
    },
    {
      'category': 'Entertainment',
      'icon': Icons.movie_outlined,
    },
    {
      'category': 'Dining Out',
      'icon': Icons.restaurant_outlined,
    },
    {
      'category': 'Education',
      'icon': Icons.school_outlined,
    },
    {
      'category': 'Savings',
      'icon': Icons.savings_outlined,
    },
    {
      'category': 'Personal Care',
      'icon': Icons.spa_outlined,
    },
    {
      'category': 'Travel',
      'icon': Icons.flight_outlined,
    },
    {
      'category': 'Subscriptions',
      'icon': Icons.subscriptions_outlined,
    },
    {
      'category': 'Gifts',
      'icon': Icons.card_giftcard_outlined,
    },
    {
      'category': 'Investments',
      'icon': Icons.trending_up_outlined,
    },
    {
      'category': 'Miscellaneous',
      'icon': Icons.category_outlined,
    },
    {
      'category': 'Others',
      'icon': Icons.more_horiz_rounded,
    }
  ];

  void getDefaultValue() {
    getCategorySelectedIndex = null;
    update();
  }

  void getSelectedCategoryInd({required int index}) {
    getCategorySelectedIndex = index;
    update();
  }

//FETCH RECORDS
  void fetchCategoryData() {
    allCategory = DBHelper.dbHelper.fetchCategory();
  }

  //LIVE UPDATE
  void searchData({required String search}) {
    allCategory = DBHelper.dbHelper.liveSearchCategory(search: search);
    update();
  }

  Future<void> updateData({required CategoryModel model}) async {
    int? res = await DBHelper.dbHelper.updateCategory(model: model);
    if (res != null) {
      Get.snackbar(
        'Update',
        "Category is updated...",
        backgroundColor: Colors.green.withOpacity(0.7),
      );
    } else {
      Get.snackbar(
        'Failed',
        "Category is updation failed...",
        backgroundColor: Colors.red.withOpacity(0.7),
      );
    }
  }

  Future<void> deleteCategory({required int id}) async {
    int? res = await DBHelper.dbHelper.deleteCategory(id: id);
    if (res != null) {
      Get.snackbar(
        'Delete',
        "Category is Delete...",
        backgroundColor: Colors.green.withOpacity(0.7),
      );
    } else {
      Get.snackbar(
        'Failed',
        "Category is Deletion failed...",
        backgroundColor: Colors.red.withOpacity(0.7),
      );
    }
  }
}
