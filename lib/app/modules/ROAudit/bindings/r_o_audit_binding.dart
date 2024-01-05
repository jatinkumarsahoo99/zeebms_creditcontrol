import 'package:get/get.dart';

import '../controllers/r_o_audit_controller.dart';

class ROAuditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ROAuditController>(
      () => ROAuditController(),
    );
  }
}
