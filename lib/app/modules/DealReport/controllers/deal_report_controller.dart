import 'dart:async';

import 'package:bms_creditcontrol/widgets/CheckBox/multi_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../DealReportModel.dart';

class DealReportController extends GetxController {
  //TODO: Implement DealReportController

  final count = 0.obs;
  var channelsList = RxList<MultiCheckBoxModel>();
  var clientList = RxList<MultiCheckBoxModel>();
  var agencyList = RxList<MultiCheckBoxModel>();
  RxList<DropDownValue> locationList = RxList([]);
  TextEditingController formDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  Rxn<DropDownValue> selectedLocation = Rxn<DropDownValue>(null);
  FocusNode clientFocus = FocusNode();
  FocusNode clientFocus1 = FocusNode();
  FocusNode locationFocus = FocusNode();
  // FocusNode channelFocus = FocusNode();
  FocusNode channelFocus1 = FocusNode();
  FocusNode agencyFocus = FocusNode();
  FocusNode agencyFocus1 = FocusNode();

  callOnLoad() {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.DEAL_REPORT_LOAD,
          fun: (map) {
            closeDialogIfOpen();
            // if (map is List && map.isNotEmpty) {
            if (map is Map && map['dealReportOnLoad'] != null) {
              if (map['dealReportOnLoad']['lstLocationMaster'] != null &&
                  map['dealReportOnLoad']['lstLocationMaster'].length > 0) {
                locationList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['dealReportOnLoad']['lstLocationMaster'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "locationCode", "locationName"));
                });
                locationList.addAll(dataList);
                locationList.refresh();
              }

              if (map['dealReportOnLoad']['lstChannelMaster'] != null &&
                  map['dealReportOnLoad']['lstChannelMaster'].length > 0) {
                channelsList.clear();
                var i = 0;
                map['dealReportOnLoad']['lstChannelMaster'].forEach((e) {
                  channelsList.add(
                      MultiCheckBoxModel(DropDownValue.fromJsonDynamic(e,"channelcode","channelname"), false, i));
                  i++;
                });
                i = 0;
              }
            }

            // } else {
            //   locationList.clear();
            // }
          },
        failed: (map){
          closeDialogIfOpen();
          LoadingDialog.showErrorDialog((map??"").toString());
        },
          );
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  Future<void>channelLeave() {
    Completer<String> completer = Completer<String>();
    try {

      List<DropDownValue> selectChannel = [];
      for (var element in channelsList) {
        if (element.isSelected ?? false) {
          selectChannel.add(element.val!);
        }
      }
      if(  selectChannel.isNotEmpty){
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "lstChannelMaster": selectChannel.map((e) => e.toJson1(keyNew:"channelcode" ,valueNew: "channelname")).toList(),
          "locationcode": selectedLocation.value?.key?? ""
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.DEAL_REPORT_CHANNEL_LEAVE,
            json: postData,
            failed: (map){
              closeDialogIfOpen();
              LoadingDialog.showErrorDialog((map??"").toString());
              completer.complete("");
            },
            fun: (map) {
              closeDialogIfOpen();
              // if (map is List && map.isNotEmpty) {
              if (map is Map && map['onLeaveChannel'] != null) {
                if (map['onLeaveChannel']['lstClientRes'] != null &&
                    map['onLeaveChannel']['lstClientRes'].length > 0) {
                  clientList.clear();
                  var i = 0;
                  map['onLeaveChannel']['lstClientRes'].forEach((e) {
                    clientList.add(
                        MultiCheckBoxModel(DropDownValue.fromJsonDynamic(e,"clientcode","clientname"), false, i));
                    i++;
                  });
                  i = 0;
                }
              }
              completer.complete("");
              // clientFocus1.requestFocus();

              // } else {
              //   locationList.clear();
              // }
            });
      }

    } catch (e) {
      closeDialogIfOpen();
      completer.complete("");
    }
    return completer.future;
  }

  clientLeave() {
    try {
      List<DropDownValue> selectClient = [];
      for (var element in clientList) {
        if (element.isSelected ?? false) {
          selectClient.add(element.val!);
        }
      }
      if(  selectClient.isNotEmpty){
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "lstClient": selectClient.map((e) => e.toJson1(keyNew:"clientcode" ,valueNew: "clientname")).toList(),
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.DEAL_REPORT_CLIENT_LEAVE,
            json: postData,
            failed: (map){
              closeDialogIfOpen();
              LoadingDialog.showErrorDialog((map??"").toString());
            },
            fun: (map) {
              closeDialogIfOpen();
              // if (map is List && map.isNotEmpty) {
              if (map is Map && map['onLeaveClient'] != null) {
                if (map['onLeaveClient']['lstagencyRes'] != null &&
                    map['onLeaveClient']['lstagencyRes'].length > 0) {
                  agencyList.clear();
                  var i = 0;
                  map['onLeaveClient']['lstagencyRes'].forEach((e) {
                    agencyList.add(
                        MultiCheckBoxModel(DropDownValue.fromJsonDynamic(e,"agencycode","agencyname"), false, i));
                    i++;
                  });
                  i = 0;
                }
              }
              agencyFocus1.requestFocus();


              // } else {
              //   locationList.clear();
              // }
            });
      }

    } catch (e) {
      closeDialogIfOpen();
    }
  }
  DealReportModel ?dealReportModel;
  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1 = [];
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }
  generateCall(){
    try {
      List<DropDownValue> selectAgency = [];
      for (var element in agencyList) {
        if (element.isSelected ?? false) {
          selectAgency.add(element.val!);
        }
      }
      if(  selectAgency.isNotEmpty){
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "lstagency": selectAgency.map((e) => e.toJson1(keyNew:"agencycode" ,valueNew: "agencyname")).toList(),
          "locationcode":selectedLocation.value?.key??"",
          "fromdate":Utils.getMMDDYYYYFromDDMMYYYYInString2(formDateController.text),
          "todate":Utils.getMMDDYYYYFromDDMMYYYYInString2(toDateController.text)
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.DEAL_REPORT_CLIENT_GENERATE,
            json: postData,
            failed: (map){
              closeDialogIfOpen();
              LoadingDialog.showErrorDialog((map??"").toString());
            },
            fun: (map) {
              closeDialogIfOpen();
              // if (map is List && map.isNotEmpty) {
            if(map is Map && map['genrate'] != null && map['genrate'].length > 0){
              dealReportModel = DealReportModel.fromJson(map as Map<String,dynamic>);
              update(["grid"]);
            }else{
              dealReportModel = null;
              update(["grid"]);
            }

              // } else {
              //   locationList.clear();
              // }
            });
      }

    } catch (e) {
      closeDialogIfOpen();
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  clearAll() {
    Get.delete<DealReportController>();
    Get.find<HomeController>().clearPage1();
  }

  @override
  void onInit() {
   /* channelFocus1 = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          clientFocus1.requestFocus();
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );*/
    super.onInit();
  }

  @override
  void onReady() {
    callOnLoad();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  formHandler(String string) {
    if(string == "Clear"){
      clearAll();
    }
  }

  void increment() => count.value++;
}
