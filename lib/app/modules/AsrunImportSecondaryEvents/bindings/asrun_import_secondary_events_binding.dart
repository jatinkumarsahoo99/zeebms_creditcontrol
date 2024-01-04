import 'package:get/get.dart';

import '../controllers/asrun_import_secondary_events_controller.dart';

class AsrunImportSecondaryEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AsrunImportSecondaryEventsController>(
      () => AsrunImportSecondaryEventsController(),
    );
  }
}
