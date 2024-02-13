import 'package:get/get.dart';

import '../controllers/sap_bill_check_report_controller.dart';

class SAPBIllCheckReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SAPBIllCheckReportController>(
      () => SAPBIllCheckReportController(),
    );
  }
}
