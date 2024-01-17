import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';
import '../GSTPlantInfoModel.dart';

class GSTPlantInfoController extends GetxController {
  //TODO: Implement GSTPlantInfoController

  final count = 0.obs;
  GSTPlantInfoModel? gstPlantInfoModel;

  PlutoGridStateManager? stateManager;
  List<Map<String,Map<String, double>>>? userGridSetting1=[];

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    fetchUserSetting1();
    super.onInit();
  }
  getData(){
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.GET_PLANT_INFO_LOAD,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['load'] != null && map['load'].length >0){
              gstPlantInfoModel = GSTPlantInfoModel.fromJson(map as Map<String,dynamic>);
              update(["grid"]);
            }else{
              gstPlantInfoModel = null;
              update(["grid"]);
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
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  formHandler(String text){
    if(text == 'Exit'){
      Get.find<HomeController>().postUserGridSetting1(
          listStateManager: [
            stateManager
          ],tableNamesList: ['tbl1']);
    }
  }

  void increment() => count.value++;
}
