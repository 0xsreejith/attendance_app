import 'package:attendance_app/app/modules/attendance/view/check_in_page.dart';
import 'package:attendance_app/app/modules/attendance/view/home_screen.dart';
import 'package:attendance_app/app/modules/attendance/view/main_screen.dart';
import 'package:attendance_app/app/modules/attendance/view/scan_face.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => MainScreen(),
    ),
    GetPage(name: Routes.HOME, page: () => const HomeScreen()),
    GetPage(name: Routes.chekIn, page: () => const CheckInPage()),
    GetPage(name: Routes.scanFace, page: ()=>const ScanFaceScreen())
  ];
}
