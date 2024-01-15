import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class TrafficOrderCorrectionController extends GetxController {
  //TODO: Implement TrafficOrderCorrectionController
  var locationList = <DropDownValue>[].obs,
      ChannelList = <DropDownValue>[].obs,
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
}
