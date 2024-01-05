import 'package:get/get.dart';

import '../controllers/readyto_bills_controller.dart';

class ReadytoBillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadytoBillsController>(
      () => ReadytoBillsController(),
    );
  }
}
