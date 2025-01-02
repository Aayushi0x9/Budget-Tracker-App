import 'dart:developer';

import 'package:budget_tracker_app/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppController controller = Get.put(AppController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracker App'),
      ),
      body: PageView.builder(
        onPageChanged: (value) {
          log("PageView Index : $value");
          controller.changeNavigationIndex(index: value);
        },
        itemCount: controller.navigationList.length,
        controller: controller.pageController,
        itemBuilder: (context, index) {
          return controller.navigationList[index];
        },
      ),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          selectedIndex: controller.getNavigationIndex.value,
          onDestinationSelected: (value) {
            controller.changeNavigationIndex(index: value);
            controller.changePage(index: value);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.category), label: 'Category'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
          ],
        );
      }),
    );
  }
}
