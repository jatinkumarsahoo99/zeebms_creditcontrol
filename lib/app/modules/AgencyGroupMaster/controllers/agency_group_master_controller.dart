import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../../widgets/PlutoGrid/src/model/pluto_cell.dart';
import '../../../../widgets/PlutoGrid/src/model/pluto_row.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../AgencyGroupMasterModel.dart';

class AgencyGroupMasterController extends GetxController {
  //TODO: Implement AgencyGroupMasterController

  final count = 0.obs;
  double fixedWidth = 0.53;

  TextEditingController groupNameController = TextEditingController();
  TextEditingController shortNameController = TextEditingController();

  Rxn<DropDownValue> selectedAgencyName = Rxn<DropDownValue>(null);
  Rxn<DropDownValue> selectedGroupName = Rxn<DropDownValue>(null);

  FocusNode groupNameFocus = FocusNode();
  FocusNode shortNameFocus = FocusNode();
  FocusNode agencyNameFocus = FocusNode();
  AgencyGroupMasterModel? agencyGroupMasterModel;
  PlutoGridStateManager? stateManager;
  String strCode = "0";
  getRetrieveRecord() {
    LoadingDialog.call();
    try {
      Map<String, dynamic> postData = {
        "GroupCode": "",
        "GroupName": groupNameController.text ?? ""
      };
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.AGENCY_GROUP_MASTER_GET_RETRIEVE_RECORD,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['retrieveRecord'] != null) {
              agencyGroupMasterModel = AgencyGroupMasterModel.fromJson(map as Map<String, dynamic>);
              if (agencyGroupMasterModel != null &&
                  agencyGroupMasterModel?.retrieveRecord != null &&
                  agencyGroupMasterModel?.retrieveRecord?.lstGroup != null &&
                  (agencyGroupMasterModel?.retrieveRecord?.lstGroup?.length ?? 0) > 0) {
                shortNameController.text =
                    agencyGroupMasterModel?.retrieveRecord?.lstGroup?[0].groupShortName ?? "";
                selectedGroupName.value = DropDownValue(
                    key: agencyGroupMasterModel?.retrieveRecord?.lstGroup?[0].groupCode ?? "",
                    value: agencyGroupMasterModel?.retrieveRecord?.lstGroup?[0].groupName ?? "");
                strCode = agencyGroupMasterModel?.retrieveRecord?.lstGroup?[0].groupCode ?? "0";
              }
              update(['grid']);
            } else {
              agencyGroupMasterModel = null;
              strCode = "0";
              update(['grid']);
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            agencyGroupMasterModel = null;
            strCode = "0";
            update(['grid']);
          });
    } catch (e) {
      closeDialogIfOpen();
      agencyGroupMasterModel = null;
      strCode = "0";
      update(['grid']);
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  addBtnCall() {
    if (stateManager != null) {
      stateManager?.setFilter((element) => true);
      if (duplicateRowsCheck()) {
        LoadingDialog.showErrorDialog("Agency already in the group");
      } else {
        stateManager?.insertRows((stateManager?.rows.length ?? 0), [
          PlutoRow(cells: {
            "agencyCode": PlutoCell(value: selectedAgencyName.value?.key ?? ""),
            "agencyName": PlutoCell(value: selectedAgencyName.value?.value ?? ""),
            "no": PlutoCell(value: ((stateManager?.rows.length ?? 0)).toString()),
          })
        ]);
        stateManager?.notifyListeners();
      }

      // update(['grid']);
    } else {
      agencyGroupMasterModel =
          AgencyGroupMasterModel(retrieveRecord: RetrieveRecord(lstagencymaster: [], lstGroup: []));
      agencyGroupMasterModel?.retrieveRecord?.lstagencymaster?.add(Lstagencymaster(
          agencyCode: selectedAgencyName.value?.key ?? "",
          agencyName: selectedAgencyName.value?.value ?? ""));
      update(['grid']);
    }
  }

  bool duplicateRowsCheck() {
    if (stateManager != null) {
      for (int i = 0; i < (stateManager?.rows.length ?? 0); i++) {
        if (((stateManager?.rows[i].cells['agencyName']?.value ?? "")
                    .toString()
                    .toLowerCase()
                    .trim() ==
                (selectedAgencyName.value?.value ?? "").toString().toLowerCase().trim()) ||
            ((stateManager?.rows[i].cells['agencyCode']?.value ?? "")
                    .toString()
                    .toLowerCase()
                    .trim() ==
                (selectedAgencyName.value?.key ?? "").toString().toLowerCase().trim())) {
          return true;
          break;
        }
      }
      return false;
    } else {
      return false;
    }
  }

  List<Map<String, dynamic>> getDataFromGrid(PlutoGridStateManager? statemanager) {
    if (statemanager != null) {
      statemanager.setFilter((element) => true);
      statemanager.notifyListeners();
      List<Map<String, dynamic>> mapList = [];
      for (var row in statemanager.rows) {
        Map<String, dynamic> rowMap = {};
        for (var key in row.cells.keys) {
          if(key.toString().toLowerCase() == "agencyCode".toLowerCase().trim()){
            rowMap["code"] = row.cells[key]?.value ?? "";
          }else{
            rowMap[key] = row.cells[key]?.value ?? "";
          }

        }
        mapList.add(rowMap);
      }
      return mapList;
    } else {
      return [];
    }
  }

  removeCall() {
    if (stateManager != null) {
      LoadingDialog.modify3("Want to remove selected row?", () {
        stateManager?.removeCurrentRow();
        stateManager?.notifyListeners();
      }, () {}, cancelTitle: "No", confirmTitle: "Yes");
    } else {}
  }

  saveFunCall() {
    if (groupNameController.text.trim() == "") {
      LoadingDialog.showErrorDialog("Group Name can not be empty.");
    } else if (shortNameController.text.trim() == "") {
      LoadingDialog.showErrorDialog("Group Short Name can not be empty.");
    } else if (stateManager == null || (stateManager?.rows.length ?? 0) == 0) {
      LoadingDialog.showErrorDialog("Agency List can not be empty.");
    } else {
      if (strCode != "0") {
        LoadingDialog.modify3("Record Already exists!\nDo you want to modify it?", (){
          saveApiCall();
        }, (){},
            confirmTitle: "Yes",cancelTitle: "No");
      } else {
        saveApiCall();
      }
    }
  }

  clearAll() {
    Get.delete<AgencyGroupMasterController>();
    Get.find<HomeController>().clearPage1();
  }

  saveApiCall() {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "groupCode":strCode?? "",
        "groupName": groupNameController.text??"",
        "groupShortName":shortNameController.text?? "",
        "modifiedBy": Get.find<MainController>().user?.logincode ?? "",
        "lstdt": getDataFromGrid(stateManager)
      };

      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AGENCY_GROUP_MASTER_POST,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['save'] != null) {
              LoadingDialog.callDataSaved(
                  msg: map['save'] ?? "",
                  callback: () {
                    clearAll();
                  });
            } else {
              LoadingDialog.showErrorDialog("Something went wrong");
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            LoadingDialog.showErrorDialog("Something went wrong");
          });
    } catch (e) {
      closeDialogIfOpen();
      print(">>>>>>exception" + e.toString());
      LoadingDialog.showErrorDialog("Something went wrong");
    }
  }

  @override
  void onInit() {
    groupNameFocus = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          getRetrieveRecord();
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
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

  void increment() => count.value++;

  formHandler(String text) {
    if(text == "Save"){
      saveFunCall();
    }else if(text == "Clear"){
      clearAll();
    }else if(text == "Search"){
      Get.to(
        const SearchPage(
          key: Key("Agency Group Master"),
          screenName: "Agency Group Master",
          appBarName: "Agency Group Master",
          strViewName: "BMS_Agencygroupmasterv",
          isAppBarReq: true,
        ),
      );
    }
  }
}
