import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../providers/ApiFactory.dart';

class InvoiceRevisionController extends GetxController {
  //TODO: Implement InvoiceRevisionController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    onLoad();
  }

  onLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.INVOICE_REVISION_GET_LOCATION,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          closeDialogIfOpen();
          // if (map is Map &&
          //     map.containsKey("cspLoad") &&
          //     map['cspLoad'] != null) {
          //   var locationData = map['cspLoad']['lstLocation'];
          //   if (locationData != null && locationData.isNotEmpty) {
          //     locationData.forEach((e) {
          //       locationList.add(DropDownValue(
          //         key: e["locationCode"],
          //         value: e["locationName"],
          //       ));
          //     });
          //   }

          //   var channelData = map["cspLoad"]["lstChannel"];
          //   if (channelData != null && channelData.isNotEmpty) {
          //     channelData.forEach((e) {
          //       channelList.add(DropDownValue(
          //         key: e["channelcode"],
          //         value: e["channelname"],
          //       ));
          //     });
          //   }

          //   // map['cmLoad']["lstCMPlace"].forEach((e) {
          //   //   cityList.add(
          //   //       DropDownValue(key: e["placecode"], value: e["placename"]));
          //   // });
          // }
        },
        failed: (map) {
          LoadingDialog.showErrorDialog(map);
        });
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
