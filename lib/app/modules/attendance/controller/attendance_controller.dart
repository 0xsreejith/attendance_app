import 'package:attendance_app/app/modules/attendance/model/attendance_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class AttendanceController extends GetxController {
  var attendanceList = <AttendanceModel>[].obs;
  var filteredList = <AttendanceModel>[].obs;

  var selectedStatus = "All".obs;
  var selectedStartDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();

  var isCalendarView = false.obs;

  void fetchData() {
    attendanceList.value = [
      AttendanceModel(
        date: DateTime(2025, 6, 7),
        checkIn: "9:00 AM",
        checkOut: "5:00 PM",
        location: "Main Office",
        status: "Present",
      ),
      AttendanceModel(
        date: DateTime(2025, 6, 6),
        checkIn: "--",
        checkOut: "--",
        location: "Main Office",
        status: "Absent",
      ),
      AttendanceModel(
        date: DateTime(2025, 6, 5),
        checkIn: "9:15 AM",
        checkOut: "5:00 PM",
        location: "Main Office",
        status: "Late",
      ),
    ];
    filteredList.assignAll(attendanceList);
  }

  void applyFilter(String status) {
    selectedStatus.value = status;
    List<AttendanceModel> filtered = attendanceList;

    if (status != "All") {
      filtered = filtered.where((e) => e.status == status).toList();
    }

    if (selectedStartDate.value != null && selectedEndDate.value != null) {
      filtered = filtered.where((e) =>
        e.date.isAfter(selectedStartDate.value!.subtract(const Duration(days: 1))) &&
        e.date.isBefore(selectedEndDate.value!.add(const Duration(days: 1)))
      ).toList();
    }

    filteredList.value = filtered;
  }

  String get formattedRange {
    final start = selectedStartDate.value;
    final end = selectedEndDate.value;
    if (start == null || end == null) return "Select Date Range";
    return "${DateFormat('MMM dd').format(start)} - ${DateFormat('MMM dd, yyyy').format(end)}";
  }
}
