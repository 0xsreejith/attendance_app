// lib/app/modules/attendance/controllers/task_tab_controller.dart
import 'package:get/get.dart';

class TaskTabController extends GetxController {
  var selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }
}
