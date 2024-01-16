import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/CheckBox/multi_check_box.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:get/get.dart';

class ExportBillingFPCController extends GetxController {
  var locations = RxList<MultiCheckBoxModel>();
  var channels = RxList<MultiCheckBoxModel>();

  List<DropDownValue> selectLocation = [];
  List<DropDownValue> selectChannel = [];

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

  getLoadData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.AZURE_REDIRECT_UI,
      fun: (Map map) {
        Get.back();
        locations.clear();
        channels.clear();
        var i = 0;
        map["loadData"]["location"].forEach((e) {
          locations.add(MultiCheckBoxModel(
              DropDownValue(key: e["channelcode"], value: e["channelname"]),
              false,
              i));
          i++;
        });
        i = 0;
        map["loadData"]["channel"].forEach((e) {
          channels.add(MultiCheckBoxModel(
              DropDownValue(key: e["channelcode"], value: e["channelname"]),
              false,
              i));
          i++;
        });
      },
      // failed: (resp) {
      //   Get.back();
      //   LoadingDialog.showErrorDialog(resp.toString());
      // }
    );
  }
}
