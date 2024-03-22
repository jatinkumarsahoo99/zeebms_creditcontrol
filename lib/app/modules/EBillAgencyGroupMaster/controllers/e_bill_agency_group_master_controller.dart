import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class EBillAgencyGroupMasterController extends GetxController {
  List<DropDownValue>? grpList;

  List<DropDownValue>? lstagency;
  List<DropDownValue>? lstagencymaster;
  List<DropDownValue>? lstemaildetails;

  DropDownValue? selectedGrp;
  DropDownValue? selectedAgency;

  TextEditingController mailTo = TextEditingController();
  TextEditingController mailCC = TextEditingController();
  TextEditingController grpName = TextEditingController();

  RxBool grp = RxBool(false);
  FocusNode grpNameFocus=FocusNode();

  @override
  void onInit() {
    getInit();
    super.onInit();
    grpNameFocus.addListener(() {
      if(!grpNameFocus.hasFocus){
        grpName.text=grpName.text.toUpperCase();
      }
    });
  }

  getInit() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.EBILL_AGENCY_INIT,
        fun: (map) {
          if (map is Map &&
              map.containsKey("pageload") &&
              map["pageload"] != null) {
            grpList = [];
            map["pageload"].forEach((e) {
              grpList?.add(DropDownValue(
                  key: e["groupCode"].toString(), value: e["groupname"]));
            });
          }
          update(["init"]);
        });
  }

  getClientLeave() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.EBILL_AGENCY_GRP_LEAVE + (selectedGrp?.key ?? ""),
        fun: (map) {
          lstagency = [];
          lstagencymaster = [];
          lstemaildetails = [];
          if (map is Map &&
              map.containsKey("groups") &&
              map["groups"] != null) {
            map['groups']["lstagency"].forEach((e) {
              lstagency?.add(DropDownValue(
                  key: e["agencycode"].toString(), value: e["agencyname"]));
            });
            if (map['groups']["lstagencymaster"] != null) {
              map['groups']["lstagencymaster"].forEach((e) {
                lstagencymaster?.add(DropDownValue(
                    key: e["agencycode"].toString(), value: e["agencyname"]));
              });
            }
            if (map['groups']["lstemaildetails"] != null) {
              map['groups']["lstemaildetails"].forEach((e) {
                lstemaildetails?.add(DropDownValue(
                    key: e["mailcc"].toString(), value: e["mailto"]));
              });
            }
            mailTo.text = lstemaildetails![0].value ?? "";
            mailCC.text = lstemaildetails![0].key ?? "";
          }
          update(["init", "billMaster"]);
        });
  }

  void addToGroup() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.EBILL_AGENCY_ADD_GRP(
            selectedGrp?.key ?? "", selectedAgency?.key ?? ""),
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey("lstagency") &&
              map["lstagency"] != null) {
            lstagencymaster = [];
            if (map['lstagency'] != null) {
              map['lstagency'].forEach((e) {
                lstagencymaster?.add(DropDownValue(
                    key: e["agencycode"].toString(), value: e["agencyname"]));
              });
            }
            update(['billMaster']);
          }
        });
  }

  void removeToGroup() {
    LoadingDialog.call();
    var jsonMap = {
      "lstZsapAgency": lstagencymaster
          ?.where((element) => element.isSelected ?? false)
          .map((e) => {
                "groupCode": (int.tryParse(selectedGrp?.key ?? "") ?? 0),
                "agencycode": e.key ?? ""
              })
          .toList(),
      "groupCode": int.tryParse(selectedGrp?.key ?? "")
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.EBILL_AGENCY_REMOVE_GRP,
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey("agency") &&
              map["agency"] != null) {
            lstagencymaster = [];
            if (map['agency'] != null) {
              map['agency'].forEach((e) {
                lstagencymaster?.add(DropDownValue(
                    key: e["agencycode"].toString(), value: e["agencyname"]));
              });
            }
            update(['billMaster']);
          }
        },
        json: jsonMap);
  }

  void saveData() {
    LoadingDialog.call();
    var jsonMap = {
      "groupcode": int.tryParse(selectedGrp?.key ?? ""),
      "groupName": selectedGrp?.value ?? "",
      "mailto": mailTo.text,
      "mailcc": mailCC.text
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.EBILL_AGENCY_SAVE,
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey("save") &&
              map["save"] != null &&
              map["save"]
                  .toString()
                  .trim()
                  .toLowerCase()
                  .contains('successfully')) {
            LoadingDialog.callErrorMessage1(msg: map["save"]);
          } else {
            LoadingDialog.callErrorMessage1(msg: map.toString());
          }
        },
        json: jsonMap);
  }

  void addNewGroup() {
    grpName.text = "";
    grp.value = !grp.value;
  }

  void addNewGroup1() {
    if (grpName.text == "") {
      return;
    }
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.EBILL_AGENCY_ADD_GRP_NAME + grpName.text,
        fun: (map) {
          grpName.text = "";
          Get.back();
          if (map is Map &&
              map.containsKey("addbutton") &&
              map["addbutton"].containsKey("lstgroupname") &&
              map["addbutton"]["lstgroupname"] != null) {
            grpList = [];
            map["addbutton"]["lstgroupname"].forEach((e) {
              grpList?.add(DropDownValue(
                  key: e["groupCode"].toString(), value: e["groupname"]));
            });
            update(["init"]);
          }
        });
  }

  void save() {
    var jsonData = {
      "groupcode": selectedGrp?.key ?? "",
      "groupName": selectedGrp?.value ?? "",
      "mailto": mailTo.text,
      "mailcc": mailCC.text
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.EBILL_AGENCY_SAVE,
        fun: (map) {
          Get.back();
        },
        json: jsonData);
  }
}
