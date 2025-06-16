import 'package:attendance_app/app/modules/attendance/controller/task_controller.dart';
import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:attendance_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(TaskController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.MAIN,
      getPages: AppPages.routes,
    );
  }
}
