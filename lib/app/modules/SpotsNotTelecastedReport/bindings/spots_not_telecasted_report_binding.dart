import 'package:get/get.dart';

import '../controllers/spots_not_telecasted_report_controller.dart';

class SpotsNotTelecastedReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpotsNotTelecastedReportController>(
      () => SpotsNotTelecastedReportController(),
    );
  }
}
