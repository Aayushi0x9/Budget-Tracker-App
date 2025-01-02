import 'package:budget_tracker_app/screen/pages/home/home_screen.dart';
import 'package:get/get.dart';

class GetPages extends GetxController {
  // static String signIn = '/';
  static String home = '/home';

  static List<GetPage> pagesGet = [
    // GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: home, page: () => HomeScreen()),
  ];
}
