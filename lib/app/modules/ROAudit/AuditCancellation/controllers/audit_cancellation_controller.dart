import 'dart:async';

import 'package:bms_creditcontrol/app/modules/ROAudit/AuditCancellation/CancellationRetrieveModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/LoadingDialog.dart';
import '../../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../../controller/ConnectorControl.dart';
import '../../../../data/DropDownValue.dart';
import '../../../../providers/ApiFactory.dart';
import '../../../../providers/Utils.dart';

class AuditCancellationController extends GetxController {
  //TODO: Implement AuditCancellationController

  final count = 0.obs;

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
      cancelNoController = TextEditingController(),
      spoyAmountController = TextEditingController(),
      payModeController = TextEditingController();

  Map<String, dynamic> dataFromRO = {};
  Rx<bool> isEnable = Rx<bool>(false);

  CancellationRetrieveModel ?cancellationRetrieveModel;

  Future<String> getDataFromApi() {
    Completer<String> completer = Completer<String>();
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.RO_AUDIT_CANCELLATION_DOUBLE_CLICK,
          json: dataFromRO,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map) {
              // auditBookingModel = AuditBookingModel.fromJson(map as Map<String, dynamic>);
              cancellationRetrieveModel = CancellationRetrieveModel.fromJson(map as Map<String,dynamic>);
              completer.complete("");
            } else {
              cancellationRetrieveModel = null;
              completer.complete("");
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            cancellationRetrieveModel = null;
            completer.complete("");
          });
    } catch (e) {
      closeDialogIfOpen();
      cancellationRetrieveModel = null;
      completer.complete("");
    }
    return completer.future;
  }

  PlutoGridStateManager? stateManager;
  dataBind(){
    getDataFromApi().then((value) {
      if(cancellationRetrieveModel != null && cancellationRetrieveModel?.infoCancellationBookingList != null){
        selectedLocation.value = DropDownValue(key:dataFromRO['LocationCode'] , value:dataFromRO['LocationName'] );
        selectedChannel.value = DropDownValue(key:dataFromRO['ChannelCode'] , value:dataFromRO['ChannelName'] );
        selectedClient.value = DropDownValue(value:dataFromRO['clientName'] ,key:cancellationRetrieveModel?.infoCancellationBookingList?.clientCode??"" );
        selectedAgency.value = DropDownValue(value:dataFromRO['agencyName'] ,key:cancellationRetrieveModel?.infoCancellationBookingList?.agencyCode??"" );
        selectedBrand.value = DropDownValue(value:dataFromRO['brandName'] ,key:cancellationRetrieveModel?.infoCancellationBookingList?.brandCode??"" );
        refDateController.text = Utils.toDateFormat5(cancellationRetrieveModel?.infoCancellationBookingList?.referenceDate??"");
        // fpcEffDtController.text = Utils.toDateFormat4(auditBookingModel?.infoShowBookingList?.sGetCurrentSQLDate??"");
        // bookedDtController.text = Utils.toDateFormat4(auditBookingModel?.infoShowBookingList?.sGetCurrentSQLDate??"");
        refNoController.text = cancellationRetrieveModel?.infoCancellationBookingList?.referenceNumber??"";
        bookingNoController.text =  cancellationRetrieveModel?.infoCancellationBookingList?.bookingNumber??"";
        textController1.text =  cancellationRetrieveModel?.infoCancellationBookingList?.cancelNumber??"";
        textController2.text = cancellationRetrieveModel?.infoCancellationBookingList?.cancelMonth??"";
        dealNoController.text = cancellationRetrieveModel?.infoCancellationBookingList?.dealNumber??"";
        payRouteController.text =cancellationRetrieveModel?.infoCancellationBookingList?.payroute??"";
        payModeController.text =cancellationRetrieveModel?.infoCancellationBookingList?.payMode??"";
        executiveController.text = cancellationRetrieveModel?.infoCancellationBookingList?.personnelCode??"";
        update(['grid']);
      }
    });
  }



  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  void onInit() {
    dataFromRO = Get.arguments;
    super.onInit();
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

  void increment() => count.value++;
}
