import 'package:attendance_app/app/modules/attendance_history/model/attendance_model.dart';
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
        date: DateTime(2025, 6, 6),
        checkIn: "9:30 AM",
        checkOut: "5:00 PM",
        location: "Main Office",
        status: "Late", // Changed from Absent to Late
      ),
      AttendanceModel(
        date: DateTime(2025, 6, 9),
        checkIn: "9:00 AM",
        checkOut: "5:00 PM",
        location: "Main Office",
        status: "Present",
      ),
      AttendanceModel(
        date: DateTime(2025, 6, 10),
        checkIn: "9:05 AM",
        checkOut: "5:00 PM",
        location: "Main Office",
        status: "Present",
      ),
      AttendanceModel(
        date: DateTime(2025, 6, 16),
        checkIn: "9:00 AM",
        checkOut: "5:00 PM",
        location: "Main Office",
        status: "Present",
      ),
      AttendanceModel(
        date: DateTime(2025, 6, 17),
        checkIn: "9:10 AM",
        checkOut: "5:00 PM",
        location: "Main Office",
        status: "Present",
      ),
      AttendanceModel(
        date: DateTime(2025, 6, 24),
        checkIn: "--",
        checkOut: "--",
        location: "Main Office",
        status: "Absent",
      ),
      AttendanceModel(
        date: DateTime(2025, 6, 25),
        checkIn: "--",
        checkOut: "--",
        location: "Main Office",
        status: "Leave",
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
      filtered = filtered
          .where((e) =>
              e.date.isAfter(
                  selectedStartDate.value!.subtract(const Duration(days: 1))) &&
              e.date.isBefore(
                  selectedEndDate.value!.add(const Duration(days: 1))))
          .toList();
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
