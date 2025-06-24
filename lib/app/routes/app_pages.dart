import 'package:attendance_app/app/modules/attendance/view/attendance.dart';
import 'package:attendance_app/app/modules/attendance_punch/view/check_in_page.dart';
import 'package:attendance_app/app/modules/attendance_punch/view/scan_face.dart';
import 'package:attendance_app/app/modules/auth/views/forgotten_passwrod.dart';
import 'package:attendance_app/app/modules/auth/views/login_page.dart';
import 'package:attendance_app/app/modules/auth/views/main_page.dart';
import 'package:attendance_app/app/modules/auth/views/signup_page.dart';
import 'package:attendance_app/app/modules/holiday/view/holiday_screen.dart';
import 'package:attendance_app/app/modules/home/view/home_screen.dart';
import 'package:attendance_app/app/modules/leave/view/apply_leave_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.MAIN, page: () => const MainPage()),
    GetPage(name: Routes.HOME, page: () => const HomeScreen()),
    GetPage(name: Routes.chekIn, page: () => CheckInPage()),
    GetPage(name: Routes.scanFace, page: () => const ScanFaceScreen()),
    GetPage(name: Routes.leave, page: () => const ApplyForLeaveScreen()),
    GetPage(name: Routes.login, page: () => LoginPage()),
    GetPage(name: Routes.signUp, page: () => SignupPage()),
    GetPage(name: Routes.forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(name: Routes.attendance, page: () => AttendanceScreen()),
    GetPage(name: Routes.holiday, page: () => const HolidayScreen()),
  ];
}
