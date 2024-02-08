import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../ToInitModel.dart';

class TrafficOrderCorrectionController extends GetxController {
  //TODO: Implement TrafficOrderCorrectionController
  var locationList = <DropDownValue>[].obs,
      channelList = <DropDownValue>[].obs,
      clientList = <DropDownValue>[].obs,
      agencyList = <DropDownValue>[].obs,
      brandList = <DropDownValue>[].obs,
      adRevenueList = <DropDownValue>[].obs,
      payRouteList = <DropDownValue>[].obs,
      plantList = <DropDownValue>[].obs,
      tapeID_List = <DropDownValue>[].obs,
      spotStatusList = <DropDownValue>[].obs,
      bookingRefNoList = <DropDownValue>[].obs,
      zoneList = <DropDownValue>[].obs;

  DropDownValue? selectedLocation,
      selectedChannel,
      selectedZone,
      selectedClient,
      selectedAgency,
      selectedBrand,
      selectedAdRevenue,
      selectedPayRoute,
      selectedPlant,
      selectedTapeId,
      selectedBookingRefNo,
      selectedSpotStatus;

  final tecBookingNo = TextEditingController().obs;
  final tecFrom = TextEditingController().obs;
  final tecTo = TextEditingController().obs;
  final tecZone = TextEditingController().obs;
  final tecClient = TextEditingController().obs;
  final tecAgency = TextEditingController().obs;
  final tecBrand = TextEditingController().obs;
  final tecAdRevenue = TextEditingController().obs;
  final tecPayRoute = TextEditingController().obs;
  final tecBookingRefNo = TextEditingController().obs;
  final tecPlant = TextEditingController().obs;
  final tecDuration = TextEditingController().obs;
  final tecCaption = TextEditingController().obs;
  final tecAmount = TextEditingController().obs;
  final tecRemarks = TextEditingController().obs;

  ToInitModel? initData;

  @override
  void onInit() {
    getLoad();
    super.onInit();
  }

  getLoad() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.TO_INIT,
        fun: (map) {
          initData = ToInitModel.fromJson(map);
          locationList.value = initData?.onload?.lstLocation ?? [];
          zoneList.value = initData?.onload?.lstZone ?? [];
        });
  }

  getChannel() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.TO_LOC_LEAVE + (selectedLocation?.key ?? ""),
        fun: (map) {
          channelList.value.clear();
          if (map is Map && map.containsKey("infoLocationLeave")) {
            map["infoLocationLeave"].forEach((v) {
              channelList.value.add(new DropDownValue(
                  key: v["channelcode"], value: v["channelname"]));
            });
          }
        });
  }
}
