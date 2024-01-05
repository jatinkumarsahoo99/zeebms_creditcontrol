import 'package:get/get.dart';

import '../controllers/company_master_controller.dart';

class CompanyMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyMasterController>(
      () => CompanyMasterController(),
    );
  }
}
