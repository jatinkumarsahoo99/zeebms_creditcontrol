import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class CompanyMasterController extends GetxController {
  //TODO: Implement CompanyMasterController

  // final count = 0.obs;
  var cityList = <DropDownValue>[].obs;

  DropDownValue? selectedCity;

  final tecCompanyName = TextEditingController().obs;
  final tecShortName = TextEditingController().obs;
  final tecCorpAddress = TextEditingController().obs;
  final tecPin = TextEditingController().obs;
  final tecTelephone = TextEditingController().obs;
  final tecFax = TextEditingController().obs;
  final tecRegdAddress = TextEditingController().obs;
  final tecPanCardNo = TextEditingController().obs;
  final tecSTC_No = TextEditingController().obs;
  final tecFormerCompany = TextEditingController().obs;
  final tecEmailAdreess = TextEditingController().obs;
  final tecWebSite = TextEditingController().obs;
  final tecCIN_Number = TextEditingController().obs;
  final tecLogoFile = TextEditingController().obs;
  final tecSAP_Code = TextEditingController().obs;
  final tecRemarks = TextEditingController().obs;
  final tecBlank1 = TextEditingController().obs;
  final tecBlank2 = TextEditingController().obs;

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
