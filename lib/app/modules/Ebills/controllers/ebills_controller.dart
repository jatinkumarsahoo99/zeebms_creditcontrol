import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  List<DropDownValue>? lstCheckListCompany;
  List<DropDownValue>? filterListCompany;
  List<DropDownValue>? agencyGroupList;

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
            mailID.text = map['ebLoad']['fromMailId'];
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
        "optAgency": selectionCurrentType.value == "Agency" ? true : false,
        "txtTcStartDate": billingPeriod.text,
        "lstCompany": filterListCompany!
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
