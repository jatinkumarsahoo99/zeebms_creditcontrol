import 'dart:async';

import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../../controller/ConnectorControl.dart';
import '../../../../controller/HomeController.dart';
import '../../../../data/DropDownValue.dart';
import '../../../../providers/ApiFactory.dart';
import '../../../../providers/Utils.dart';
import '../../../CommonDocs/controllers/common_docs_controller.dart';
import '../../../CommonDocs/views/common_docs_view.dart';
import '../../ReScheduleRetriveDataModel.dart';

class AuditRescheduleController extends GetxController {
  //TODO: Implement AuditRescheduleController

  final count = 0.obs;

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> clientList = RxList([]);
  RxList<DropDownValue> agencyList = RxList([]);
  RxList<DropDownValue> brandList = RxList([]);

  TextEditingController fpcEffectiveDateController = TextEditingController();
  TextEditingController reschDateController = TextEditingController();
  TextEditingController refNoController = TextEditingController();
  TextEditingController refDateController = TextEditingController();
  TextEditingController bookingNoController = TextEditingController();
  TextEditingController dealNoController = TextEditingController();
  TextEditingController reschNoController = TextEditingController();
  TextEditingController reschNo_Controller = TextEditingController();

  Rxn<DropDownValue>? selectedLocation = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedChannel = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedClient = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedAgency = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedBrand = Rxn<DropDownValue>(null);

  PlutoGridStateManager? stateManagerLeft;
  PlutoGridStateManager? stateManagerRight;

  double columnWidth = 180;

  Map<String, dynamic> dataFromRO = {};
  @override
  void onInit() {
    dataFromRO = Get.arguments;
    print(">>>>>>>>>>>>>data${dataFromRO}");
    super.onInit();
  }

  ReScheduleRetriveDataModel? reScheduleRetriveDataModel;

