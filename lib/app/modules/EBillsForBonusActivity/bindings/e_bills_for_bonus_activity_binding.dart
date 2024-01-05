import 'package:get/get.dart';

import '../controllers/e_bills_for_bonus_activity_controller.dart';

class EBillsForBonusActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EBillsForBonusActivityController>(
      () => EBillsForBonusActivityController(),
    );
  }
}
