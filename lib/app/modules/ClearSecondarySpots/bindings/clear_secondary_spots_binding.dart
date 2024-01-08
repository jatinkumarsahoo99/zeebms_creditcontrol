import 'package:get/get.dart';

import '../controllers/clear_secondary_spots_controller.dart';

class ClearSecondarySpotsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClearSecondarySpotsController>(
      () => ClearSecondarySpotsController(),
    );
  }
}
