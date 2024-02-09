import 'dart:async';

// import 'package:bms_creditcontrol/widgets/PlutoGridExport/lib/pluto_grid_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../SecondaryAsrunGridModel.dart';

class SecondaryAsrunModificationController extends GetxController {
  //TODO: Implement SecondaryAsrunModificationController

  final count = 0.obs;

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  TextEditingController logDateController = TextEditingController();

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  PlutoGridStateManager? stateManager;

  var canDialogShow = false.obs;
  Widget? dialogWidget;
  Rxn<int> initialOffset = Rxn<int>(null);
  Completer<bool>? completerDialog;

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

  formHandler(String text) {}

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
        "locationcode": selectedLocation?.key??"",
        "channelcode": selectedChannel?.key??"",
        "scheduledate":logDateController.text?? ""
      };

      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.SECONDARY_ASRUN_MODIFICATION_BIND_GRID,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['bindGrid'] != null){
              secondaryAsrunGridModel = SecondaryAsrunGridModel.fromJson(map as Map<String,dynamic>);
              update(['grid']);
            }else{
              secondaryAsrunGridModel = null;
              update(['grid']);
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            secondaryAsrunGridModel = null;
            update(['grid']);
          });

    } catch (e) {
      closeDialogIfOpen();
      secondaryAsrunGridModel = null;
      update(['grid']);
    }
  }
}
