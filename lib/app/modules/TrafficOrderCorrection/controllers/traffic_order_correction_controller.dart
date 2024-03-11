import 'dart:async';

import 'package:bms_creditcontrol/app/controller/MainController.dart';
import 'package:bms_creditcontrol/app/providers/Utils.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/pluto_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/WarningBox.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/user_data_settings_model.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../InfoShowModel.dart';
import '../ToInitModel.dart';

class TrafficOrderCorrectionController extends GetxController {
  //TODO: Implement TrafficOrderCorrectionController
  var locationList = <DropDownValue>[].obs,
      channelList = <DropDownValue>[].obs,
      adRevenueList = <DropDownValue>[],
      tapeID_List = <DropDownValue>[],
      spotStatusList = <DropDownValue>[
        DropDownValue(key: "B", value: "Booked"),
        DropDownValue(key: "C", value: "Cancelled"),
        DropDownValue(key: "R", value: "Reschedule"),
      ],
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
      // selectedBookingRefNo,
      selectedSpotStatus;

  final tecBookingNo = TextEditingController();
  final tecFrom = TextEditingController();
  final tecTo = TextEditingController();
  final tecZone = TextEditingController();
  final tecClient = TextEditingController();
  final tecAgency = TextEditingController();
  final tecBrand = TextEditingController();
  final tecAdRevenue = TextEditingController();
  final tecPayRoute = TextEditingController();
  final tecBookingRefNo = TextEditingController();
  final tecPlant = TextEditingController();
  final tecDuration = TextEditingController();
  final tecCaption = TextEditingController();
  final tecAmount = TextEditingController();
  final tecRemarks = TextEditingController();
  final tecBookReference = TextEditingController();

  final gridRecordNo = TextEditingController();
  final gridRate = TextEditingController();

  // final gridRowIndex = TextEditingController();

  ToInitModel? initData;
  InfoShow? infoModel;

  bool isLeftEnable = true;

  PlutoGridStateManager? gridManager;
  PlutoGridStateManager? gridManager1;
  UserDataSettings? userDataSettings;

  var canDialogShow = false.obs;
  Widget? dialogWidget;
  Rxn<int> initialOffset = Rxn<int>(null);
  Completer<bool>? completerDialog;
  FocusNode payRouteFocus = FocusNode();

  // List<dynamic>? dealList;

  @override
  void onInit() {
    fetchUserGridSetting();
    getLoad();
    super.onInit();
    payRouteFocus.addListener(() {
      if (payRouteFocus.hasFocus) {
        getPayrouteFocus();
      } else {
        getPayroute();
      }
    });
  }

