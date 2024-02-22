import 'package:get/get.dart';

import '../controllers/audit_reschedule_controller.dart';

class AuditRescheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuditRescheduleController>(
      () => AuditRescheduleController(),
    );
  }
}
