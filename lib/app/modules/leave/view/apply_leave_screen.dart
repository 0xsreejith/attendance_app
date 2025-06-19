// File: apply_for_leave_screen.dart

import 'package:attendance_app/app/modules/leave/view/components/custom_btn.dart';
import 'package:attendance_app/app/modules/leave/view/components/custom_header.dart';
import 'package:attendance_app/app/modules/leave/view/components/leave_dashborad.dart';
import 'package:attendance_app/app/modules/leave/view/components/leave_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/leave_controller.dart';

class ApplyForLeaveScreen extends StatelessWidget {
  const ApplyForLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaveController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(),
            const SizedBox(height: 8),

            // Tab Buttons using MyBtn
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => Row(
                    children: [
                      Expanded(
                        child: MyBtn(
                          text: "Dashboard",
                          icon: Icons.dashboard,
                          isSelected: controller.selectedTab.value == 0,
                          onTap: () => controller.selectedTab.value = 0,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: MyBtn(
                          text: "Apply Leave",
                          icon: Icons.logout,
                          isSelected: controller.selectedTab.value == 1,
                          onTap: () => controller.selectedTab.value = 1,
                        ),
                      ),
                    ],
                  )),
            ),

            const SizedBox(height: 16),

            // Tab Content
            Expanded(
              child: Obx(() => controller.selectedTab.value == 0
                  ? const LeaveDashboard()
                  : const LeaveForm()),
            )
          ],
        ),
      ),
    );
  }
}
