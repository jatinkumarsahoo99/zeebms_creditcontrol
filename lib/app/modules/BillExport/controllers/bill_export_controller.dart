import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class BillExportController extends GetxController {
  //TODO: Implement BillExportController

  // final count = 0.obs;
  var locationList = <DropDownValue>[].obs,
      ChannelList = <DropDownValue>[].obs,
      agencyList = <DropDownValue>[].obs;

  DropDownValue? selectedLocation, selectedChannel, selectedAgency;

  final tecFrom = TextEditingController().obs;
  final tecTo = TextEditingController().obs;

  var gridData = [].obs;

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
