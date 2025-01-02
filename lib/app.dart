import 'package:budget_tracker_app/screen/pages/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screen/pages/get_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: GetPages.pagesGet,
      home: HomeScreen(),
    );
  }
}
