import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class SecondaryAsrunModificationController extends GetxController {
  //TODO: Implement SecondaryAsrunModificationController

  final count = 0.obs;

  RxList<DropDownValue> locationList = RxList([]);
  // RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    fetchAllLoaderData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  formHandler(String text){

  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  fetchAllLoaderData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.SECONDARY_ASRUN_MODIFICATION_LOCATION,
        // "https://jsonkeeper.com/b/D537"
        fun: ( map) {
          closeDialogIfOpen();
        });
  }

}
