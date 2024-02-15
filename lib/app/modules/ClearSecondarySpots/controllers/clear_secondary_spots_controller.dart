import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class ClearSecondarySpotsController extends GetxController {
  //TODO: Implement ClearSecondarySpotsController

  // final count = 0.obs;
  final tecYearMonth = TextEditingController();
  final tecTelecastDate = TextEditingController();

  var locationList = <DropDownValue>[].obs;
  var channelList = <DropDownValue>[].obs;

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

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
        api: ApiFactory.CLEAR_SECONDARY_SPOTS_GETLOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          closeDialogIfOpen();
          if (map is Map &&
              map.containsKey("cspLoad") &&
              map['cspLoad'] != null) {
            var locationData = map['cspLoad']['lstLocation'];
            if (locationData != null && locationData.isNotEmpty) {
              locationData.forEach((e) {
                locationList.add(DropDownValue(
                  key: e["locationCode"],
                  value: e["locationName"],
                ));
              });
            }

            var channelData = map["cspLoad"]["lstChannel"];
            if (channelData != null && channelData.isNotEmpty) {
              channelData.forEach((e) {
                channelList.add(DropDownValue(
                  key: e["channelcode"],
                  value: e["channelname"],
                ));
              });
            }

            // map['cmLoad']["lstCMPlace"].forEach((e) {
            //   cityList.add(
            //       DropDownValue(key: e["placecode"], value: e["placename"]));
            // });
          }
        },
        failed: (map) {
          LoadingDialog.showErrorDialog(map);
        });
  }

  onScrollClick() {
    var model = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? "",
      "fdate": dateFormat(tecTelecastDate.text),
      "yearmonth": tecYearMonth.text,
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.CLEAR_SECONDARY_SPOTS_SCROLL,
      json: model,
      fun: (resp) {
        Get.back();
        // if (resp != null &&
        //     resp is Map<String, dynamic> &&
        //     resp.toString().contains("successfully")) {
        //   LoadingDialog.callDataSaved(
        //     msg: resp["message"],
        //     callback: () {
        //       callClear();
        //     },
        //   );
        // }
      },
    );
  }

  String dateFormat(String? date) {
    if (date != null && date != "") {
      DateTime dateNew = DateFormat("dd-MM-yyyy").parse(date);
      return DateFormat("yyyy-MM-ddTHH:mm:ss").format(dateNew);
    } else {
      return "";
    }
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

  // void increment() => count.value++;
}