  Future<String> getDataFromApi() {
    Completer<String> completer = Completer<String>();
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.RO_AUDIT_RESCHEDULE_CELL_DOUBLE_CLICK,
          json: dataFromRO,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['infoReschduleBookingList'] != null) {
              reScheduleRetriveDataModel =
                  ReScheduleRetriveDataModel.fromJson(map as Map<String, dynamic>);
              completer.complete("");
            } else {
              reScheduleRetriveDataModel = null;
              completer.complete("");
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            reScheduleRetriveDataModel = null;
            completer.complete("");
          });
    } catch (e) {
      closeDialogIfOpen();
      reScheduleRetriveDataModel = null;
      completer.complete("");
    }
    return completer.future;
  }

  datBind() {
    getDataFromApi().then((value) {
      if (reScheduleRetriveDataModel != null) {
        RxList<DropDownValue> dataList1 = RxList([]);
        reScheduleRetriveDataModel?.infoReschduleBookingList?.lstLocation?.forEach((e) {
          dataList1.add(DropDownValue.fromJsonDynamic(e.toJson(), "locationCode", "locationName"));
        });
        locationList.addAll(dataList1);
        locationList.refresh();

        RxList<DropDownValue> dataList2 = RxList([]);
        reScheduleRetriveDataModel?.infoReschduleBookingList?.lstChannels?.forEach((e) {
          dataList2.add(DropDownValue.fromJsonDynamic(e.toJson(), "channelCode", "channelName"));
        });
        channelList.addAll(dataList2);
        channelList.refresh();

        fpcEffectiveDateController.text = Utils.toDateFormat4(
                reScheduleRetriveDataModel?.infoReschduleBookingList?.effectiveDate ?? "") ??
            "";

        reschDateController.text = Utils.toDateFormat4(
                reScheduleRetriveDataModel?.infoReschduleBookingList?.reschduleDate ?? "") ??
            "";

        refNoController.text =
            reScheduleRetriveDataModel?.infoReschduleBookingList?.referenceNumber ?? "";

        refDateController.text = Utils.toDateFormat4(
                reScheduleRetriveDataModel?.infoReschduleBookingList?.referenceDate ?? "") ??
            "";

        print(">>>>>>>>>>>>>>>>>>>>refDateController${refDateController.text}");

        bookingNoController.text =
            reScheduleRetriveDataModel?.infoReschduleBookingList?.bookingNumber ?? "";

        dealNoController.text =
            reScheduleRetriveDataModel?.infoReschduleBookingList?.dealNumber ?? "";

        reschNoController.text =
            reScheduleRetriveDataModel?.infoReschduleBookingList?.rescheduleMonth ?? "";
        reschNo_Controller.text =
            reScheduleRetriveDataModel?.infoReschduleBookingList?.rescheduleNumber ?? "";

        selectedClient?.value = DropDownValue(
            key: reScheduleRetriveDataModel?.infoReschduleBookingList?.clientcode ?? "",
            value: dataFromRO['clientName'] ?? "");

        selectedAgency?.value = DropDownValue(
            key: reScheduleRetriveDataModel?.infoReschduleBookingList?.agencyCode ?? "",
            value: dataFromRO['agencyName'] ?? "");

        selectedBrand?.value = DropDownValue(
            key: reScheduleRetriveDataModel?.infoReschduleBookingList?.brandCode ?? "",
            value: dataFromRO['brandName'] ?? "");

        selectedLocation?.value = DropDownValue(
            key: dataFromRO['LocationCode'] ?? "",
            value: dataFromRO['LocationName'] ?? "");
        selectedChannel?.value = DropDownValue(
            key: dataFromRO['ChannelCode'] ?? "",
            value: dataFromRO['ChannelName'] ?? "");

        selectedClient?.refresh();
        selectedBrand?.refresh();
        selectedAgency?.refresh();
        selectedChannel?.refresh();
        selectedLocation?.refresh();

        update(['wrightGrid','leftGrid']);
      }
    });
  }


  saveFunCall(){
    try{
      LoadingDialog.call();
      Map<String,dynamic> postData = {
        "lstReschdule": reScheduleRetriveDataModel?.infoReschduleBookingList?.reschduleDisplay?.reschdule?.map((e) => e.toJson()).toList(),
        "locationCode": dataFromRO['LocationCode']??"",
        "channelCode": dataFromRO['ChannelCode']??"",
        "reschduleMonth": dataFromRO['ReSchedulemonth']??"",
        "reschduleNumber":dataFromRO['ReScheduleNumber']??"",
        "bookingNumber":dataFromRO['BookingNumber']??"",
        "brandCode":reScheduleRetriveDataModel?.infoReschduleBookingList?.brandCode??""
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.RO_AUDIT_AUDIT_RESCHEDULE_SAVE,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['infoSaveReschdule'] != null && map['infoSaveReschdule']['message'] != null){
              LoadingDialog.callDataSaved2(msg: (map['infoSaveReschdule']['message']??"").toString(),callback: (){
                datBind();
              });
            }else{
              LoadingDialog.showErrorDialog((map??"Something went wrong").toString());
            }
            // datBind();
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    }catch(e){
      closeDialogIfOpen();
    }
  }

  clearAll() {
    Get.delete<AuditRescheduleController>();
    Get.find<HomeController>().clearPage1();
  }

  docs() async {
    String documentKey = "";
    if (dataFromRO['LocationCode'] == "" || dataFromRO['ChannelCode'] == "" ||
        dataFromRO['BookingMonth'] == "" || dataFromRO['BookingNumber'] == "") {
      documentKey = "";
    } else {
      documentKey = "ROReschedule ${dataFromRO['LocationCode']}${dataFromRO['ChannelCode']}${dataFromRO['ReSchedulemonth']}${dataFromRO['ReScheduleNumber']}";
    }
    if (documentKey == "") {
      return;
    }
    Get.defaultDialog(
      title: "Documents",
      content: CommonDocsView(documentKey: documentKey),
    ).then((value) {
      Get.delete<CommonDocsController>(tag: "commonDocs");
    });
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  void onReady() {
    datBind();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  formHandler(String text) {}

  void increment() => count.value++;
}
