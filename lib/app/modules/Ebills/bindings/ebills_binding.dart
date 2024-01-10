import 'package:get/get.dart';

import '../controllers/ebills_controller.dart';

class EbillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EbillsController>(
      () => EbillsController(),
    );
  }
}
