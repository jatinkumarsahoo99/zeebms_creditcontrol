import 'package:get/get.dart';

import '../controllers/agency_embargo_controller.dart';

class AgencyEmbargoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgencyEmbargoController>(
      () => AgencyEmbargoController(),
    );
  }
}
