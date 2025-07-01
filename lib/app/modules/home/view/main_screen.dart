import 'package:attendance_app/app/modules/attendance_history/view/attendance_screen.dart';
import 'package:attendance_app/app/modules/auth/views/profile_page.dart';
import 'package:attendance_app/app/modules/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}

class BottomNavScreen extends StatelessWidget {
  final MainScreenController controller = Get.put(MainScreenController());

  BottomNavScreen({super.key});

  final List<Widget> pages = [
    const HomeScreen(),
    MyAttendanceScreen(),
    const Center(child: Text("Leave Page")),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: "History"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_circle_right_sharp), label: "Leave"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ));
  }
}
