import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyTypeMasterController extends GetxController {
  TextEditingController currencyName = TextEditingController(),
      shortName = TextEditingController(),
      crrrencyCode = TextEditingController(),
      lowerCurrencyName = TextEditingController(),
      currency = TextEditingController();
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
}
