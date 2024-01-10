import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentRouteMasterController extends GetxController {
  TextEditingController payRouteName = TextEditingController(),
      shortName = TextEditingController(),
      collectionAgentShare = TextEditingController(),
      mainCompanyShare = TextEditingController(),
      agencyShare = TextEditingController();

  var isToBeBilled = true.obs, isActive = true.obs;

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
      case "Exit":
        break;
    }
  }

  serviceTaxFormHandler(btn) {
    switch (btn) {
      case "Save":
        break;
      case "Clear":
        break;
      case "Exit":
        // Get.back();
        break;
    }
  }
}
