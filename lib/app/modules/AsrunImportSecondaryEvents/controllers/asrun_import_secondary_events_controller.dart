import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AsrunImportSecondaryEventsController extends GetxController {
  TextEditingController logDate = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single != null) {
      print(result.files[0]);
      // importfile(result.files[0]);
    } else {
      // User canceled the pic5ker
    }
  }
}
