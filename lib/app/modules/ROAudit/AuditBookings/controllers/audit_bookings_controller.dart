import 'dart:async';

import 'package:bms_creditcontrol/app/modules/ROAudit/AuditBookings/AuditBookingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/LoadingDialog.dart';
import '../../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../../controller/ConnectorControl.dart';
import '../../../../data/DropDownValue.dart';
import '../../../../providers/ApiFactory.dart';
import '../../../../providers/Utils.dart';

class AuditBookingsController extends GetxController {
  //TODO: Implement AuditBookingsController

  // final count = 0.obs;
  var gridData = [].obs;

  var locationList = <DropDownValue>[].obs;
  var channelList = <DropDownValue>[].obs;

  // channelList = <DropDownValue>[].obs;
  Rxn<DropDownValue> selectedLocation = Rxn<DropDownValue>(null),
      selectedChannel = Rxn<DropDownValue>(null),
      selectedClient = Rxn<DropDownValue>(null),
      selectedAgency = Rxn<DropDownValue>(null),
      selectedBrand = Rxn<DropDownValue>(null);

  final refNoController = TextEditingController(),
      refDateController = TextEditingController(),
      fpcEffDtController = TextEditingController(),
      bookedDtController = TextEditingController(),
      bookingNoController = TextEditingController(),
      textController1 = TextEditingController(),
      textController2 = TextEditingController(),
      textController3 = TextEditingController(),
      dealNoController = TextEditingController(),
      payRouteController = TextEditingController(),
      executiveController = TextEditingController(),
      payModeController = TextEditingController();



  var canDialogShow = false.obs;
  Widget? dialogWidget;
  Rxn<int> initialOffset = Rxn<int>(null);

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

  Rx<bool> isEnable = Rx<bool>(false);

  Map<String, dynamic> dataFromRO = {};
  @override
  void onInit() {
    dataFromRO = Get.arguments;
    print(">>>>>>>>>>>>>data${dataFromRO}");
    super.onInit();
  }

  AuditBookingModel? auditBookingModel;

  Future<String> getDataFromApi() {
    Completer<String> completer = Completer<String>();
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.RO_AUDIT_ADDITION_CELL_DOUBLE_CLICK,
          json: dataFromRO,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map) {
              auditBookingModel = AuditBookingModel.fromJson(map as Map<String, dynamic>);
              completer.complete("");
            } else {
              auditBookingModel = null;
              completer.complete("");
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            auditBookingModel = null;
            completer.complete("");
          });
    } catch (e) {
      closeDialogIfOpen();
      auditBookingModel = null;
      completer.complete("");
    }
    return completer.future;
  }

  dataBind() {
    getDataFromApi().then((value) {
      if (auditBookingModel != null) {
        selectedLocation.value = DropDownValue(key:dataFromRO['LocationCode'] , value:dataFromRO['LocationName'] );
        selectedChannel.value = DropDownValue(key:dataFromRO['ChannelCode'] , value:dataFromRO['ChannelName'] );
        selectedClient.value = DropDownValue(value:dataFromRO['clientName'] ,key:auditBookingModel?.infoShowBookingList?.clientCode??"" );
        selectedAgency.value = DropDownValue(value:dataFromRO['agencyName'] ,key:auditBookingModel?.infoShowBookingList?.agencyCode??"" );
        selectedBrand.value = DropDownValue(value:dataFromRO['brandName'] ,key:auditBookingModel?.infoShowBookingList?.brandCode??"" );
        refDateController.text = Utils.toDateFormat5(auditBookingModel?.infoShowBookingList?.bookingRefDate??"");
        fpcEffDtController.text = Utils.toDateFormat4(auditBookingModel?.infoShowBookingList?.sGetCurrentSQLDate??"");
        bookedDtController.text = Utils.toDateFormat4(auditBookingModel?.infoShowBookingList?.sGetCurrentSQLDate??"");
        refNoController.text = auditBookingModel?.infoShowBookingList?.bookingRefNumber??"";
        bookingNoController.text = auditBookingModel?.infoShowBookingList?.bookingNumber??"";
        textController1.text = auditBookingModel?.infoShowBookingList?.bookingNumber??"";
        textController2.text = auditBookingModel?.infoShowBookingList?.zoneName??"";
        dealNoController.text = auditBookingModel?.infoShowBookingList?.remarks??"";
        payRouteController.text = auditBookingModel?.infoShowBookingList?.payRouteName??"";
        payModeController.text = auditBookingModel?.infoShowBookingList?.payMode??"";
        executiveController.text = auditBookingModel?.infoShowBookingList?.personnelCode??"";
        update(['grid']);
      }
    });
  }
  PlutoGridStateManager? stateManager;
  PlutoGridStateManager? spotGridManager;
  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  void onReady() {
    dataBind();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void increment() => count.value++;
}
