import 'package:get/get.dart';

import '../controllers/bill_transfer_controller.dart';

class BillTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillTransferController>(
      () => BillTransferController(),
    );
  }
}
