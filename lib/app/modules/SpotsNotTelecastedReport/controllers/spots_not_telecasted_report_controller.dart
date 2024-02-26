import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';

class SpotsNotTelecastedReportController extends GetxController {
  //TODO: Implement SpotsNotTelecastedReportController

  // final count = 0.obs;
  var locationList = <DropDownValue>[].obs;
  var channelList = <DropDownValue>[].obs;

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  final tecFromDate = TextEditingController().obs;
  final tecToDate = TextEditingController().obs;

  Rxn<List<Map<String, Map<String, double>>>>? userGridSetting1 = Rxn([]);

  var gridData = [].obs;

  PlutoGridStateManager? sm;

  @override
  void onInit() {
    super.onInit();
    fetchUserSetting1();
  }

  @override
  void onReady() {
    super.onReady();
    getLoad();
  }

  fetchUserSetting1() async {
    userGridSetting1?.value =
        await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  getLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.SPOT_NOT_TELECASTED_REPORT_ONLOAD,
      fun: (map) {
        Get.back();
        // locationList.clear();
        // channelList.clear();
        if (map != null &&
            map.containsKey('spotsNotTelecastedLoad') &&
            map["spotsNotTelecastedLoad"] != null) {
          // //Year
          if (map["spotsNotTelecastedLoad"]['lstLocation'] != null) {
            map["spotsNotTelecastedLoad"]['lstLocation'].forEach((e) {
              locationList.add(DropDownValue(
                  key: e['locationCode'], value: e['locationName']));
            });
            // if (locationList.isNotEmpty) {
            //   selectedLocation = locationList.first;
            // }
          }

          if (map["spotsNotTelecastedLoad"]['lstChannel'] != null) {
            map["spotsNotTelecastedLoad"]['lstChannel'].forEach((e) {
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

  getReport() {
    if (selectedChannel == null) {
      LoadingDialog.showErrorDialog("Please select channel");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.SPOT_NOT_TELECASTED_REPORT_GET_REPORT(
          locationCode: selectedLocation?.key ?? "",
          channelCode: selectedChannel?.key ?? "",
          fromDate: DateFormat("MM/dd/yyyy")
              .format(DateFormat("dd-MM-yyyy").parse(tecFromDate.value.text)),
          toDate: DateFormat("MM/dd/yyyy")
              .format(DateFormat("dd-MM-yyyy").parse(tecToDate.value.text)),
        ),
        fun: (map) {
          Get.back();
          gridData.value = [];
          // locationList.clear();
          // channelList.clear();
          if (map != null &&
              map.containsKey('genrate') &&
              map["genrate"].isNotEmpty) {
            // //Year
            gridData.value = map["genrate"];
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp);
        },
      );
    }
  }

  formHandler(btn) {
    switch (btn) {
      case "Clear":
        // callClear() {

        Get.delete<SpotsNotTelecastedReportController>();
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

  // void increment() => count.value++;
}
