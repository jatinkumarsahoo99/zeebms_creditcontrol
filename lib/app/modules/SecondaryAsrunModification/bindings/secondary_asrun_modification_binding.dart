import 'package:get/get.dart';

import '../controllers/secondary_asrun_modification_controller.dart';

class SecondaryAsrunModificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecondaryAsrunModificationController>(
      () => SecondaryAsrunModificationController(),
    );
  }
}
