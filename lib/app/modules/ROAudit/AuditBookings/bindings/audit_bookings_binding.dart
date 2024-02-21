import 'package:get/get.dart';

import '../controllers/audit_bookings_controller.dart';

class AuditBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuditBookingsController>(
      () => AuditBookingsController(),
    );
  }
}
