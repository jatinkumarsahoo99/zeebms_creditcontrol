import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/pluto_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/user_data_settings_model.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';

class SAPBIllCheckReportController extends GetxController {
  TextEditingController fromDt = TextEditingController();
  TextEditingController toDt = TextEditingController();

  DropDownValue? selectedR4;

  UserDataSettings? userDataSettings;

  List<dynamic>? dataList;

  PlutoGridStateManager? gridManager;

  @override
  void onInit() {
    fetchUserGridSetting();
    super.onInit();
  }

  formHandler(String type) {
    switch (type) {
      case "Save":
        break;
      case "Clear":
        Get.delete<SAPBIllCheckReportController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Exit":
        Get.find<HomeController>().postUserGridSetting2(listStateManager: [
          {"gridManager": gridManager},
        ], formName: "frmSapBillcheckreport");
        break;
    }
  }

  void showApiCall() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.SAP_BILL_CHECK_GENERATE(
            Utils.dateFormatChange(fromDt.text, "dd-MM-yyyy", "yyyy-MM-dd"),
            Utils.dateFormatChange(toDt.text, "dd-MM-yyyy", "yyyy-MM-dd"),
            (selectedR4?.key ?? "")),
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey("genrate") &&
              map["genrate"] != null &&
              map["genrate"].containsKey("lstcompany") &&
              map["genrate"]["lstcompany"] != null) {
            dataList = map["genrate"]["lstcompany"];
            update(["grid"]);
          }
        });
  }

  fetchUserGridSetting() async {
    userDataSettings = await Get.find<HomeController>()
        .fetchUserSetting2(formName: "frmSapBillcheckreport");
  }
}
