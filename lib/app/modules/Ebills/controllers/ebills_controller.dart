import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EbillsController extends GetxController {
  TextEditingController billingPeriod = TextEditingController(),
      billingPeriod2 = TextEditingController(),
      toTEC = TextEditingController(),
      ccTEC = TextEditingController(),
      mailID = TextEditingController();

  var isTestMail = false.obs;
  var isAll = true.obs;
  var isBills = true.obs;
  var isTC = true.obs;
  var isSummary = true.obs;
  var isConsolidated = false.obs;
  String? fromEmailId;
  String? asiaTodayFromMailId;

  List<DropDownValue>? lstCheckListCompany;
  List<DropDownValue>? filterListCompany;
  List<DropDownValue>? agencyGroupList;
  List<DropDownValue>? filterAgencyGroupList;

  RxnString selectionCurrentType = RxnString('Group');
  RxnString sendingCurrentType = RxnString('Domestic');

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
        api: ApiFactory.EBILLS_GET_LOAD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('ebLoad')) {
            // Mail ID
            fromEmailId = map['ebLoad']['fromMailId'];
            asiaTodayFromMailId = map['ebLoad']['asiaTodayFromMailId'];
            mailID.text = fromEmailId ?? "";
            // Check LIst Company
            lstCheckListCompany = [];
            map['ebLoad']['lstCheckListCompany'].forEach((e) {
              lstCheckListCompany?.add(DropDownValue(
                key: e['companyCode'],
                value: e['companyName'],
              ));
            });
            update(["init", "checkListCompany"]);
          }
        });
  }

  sendingOptionRadioButtion(String val) {
    switch (val) {
      case 'Domestic':
        mailID.text = fromEmailId ?? "";
        break;
      case 'ATL':
        mailID.text = asiaTodayFromMailId ?? "";
        break;
      default:
    }
  }

  postAgency() {
    bool? isCheck;
    lstCheckListCompany
        ?.where((element) => element.isSelected ?? false)
        .map((e) {
      isCheck = true;
      return true;
    }).toList();
    if (isCheck == true) {
      var payload = {
        "optAgency": selectionCurrentType.value == "Agency" ? true : false,
        "txtTcStartDate": billingPeriod.text,
        "lstCompany": lstCheckListCompany
            ?.where((element) => element.isSelected ?? false)
            .map((e) => e.toJsonCustom('companyCode', 'companyName'))
            .toList(),
        "txtStartDate": billingPeriod2.text
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EBILLS_POST_AGENCY,
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

  createXML() {
    bool? isCheck;
    agencyGroupList?.where((element) => element.isSelected ?? false).map((e) {
      isCheck = true;
      return true;
    }).toList();
    if (isCheck == true) {
      var payload = {
        "lstCompany": lstCheckListCompany
            ?.where((element) => element.isSelected ?? false)
            .map((e) => e.toJsonCustom('companyCode', 'companyName'))
            .toList(),
        "lsttblAgencyOrGroup": agencyGroupList
            ?.where((element) => element.isSelected ?? false)
            .map((e) => e.toJsonCustom('code', 'name'))
            .toList(),
        "chkConsolidated": isConsolidated.value,
        "optAgency": selectionCurrentType.value == "Agency" ? true : false,
        "chkOnlyBills": isBills.value,
        "chkOnlySummary": isSummary.value,
        "chkTc": isTC.value,
        "txtTcStartDate": billingPeriod.text,
        "txtStartDate": billingPeriod2.text,
        "optBillingMumbai":
            sendingCurrentType.value == "Domestic" ? true : false,
        "chkAdditionalTo": false,
        "chkAdditionalCc": false,
        "txtAddTo": toTEC.text,
        "chkTestMail": isTestMail.value,
        "txtAddCc": ccTEC.text,
        "txtFromMailId": mailID.text,
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EBILLS_CREATE_XML_CLICK,
          json: payload,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('ebCreateXml')) {
              LoadingDialog.callDataSaved(msg: map['ebCreateXml']['message']);
            }
          });
    }
  }

  manageBillingPeriod() {
    var day = DateFormat('dd')
        .format(DateFormat('dd-MM-yyyy').parse(billingPeriod.text));
    var month = DateFormat('MM')
        .format(DateFormat('dd-MM-yyyy').parse(billingPeriod.text));
    var year = DateFormat('yyyy')
        .format(DateFormat('dd-MM-yyyy').parse(billingPeriod.text));
    int noOfDaysInMonth =
        DateTime(int.parse(year), int.parse(month) + 1, 0).day;
    if (num.parse(day) <= 14) {
      billingPeriod2.text = "15-$month-$year";
    } else {
      billingPeriod2.text = "$noOfDaysInMonth-$month-$year";
    }
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

  clear() {
    toTEC.clear();
    ccTEC.clear();
    agencyGroupList!.clear();
    update(["init", "agencyGroupList"]);
  }
}
