import 'package:get/get.dart';

import '../controllers/agency_master_controller.dart';

class AgencyMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgencyMasterController>(
      () => AgencyMasterController(),
    );
  }
}
