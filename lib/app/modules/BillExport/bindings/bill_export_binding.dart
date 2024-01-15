import 'package:get/get.dart';

import '../controllers/bill_export_controller.dart';

class BillExportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillExportController>(
      () => BillExportController(),
    );
  }
}
