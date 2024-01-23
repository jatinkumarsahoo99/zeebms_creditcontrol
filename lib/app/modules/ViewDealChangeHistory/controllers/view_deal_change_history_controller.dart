import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';

class ViewDealChangeHistoryController extends GetxController {
  //TODO: Implement ViewDealChangeHistoryController

  var locationList = <DropDownValue>[].obs,
      channelList = <DropDownValue>[].obs,
      clientList = <DropDownValue>[].obs,
      dealNoList = <DropDownValue>[].obs;

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedClient;
  DropDownValue? selectedDealNo;

  PlutoGridStateManager? sm;

  FocusNode channelFN = FocusNode();
  FocusNode clientFN = FocusNode();

  Rxn<List<Map<String, Map<String, double>>>>? userGridSetting1 = Rxn([]);

  var gridData = [].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserSetting1();
    // channelFN.addListener(() {
    //   if (!) {

    //   }
    // });
  }

  fetchUserSetting1() async {
    userGridSetting1?.value =
        await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onReady() {
    super.onReady();
    getLoad();
  }

  getLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.VIEW_DEAL_CHANGE_HISTORY_ON_LOAD,
      fun: (map) {
        Get.back();
        locationList.clear();
        channelList.clear();
        if (map != null && map.containsKey('dealChangeHistoryOnLoad')) {
          // //Year
          if (map["dealChangeHistoryOnLoad"]['lstLocation'] != null) {
            map["dealChangeHistoryOnLoad"]['lstLocation'].forEach((e) {
              locationList.add(DropDownValue(
                  key: e['locationCode'], value: e['locationName']));
            });
            if (locationList.isNotEmpty) {
              selectedLocation = locationList.first;
            }
          }

          if (map["dealChangeHistoryOnLoad"]['lstChannel'] != null) {
            map["dealChangeHistoryOnLoad"]['lstChannel'].forEach((e) {
              channelList.add(DropDownValue(
                  key: e['channelcode'], value: e['channelname']));
            });
            // if (channelList.isNotEmpty) {
            //   selectedChannel = channelList.first;
            // }
          }
        } else {
          LoadingDialog.showErrorDialog(map);
        }
      },
      failed: (resp) {
        Get.back();
        LoadingDialog.showErrorDialog(resp);
      },
    );
  }

  onChannelLeave() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.VIEW_DEAL_CHANGE_HISTORY_ON_CHANNEL_LEAVE(
        locationCode: selectedLocation?.key ?? "",
        channelCode: selectedChannel?.key ?? "",
      ),
      fun: (map) {
        Get.back();
        clientList.clear();

        if (map != null && map.containsKey('channelLeave')) {
          // //Year
          if (map["channelLeave"] != null) {
            map["channelLeave"].forEach((e) {
              clientList.add(
                  DropDownValue(key: e['clientcode'], value: e['clientname']));
            });
          }
        } else {
          LoadingDialog.showErrorDialog(map);
        }
      },
      failed: (resp) {
        Get.back();
        LoadingDialog.showErrorDialog(resp);
      },
    );
  }

  onClientLeave() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.VIEW_DEAL_CHANGE_HISTORY_ON_CLIENT_LEAVE(
        locationCode: selectedLocation?.key ?? "",
        channelCode: selectedChannel?.key ?? "",
        clientCode: selectedClient?.key ?? "",
      ),
      fun: (map) {
        Get.back();
        dealNoList.clear();

        if (map != null && map.containsKey('clientLeave')) {
          // //Year
          if (map["clientLeave"] != null) {
            map["clientLeave"].forEach((e) {
              dealNoList.add(DropDownValue(key: "", value: e['dealnumber']));
            });
          }
        } else {
          LoadingDialog.showErrorDialog(map);
        }
      },
      failed: (resp) {
        Get.back();
        LoadingDialog.showErrorDialog(resp);
      },
    );
  }

  getDealHistory() {
    LoadingDialog.call();

    var payload = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? "",
      "dealnumber": selectedDealNo?.value ?? "",
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.VIEW_DEAL_CHANGE_HISTORY_GET_HISTORY,
        json: payload,
        fun: (map) {
          Get.back();
          if (map != null &&
              map.containsKey("history") &&
              map["history"].length > 0) {
            // //Year
            gridData.value = map["history"];
            // if (map["clientLeave"] != null) {
            //   map["clientLeave"].forEach((e) {
            //     dealNoList.add(DropDownValue(key: "", value: e['dealnumber']));
            //   });
            // }
          } else {
            LoadingDialog.showErrorDialog(map.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp);
        });
    // }
  }

  formHandler(btn) {
    switch (btn) {
      case "Clear":
        // callClear() {

        Get.delete<ViewDealChangeHistoryController>();
        Get.find<HomeController>().clearPage1();
        // }
        break;
      case "Save":
        break;
      case "Delete":
        break;
      case "Refresh":
        break;
      case "Exit":
        print("Im in Exit");
        try {
          Get.find<HomeController>().postUserGridSetting1(listStateManager: [
            sm,
          ]);
        } catch (e) {
          print("Exit Error ===>" + e.toString());
        }
        break;
      case "Docs":
        break;
      case "Search":
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
