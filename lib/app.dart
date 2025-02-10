import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screen/pages/get_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff141326),
      ),
      getPages: GetPages.pagesGet,
      // home: const HomeScreen(),
    );
  }
}
