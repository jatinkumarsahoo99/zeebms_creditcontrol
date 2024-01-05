import 'package:get/get.dart';

import '../controllers/deal_report_controller.dart';

class DealReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DealReportController>(
      () => DealReportController(),
    );
  }
}
