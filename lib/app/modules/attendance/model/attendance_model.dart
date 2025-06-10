class AttendanceModel {
  final DateTime date;
  final String checkIn;
  final String checkOut;
  final String location;
  final String status;

  AttendanceModel({
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.location,
    required this.status,
  });
}
