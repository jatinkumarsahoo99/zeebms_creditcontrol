import 'dart:async';

// import 'package:bms_creditcontrol/widgets/PlutoGridExport/lib/pluto_grid_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../SecondaryAsrunGridModel.dart';
import '../SecondaryAsrunModifictionResponseModel.dart';

class SecondaryAsrunModificationController extends GetxController {
  //TODO: Implement SecondaryAsrunModificationController

  final count = 0.obs;

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  TextEditingController logDateController = TextEditingController();

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  PlutoGridStateManager? stateManager;
  PlutoGridStateManager? stateManagerDialog;

  var canDialogShow = false.obs;
  Widget? dialogWidget;
  Rxn<int> initialOffset = Rxn<int>(null);
  Completer<bool>? completerDialog;

  String? strTapeID = "";
  String? strProgramName = "";
  String? intTapeDuration = "0";

  List<LstFinalAsRun>? lstFinalAsRunDataList = [];

  TextEditingController tapeIdEditingController = TextEditingController();
  TextEditingController finalProgramEditingController = TextEditingController();
  TextEditingController finalMidPreEditingController = TextEditingController();
  TextEditingController finalTelecastTimeEditingController = TextEditingController();
  TextEditingController finalDurationEditingController = TextEditingController();

  Rx<bool> isEnable = Rx<bool>(true);

  var rebuildSecModKey = GlobalKey<ScaffoldState>();

