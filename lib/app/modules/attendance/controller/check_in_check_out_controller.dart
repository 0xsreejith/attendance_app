import 'package:get/get.dart';

class PunchInPunchOutController extends GetxController {
  var isPunchedIn = false.obs;
  var punchInTime = ''.obs;
  var punchOutTime = ''.obs;
  var punchLocation = ''.obs;
  var isOnsite = false.obs; // Track location type for punch-out

  void punchIn({required bool isOnsite}) {
    this.isOnsite.value = isOnsite; // Store location type
    isPunchedIn.value = true;
    punchInTime.value = _getFormattedTime();
    punchLocation.value = isOnsite ? "On Site" : "Remote (Work From Home)";
  }

  void punchOut() {
    isPunchedIn.value = false;
    punchOutTime.value = _getFormattedTime();
    
    // Here you would typically send this data to your backend
    print('Punched out at: ${punchOutTime.value}');
    
    // Reset location after punch out
    punchLocation.value = '';
  }

  void resetPunch() {
    isPunchedIn.value = false;
    punchInTime.value = '';
    punchOutTime.value = '';
    punchLocation.value = '';
    isOnsite.value = false;
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.day}-${now.month}-${now.year}";
  }
}