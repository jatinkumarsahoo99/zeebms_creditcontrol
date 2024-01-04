import 'package:get/get.dart';

import '../controllers/combo_deal_entry_controller.dart';

class ComboDealEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComboDealEntryController>(
      () => ComboDealEntryController(),
    );
  }
}
