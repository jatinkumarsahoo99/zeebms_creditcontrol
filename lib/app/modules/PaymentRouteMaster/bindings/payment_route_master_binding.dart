import 'package:get/get.dart';

import '../controllers/payment_route_master_controller.dart';

class PaymentRouteMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentRouteMasterController>(
      () => PaymentRouteMasterController(),
    );
  }
}
