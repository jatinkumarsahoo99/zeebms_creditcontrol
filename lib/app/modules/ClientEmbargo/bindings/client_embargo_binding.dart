import 'package:get/get.dart';

import '../controllers/client_embargo_controller.dart';

class ClientEmbargoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientEmbargoController>(
      () => ClientEmbargoController(),
    );
  }
}
