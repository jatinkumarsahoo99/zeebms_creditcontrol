import 'package:get/get.dart';

import '../controllers/station_master_controller.dart';

class StationMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StationMasterController>(
      () => StationMasterController(),
    );
  }
}
