import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/DropDownValue.dart';

class AuditCancellationController extends GetxController {
  //TODO: Implement AuditCancellationController

  final count = 0.obs;

  var gridData = [].obs;

  var locationList = <DropDownValue>[].obs;
  var channelList = <DropDownValue>[].obs;

  // channelList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation,
      selectedChannel,
      selectedClient,
      selectedAgency,
      selectedBrand;

  final tecFpcDate = TextEditingController(),
      tecBookDate = TextEditingController(),
      tecBlankDate = TextEditingController(),
      tecBookNo = TextEditingController(),
      tecBlankYear = TextEditingController(),
      tecBlankCo_ordinate = TextEditingController(),
      tecDealNo = TextEditingController(),
      tecPayRoute = TextEditingController(),
      tecPayMode = TextEditingController(),
      tecExecutive = TextEditingController(),
      tecRefDate = TextEditingController(),
      tecCancelNo = TextEditingController(),
      tecSpotAmt = TextEditingController(),
      tecRefNo = TextEditingController();

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

  void increment() => count.value++;
}
