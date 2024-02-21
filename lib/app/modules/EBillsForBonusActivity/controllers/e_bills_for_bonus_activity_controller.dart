import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  postAgency() {
    filterListCompany = [];
    for (var i = 0; i < lstCheckListCompany!.length; i++) {
      if (lstCheckListCompany![i].isSelected == true) {
        filterListCompany!.add(DropDownValue(
          key: lstCheckListCompany![i].key,
          value: lstCheckListCompany![i].value,
        ));
      }
    }
    if (filterListCompany!.isNotEmpty) {
      var payload = {
        "optAgency": selectExportType.value == "Agency" ? true : false,
        "tcStartDate": telecastPeriod.text,
        "lstCompanyList": filterListCompany!
            .map((e) => e.toJsonCustom('companyCode', 'companyName'))
            .toList(),
        "startDate": telecastPeriod2.text
      };

      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EBILLS_BONUS_ACTIVITY_FETCH_AGENCY_LIST,
          json: payload,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('ebAgencyGroup')) {
              agencyGroupList = [];
              if (map['ebAgencyGroup']['lstAgency'] != null) {
                map['ebAgencyGroup']['lstAgency'].forEach((e) {
                  agencyGroupList?.add(DropDownValue(
                    key: e['agencycode'],
                    value: e['name'],
                  ));
                });
              } else {
                if (map['ebAgencyGroup']['lstGroup'] != null) {
                  map['ebAgencyGroup']['lstGroup'].forEach((e) {
                    agencyGroupList?.add(DropDownValue(
                      key: e['groupcode'].toString(),
                      value: e['name'],
                    ));
                  });
                }
              }

              update(["init", "agencyGroupList"]);
            }
          });
    }
  }

  domesticClick() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.EBILLS_BONUS_ACTIVITY_RD_BILLING_MUMBAI_CHECK('true'),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('infoBillingMum')) {
            // Mail ID
            mailID.text = map['infoBillingMum'];
          }
        });
  }

  asiaClick() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.EBILLS_BONUS_ACTIVITY_RD_BILLING_ASIA_CHECK('false'),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('infoBillingAsia')) {
            // Mail ID
            mailID.text = map['infoBillingAsia'];
          }
        });
  }

  createXML() {
    // if (filterListCompany!.isNotEmpty) {
    var payload = {
      "consolidated": "<integer>",
      "lstCompanyList": filterListCompany!
          .map((e) => e.toJsonCustom('companyCode', 'companyName'))
          .toList(),
      "txt_TcStartDT": telecastPeriod.text,
      "txt_StartDT": telecastPeriod2.text,
      "chk_Is_Consolidated": "<boolean>",
      "lstAgent": [
        {"code": "<string>", "name": "<string>"},
      ],
      "rDbt_Agency": selectExportType.value == "Agency" ? true : false,
      "isBillExist": false,
      "isTcExist": false,
      "chk_OnlyBills": true,
      "chk_OnlySummary": true,
      "chk_TC": true,
      "rdBtn_BillingMumbai": false,
      "testMail": isTestMail.value,
      "additionalTo": false,
      "additionalCc": false,
      "isConsolidated": false,
      "code": "<string>",
      "agencyNM": "<string>",
      "txtAddTo": toTEC.text,
      "txtAddCc": ccTEC.text,
      "txt_FromMailID": mailID.text,
      "companyName": "<string>"
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.EBILLS_BONUS_ACTIVITY_CREATE_XML,
        json: payload,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('ebAgencyGroup')) {
            update(["init", "agencyGroupList"]);
          }
        });
    // }
  }

  manageBillingPeriod() {
    var day = DateFormat('dd')
        .format(DateFormat('dd-MM-yyyy').parse(telecastPeriod.text));
    var month = DateFormat('MM')
        .format(DateFormat('dd-MM-yyyy').parse(telecastPeriod.text));
    var year = DateFormat('yyyy')
        .format(DateFormat('dd-MM-yyyy').parse(telecastPeriod.text));
    int noOfDaysInMonth =
        DateTime(int.parse(year), int.parse(month) + 1, 0).day;
    if (num.parse(day) <= 14) {
      telecastPeriod2.text = "15-$month-$year";
    } else {
      telecastPeriod2.text = "$noOfDaysInMonth-$month-$year";
    }
  }
}
