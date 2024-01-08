import 'package:get/get.dart';

import '../controllers/credit_rate_master_controller.dart';

class CreditRateMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreditRateMasterController>(
      () => CreditRateMasterController(),
    );
  }
}
