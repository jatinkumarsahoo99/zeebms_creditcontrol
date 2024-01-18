import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class SalesExecutiveMasterController extends GetxController {
  double widthRatio = 0.4;

  DropDownValue? selectSapName;
  DropDownValue? selectCompany;
  DropDownValue? selectLocation;
  DropDownValue? selectStation;
  DropDownValue? selectPlace;
  RxString sapCode = RxString("");
  RxString executiveName = RxString("");
  RxString department = RxString("");
  RxString designation = RxString("");
  RxString mobileno = RxString("");
  RxString email = RxString("");
  RxBool isActive = RxBool(false);

  @override
  void onInit() {
    super.onInit();
  }

  getLoad() {
    /*Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_CREATION_GET_LOAD(),
        fun: (Map map) {

          // update(["listUpdate"]);
        });*/
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        break;
      case "Clear":
        Get.delete<SalesExecutiveMasterController>();
        Get.find<HomeController>().clearPage1();
        break;
    }
  }
}
