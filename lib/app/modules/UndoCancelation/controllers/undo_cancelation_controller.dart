import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class UndoCancelationController extends GetxController {
  //TODO: Implement UndoCancelationController

  RxList<DropDownValue> locations = RxList<DropDownValue>([]);
  RxList<DropDownValue> channels = RxList<DropDownValue>([]);
  RxBool isEnable = RxBool(true);
  DropDownValue? selectLocation;
  DropDownValue? selectChannel;
  TextEditingController scheduleDate = TextEditingController();
  TextEditingController bookingNumber = TextEditingController();
  // RxString? selectValue=RxString(null);
  Rxn<String> selectValue = Rxn<String>(null);
  var selectAllValue = false.obs;
  int inwardLastSelectedIdx = 0;

  // List<Map<String, dynamic>>? responseData;
  var responseData = [].obs;

  PlutoGridStateManager? stateManager;
  bool booked = false;
  bool onHold = false;
  bool expsoureSpots = false;

  getStatus({required String sel}) {
    switch (sel) {
      case "Booked":
        booked = true;
        onHold = false;
        expsoureSpots = false;
        break;
      case "On Hold":
        booked = false;
        onHold = true;
        expsoureSpots = false;
        break;
      case "Expsoure Spots":
        booked = false;
        onHold = false;
        expsoureSpots = true;
        break;
      default:
        booked = false;
        onHold = false;
        expsoureSpots = false;
    }
  }

  checkAll(bool sta) {
    if (sta) {
      for (int i = 0; i < (stateManager?.rows.length ?? 0); i++) {
        stateManager?.rows[i].cells['selectItem']?.value = "true";
      }
    } else {
      for (int i = 0; i < (stateManager?.rows.length ?? 0); i++) {
        stateManager?.rows[i].cells['selectItem']?.value = "false";
      }
    }
    stateManager?.notifyListeners();
    // responseData.refresh();
    print(responseData);
  }

  getAllLoadData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.UNDO_CANCELATION_GET_LOAD,
      // "https://jsonkeeper.com/b/D537"
      fun: (map) {
        closeDialogIfOpen();
        if (map is Map &&
            map.containsKey("loadData") &&
            map['loadData'] != null &&
            map['loadData'].length > 0) {
          locations.clear();
          RxList<DropDownValue> dataList = RxList<DropDownValue>([]);
          map['loadData'].forEach((element) {
            dataList.add(DropDownValue.fromJsonDynamic(
                element as Map<String, dynamic>,
                "locationCode",
                "locationName"));
          });
          locations.addAll(dataList);
          selectLocation = locations.first;
          getChannelList(selectLocation?.key ?? "");
          locations.refresh();
        } else {
          locations.clear();
          locations.refresh();
        }
      },
    );
  }

  getChannelList(String? locationCode) {
    if (locationCode != null && locationCode != "") {
      try {
        LoadingDialog.call();
        Get.find<ConnectorControl>().GETMETHODCALL(
            api: ApiFactory.UNDO_CANCELATION_GET_CHANNEL + locationCode,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map &&
                  map.containsKey("location") &&
                  map['location'] != null &&
                  map['location'].length > 0) {
                channels.clear();
                RxList<DropDownValue> dataList = RxList<DropDownValue>([]);
                map['location'].forEach((element) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      element as Map<String, dynamic>,
                      "channelCode",
                      "channelName"));
                });
                channels.addAll(dataList);
                channels.refresh();
              } else {
                channels.clear();
                channels.refresh();
              }
            });
      } catch (e) {
        closeDialogIfOpen();
      }
    } else {}
  }

  String dateFormat(String? date) {
    if (date != null && date != "") {
      DateTime dateNew = DateFormat("dd-MM-yyyy").parse(date);
      return DateFormat("yyyy-MM-ddTHH:mm:ss").format(dateNew);
    } else {
      return "";
    }
  }

  handleactionOnPressChangeInward(
      PlutoGridCellPosition position, bool isSpaceCalled) {
    inwardLastSelectedIdx =
        stateManager?.refRows[position.rowIdx ?? 0].sortIdx ?? 0;
    if (isSpaceCalled) {
      if (stateManager != null) {
        stateManager?.changeCellValue(
          stateManager!.currentCell!,
          stateManager!.currentCell!.value == "true" ? "false" : "true",
          force: true,
          callOnChangedEvent: true,
          notify: true,
        );
      }
    }
  }

  OnUndoSpot() {
    var undoSpotList = [];
    for (var i = 0; i < responseData.length; i++) {
      if (responseData[i]["selectItem"]) {
        undoSpotList.add({
          "hold": onHold,
          "booked": booked,
          "exposureaudit": expsoureSpots,
          "locationcode": selectLocation?.key ?? "",
          "channelcode": selectChannel?.key ?? "",
          "bookingnumber": responseData[i]["bookingnumber"],
          "bookingdetailcode": responseData[i]["bookingdetailcode"]
        });
      }
    }
    var payLoad = {"lstUndoSpot": undoSpotList};
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.UNDO_CANCELATION_POST_UNDO_SPOT,
        json: payLoad,
        fun: (Map map) {
          Get.back();
          if (map != null && map.toString().contains('successfully')) {
            // var msg = map['save']['message'];
            LoadingDialog.callDataSaved(
                msg: map["undoSpot"],
                callback: () {
                  // getFormLoad();
                });
          }
        });
  }

  getShow() {
    try {
      responseData.value = [];
      Map<String, dynamic> postData = {
        "hold": onHold,
        "booked": booked,
        "exposureaudit": expsoureSpots,
        "locationcode": selectLocation?.key ?? "",
        "channelcode": selectChannel?.key ?? "",
        "teldate": dateFormat(scheduleDate.text) ?? "",
        "bookingnumber": bookingNumber.text ?? ""
      };

      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.UNDO_CANCELATION_POST_SHOW,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            print("map>>>>>" + map.toString());
            if (map != null && map.containsKey("show")) {
              if (map["show"]["lstHold"] != null) {
                responseData.value = map["show"]["lstHold"];
              } else if (map["show"]["lstBooked"] != null) {
                responseData.value = map["show"]["lstBooked"];
              } else if (map["show"]["lstExposureaudit"] != null) {
                responseData.value = map["show"]["lstExposureaudit"];
              }
              update(["grid"]);
            }
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getAllLoadData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  formHandler(btn) {}

  void getChannelFocusOut() {}
}
