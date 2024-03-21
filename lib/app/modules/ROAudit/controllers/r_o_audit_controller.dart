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
  PlutoGridStateManager? stateManager1;
  PlutoGridStateManager? stateManager2;
  PlutoGridStateManager? stateManager3;
  Map<String, dynamic> responseData = {'report': []};

 /* (String x,String y)funTest(){
    return ("x","y");
  }*/


  TextEditingController scheduleDateController = TextEditingController();

  List<Map<String,Map<String, double>>>? userGridSetting1 = [];



  Rx<bool>additionClick = Rx<bool>(false);

  Color backColor = const Color(0xFFE7ECEF);
  Rx<double> blur = Rx<double>(30);
  Rx<Offset> distance = Rx<Offset>( Offset(10,10));
  Rx<int> selectedInt = Rx<int>(0);
  Rx<String> selectTab = Rx<String>("Additions");
  formHandler(String sta) {
    if(sta == "Exit"){
      Get.find<HomeController>().postUserGridSetting1(
          listStateManager: [
            stateManager1,
            stateManager2,
            stateManager3,
          ],tableNamesList: ["tbl1","tbl2","tbl3"]);
    }
    if(sta == "Clear"){
      clearAll();
    }

  }

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
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
    if(selectLocation != null && selectChannel != null){
      try {
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "strType": name ?? "",
          "LocationCode": selectLocation?.key ?? "",
          "ChannelCode": selectChannel?.key ?? "",
          "DtpDate": Utils.getMMDDYYYYFromDDMMYYYYInString(scheduleDateController.text ?? "")
        };
        Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
            api: ApiFactory.RO_AUDIT_SHOW_DETAILS,
            json: postData,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map) {
                roAuditRetrieveModel = ROAuditRetrieveModel.fromJson(map as Map<String, dynamic>);
                update(['grid']);
              } else {
                roAuditRetrieveModel = null;
                update(['grid']);
              }
            },
            failed: (map) {
              closeDialogIfOpen();
              roAuditRetrieveModel = null;
              update(['grid']);
            });
      } catch (e) {
        closeDialogIfOpen();
        roAuditRetrieveModel = null;
        update(['grid']);
      }
    }
  }

  String getTableNo(int ? key){
    switch(key){
      case 0:
        return "tbl1";
        break;
      case 1:
        return "tbl2";
        break;
      case 2:
        return "tbl3";
        break;
      case 3:
        return "tbl4";
        break;
      case 4:
        return "tbl5";
        break;
      default:
        return "tbl1";
        break;
    }
  }

  @override
  void onInit() {
    fetchUserSetting1();
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
