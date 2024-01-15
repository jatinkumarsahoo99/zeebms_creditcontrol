import 'package:get/get.dart';

import '../controllers/e_bill_agency_group_master_controller.dart';

class EBillAgencyGroupMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EBillAgencyGroupMasterController>(
      () => EBillAgencyGroupMasterController(),
    );
  }
}