  fetchUserGridSetting() async {
    userDataSettings = await Get.find<HomeController>().fetchUserSetting2(
        formName: Routes.TRAFFIC_ORDER_CORRECTION.replaceAll("/", ""));
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

  getPayroute() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.TO_PAYROUTE_LEAVE(selectedLocation?.key ?? '',
            selectedChannel?.key ?? '', selectedPayRoute?.key ?? ''),
        fun: (map) {
          if (map is Map &&
              map.containsKey("infoPayRouteLeave") &&
              map["infoPayRouteLeave"] != null) {
            if (map["infoPayRouteLeave"].containsKey("lstplants") &&
                map["infoPayRouteLeave"]["lstplants"] != null) {
              List<DropDownValue>? listData = [];
              map["infoPayRouteLeave"]["lstplants"].forEach((e) {
                listData.add(DropDownValue(
                    key: e["plantid"].toString(), value: e["column1"]));
              });
              infoModel?.lstplants = listData;
            }
          }
        });
  }

  getPayrouteFocus() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.TO_PAYROUTE_GOT_FOCUS(
            selectedPayRoute?.key ?? '',
            selectedLocation?.key ?? '',
            selectedChannel?.key ?? '',
            selectedClient?.key ?? '',
            selectedAgency?.key ?? ''),
        fun: (map) {
          if (map is Map &&
              map.containsKey("infoPayRoute") &&
              map["infoPayRoute"] != null) {
            if (map["infoPayRoute"].containsKey("lstPayRoute") &&
                map["infoPayRoute"]["lstPayRoute"] != null) {
              List<DropDownValue>? listData = [];
              map["infoPayRoute"]["lstPayRoute"].forEach((e) {
                listData.add(DropDownValue(
                    key: e["payroutecode"], value: e["payroutename"]));
                if (e["payroutecode"] ==
                    map["infoPayRoute"]["payRouteSelected"]) {
                  selectedPayRoute = DropDownValue(
                      key: e["payroutecode"], value: e["payroutename"]);
                }
              });
              infoModel?.lstPayRoutes = listData;
              update(["dropdown"]);
            }
          }
        });
  }

  getToCorrectionCellClick() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.TO_GRID_TO_CORRECTION_CELL_CLICK(
          selectedLocation?.key ?? '',
          selectedChannel?.key ?? '',
          tecBookingNo.text,
          tecDuration.text,
        ),
        fun: (map) {
          if (map is Map &&
              map.containsKey("infoCellDoubleClick") &&
              map["infoCellDoubleClick"] != null) {
            if (map["infoCellDoubleClick"].containsKey("lstTapes") &&
                map["infoCellDoubleClick"]["lstTapes"] != null) {
              List<DropDownValue>? listData = [];
              map["infoCellDoubleClick"]["lstTapes"].forEach((e) {
                listData.add(DropDownValue(key: e["code"], value: e["name"]));
              });
              // listData.add(DropDownValue(key: "Tets", value: "Test"));
              tapeID_List = listData;
              update(["main"]);
            }
          }
        });
  }

  getTapeIdLeave() {
    if (tecDuration.text != "" && tecAmount.text != "")
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.TO_TAPE_ID_LEAVE(
              selectedTapeId?.key ?? '', tecDuration.text, tecAmount.text),
          fun: (map) {
            if (map is Map &&
                map.containsKey("infoCellDoubleClick") &&
                map["infoCellDoubleClick"] != null) {
              tecCaption.text = map["infoCellDoubleClick"]["caption"];
              tecDuration.text = map["infoCellDoubleClick"]["duration"];
              tecAmount.text = map["infoCellDoubleClick"]["amount"];
            }
          });
  }

  save() {
    if (tecRemarks.text == "" || tecRemarks.text == "NoRemark") {
      LoadingDialog.callErrorMessage1(msg: "Please select Valid Remark.");
    } else if (selectedLocation == null) {
      LoadingDialog.callErrorMessage1(msg: "Please select location");
    } else if (selectedChannel == null) {
      LoadingDialog.callErrorMessage1(msg: "Please select channel");
    } else if (tecBookingNo == "") {
      LoadingDialog.callErrorMessage1(msg: "Please enter booking no");
    } else {
      try {
        var jsonData = {
          "locationCode": selectedLocation?.key ?? '',
          "channelCode": selectedChannel?.key ?? '',
          "bookingNumber": tecBookingNo.text,
          "clientName": selectedClient?.value ?? '',
          "clientCode": selectedClient?.key ?? '',
          "agencyName": selectedAgency?.value ?? '',
          "agencyCode": selectedAgency?.key ?? '',
          "payRouteCode": selectedPayRoute?.key ?? "",
          "payRouteName": selectedPayRoute?.value ?? "",
          "brandCode": selectedBrand?.key ?? "",
          "brandName": selectedBrand?.value ?? "",
          "bookingRefNumber": tecBookingRefNo.text,
          "plantId": selectedPlant?.key ?? "",
          "modifed": Get.find<MainController>().user?.personnelNo ?? "",
          "loggedUser": Get.find<MainController>().user?.personnelNo ?? "",
          "roClientName": tecClient.text,
          "roAgencyName": tecAgency.text,
          "roPayRouteName": tecPayRoute.text,
          "roBrandName": tecBrand.text,
          "roBookingReferenceNumber": tecBookingRefNo.text,
          "lstToCorrection": gridManager?.rows
              .map((e) => {
                    "bookingDetailCode": double.tryParse(
                        e.cells["Booking DetailCode"]?.value ?? ""),
                    "spotAmount":
                        double.tryParse(e.cells["Spot Amount"]?.value ?? ""),
                    "bookingStatus": e.cells["Booking Status"]?.value ?? "",
                    "spotStatus": e.cells["Telecast Status"]?.value ?? "",
                    "recordNumber":
                        int.tryParse(e.cells["recordNumber"]?.value ?? ""),
                    "commercialCode": e.cells["commercialCode"]?.value ?? "",
                    "remarks": e.cells["remarks"]?.value ?? ""
                  })
              .toList(),
          "roAdRevenue": tecAdRevenue.text,
          "roZoneName": tecZone.text,
          "roZoneCode": infoModel?.selecedZoneCode
        };

        LoadingDialog.call();
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.TO_ONSAVE,
            fun: (map) {
              Get.back();
              if (map is Map &&
                  map.containsKey("infoSave") &&
                  map["infoSave"].containsKey("strMessage") &&
                  map["infoSave"]["strMessage"] == "Data Saved Successfully.") {
                LoadingDialog.callDataSavedMessage(
                    map["infoSave"]["strMessage"].toString(), callback: () {
                  Get.delete<TrafficOrderCorrectionController>();
                  Get.find<HomeController>().clearPage1();
                });
              } else {
                LoadingDialog.callErrorMessage1(msg: map.toString());
              }
            },
            json: jsonData);
      } catch (e) {
        LoadingDialog.callErrorMessage1(msg: e.toString());
      }
    }
  }

  String getBookingName(String name) {
    switch (name) {
      case "B":
        return "Booking";
      case "C":
        return "Cancelled";
      case "R":
        return "Reschedule";
      default:
        return "";
    }
  }

  getDetails() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.TO_PAYROUTE_GET_DETAILS(
            selectedLocation?.key ?? "",
            selectedChannel?.key ?? "",
            tecBookingNo.text,
            Utils.dateFormatChange(tecFrom.text, "dd-MM-yyyy", "yyyy-MM-dd"),
            Utils.dateFormatChange(tecTo.text, "dd-MM-yyyy", "yyyy-MM-dd")),
        fun: (map) {
          Get.back();
          if (map is Map && map.containsKey("infoShow")) {
            infoModel = InfoShow.fromJson(map["infoShow"]);
            selectedAdRevenue = DropDownValue(
                key: infoModel?.selectedAdRevenue ?? "",
                value: infoModel?.roAdRevenue ?? "");
            selectedPlant = DropDownValue(
                key: infoModel?.plantId ?? "", value: infoModel?.roPlant ?? "");
            selectedZone = DropDownValue(
                key: infoModel?.selecedZoneCode ?? "",
                value: infoModel?.roZone ?? "");
            selectedClient = DropDownValue(
                key: infoModel?.selectedClientCode ?? "",
                value: infoModel?.roClient ?? "");
            selectedAgency = DropDownValue(
                key: infoModel?.selectedAgencyCode ?? "",
                value: infoModel?.roAgency ?? "");
            selectedBrand = DropDownValue(
                key: infoModel?.selectedBrandCode ?? "",
                value: infoModel?.roBrandName ?? "");
            selectedPayRoute = DropDownValue(
                key: infoModel?.selectedPayRouteCode ?? "",
                value: infoModel?.roPayRoute ?? "");
            // selectedBookingRefNo = DropDownValue(
            //     key: infoModel?.bookingReferenceNumber ?? "",
            //     value: infoModel?.roBookingReferenceNumber ?? "");
            tecBookReference.text = infoModel?.roBookingReferenceNumber ?? "";
            tecZone.text = infoModel?.roZone ?? "";
            tecClient.text = infoModel?.roClient ?? "";
            tecAgency.text = infoModel?.roAgency ?? "";
            tecBrand.text = infoModel?.roBrandName ?? "";
            tecAdRevenue.text = infoModel?.roAdRevenue ?? "";
            tecPayRoute.text = infoModel?.roPayRoute ?? "";
            tecBookingRefNo.text = infoModel?.roBookingReferenceNumber ?? "";
            tecPlant.text = infoModel?.roPlant ?? "";
            isLeftEnable = false;
            update(["dropdown", "grid"]);
          } else {
            LoadingDialog.callErrorMessage1(msg: map.toString());
          }
        });
  }

  void formHandler(String btnName) {
    switch (btnName) {
      case "Exit":
        Get.find<HomeController>().postUserGridSetting2(listStateManager: [
          {"gridManager": gridManager},
        ], formName: Routes.TRAFFIC_ORDER_CORRECTION.replaceAll("/", ""));
        break;
      case "Save":
        save();
        break;
      case "Clear":
        Get.delete<TrafficOrderCorrectionController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Search":
        Get.to(SearchPage(
            screenName: "Traffic Order Correction",
            isAppBarReq: true,
            // isPopup: true,
            appBarName: "Traffic Order Correction",
            strViewName: "vTesting"));
        break;
    }
  }

  rowDoubleTap(PlutoRow? row) {
    gridManager?.setCurrentCell(row?.cells["Booking DetailCode"], row?.sortIdx ?? 0);
    tapeID_List = [
      DropDownValue(
          key: row?.cells["commercialCode"]?.value ?? "",
          value: row?.cells["Tape Code"]?.value ?? "")
    ];
    selectedTapeId = tapeID_List[0];
    selectedSpotStatus = DropDownValue(
        key: row?.cells["Booking Status"]?.value ?? "",
        value: getBookingName(row?.cells["Booking Status"]?.value ?? ""));
    tecDuration.text = row?.cells["Duration"]?.value ?? "";
    tecAmount.text = row?.cells["Spot Amount"]?.value ?? "";
    tecCaption.text = row?.cells["Caption"]?.value ?? "";
    tecRemarks.text = row?.cells["remarks"]?.value ?? "";
    gridRecordNo.text = row?.cells["recordNumber"]?.value ?? "";
    update(["main"]);
    getToCorrectionCellClick();
  }

  void modifyClick() {
    gridManager?.currentRow?.cells["Booking Status"]?.value =
        selectedSpotStatus?.key ?? "";
    gridManager?.currentRow?.cells["Tape Code"]?.value =
        selectedTapeId?.value ?? "";
    gridManager?.currentRow?.cells["Spot Amount"]?.value = tecAmount.text;
    gridManager?.currentRow?.cells["remarks"]?.value = tecRemarks.text;
    gridManager?.currentRow?.cells["Caption"]?.value = tecCaption.text;
    gridManager?.currentRow?.cells["Duration"]?.value = tecDuration.text;
    gridManager?.currentRow?.cells["commercialCode"]?.value =
        selectedTapeId?.key ?? "";
    gridManager?.currentRow?.cells["recordNumber"]?.value = gridRecordNo.text;
    gridManager?.currentRow?.cells["Spot Amount"]?.value = tecAmount.text;

    selectedTapeId = null;
    selectedSpotStatus = null;
    tecDuration.text = "";
    tecAmount.text = "";
    tecCaption.text = "";
    // tecRemarks.text = "";
    gridManager?.notifyListeners();
    update(["main"]);
  }

  void dealClick() {
    showInsertDialog2();
  }

  showInsertDialog2() {
    initialOffset.value = 2;
    dialogWidget = Material(
      color: Colors.white,
      child: SizedBox(
        width: Get.width * 0.7,
        child: Column(
          children: [
            Container(
              height: 40,
              width: Get.width * 0.7,
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Positioned(
                    right: 5,
                    top: 5,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        dialogWidget = null;
                        canDialogShow.value = false;
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Deal',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: Get.height * 0.5,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GetBuilder<TrafficOrderCorrectionController>(
                    id: "insertData",
                    init: this,
                    builder: (controller) {
                      return SizedBox(
                        // width: 500,
                        width: Get.width * 0.7,
                        height: Get.height * 0.5,
                        child: (controller.infoModel?.lstNewDealDetails !=
                                    null &&
                                (controller.infoModel?.lstNewDealDetails
                                        ?.isNotEmpty ??
                                    false))
                            ? DataGridFromMap(
                                // hideCode: false,
                                formatDate: false,
                                // checkRow: true,
                                showSrNo: false,
                                mode: PlutoGridMode.normal,
                                hideCode: false,
                                // checkRowKey: "eventtype",
                                onload: (PlutoGridOnLoadedEvent load) {
                                  print("My Data is>>>");
                                  controller.gridManager1 = load.stateManager;
                                },
                                onRowDoubleTap:
                                    (PlutoGridOnRowDoubleTapEvent tap) {
                                  gridRecordNo.text =
                                      tap.row.cells["recordnumber"]?.value;
                                  gridRate.text = tap.row.cells["rate"]?.value;
                                  tecAmount.text =
                                      ((num.tryParse(gridRate.text) ?? 0) *
                                              (num.tryParse(tecDuration.text) ??
                                                  0) /
                                              10)
                                          .toString();
                                },
                                mapData: (controller
                                    .infoModel?.lstNewDealDetails
                                    ?.map((e) => e.toJson())
                                    .toList())!)
                            // _dataTable3()
                            : const WarningBox(
                                text:
                                    'Enter Location, Channel & Date to get the Break Definitions'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    canDialogShow.value = true;
  }
}
