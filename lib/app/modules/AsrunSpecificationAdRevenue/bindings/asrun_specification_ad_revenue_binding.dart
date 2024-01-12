import 'package:get/get.dart';

import '../controllers/asrun_specification_ad_revenue_controller.dart';

class AsrunSpecificationAdRevenueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AsrunSpecificationAdRevenueController>(
      () => AsrunSpecificationAdRevenueController(),
    );
  }
}
