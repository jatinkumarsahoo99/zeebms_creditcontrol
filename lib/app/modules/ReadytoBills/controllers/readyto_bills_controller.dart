import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadytoBillsController extends GetxController {
  TextEditingController fromDate = TextEditingController(),
      toDate = TextEditingController();

  List extraButtonName = ['Verify', 'Billing Value', 'Export', 'Clear', 'Exit'];

  var isR4 = false.obs;
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

  formHandler(btn) {
    switch (btn) {
      case "Save":
        break;
      case "Clear":
        break;
      case "Verify":
        break;
      case "Billing Value":
        break;
      case "Export":
        break;
      case "Exit":
        // print("Im in Exit");
        // try {
        //   Get.find<HomeController>().postUserGridSetting1(listStateManager: [
        //     loadInwardGrid,
        //   ]);
        // } catch (e) {
        //   print("Exit Error ===>" + e.toString());
        // }
        break;
    }
  }
}
