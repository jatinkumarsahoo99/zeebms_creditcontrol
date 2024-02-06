import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../ClientEmbargoHistoryModel.dart';
import '../ClientEmbargoModel.dart';

class ClientEmbargoController extends GetxController {
  //TODO: Implement ClientEmbargoController

  final count = 0.obs;
  var selectedTab = 0.obs;
  double fixedWidth = 0.52;
  ClientEmbargoModel? clientEmbargoModel;
  PlutoGridStateManager? stateManager;
  PlutoGridStateManager? stateManagerHistory;
  TextEditingController dateController = TextEditingController();
  TextEditingController embargoNoController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  Rxn<DropDownValue> selectedClient = Rxn<DropDownValue>(null);

  ClientEmbargoHistoryModel ?clientEmbargoHistoryModel;

  getAllLoadData() {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.CLIENT_EMBARGO_ON_LOAD,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            print(">>>>>>>>>>mapData"+map.toString());
            if(map is Map && map['ceLoad'] != null &&
                map['ceLoad']['lstclientEmbs'] != null &&
                map['ceLoad']['lstclientEmbs'].length >0){
              clientEmbargoModel = ClientEmbargoModel.fromJson(map as Map<String,dynamic>);
              dateController.text = Utils.getMMDDYYYYFromDDMMYYYYInString2(clientEmbargoModel?.ceLoad?.minfromDate??"") ;
              print(">>>>>>>>>>>>>>>>>>data${clientEmbargoModel?.toJson()}");
              update(['grid1']);
            }else{
              clientEmbargoModel = null;
              update(['grid1']);
            }
          },
          failed: (map) {
            closeDialogIfOpen();

          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  getClientNameClick({String? clientCode}){
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.CLIENT_EMBARGO_GET_CLIENT_NAME_CLICK+(clientCode??""),
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['clientNameClick'] != null &&
                map['clientNameClick']['lstClient'] != null && map['clientNameClick']['lstClient'].length > 0){
            clientEmbargoHistoryModel = ClientEmbargoHistoryModel.fromJson(map as Map<String,dynamic>);
            update(['grid2']);
            }else{
              clientEmbargoHistoryModel = null;
              update(['grid2']);
            }
          },
          failed: (map) {
            closeDialogIfOpen();
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




  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getAllLoadData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  formHandler(String string) {

  }
}
