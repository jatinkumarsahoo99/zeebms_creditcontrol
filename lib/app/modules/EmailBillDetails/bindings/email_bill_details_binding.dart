import 'package:get/get.dart';

import '../controllers/email_bill_details_controller.dart';

class EmailBillDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailBillDetailsController>(
      () => EmailBillDetailsController(),
    );
  }
}
