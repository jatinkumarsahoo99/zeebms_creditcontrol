import 'package:get/get.dart';

import '../controllers/company_channel_link_controller.dart';

class CompanyChannelLinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyChannelLinkController>(
      () => CompanyChannelLinkController(),
    );
  }
}
