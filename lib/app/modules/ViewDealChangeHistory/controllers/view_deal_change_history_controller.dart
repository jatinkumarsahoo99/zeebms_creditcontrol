import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:get/get.dart';

import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';

class ViewDealChangeHistoryController extends GetxController {
  //TODO: Implement ViewDealChangeHistoryController

  var locationList = <DropDownValue>[].obs,
      channelList = <DropDownValue>[].obs,
      clientList = <DropDownValue>[].obs,
      dealNoList = <DropDownValue>[].obs;

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedClient;
  DropDownValue? selectedDealNo;

  PlutoGridStateManager? sm;

  var gridData = [].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
