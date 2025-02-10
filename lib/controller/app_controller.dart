import 'package:budget_tracker_app/component/all_category.dart';
import 'package:budget_tracker_app/component/all_spending.dart';
import 'package:budget_tracker_app/component/category.dart';
import 'package:budget_tracker_app/component/spending.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxInt getNavigationIndex = 0.obs;
  PageController pageController = PageController(initialPage: 1);

  List<Widget> navigationList = [
    const AllSpending(),
    const Spending(),
    const AllCategory(),
    const CategoryComp(),
  ];

  void changeNavigationIndex({required int index}) {
    getNavigationIndex.value = index;
  }

  void changePage({required int index}) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
