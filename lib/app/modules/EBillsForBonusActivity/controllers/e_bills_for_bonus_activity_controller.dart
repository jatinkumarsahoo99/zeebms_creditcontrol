import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EBillsForBonusActivityController extends GetxController {
  TextEditingController telecastPeriod = TextEditingController(),
      telecastPeriod2 = TextEditingController(),
      toTEC = TextEditingController(),
      ccTEC = TextEditingController(),
      mailID = TextEditingController();

  List<DropDownValue>? lstCheckListCompany;
  List<DropDownValue>? filterListCompany;
  List<DropDownValue>? agencyGroupList;

  RxnString selectExportType = RxnString("Group");
  RxnString selRadio = RxnString("Domestic");
  var isTestMail = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoad();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getOnLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.EBILLS_BONUS_ACTIVITY_PAGE_LOAD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('infoPageLoad')) {
            // Mail ID
            mailID.text = map['infoPageLoad']['fromEmailId'];
            // Check LIst Company
            lstCheckListCompany = [];
            map['infoPageLoad']['lstCheckCompanyList'].forEach((e) {
              lstCheckListCompany?.add(DropDownValue(
                key: e['companyCode'],
                value: e['companyName'],
              ));
            });
            update(["init", "checkListCompany"]);
          }
        });
  }
}
