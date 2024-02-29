import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/pluto_grid.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../ROAuditRetrieveModel.dart';

class ROAuditController extends GetxController {
  //TODO: Implement ROAuditController

  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);


  DropDownValue? selectLocation;
  DropDownValue? selectChannel;

  PlutoGridStateManager? stateManager;
  Map<String, dynamic> responseData = {'report': []};

  TextEditingController scheduleDateController = TextEditingController();

  List<Map<String,Map<String, double>>>? userGridSetting1;

  Rx<bool>additionClick = Rx<bool>(false);

  Color backColor = const Color(0xFFE7ECEF);
  Rx<double> blur = Rx<double>(30);
  Rx<Offset> distance = Rx<Offset>( Offset(10,10));
  Rx<int> selectedInt = Rx<int>(0);
  Rx<String> selectTab = Rx<String>("Additions");
  formHandler(String sta) {
    if(sta == "Clear"){
      clearAll();
    }

  }

  clearAll() {
    Get.delete<ROAuditController>();
    Get.find<HomeController>().clearPage1();
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  fetchAllLoaderData() {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.RO_AUDIT_ON_LOAD,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['onload'] != null){
              RxList<DropDownValue> dataList = RxList([]);
              map['onload']['lstLocation'].forEach((e) {
                dataList.add(DropDownValue.fromJsonDynamic(e, "locationCode", "locationName"));
              });
              locationList.addAll(dataList);
              locationList.refresh();
            }

          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  getChannel({String? locationCode}){
    if(locationCode != null && locationCode != ""){
      try{
        LoadingDialog.call();
        Get.find<ConnectorControl>().GETMETHODCALL(
            api: ApiFactory.RO_AUDIT_ON_LOCATION_LEAVE+locationCode,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if(map is Map && map['infoChannelList'] != null){
                RxList<DropDownValue> dataList = RxList([]);
                map['infoChannelList'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "channelCode", "channelName"));
                });
                channelList.addAll(dataList);
                channelList.refresh();
              }

            },
            failed: (map) {
              closeDialogIfOpen();
            });
      }catch(e){
        closeDialogIfOpen();
      }
    }
  }

  ROAuditRetrieveModel? roAuditRetrieveModel;

  showDetails({String? name}){
      try{
        LoadingDialog.call();
        Map<String,dynamic> postData = {
          "strType":name??"",
          "LocationCode":selectLocation?.key??"",
          "ChannelCode":selectChannel?.key??"",
          "DtpDate":Utils.getMMDDYYYYFromDDMMYYYYInString( scheduleDateController.text??"")
        };
        Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
            api: ApiFactory.RO_AUDIT_SHOW_DETAILS,
            json: postData,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if(map is Map){
                roAuditRetrieveModel = ROAuditRetrieveModel.fromJson(map as Map<String,dynamic>);
                update(['grid']);
              }else{
                roAuditRetrieveModel = null;
                update(['grid']);
              }
            },
            failed: (map) {
              closeDialogIfOpen();
              roAuditRetrieveModel = null;
              update(['grid']);
            });
      }catch(e){
        closeDialogIfOpen();
        roAuditRetrieveModel = null;
        update(['grid']);
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
}
