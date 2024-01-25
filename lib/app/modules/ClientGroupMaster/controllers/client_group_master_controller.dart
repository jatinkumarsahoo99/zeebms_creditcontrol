import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class ClientGroupMasterController extends GetxController {
  //TODO: Implement ClientGroupMasterController

  // final count = 0.obs;
  final tecGroupName = TextEditingController().obs;
  final tecShortName = TextEditingController().obs;
  final tecCreator = TextEditingController().obs;

  DropDownValue? selectedClientName;

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
