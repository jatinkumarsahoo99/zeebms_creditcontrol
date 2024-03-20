import 'dart:async';

import 'package:bms_creditcontrol/app/modules/ROAudit/AuditBookings/AuditBookingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../widgets/CheckBoxWidget.dart';
import '../../../../../widgets/FormButton.dart';
import '../../../../../widgets/LoadingDialog.dart';
import '../../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../../controller/ConnectorControl.dart';
import '../../../../controller/HomeController.dart';
import '../../../../data/DropDownValue.dart';
import '../../../../providers/ApiFactory.dart';
import '../../../../providers/Utils.dart';
import '../../../CommonDocs/controllers/common_docs_controller.dart';
import '../../../CommonDocs/views/common_docs_view.dart';

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
      refDateController = TextEditingController(text: DateFormat("dd-MMM-yyyy").format(DateTime.now())),
      fpcEffDtController = TextEditingController(),
      bookedDtController = TextEditingController(),
      bookingNoController = TextEditingController(),
      textController1 = TextEditingController(),
      textController2 = TextEditingController(),
      textController3 = TextEditingController(),
      dealNoController = TextEditingController(),
      payRouteController = TextEditingController(),
      executiveController = TextEditingController(),
      remarkController = TextEditingController(),
      pdcController = TextEditingController(),
      maxSpendControllerDialog = TextEditingController(),
      payModeController = TextEditingController();



  var canDialogShow = false.obs;
  Widget? dialogWidget;
  Rxn<int> initialOffset = Rxn<int>(null);

  Rx<bool> isPDCEntered = Rx<bool>(false);

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

  dragValidation({bool? dealRows = false,
    bool? buildValue = false,
    bool? bookingExceeds = false,
    bool? clientUnder = false ,
    bool? agencyUnder = false,
    bool? commercialDur = false}) {
    initialOffset.value = 1;
    // Completer<bool> completer = Completer<bool>();
    dialogWidget = Material(
      color: Colors.white,
      // borderRadius: BorderRadius.circular(7),
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.35,
          height: Get.height * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 24,
                // color: Colors.grey[200],
                child: Stack(
                  fit: StackFit.expand,
                  // alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Validation',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          dialogWidget = null;
                          canDialogShow.value = false;
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              CheckBoxWidget1(title: "Deal Rows With Negative Balances", isEnable: dealRows??false,value:dealRows??false ,),
              CheckBoxWidget1(title: "Build Value is Less than Booked Value", isEnable: buildValue??false,value:buildValue??false ),
              CheckBoxWidget1(title: "Booking Exceeds Max Spend in Deal", isEnable: bookingExceeds??false,value: bookingExceeds??false),
              CheckBoxWidget1(title: "Client Under embargo", isEnable:clientUnder?? false,value:clientUnder?? false ,),
              CheckBoxWidget1(title: "Agency Under Embargo", isEnable: agencyUnder??false,value:agencyUnder??false ),
              CheckBoxWidget1(title: "Commercial Duration Mismatch", isEnable: commercialDur??false,value: commercialDur??false),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormButtonWrapper(
                    btnText: "DONE",
                    showIcon: false,
                    // isEnabled: btn['isDisabled'],
                    callback: () {
                      dialogWidget = null;
                      canDialogShow.value = false;
                    },
                  )
                ],
              ),
              SizedBox(
                height: 2,
              )
            ],
          ),
        ),
      ),
    );
    canDialogShow.value = true;
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
  List<LstBookingDetails> ?spotFilterList = [];

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

        refDateController.text = Utils.toDateFormat7(auditBookingModel?.infoShowBookingList?.bookingRefDate??"");
        print(">>>>>>>>>>>>refDate${refDateController.text}");
        // update(['date']);
         auditBookingModel?.infoShowBookingList?.displayBookingStatus?.lstBookingDetails?.forEach((element) {
           spotFilterList?.add(element);
        });

        // fpcEffDtController.text = Utils.toDateFormat4(auditBookingModel?.infoShowBookingList?.sGetCurrentSQLDate??"");
        // bookedDtController.text = Utils.toDateFormat4(auditBookingModel?.infoShowBookingList?.sGetCurrentSQLDate??"");
        refNoController.text = auditBookingModel?.infoShowBookingList?.bookingRefNumber??"";
        bookingNoController.text =dataFromRO["BookingMonth"]??"";
        textController1.text = auditBookingModel?.infoShowBookingList?.bookingNumber??"";
        textController2.text = auditBookingModel?.infoShowBookingList?.zoneName??"";
        dealNoController.text = auditBookingModel?.infoShowBookingList?.remarks??"";
        payRouteController.text = auditBookingModel?.infoShowBookingList?.payRouteName??"";
        payModeController.text = auditBookingModel?.infoShowBookingList?.payMode??"";
        executiveController.text = auditBookingModel?.infoShowBookingList?.personnelCode??"";

        if((auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkDealNegativeBalance??false) ||
            (auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkValuation??false) ||
            (auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkMaxSpendcheck??false) ||
            (auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkClientEmbargo??false) ||
            (auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkAgencyEmbargo??false) ||
            (auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkAgencyEmbargo??false)
        ){
          dragValidation(
            dealRows: auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkDealNegativeBalance??false,
            buildValue: auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkValuation??false,
            bookingExceeds: auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkMaxSpendcheck??false,
            clientUnder: auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkClientEmbargo??false,
            agencyUnder: auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkAgencyEmbargo??false,
            commercialDur: auditBookingModel?.infoShowBookingList?.dislpayDealDetails?.chkCommDurMismatch??false,
          );
        }

        if(auditBookingModel?.infoShowBookingList?.isPdcEnterd == "1"){
          remarkController.text = auditBookingModel?.infoShowBookingList?.remark??"";
          pdcController.text = auditBookingModel?.infoShowBookingList?.pdcInfo??"";
          isPDCEntered.value = true;
          isPDCEntered.refresh();
        }else{
          remarkController.text = "";
          pdcController.text = "";
          isPDCEntered.value = false;
          isPDCEntered.refresh();
        }
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


  saveFunCall(){
    try{
      LoadingDialog.call();
      Map<String,dynamic> postData = {
        "lstSpots": auditBookingModel?.infoShowBookingList
            ?.displayDetails?.lstSpot?.map((e) => e.toJson()).toList(),
        "locationCode": dataFromRO['LocationCode']??"",
        "channelCode": dataFromRO['ChannelCode']??"",
        "bookingMonth": dataFromRO['BookingMonth']??"",
        "bookingNumber":dataFromRO['BookingNumber']??""
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.RO_AUDIT_AUDIT_DITION_POST,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['infoSave'] != null && map['infoSave']['message'] != ""){
              LoadingDialog.callDataSaved2(msg: (map['infoSave']['message']??"").toString(),callback: (){
                Get.back(result: true);
              });
            }else{
              LoadingDialog.showErrorDialog((map??"Something went wrong").toString());
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    }catch(e){
      closeDialogIfOpen();
    }
  }

  clearAll() {
    Get.delete<AuditBookingsController>();
    Get.find<HomeController>().clearPage1();
  }

  docs() async {
    String documentKey = "";
    if (dataFromRO['LocationCode'] == "" || dataFromRO['ChannelCode'] == "" ||
        dataFromRO['BookingMonth'] == "" || dataFromRO['BookingNumber'] == "") {
      documentKey = "";
    } else {
      documentKey = "RObooking ${dataFromRO['LocationCode']}${dataFromRO['ChannelCode']}${dataFromRO['BookingMonth']}${dataFromRO['BookingNumber']}";
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

  btnAudit(){
    try{
      LoadingDialog.call();
      Map<String,dynamic> postData = {
        "locationCode": dataFromRO['LocationCode']??"",
        "channelCode": dataFromRO['ChannelCode']??"",
        "bookingMonth": dataFromRO['BookingMonth']??"",
        "bookingNumber": dataFromRO['BookingNumber']??"",
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.RO_AUDIT_AUDIT_RESCHEDULE_MARK_AS_UN_AUDIT,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['infoUnAudit'] != null && map['infoUnAudit']['message'] != null){
              LoadingDialog.callDataSaved(msg: (map['infoUnAudit']['message']??"").toString());
            }else{
              LoadingDialog.showErrorDialog((map??"Something went wrong").toString());
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    }catch(e){
      closeDialogIfOpen();
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
