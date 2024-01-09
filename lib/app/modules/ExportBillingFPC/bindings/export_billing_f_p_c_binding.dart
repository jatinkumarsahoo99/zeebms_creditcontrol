import 'package:get/get.dart';

import '../controllers/export_billing_f_p_c_controller.dart';

class ExportBillingFPCBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExportBillingFPCController>(
      () => ExportBillingFPCController(),
    );
  }
}
