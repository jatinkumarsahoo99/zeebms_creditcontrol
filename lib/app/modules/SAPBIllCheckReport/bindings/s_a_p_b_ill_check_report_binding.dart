import 'package:get/get.dart';

import '../controllers/s_a_p_b_ill_check_report_controller.dart';

class SAPBIllCheckReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SAPBIllCheckReportController>(
      () => SAPBIllCheckReportController(),
    );
  }
}
