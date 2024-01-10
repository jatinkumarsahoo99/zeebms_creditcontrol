import 'package:get/get.dart';

import '../controllers/client_deals_controller.dart';

class ClientDealsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientDealsController>(
      () => ClientDealsController(),
    );
  }
}
