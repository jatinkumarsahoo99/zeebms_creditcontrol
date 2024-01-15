import 'package:get/get.dart';

import '../controllers/generate_booking_report_controller.dart';

class GenerateBookingReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateBookingReportController>(
      () => GenerateBookingReportController(),
    );
  }
}
