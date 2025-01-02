import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  int? getCategorySelectedIndex;
  List<Map<String, dynamic>> category = [
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
  void getSelectedCategoryInd({required int index}) {
    getCategorySelectedIndex = index;
    update();
  }
}
