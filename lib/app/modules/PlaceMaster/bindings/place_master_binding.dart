import 'package:get/get.dart';

import '../controllers/place_master_controller.dart';

class PlaceMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaceMasterController>(
      () => PlaceMasterController(),
    );
  }
}
