import 'package:attendance_app/app/modules/attendance_history/controller/attendance_controller.dart';
import 'package:attendance_app/app/modules/attendance_punch/controller/check_in_check_out_controller.dart';
import 'package:attendance_app/app/modules/holiday/controller/holiday_controller.dart';
import 'package:attendance_app/app/modules/home/controller/tab_navigation.dart';
import 'package:attendance_app/app/modules/home/controller/task_controller.dart';
import 'package:get/get.dart';
import 'package:attendance_app/app/modules/auth/controllers/auth_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put<TaskController>(TaskController());
    Get.put<AttendanceController>(AttendanceController());
    Get.lazyPut<PunchInPunchOutController>(() => PunchInPunchOutController());
    Get.put<TaskTabController>(TaskTabController());
   Get.put(HolidayController());
  }
}
