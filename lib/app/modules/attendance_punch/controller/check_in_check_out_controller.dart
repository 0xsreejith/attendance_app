import 'package:get/get.dart';

class PunchInPunchOutController extends GetxController {
  var isPunchedIn = false.obs;
  var punchInTime = ''.obs;
  var punchOutTime = ''.obs;
  var punchLocation = ''.obs;
  var isOnsite = false.obs;

  void punchIn({required bool isOnsite}) {
    this.isOnsite.value = isOnsite;
    isPunchedIn.value = true;
    punchInTime.value = _getFormattedTime();
    punchLocation.value = isOnsite ? "On Site" : "Remote (Work From Home)";
  }

  void punchOut() {
    isPunchedIn.value = false;
    punchOutTime.value = _getFormattedTime();
    print('Punched out at: ${punchOutTime.value}');
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
    return DateTime.now().toIso8601String();
  }
}
