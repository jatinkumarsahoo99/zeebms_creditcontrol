import 'package:get/get.dart';

import '../controllers/audit_cancellation_controller.dart';

class AuditCancellationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuditCancellationController>(
      () => AuditCancellationController(),
    );
  }
}