  Offset? getOffSetValue(BoxConstraints constraints) {
    switch (initialOffset.value) {
      case 1:
        return Offset((constraints.maxWidth / 3) + 30, constraints.maxHeight / 3);
      case 2:
        return Offset(Get.width * 0.09, Get.height * 0.12);
      case 3:
        return const Offset(20, 20);
      default:
        return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    fetchAllLoaderData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  SecondaryAsrunGridModel? secondaryAsrunGridModel;

  fetchAllLoaderData() {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.SECONDARY_ASRUN_MODIFICATION_LOCATION,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map &&
                map['location'] != null &&
                map['location']['result'] != null &&
                map['location']['result'].length > 0) {
              RxList<DropDownValue> dataList = RxList([]);
              map['location']['result'].forEach((e) {
                dataList.add(DropDownValue.fromJsonDynamic(e, "locationCode", "locationName"));
              });
              locationList.addAll(dataList);
              locationList.refresh();
            } else {}
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  getChannels({String? locationCode}) {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.SECONDARY_ASRUN_MODIFICATION_CHANNEL + (locationCode ?? ""),
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            channelList.clear();
            if (map is Map &&
                map['channel'] != null &&
                map['channel']['result'] != null &&
                map['channel']['result'].length > 0) {
              RxList<DropDownValue> dataList = RxList([]);
              map['channel']['result'].forEach((e) {
                dataList.add(DropDownValue.fromJsonDynamic(e, "channelCode", "channelName"));
              });
              channelList.addAll(dataList);
              channelList.refresh();
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  getBindData() {
    LoadingDialog.call();
    try {
      Map<String, dynamic> postData = {
        "locationcode": selectedLocation?.key ?? "",
        "channelcode": selectedChannel?.key ?? "",
        "scheduledate": Utils.getMMDDYYYYFromDDMMYYYYInString4(logDateController.text)
      };

      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.SECONDARY_ASRUN_MODIFICATION_BIND_GRID,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['bindGrid'] != null) {
              secondaryAsrunGridModel =
                  SecondaryAsrunGridModel.fromJson(map as Map<String, dynamic>);
              lstFinalAsRunDataList = secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun??[];
              isEnable.value = false;
              isEnable.refresh();
              update(['grid']);
            } else {
              secondaryAsrunGridModel = null;
              lstFinalAsRunDataList = [];
              isEnable.value = false;
              isEnable.refresh();
              update(['grid']);
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            secondaryAsrunGridModel = null;
            lstFinalAsRunDataList = [];
            isEnable.value = false;
            isEnable.refresh();
            update(['grid']);
          });
    } catch (e) {
      closeDialogIfOpen();
      secondaryAsrunGridModel = null;
      lstFinalAsRunDataList = [];
      isEnable.value = false;
      isEnable.refresh();
      update(['grid']);
    }
  }

  onDoubleClick(int? index, PlutoGridOnRowDoubleTapEvent? event) {
    if (index != null && index != -1 && event != null) {
      strTapeID = stateManager?.rows[index].cells['tapeID']?.value ?? "";
      strProgramName = stateManager?.rows[index].cells['programName']?.value ?? "";
      intTapeDuration = (stateManager?.rows[index].cells['tapeDuration']?.value ?? "0").toString();

      LoadingDialog.modify3("Want to change the status to NOT TELECASTED", () {
        telFun(index);
      }, () {}, confirmTitle: "Yes", cancelTitle: "No");
    }
  }

  telFun(int index) {
    bool? blnRowUpdated = false;
    lstFinalAsRunDataList = secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun??[];

    for (int i = 0; i < (stateManager?.rows.length ?? 0); i++) {
      if (index == i) {
        for (int j = 0; j < (secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun?.length ?? 0); j++) {
          if (((stateManager?.rows[i].cells['tapeID']?.value) ==
                  secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun?[j].exportTapeCode) &&
              ((stateManager?.rows[i].cells['tapeDuration']?.value) ==
                  secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun?[j].tapeDuration) &&
              ((stateManager?.rows[i].cells['telecastTime']?.value) ==
                  secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun?[j].telecastTime)) {
            secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun?[j].spotStatus = "U";
            lstFinalAsRunDataList = secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun??[];
            blnRowUpdated = true;
          }
        }

        if (blnRowUpdated == false) {
          if ((secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun?.length ?? 0) > 0) {
            lstFinalAsRunDataList?.add(LstFinalAsRun(
                exportTapeCode: stateManager?.rows[i].cells['tapeID']?.value,
                exportTapeCaption: stateManager?.rows[i].cells['tapeID']?.value,
                tapeDuration:
                    (stateManager?.rows[i].cells['tapeDuration']?.value ?? "0").toString(),
                programname: stateManager?.rows[i].cells['programName']?.value,
                telecastTime: stateManager?.rows[i].cells['telecastTime']?.value,
                spotStatus: "U",
                spotPosition: stateManager?.rows[i].cells['spotPositionShortName']?.value,
                programCode: "",
                segmentNumber: ""));
          } else {
            lstFinalAsRunDataList = [];
            lstFinalAsRunDataList?.add(LstFinalAsRun(
                exportTapeCode: stateManager?.rows[i].cells['tapeID']?.value,
                exportTapeCaption: stateManager?.rows[i].cells['tapeID']?.value,
                tapeDuration:
                    (stateManager?.rows[i].cells['tapeDuration']?.value ?? "0").toString(),
                programname: stateManager?.rows[i].cells['programName']?.value,
                telecastTime: stateManager?.rows[i].cells['telecastTime']?.value,
                spotStatus: "U",
                spotPosition: stateManager?.rows[i].cells['spotPositionShortName']?.value,
                programCode: "",
                segmentNumber: ""));
          }
        }

        stateManager?.rows[index].cells['spotStatus']?.value = "NOT TELECASTED";
        stateManager?.rows[index].cells['modifyStatus']?.value = "M";
        stateManager?.rows[index].cells['telecastDuration']?.value = "";
        stateManager?.rows[index].cells['telecastDuration']?.value = "";
        stateManager?.rows[index].cells['telecastTime']?.value = "";
        stateManager?.rows[index].cells['telprogname']?.value = "";
        stateManager?.rows[index].cells['telpos']?.value = "";
        stateManager?.notifyListeners();

        // stateManager.
      }
    }
  }

  dialogOkClick() {
    print(
        ">>>>>>>>>>>>>>>>>val${tapeIdEditingController.text}${strTapeID}${finalDurationEditingController.text}"
        "${intTapeDuration}${finalProgramEditingController.text}${strProgramName}");

    if ((tapeIdEditingController.text.toString().trim() != strTapeID.toString().trim()) ||
        (finalDurationEditingController.text.toString().trim() !=
            intTapeDuration.toString().trim())) {
      print(">>>>>>>>>>>in if");

      Get.defaultDialog(
          title: "",
          barrierDismissible: false,
          contentPadding: EdgeInsets.only(
            left: SizeDefine.popupMarginHorizontal,
            right: SizeDefine.popupMarginHorizontal,
            bottom: 16,
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 55),
              const SizedBox(height: 10),
              Text(
                "Telecast Tape Id / Duration not matching with booking. Please\ncorrect accordingly",
                style: TextStyle(color: Colors.black, fontSize: SizeDefine.popupTxtSize),
              )
            ],
          ),
          confirm: DailogCloseButton(
            autoFocus: true,
            callback: () {
              Get.back();
            },
            btnText: "OK",
          ));

      LoadingDialog.showErrorDialog(
        "Telecast Tape Id / Duration not matching with booking. Please\ncorrect accordingly",
      );
    } else {
      if (finalProgramEditingController.text.toString().trim() !=
          strProgramName.toString().trim()) {
        print(">>>>>>>>>>>>>in else if");
        LoadingDialog.modify3("Program name not matching. Do you want to still continue?", () {},
            () {
          return;
        }, confirmTitle: "Yes", cancelTitle: "No");
      }

      stateManager?.rows[stateManager?.currentRowIdx ?? 0].cells['telecastDuration']?.value =
          finalDurationEditingController.text;
      stateManager?.rows[stateManager?.currentRowIdx ?? 0].cells['telecastTime']?.value =
          finalTelecastTimeEditingController.text;
      stateManager?.rows[stateManager?.currentRowIdx ?? 0].cells['telprogname']?.value =
          finalProgramEditingController.text;
      stateManager?.rows[stateManager?.currentRowIdx ?? 0].cells['modifyStatus']?.value = "M";
      stateManager?.rows[stateManager?.currentRowIdx ?? 0].cells['telecastProgramcode']?.value =
          (stateManagerDialog
                      ?.rows[stateManagerDialog?.currentRowIdx ?? 0].cells['programCode']?.value ??
                  "")
              .toString();
      btnOkApiCall(val: Uri.encodeComponent(finalMidPreEditingController.text ?? ""));

      stateManager?.rows[stateManager?.currentRowIdx ?? 0].cells['spotStatus']?.value =
          "TELECASTED";
      stateManagerDialog?.rows[stateManagerDialog?.currentRowIdx ?? 0].cells['spotStatus']?.value =
          "T";

      stateManagerDialog?.notifyListeners();
      stateManager?.notifyListeners();
    }
  }

