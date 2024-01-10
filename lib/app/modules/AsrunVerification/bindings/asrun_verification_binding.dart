import 'package:get/get.dart';

import '../controllers/asrun_verification_controller.dart';

class AsrunVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AsrunVerificationController>(
      () => AsrunVerificationController(),
    );
  }
}
