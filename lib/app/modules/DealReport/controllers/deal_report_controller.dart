import 'package:bms_creditcontrol/widgets/CheckBox/multi_check_box.dart';
import 'package:get/get.dart';

class DealReportController extends GetxController {
  //TODO: Implement DealReportController

  final count = 0.obs;
  var channels = RxList<MultiCheckBoxModel>();


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

  formHandler(String string) {

  }

  void increment() => count.value++;
}
