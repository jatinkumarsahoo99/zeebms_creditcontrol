import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../providers/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class ClientDealsController extends GetxController {
  //TODO: Implement ClientDealsController

  final count = 0.obs;
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  Rx<TextEditingController> duration = TextEditingController().obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> clientList = RxList([]);
  RxList<DropDownValue> agencyList = RxList([]);
  RxList<DropDownValue> brandList = RxList([]);
  RxList<DropDownValue> accountList = RxList([]);
  RxList<DropDownValue> subTypeList = RxList([]);
  RxList<DropDownValue> spotTypeList = RxList([]);
  RxList<DropDownValue> programList = RxList([]);
  RxList<DropDownValue> addInfoList = RxList([]);
  RxList<DropDownValue> clientList2 = RxList([]);
  RxList<DropDownValue> payMode = RxList([]);
  RxList<DropDownValue> currency = RxList([]);
  RxList<DropDownValue> locationList2 = RxList([]);
  RxList<DropDownValue> dealType = RxList([]);
  RxList<DropDownValue> channelList2 = RxList([]);

  Rxn<DropDownValue>? selectedLocation;
  Rxn<DropDownValue>? selectedChannel;
  Rxn<DropDownValue>? selectedClient;
  Rxn<DropDownValue>? selectPayMode;
  Rxn<DropDownValue>? selectCurrency;

  TextEditingController dealNoController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController referenceDateController = TextEditingController();
  TextEditingController maxSpeedController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController secondsController = TextEditingController();

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