  btnOkApiCall({String? val}) {
    // "spotPositionTypeCode": "ZAMID00002",
    // "spotPositionTypeName": "MID PROGRAM"
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.SECONDARY_ASRUN_MODIFICATION_GET_OK + (val ?? ""),
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            // channelList.clear();
            if (map is Map && map['okClick'] != null && map['okClick'].length > 0) {
              map['okClick'].forEach((e) {
                stateManager?.rows[stateManager?.currentRowIdx ?? 0].cells['telpos']?.value =
                    e['spotPositionTypeName'];
                stateManager?.rows[stateManager?.currentRowIdx ?? 0].cells['telecastMidPre']
                    ?.value = e['spotPositionTypeCode'];
              });
              stateManager?.notifyListeners();
              dialogWidget = null;
              canDialogShow.value = false;
            } else {
              LoadingDialog.showErrorDialog1("Something went wrong", callback: () {
                dialogWidget = null;
                canDialogShow.value = false;
              });
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }
  SecondaryAsrunModifictionResponseModel? secondaryAsrunModifictionResponseModel;

  saveResBindData(Map<String,dynamic>? map){
    try{
      if(map != null && map['postSave'] != null){
        secondaryAsrunModifictionResponseModel =
            SecondaryAsrunModifictionResponseModel.fromJson(map);

        if(secondaryAsrunModifictionResponseModel?.postSave != null &&
            secondaryAsrunModifictionResponseModel?.postSave?.dgvAsRunModification != null ){
          secondaryAsrunGridModel?.bindGrid?.lstAsRunBookingDetails?.clear();
          secondaryAsrunModifictionResponseModel?.postSave?.dgvAsRunModification?.forEach((element) {
            secondaryAsrunGridModel?.bindGrid?.lstAsRunBookingDetails?.add(LstAsRunBookingDetails.fromJson(element.toJson()));
          });
        }
        if(secondaryAsrunModifictionResponseModel?.postSave != null &&
            secondaryAsrunModifictionResponseModel?.postSave?.dgvTelecasted != null ){
          secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun?.clear();
          secondaryAsrunModifictionResponseModel?.postSave?.dgvTelecasted?.forEach((element) {
            secondaryAsrunGridModel?.bindGrid?.lstFinalAsRun?.add(LstFinalAsRun.fromJson(element.toJson()));
          });
        }
        update(['grid']);
      }else{
        secondaryAsrunModifictionResponseModel = null;
      }

    }catch(e){
      secondaryAsrunModifictionResponseModel = null;
    }
  }

  postSave() {
    if ((stateManager?.rows.length ?? 0) > 0) {
      try {
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "lstAsRunModification": getDataFromGrid(stateManager),
          "lstFinalAsRun": getDataFromGrid1(stateManagerDialog),
          "locationCode": selectedLocation?.key ?? "",
          "channelCode": selectedChannel?.key ?? "",
          "logDate": Utils.getMMDDYYYYFromDDMMYYYYInString3(logDateController.text) ?? ""
        };

        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.SECONDARY_ASRUN_MODIFICATION_SAVE,
            json: postData,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map && map['postSave'] != null) {
                saveResBindData(map as Map<String,dynamic>);
                LoadingDialog.callDataSaved(
                    msg: map['postSave']['message'] ?? "Something went wrong",
                    callback: () {
                      clearAll();
                    });
              } else {
                LoadingDialog.showErrorDialog((map ?? "Something went wrong").toString());
              }
            },
            failed: (map) {
              closeDialogIfOpen();
              LoadingDialog.showErrorDialog((map ?? "Something went wrong").toString());
            });
      } catch (e) {
        closeDialogIfOpen();
        LoadingDialog.showErrorDialog(("Something went wrong").toString());
      }
    } else {
      LoadingDialog.showErrorDialog(("Sorry! No record(s) to save."));
    }
  }

  btnClearMisMatch() {
    try {
      if (secondaryAsrunGridModel != null && secondaryAsrunGridModel?.bindGrid != null
          /* &&
          secondaryAsrunGridModel?.bindGrid?.lstbookingdetail != null
           && (secondaryAsrunGridModel?.bindGrid?.lstbookingdetail?.length ?? 0) > 0*/
          ) {
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "locationcode": selectedLocation?.key ?? "",
          "channelcode": selectedChannel?.key ?? "",
          "date": Utils.getMMDDYYYYFromDDMMYYYYInString3(logDateController.text) ?? "",
          "lstTape": (secondaryAsrunGridModel?.bindGrid?.lstbookingdetail
                  ?.map((e) => e.toJson())
                  .toList()) ??
              []
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.SECONDARY_ASRUN_MODIFICATION_GET_CLEAR_MISMATCH,
            json: postData,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map &&
                  map['clearmismatch'] != null &&
                  map['clearmismatch']['message'] != null) {
                LoadingDialog.callDataSaved2(
                    msg: (map['clearmismatch']['message'] ?? "").toString(),
                    callback: () {
                      getBindData();
                    });
              } else {
                LoadingDialog.showErrorDialog((map ?? "Something went wrong").toString());
              }
            },
            failed: (map) {
              closeDialogIfOpen();
              LoadingDialog.showErrorDialog(("Something went wrong").toString());
            });
      } else {
        LoadingDialog.callInfoMessage("No miss Match found");
      }
    } catch (e) {
      closeDialogIfOpen();
      LoadingDialog.showErrorDialog(("Something went wrong").toString());
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
          if ((key.toString().trim() == "tapeDuration") ||
              (key.toString().trim() == "telecastDuration") ||
              (key.toString().trim() == "bookingdetailcode") ||
              (key.toString().trim() == "bookingDetailCode1") ||
              (key.toString().trim() == "recordnumber")) {
            if (row.cells[key]?.value != null &&
                (row.cells[key]?.value ?? "").toString().trim() != "") {
              try {
                rowMap[key] = int.parse(row.cells[key]?.value);
              } catch (e) {
                rowMap[key] = double.parse(row.cells[key]?.value);
              }
            } else {
              // rowMap[key] = DateFormat("yyyy-MM-dd").format(DateTime.now()) + (row.cells[key]?.value ?? "");
              rowMap[key] = 0;
            }
          } else if ((key.toString().trim() == "MID/Pre")) {
            rowMap["midPre"] = row.cells[key]?.value ?? "";
          } else {
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

  List<Map<String, dynamic>> getDataFromGrid1(PlutoGridStateManager? statemanager) {
    if (statemanager != null) {
      statemanager.setFilter((element) => true);
      statemanager.notifyListeners();
      List<Map<String, dynamic>> mapList = [];
      for (var row in statemanager.rows) {
        Map<String, dynamic> rowMap = {};
        for (var key in row.cells.keys) {
          if ((key.toString().trim() == "tapeDuration")) {
            if (row.cells[key]?.value != null &&
                (row.cells[key]?.value ?? "").toString().trim() != "") {
              try {
                rowMap[key] = int.parse(row.cells[key]?.value);
              } catch (e) {
                rowMap[key] = double.parse(row.cells[key]?.value);
              }
            } else {
              // rowMap[key] = DateFormat("yyyy-MM-dd").format(DateTime.now()) + (row.cells[key]?.value ?? "");
              rowMap[key] = 0;
            }
          } else {
            rowMap[key] = row.cells[key]?.value ?? "";
          }
        }
        mapList.add(rowMap);
      }
      return mapList;
    } else {
      if (lstFinalAsRunDataList != null && (lstFinalAsRunDataList?.length ?? 0) > 0) {
        return (lstFinalAsRunDataList!.map((e) => e.toJson1()).toList());
      }
      return [];
    }
  }

  clearAll() {
    LoadingDialog.modify4("Unsaved data will be lost, want to continue?", () {
      // Get.delete<SecondaryAsrunModificationController>();
      // Get.find<HomeController>().clearPage1();
      clearAllVariable();
    }, () {}, deleteTitle: "Yes", confirmTitle: "No");
  }

  clearAllVariable(){
    secondaryAsrunModifictionResponseModel = null;
    secondaryAsrunGridModel = null;
    isEnable.value = true;
    isEnable.refresh();
    lstFinalAsRunDataList = [];
     selectedLocation = null;
     selectedChannel = null;
    dialogWidget = null;
    canDialogShow.value = false;
     update(['grid']);

  }

  formHandler(String text) {
    if (text == "Clear") {
      clearAll();
    }
    if (text == "Save") {
      postSave();
    }
    if (text == "Search") {
      Get.to(SearchPage(
          key: Key("Secondary Asrun Modification"),
          screenName: "Secondary Asrun Modification",
          appBarName: "Secondary Asrun Modification",
          strViewName: "vTesting",
          isAppBarReq: true));
    }
  }
}
