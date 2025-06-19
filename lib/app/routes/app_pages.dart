import 'package:attendance_app/app/modules/attendance_punch/view/check_in_page.dart';
import 'package:attendance_app/app/modules/home/view/screens/home_screen.dart';
import 'package:attendance_app/app/modules/home/view/screens/main_screen.dart';
import 'package:attendance_app/app/modules/home/view/screens/scan_face.dart';
import 'package:attendance_app/app/modules/leave/view/apply_leave_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => MainScreen(),
    ),
    GetPage(name: Routes.HOME, page: () => const HomeScreen()),
    GetPage(name: Routes.chekIn, page: () => CheckInPage()),
    GetPage(name: Routes.scanFace, page: () => const ScanFaceScreen()),
    GetPage(name: Routes.leave, page: () => const ApplyForLeaveScreen())
  ];
}
