import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonSearch/views/common_search_view.dart';

class ClientGroupMasterController extends GetxController {
  //TODO: Implement ClientGroupMasterController

  // final count = 0.obs;
  final tecGroupName = TextEditingController().obs;
  final tecShortName = TextEditingController().obs;
  final tecCreator = TextEditingController().obs;

  DropDownValue? selectedClientName;

  FocusNode groupNameFN = FocusNode();

  var gridData = [].obs;

  var groupCode = "0";

  @override
  void onInit() {
    super.onInit();
    groupNameFN.addListener(() {
      if (!groupNameFN.hasFocus) {
        if (tecGroupName.value.text.isNotEmpty) {
          getRecord();
        }
      }
    });
    // groupNameFN = FocusNode(
    //   onKeyEvent: (node, event) {
    //     if (event.logicalKey == LogicalKeyboardKey.tab) {
    //       // getRecord();
    //       if (tecGroupName.value.text.isNotEmpty) {
    //         getRecord();
    //       }
    //       return KeyEventResult.ignored;
    //     }
    //     return KeyEventResult.ignored;
    //   },
    // );
  }

  @override
  void onReady() {
    super.onReady();
  }

  onAdd() {
    if (tecGroupName.value.text.isEmpty) {
      LoadingDialog.showErrorDialog("Group Name cannot be empty.");
    } else if (tecShortName.value.text.isEmpty) {
      LoadingDialog.showErrorDialog("Group Short Name cannot be empty.");
    } else if (selectedClientName == null) {
      LoadingDialog.showErrorDialog("Please select client name");
    } else {
      checkAndAddClientCode(
          selectedClientName?.key ?? "", selectedClientName?.value ?? "");
    }
  }

  void checkAndAddClientCode(String code, String name) {
    // Check if the client code is already present in the list
    if (code != "") {
      bool isCodePresent =
          gridData.any((client) => client['clientCode'] == code);

      if (isCodePresent) {
        LoadingDialog.showErrorDialog("Client already in the group");
      } else if (!isCodePresent) {
        // If the client code is not present, add new data to the list
        Map<String, String> newClient = {
          "clientCode": code,
          "clientName": name
        };
        gridData.add(newClient);
        gridData.refresh();
      }
    }
  }

  getRecord() {
    // tecPayRouteCategory.value.text =
    //     tecPayRouteCategory.value.text.toUpperCase();
    groupCode = "0";
    tecShortName.value.clear();
    tecCreator.value.clear();
    gridData.value = [];
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.CLIENT_GROUP_MASTER_GET_RECORD(
        groupName: tecGroupName.value.text,
      ),
      fun: (resp) {
        Get.back();
        if (resp != null &&
            resp is Map<String, dynamic> &&
            resp["retrieve"] != null) {
          var clientDetails = resp["retrieve"]["lstClientDetails"];
          if (clientDetails != null && clientDetails.isNotEmpty) {
            groupCode = clientDetails[0]["groupCode"];
            tecShortName.value.text = clientDetails[0]["groupShortName"];
            tecCreator.value.text = clientDetails[0]["employeeName"];
          }

          var groupDetails = resp["retrieve"]["lstVClientGroupMaster"];
          if (groupDetails != null && groupDetails.isNotEmpty) {
            gridData.value = groupDetails;
          }
        }
      },
      failed: (resp) {
        Get.back();
        LoadingDialog.showErrorDialog(resp.toString());
      },
    );
  }

  saveRecord() {
    // print("Save button tapped");
    // print(" code" + payrouteCategoryCode);

    if (tecGroupName.value.text.isEmpty) {
      LoadingDialog.showErrorDialog("Group Name cannot be empty.");
    } else if (tecShortName.value.text.isEmpty) {
      LoadingDialog.showErrorDialog("Group Short Name cannot be empty.");
    } else if (groupCode != "0") {
      LoadingDialog.recordExists(
        "Record Already exist! \n Do you want to modify it",
        () {
          callSaveRecord();
        },
      );
    } else {
      callSaveRecord();
    }
  }

  callSaveRecord() {
    print("calling save record");
    var codeList = [];
    for (var i = 0; i < gridData.length; i++) {
      codeList.add({"code": gridData[i]["clientCode"]});
    }
    var model = {
      "groupCode": groupCode,
      "groupName": tecGroupName.value.text,
      "groupShortName": tecShortName.value.text,
      "lstdt": codeList
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.CLIENT_GROUP_MASTER_SAVE_RECORD,
      json: model,
      fun: (resp) {
        Get.back();
        if (resp != null &&
            resp is Map<String, dynamic> &&
            resp.toString().contains("successfully")) {
          LoadingDialog.callDataSaved(
            msg: resp["message"],
            callback: () {
              callClear();
            },
          );
        }
      },
    );
  }

  callClear() {
    Get.delete<ClientGroupMasterController>();
    Get.find<HomeController>().clearPage1();
  }

  formHandler(btn) {
    switch (btn) {
      case "Clear":
        callClear();

        break;
      case "Save":
        // payRouteFocus.unfocus();
        // UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        saveRecord();
        break;
      case "Delete":
        break;
      case "Refresh":
        break;
      case "Exit":
        break;
      case "Docs":
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("Client Group Master"),
            screenName: "Client Group Master",
            appBarName: "Client Group Master",
            strViewName: "BMS_vClientGroupMaster",
            isAppBarReq: true,
          ),
        );
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void increment() => count.value++;
}
