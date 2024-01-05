import 'package:get/get.dart';

import '../controllers/g_s_t_plant_info_controller.dart';

class GSTPlantInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GSTPlantInfoController>(
      () => GSTPlantInfoController(),
    );
  }
}
