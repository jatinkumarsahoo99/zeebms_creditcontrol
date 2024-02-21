import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../../data/DropDownValue.dart';



class AuditRescheduleController extends GetxController {
  //TODO: Implement AuditRescheduleController

  final count = 0.obs;

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  TextEditingController logDateController = TextEditingController();

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  PlutoGridStateManager? stateManager;
  PlutoGridStateManager? stateManagerDialog;
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

  formHandler(String text) {

  }

  void increment() => count.value++;
}
