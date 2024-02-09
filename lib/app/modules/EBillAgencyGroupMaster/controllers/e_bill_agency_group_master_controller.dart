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

  RxBool grp=RxBool(false);

  @override
  void onInit() {
    getInit();
    super.onInit();
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
            map['groups']["lstagencymaster"].forEach((e) {
              lstagencymaster?.add(DropDownValue(
                  key: e["agencycode"].toString(), value: e["agencyname"]));
            });
            map['groups']["lstemaildetails"].forEach((e) {
              lstemaildetails?.add(DropDownValue(
                  key: e["mailcc"].toString(), value: e["mailto"]));
            });
            mailTo.text = lstemaildetails![0].value ?? "";
            mailCC.text = lstemaildetails![0].value ?? "";
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
        });
  }

  void removeToGroup() {
    LoadingDialog.call();
    var jsonMap = {
      "lstZsapAgency": lstagencymaster?.map((e) => e.toJsonCustom("groupCode", "agencycode")).toList(),
      "groupCode": selectedGrp?.key??""
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.EBILL_AGENCY_REMOVE_GRP,
        fun: (map) {
          Get.back();
        },
        json: jsonMap);
  }

  void addNewGroup() {
    grp.value=!grp.value;
  }
}
