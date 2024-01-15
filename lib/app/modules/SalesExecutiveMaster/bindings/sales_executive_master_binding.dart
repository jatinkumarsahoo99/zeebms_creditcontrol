import 'package:get/get.dart';

import '../controllers/sales_executive_master_controller.dart';

class SalesExecutiveMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesExecutiveMasterController>(
      () => SalesExecutiveMasterController(),
    );
  }
}
