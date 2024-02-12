import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EbillsController extends GetxController {
  TextEditingController billingPeriod = TextEditingController(),
      billingPeriod2 = TextEditingController(),
      mailID = TextEditingController();

  var isTestMail = false.obs;
  var isAll = true.obs;
  var isBills = true.obs;
  var isTC = true.obs;
  var isSummary = true.obs;
  var isConsolidated = false.obs;

  List<String> selectionTypes = [
    "Agency",
    "Group",
  ];

  List<String> sendingTypes = [
    "Domestic",
    "ATL",
  ];
  RxnString selectionCurrentType = RxnString();
  RxnString sendingCurrentType = RxnString();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    selectionCurrentType.value = 'Group';
    sendingCurrentType.value = 'Domestic';
    getOnLoad();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getOnLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.EBILLS_GET_LOAD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('location')) {}
        });
  }

  checkAll() {
    if (isAll.isTrue) {
      isAll.value = false;
      isBills.value = false;
      isTC.value = false;
      isSummary.value = false;
    } else {
      isAll.value = true;
      isBills.value = true;
      isTC.value = true;
      isSummary.value = true;
    }
    update(['eBills']);
  }
}
