import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../providers/ApiFactory.dart';

class AgencyGroupMasterController extends GetxController {
  //TODO: Implement AgencyGroupMasterController

  final count = 0.obs;
  double fixedWidth = 0.53;



  @override
  void onInit() {
    // getAllLoadData();
    super.onInit();
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

  formHandler(String text){

  }

}
