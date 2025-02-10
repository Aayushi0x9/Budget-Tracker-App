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
      backgroundColor: Color(0xff141326),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff141326),
        title: const Text(
          'BUDGET TRACKER',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
            NavigationDestination(
                icon: Icon(Icons.done_all), label: 'all spending'),
            NavigationDestination(icon: Icon(Icons.spa), label: 'Spending'),
            NavigationDestination(
                icon: Icon(Icons.call_to_action_outlined),
                label: 'All Category'),
            NavigationDestination(
                icon: Icon(Icons.category), label: 'Category'),
          ],
        );
      }),
    );
  }
}
