import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../providers/Utils.dart';

class ClientDealsController extends GetxController {
  //TODO: Implement ClientDealsController

  final count = 0.obs;
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  Rx<TextEditingController> duration = TextEditingController().obs;

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

  // void calculateDuration() {
  //   num secondStartTime =
  //       Utils.oldBMSConvertToSecondsValue(value: startTime.text);
  //   num secondEndTime =
  //       Utils.oldBMSConvertToSecondsValue(value: endTime.text);

  //   var sec;
  //   if (startTime.text.length >= 11) {
  //     if ((secondEom - secondSom) < 0) {
  //       LoadingDialog.showErrorDialog("EOM should not be less than SOM.");
  //     } else {
  //       duration.value.text =
  //           Utils.convertToTimeFromDouble(value: secondEom - secondSom);

  //       sec = Utils.oldBMSConvertToSecondsValue(value: duration.value.text);
  //     }
  //   }

  //   print(">>>>>>>>>" + duration.value.text);
  //   print(">>>>>>>>>" + sec.toString());
  // }

  void increment() => count.value++;
}
