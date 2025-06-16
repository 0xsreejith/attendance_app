import 'package:attendance_app/app/modules/attendance/view/home_screen.dart';
import 'package:attendance_app/app/modules/attendance/view/main_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => MainScreen(),
    ),
    GetPage(name: Routes.HOME, page: () => const HomeScreen())
  ];
}
