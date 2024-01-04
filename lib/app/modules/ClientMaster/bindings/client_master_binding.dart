import 'package:get/get.dart';

import '../controllers/client_master_controller.dart';

class ClientMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientMasterController>(
      () => ClientMasterController(),
    );
  }
}
