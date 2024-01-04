import 'package:get/get.dart';

import '../controllers/invoice_revision_controller.dart';

class InvoiceRevisionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceRevisionController>(
      () => InvoiceRevisionController(),
    );
  }
}
