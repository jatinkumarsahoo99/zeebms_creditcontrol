import 'package:get/get.dart';

import '../controllers/client_group_master_controller.dart';

class ClientGroupMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientGroupMasterController>(
      () => ClientGroupMasterController(),
    );
  }
}
