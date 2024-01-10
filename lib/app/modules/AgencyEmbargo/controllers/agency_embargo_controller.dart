import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AgencyEmbargoController extends GetxController {
  TextEditingController date = TextEditingController(),
      embargoNo = TextEditingController(),
      reson = TextEditingController();

  var selectedTab = "Embargo List".obs;
  List<String> mainTabs = [
    "Embargo List", //0
    "Agency History", //1
  ];
  PageController pageController = PageController(initialPage: 0);
  @override
  void onInit() {
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

  formHandler(btn) {
    switch (btn) {
      case "Save":
        break;
      case "Clear":
        break;
      case "Exit":
        // print("Im in Exit");
        // try {
        //   Get.find<HomeController>().postUserGridSetting1(listStateManager: [
        //     loadInwardGrid,
        //   ]);
        // } catch (e) {
        //   print("Exit Error ===>" + e.toString());
        // }
        break;
    }
  }
}
