import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';

class PlaceTypeMasterController extends GetxController {
  //TODO: Implement PlaceTypeMasterController

  final count = 0.obs;
  TextEditingController placeTypeMasterController = TextEditingController();
  FocusNode placeTypeFocus = FocusNode();
  String? placeTypeCode;
  @override
  void onInit() {
    placeTypeFocus = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          getRetrieveRecord();
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
    super.onInit();
  }

  getRetrieveRecord() {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "PlaceTypeCode": placeTypeCode ?? "",
        "PlaceTypeName": placeTypeMasterController.text ?? ""
      };

      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.PLACE_TYPE_MASTER_GET_RETRIEVE_RECORD,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['retrieveRecord'] != null && map['retrieveRecord'].length > 0 && map['retrieveRecord'][0]['placeTypeCode'] != null){
              placeTypeCode = map['retrieveRecord'][0]['placeTypeCode'];
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            LoadingDialog.showErrorDialog(map.toString());
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  save(){
    if(placeTypeCode != null && placeTypeCode != "" && placeTypeCode != "0"){
      LoadingDialog.modify ("Record Already exist!\nDo you want to modify it?",(){
        // saveCall();
      },(){
        saveCall();
      },cancelTitle: "Yes",deleteTitle:"No" );
    }else{
      saveCall();
    }
  }

  saveCall(){
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "placeTypeCode": placeTypeCode ?? "",
        "placeTypeName": placeTypeMasterController.text ?? ""
      };

      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.PLACE_TYPE_MASTER_POST_SAVE,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['save'] != null && map['save'] != ""){
              LoadingDialog.callDataSaved(callback:(){
                placeTypeCode = null;
                placeTypeMasterController.text = "";
                // clearAll();
              } ,msg: map['save']??"");
            }else{
              LoadingDialog.showErrorDialog(map.toString());
            }

          },
          failed: (map) {
            closeDialogIfOpen();
            LoadingDialog.showErrorDialog(map.toString());
          });
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
    Get.delete<PlaceTypeMasterController>();
    Get.find<HomeController>().clearPage1();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  formHandler(String string) {
    if (string == "Clear") {
      clearAll();
    }else if(string == "Save"){
      save();
    }
  }
}
