import 'package:get/get.dart';

import '../controllers/traffic_order_correction_controller.dart';

class TrafficOrderCorrectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrafficOrderCorrectionController>(
      () => TrafficOrderCorrectionController(),
    );
  }
}
