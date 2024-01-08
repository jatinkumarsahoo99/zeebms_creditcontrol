import 'package:get/get.dart';

import '../controllers/currency_type_master_controller.dart';

class CurrencyTypeMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurrencyTypeMasterController>(
      () => CurrencyTypeMasterController(),
    );
  }
}
