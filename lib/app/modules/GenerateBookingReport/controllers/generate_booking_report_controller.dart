import 'package:get/get.dart';

import '../../../../widgets/CheckBox/multi_check_box.dart';

class GenerateBookingReportController extends GetxController {
  //TODO: Implement GenerateBookingReportController

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

  void increment() => count.value++;
}
