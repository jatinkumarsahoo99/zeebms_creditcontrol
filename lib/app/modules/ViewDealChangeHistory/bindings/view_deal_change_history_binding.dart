import 'package:get/get.dart';

import '../controllers/view_deal_change_history_controller.dart';

class ViewDealChangeHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewDealChangeHistoryController>(
      () => ViewDealChangeHistoryController(),
    );
  }
}
