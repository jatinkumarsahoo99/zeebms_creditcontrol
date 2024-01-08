import 'package:get/get.dart';

import '../controllers/payroute_category_master_controller.dart';

class PayrouteCategoryMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayrouteCategoryMasterController>(
      () => PayrouteCategoryMasterController(),
    );
  }
}
