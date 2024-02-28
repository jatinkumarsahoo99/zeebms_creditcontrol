import 'dart:convert';

import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EBillsForBonusActivityController extends GetxController {
  TextEditingController telecastPeriod = TextEditingController(),
      telecastPeriod2 = TextEditingController(),
      toTEC = TextEditingController(),
      ccTEC = TextEditingController(),
      mailID = TextEditingController();
  String? fromEmailId;
  String? fromAsiaEmailId;

  List<DropDownValue>? lstCheckListCompany;
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
            fromEmailId = map['infoPageLoad']['fromEmailId'];
            fromAsiaEmailId = map['infoPageLoad']['fromAsiaEmailId'];
            mailID.text = fromEmailId ?? "";
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

  sendingOptionRadioButtion(String val) {
    switch (val) {
      case 'Domestic':
        mailID.text = fromEmailId ?? "";
        break;
      case 'ATL':
        mailID.text = fromAsiaEmailId ?? "";
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
        "optAgency": selectExportType.value == "Agency" ? true : false,
        "tcStartDate": telecastPeriod.text,
        "lstCompanyList": lstCheckListCompany
            ?.where((element) => element.isSelected ?? false)
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
            if (map != null && map.containsKey('infoAgencyList')) {
              agencyGroupList = [];
              if (map['infoAgencyList']['lstAgency'] != null) {
                map['infoAgencyList']['lstAgency'].forEach((e) {
                  agencyGroupList?.add(DropDownValue(
                    key: e['code'].toString(),
                    value: e['name'],
                  ));
                });
              } else {
                if (map['infoAgencyList']['lstGroupAgency'] != null) {
                  map['infoAgencyList']['lstGroupAgency'].forEach((e) {
                    agencyGroupList?.add(DropDownValue(
                      key: e['code'].toString(),
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
        "consolidated": 0,
        "lstCompanyList": lstCheckListCompany
            ?.where((element) => element.isSelected ?? false)
            .map((e) => e.toJsonCustom('companyCode', 'companyName'))
            .toList(),
        "txt_TcStartDT": telecastPeriod.text,
        "txt_StartDT": telecastPeriod2.text,
        "chk_Is_Consolidated": false,
        "lstAgent": agencyGroupList
            ?.where((element) => element.isSelected ?? false)
            .map((e) => e.toJsonCustom('code', 'name'))
            .toList(),
        "rDbt_Agency": selectExportType.value == "Agency" ? true : false,
        "isBillExist": true,
        "isTcExist": true,
        "chk_OnlyBills": false,
        "chk_OnlySummary": false,
        "chk_TC": true,
        "rdBtn_BillingMumbai": selRadio.value == 'Domestic' ? true : false,
        "testMail": isTestMail.value,
        "additionalTo": false,
        "additionalCc": false,
        "isConsolidated": false,
        "txtAddTo": toTEC.text,
        "txtAddCc": ccTEC.text,
        "txt_FromMailID": mailID.text,
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EBILLS_BONUS_ACTIVITY_CREATE_XML,
          json: payload,
          fun: (Map map) async {
            Get.back();
            if (map != null && map.containsKey('infoCreateXml')) {
              if (map['infoCreateXml']['tcXml']['message']
                  .contains('XML created successfully.')) {
                String fileName = extractFileName(
                    map['infoCreateXml']['tcXml']['ebillsTCpath']);
                await FileSaver.instance.saveFile(
                  name: (fileName),
                  bytes: base64Decode(map['infoCreateXml']['tcXml']['tc']),
                );

                LoadingDialog.callDataSaved(
                    msg: map['infoCreateXml']['sendMails']['message'],
                    callback: () {
                      LoadingDialog.callDataSaved(
                          msg: map['infoCreateXml']['tcXml']['message'],
                          callback: () {
                            Get.back();
                          });
                    });
              } else {
                LoadingDialog.showErrorDialog(
                    map['infoCreateXml']['sendMails']['message'], callback: () {
                  LoadingDialog.showErrorDialog(
                      map['infoCreateXml']['tcXml']['message'], callback: () {
                    Get.back();
                  });
                });
              }

              // update(["init", "agencyGroupList"]);
            }
          });
    }
  }

  String extractFileName(String filePath) {
    List<String> pathSegments = filePath.split(RegExp(r'[\\/\\\\]'));
    String fileName = pathSegments.last;

    return fileName;
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
