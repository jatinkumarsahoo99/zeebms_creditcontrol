import 'package:get/get.dart';

import '../controllers/place_type_master_controller.dart';

class PlaceTypeMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaceTypeMasterController>(
      () => PlaceTypeMasterController(),
    );
  }
}
