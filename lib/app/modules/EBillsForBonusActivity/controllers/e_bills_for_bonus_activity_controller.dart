import 'package:get/get.dart';

class EBillsForBonusActivityController extends GetxController {
  //TODO: Implement EBillsForBonusActivityController

  final count = 0.obs;
  RxnString selectExportType = RxnString("Agency");
  RxnString selRadio = RxnString("ATL");
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
