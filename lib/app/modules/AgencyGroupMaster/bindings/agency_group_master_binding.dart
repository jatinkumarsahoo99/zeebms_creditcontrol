import 'package:get/get.dart';

import '../controllers/agency_group_master_controller.dart';

class AgencyGroupMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgencyGroupMasterController>(
      () => AgencyGroupMasterController(),
    );
  }
}
