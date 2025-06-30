import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LeaveController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final reasonController = TextEditingController();
  final selectedLeaveType = RxnString();
  final fromDate = Rxn<DateTime>();
  final toDate = Rxn<DateTime>();
  final selectedAttachment = Rxn<String>();
  final selectedTab = 0.obs;

  final List<String> leaveTypes = [
    "Casual Leave",
    "Sick Leave",
    "Work From Home",
    "Earned Leave",
  ];

  void pickFromDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      fromDate.value = picked;
      if (toDate.value != null && toDate.value!.isBefore(picked)) {
        toDate.value = null;
      }
    }
  }

  void pickToDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: fromDate.value ?? DateTime.now(),
      firstDate: fromDate.value ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      toDate.value = picked;
    }
  }

  void showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take Photo'),
            onTap: () async {
              Get.back(); 
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                selectedAttachment.value = pickedFile.name;
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Pick from Gallery'),
            onTap: () async {
              Get.back();
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                selectedAttachment.value = pickedFile.name;
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.insert_drive_file),
            title: const Text('Pick Document'),
            onTap: () async {
              Get.back();
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                selectedAttachment.value = result.files.single.name;
              }
            },
          ),
        ],
      ),
    );
  }

  void submitLeave() {
    if (formKey.currentState!.validate()) {
      if (fromDate.value == null ||
          toDate.value == null ||
          selectedLeaveType.value == null) {
        Get.snackbar("Incomplete", "Please fill all required fields.");
        return;
      }

      Get.snackbar("Success", "Leave request submitted!");
      clearForm();
    }
  }

  void clearForm() {
    reasonController.clear();
    selectedLeaveType.value = null;
    fromDate.value = null;
    toDate.value = null;
    selectedAttachment.value = null;
  }

  @override
  void onClose() {
    reasonController.dispose();
    super.onClose();
  }
}
