import 'package:attendance_app/app/bindings/gloabl_bindings.dart';
import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:attendance_app/app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Attendance App',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.MAIN,
      getPages: AppPages.routes,
      initialBinding: GlobalBinding(),
    );
  }
}
