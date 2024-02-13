import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class ClearSecondarySpotsController extends GetxController {
  //TODO: Implement ClearSecondarySpotsController

  // final count = 0.obs;
  final tecYearMonth = TextEditingController();
  final tecTelecastDate = TextEditingController();

  var locationList = <DropDownValue>[].obs;
  var channelList = <DropDownValue>[].obs;

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

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

  // void increment() => count.value++;
}
