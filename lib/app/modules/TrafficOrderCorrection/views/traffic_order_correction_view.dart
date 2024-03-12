import 'package:bms_creditcontrol/widgets/PlutoGrid/pluto_grid.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/sized_box_widget.dart';
import '../../../controller/HomeController.dart';
import '../../../data/user_data_settings_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/traffic_order_correction_controller.dart';

class TrafficOrderCorrectionView
    extends GetView<TrafficOrderCorrectionController> {
  TrafficOrderCorrectionView({Key? key}) : super(key: key);

  final controller = Get.put<TrafficOrderCorrectionController>(
    TrafficOrderCorrectionController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Obx(() {
          return controller.canDialogShow.value
              ? DraggableFab(
                  initPosition: Offset(Get.width * 0.27, Get.height * 0.10),
                  child: controller.dialogWidget!,
                )
              : SizedBox();
        }),
        body: GetBuilder(
          init: controller,
          builder: (controller) {
            return FocusTraversalGroup(
              policy: OrderedTraversalPolicy(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: FocusTraversalOrder(
                              order: NumericFocusOrder(1),
                              child: Column(
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Obx(() {
                                                  return DropDownField
                                                      .formDropDown1WidthMapExpand(
                                                    controller
                                                        .locationList.value,
                                                    (value) {
                                                      controller
                                                              .selectedLocation =
                                                          value;
                                                      controller.getChannel();
                                                    },
                                                    "Location",
                                                    // .23,
                                                    autoFocus: true,
                                                    selected: controller
                                                        .selectedLocation,
                                                    // titleInLeft: true,
                                                  );
                                                }),
                                              ),
                                              sizedBoxWidth(10),
                                              Expanded(
                                                child: DropDownField
                                                    .formDropDown1WidthMapExpand(
                                                  controller.channelList.value,
                                                  (value) {
                                                    controller.selectedChannel =
                                                        value;
                                                  },
                                                  "Channel",
                                                  // .23,
                                                  autoFocus: true,
                                                  selected: controller
                                                      .selectedChannel,
                                                  // titleInLeft: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                          sizedBoxHeight(5),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              // InputFields.
                                              Expanded(
                                                child: InputFields
                                                    .formFieldExpand2(
                                                  hintTxt: "Booking No",
                                                  controller:
                                                      controller.tecBookingNo,
                                                  // titleInLeft: true,
                                                  titleSizeboxWidth: 60,
                                                  bottomPadding: false,
                                                ),
                                              ),
                                              sizedBoxWidth(5),
                                              DateWithThreeTextField(
                                                title: "From",
                                                mainTextController:
                                                    controller.tecFrom,
                                                widthRation: .10,
                                                // titleInLeft: true,
                                              ),
                                              sizedBoxWidth(5),

                                              DateWithThreeTextField(
                                                title: "To",
                                                mainTextController:
                                                    controller.tecTo,
                                                widthRation: .10,
                                                // titleInLeft: true,
                                              ),
                                              sizedBoxWidth(5),

                                              FormButtonWrapper(
                                                btnText: "Show Details",
                                                callback: () {
                                                  controller.getDetails();
                                                },
                                                showIcon: false,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  sizedBoxHeight(5),
                                  GetBuilder<TrafficOrderCorrectionController>(
                                      id: "dropdown",
                                      init: controller,
                                      builder: (logic) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                          hintTxt: "Zone",
                                                          controller: controller
                                                              .tecZone,
                                                          // titleInLeft: true,
                                                          titleSizeboxWidth: 60,
                                                          bottomPadding: false,
                                                          isEnable: controller
                                                              .isLeftEnable),
                                                ),
                                                sizedBoxWidth(10),
                                                Expanded(
                                                  child: DropDownField
                                                      .formDropDown1WidthMapExpand(
                                                    controller.zoneList.value,
                                                    (value) {
                                                      controller.selectedZone =
                                                          value;
                                                    },
                                                    "Zone",
                                                    // .23,
                                                    autoFocus: true,
                                                    selected:
                                                        controller.selectedZone,
                                                    // titleInLeft: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            sizedBoxHeight(5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                          hintTxt: "Client",
                                                          controller: controller
                                                              .tecClient,
                                                          // titleInLeft: true,
                                                          titleSizeboxWidth: 60,
                                                          bottomPadding: false,
                                                          isEnable: controller
                                                              .isLeftEnable),
                                                ),
                                                sizedBoxWidth(10),
                                                Expanded(
                                                  child: DropDownField
                                                      .formDropDown1WidthMapExpand(
                                                    controller.infoModel
                                                            ?.lstClients ??
                                                        [],
                                                    (value) {
                                                      controller
                                                              .selectedClient =
                                                          value;
                                                    },
                                                    "Client",
                                                    // .23,
                                                    autoFocus: true,
                                                    selected: controller
                                                        .selectedClient,
                                                    // titleInLeft: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            sizedBoxHeight(5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                          hintTxt: "Agency",
                                                          controller: controller
                                                              .tecAgency,
                                                          // titleInLeft: true,
                                                          titleSizeboxWidth: 60,
                                                          bottomPadding: false,
                                                          isEnable: controller
                                                              .isLeftEnable),
                                                ),
                                                sizedBoxWidth(10),
                                                Expanded(
                                                  child: DropDownField
                                                      .formDropDown1WidthMapExpand(
                                                    controller.infoModel
                                                            ?.lstAgency ??
                                                        [],
                                                    (value) {
                                                      controller
                                                              .selectedAgency =
                                                          value;
                                                    },
                                                    "Agency",
                                                    // .23,
                                                    autoFocus: true,
                                                    selected: controller
                                                        .selectedAgency,
                                                    // titleInLeft: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            sizedBoxHeight(5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                          hintTxt: "Brand",
                                                          controller: controller
                                                              .tecBrand,
                                                          // titleInLeft: true,
                                                          titleSizeboxWidth: 60,
                                                          bottomPadding: false,
                                                          isEnable: controller
                                                              .isLeftEnable),
                                                ),
                                                sizedBoxWidth(10),
                                                Expanded(
                                                  child: DropDownField
                                                      .formDropDown1WidthMapExpand(
                                                    controller.infoModel
                                                            ?.lstBrand ??
                                                        [],
                                                    (value) {
                                                      controller.selectedBrand =
                                                          value;
                                                    },
                                                    "Brand",
                                                    // .23,
                                                    autoFocus: true,
                                                    selected: controller
                                                        .selectedBrand,
                                                    // titleInLeft: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            sizedBoxHeight(5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                          hintTxt: "Ad Revenue",
                                                          controller: controller
                                                              .tecAdRevenue,
                                                          // titleInLeft: true,
                                                          titleSizeboxWidth: 60,
                                                          bottomPadding: false,
                                                          isEnable: controller
                                                              .isLeftEnable),
                                                ),
                                                sizedBoxWidth(10),
                                                Expanded(
                                                  child: DropDownField
                                                      .formDropDown1WidthMapExpand(
                                                    controller.infoModel
                                                            ?.lstAdRevenue ??
                                                        [],
                                                    (value) {
                                                      controller
                                                              .selectedAdRevenue =
                                                          value;
                                                    },
                                                    "Ad Revenue",
                                                    // .23,
                                                    autoFocus: true,
                                                    selected: controller
                                                        .selectedAdRevenue,
                                                    // titleInLeft: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            sizedBoxHeight(5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                          hintTxt: "Pay Route",
                                                          controller: controller
                                                              .tecPayRoute,
                                                          // titleInLeft: true,
                                                          titleSizeboxWidth: 60,
                                                          bottomPadding: false,
                                                          isEnable: controller
                                                              .isLeftEnable),
                                                ),
                                                sizedBoxWidth(10),
                                                Expanded(
                                                  child: DropDownField
                                                      .formDropDown1WidthMapExpand(
                                                          controller.infoModel
                                                                  ?.lstPayRoutes ??
                                                              [], (value) {
                                                    controller
                                                            .selectedPayRoute =
                                                        value;
                                                    controller.getPayroute();
                                                    controller
                                                        .getPayrouteFocus();
                                                  }, "Pay Route",
                                                          // .23,
                                                          autoFocus: true,
                                                          selected: controller
                                                              .selectedPayRoute,
                                                          inkWellFocusNode:
                                                              controller
                                                                  .payRouteFocus
                                                          // titleInLeft: true,
                                                          ),
                                                ),
                                              ],
                                            ),
                                            sizedBoxHeight(5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                          hintTxt:
                                                              "Booking Reference Number",
                                                          controller: controller
                                                              .tecBookingRefNo,
                                                          // titleInLeft: true,
                                                          titleSizeboxWidth: 60,
                                                          bottomPadding: false,
                                                          isEnable: controller
                                                              .isLeftEnable),
                                                ),
                                                sizedBoxWidth(10),
                                                Expanded(
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                    hintTxt:
                                                        "Booking Reference Number",
                                                    controller: controller
                                                        .tecBookReference,
                                                    // titleInLeft: true,
                                                    titleSizeboxWidth: 60,
                                                    bottomPadding: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            sizedBoxHeight(5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                          hintTxt: "Plant",
                                                          controller: controller
                                                              .tecPlant,
                                                          // titleInLeft: true,
                                                          titleSizeboxWidth: 60,
                                                          bottomPadding: false,
                                                          isEnable: controller
                                                              .isLeftEnable),
                                                ),
                                                sizedBoxWidth(10),
                                                Expanded(
                                                  child: DropDownField
                                                      .formDropDown1WidthMapExpand(
                                                    controller.infoModel
                                                            ?.lstplants ??
                                                        [],
                                                    (value) {
                                                      controller.selectedPlant =
                                                          value;
                                                    },
                                                    "Plant",
                                                    // .23,
                                                    autoFocus: true,
                                                    selected: controller
                                                        .selectedPlant,
                                                    // titleInLeft: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                          sizedBoxWidth(10),
                          Expanded(
                            child: FocusTraversalOrder(
                              order: NumericFocusOrder(2),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GetBuilder<
                                                  TrafficOrderCorrectionController>(
                                              id: "main",
                                              init: controller,
                                              builder: (logic) {
                                                return Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: DropDownField
                                                                .formDropDown1WidthMapExpand(
                                                                    controller
                                                                            .tapeID_List ??
                                                                        [],
                                                                    (value) {
                                                              controller
                                                                      .selectedTapeId =
                                                                  value;
                                                              controller
                                                                  .getTapeIdLeave();
                                                            }, "Tape Id",
                                                                    // .23,
                                                                    autoFocus:
                                                                        true,
                                                                    selected:
                                                                        controller
                                                                            .selectedTapeId
                                                                    // titleInLeft: true,
                                                                    ),
                                                          ),
                                                          sizedBoxWidth(10),
                                                          Expanded(
                                                            child: InputFields
                                                                .formFieldExpand2(
                                                              hintTxt:
                                                                  "Duration",
                                                              controller:
                                                                  controller
                                                                      .tecDuration,
                                                              // titleInLeft: true,
                                                              // titleSizeboxWidth: 60,
                                                              bottomPadding:
                                                                  false,
                                                              isEnable: false,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      sizedBoxHeight(5),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: InputFields
                                                                .formFieldExpand2(
                                                              hintTxt: "Amount",
                                                              controller:
                                                                  controller
                                                                      .tecAmount,
                                                              // titleInLeft: true,
                                                              // titleSizeboxWidth: 60,
                                                              bottomPadding:
                                                                  false,
                                                            ),
                                                          ),
                                                          sizedBoxWidth(10),
                                                          Expanded(
                                                            child: DropDownField
                                                                .formDropDown1WidthMapExpand(
                                                              controller
                                                                      .spotStatusList ??
                                                                  [],
                                                              (value) {
                                                                controller
                                                                        .selectedSpotStatus =
                                                                    value;
                                                              },
                                                              "Spot Status",
                                                              selected: controller
                                                                  .selectedSpotStatus,
                                                              // .23,
                                                              autoFocus: true,
                                                              // titleInLeft: true,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                          sizedBoxWidth(5),
                                          Expanded(
                                            child: InputFields.formFieldExpand2(
                                              hintTxt: "Caption",
                                              controller: controller.tecCaption,
                                              // titleInLeft: true,
                                              // titleSizeboxWidth: 60,
                                              height: 60,
                                              bottomPadding: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  sizedBoxHeight(5),
                                  Expanded(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          // mainAxisSize: MainAxisSize.max,
                                          children: [
                                            InputFields.formFieldExpand2(
                                              hintTxt: "Remarks",
                                              controller: controller.tecRemarks,
                                              // titleInLeft: true,
                                              // titleSizeboxWidth: 60,
                                              bottomPadding: false,
                                            ),
                                            sizedBoxHeight(5),

                                            // Spacer()
                                            GetBuilder<
                                                    TrafficOrderCorrectionController>(
                                                id: "grid",
                                                init: controller,
                                                builder: (logic) {
                                                  return Expanded(
                                                    child: (controller.infoModel != null &&
                                                            controller.infoModel
                                                                    ?.lstToCorrection !=
                                                                null &&
                                                            (controller
                                                                    .infoModel
                                                                    ?.lstToCorrection
                                                                    ?.isNotEmpty ??
                                                                false))
                                                        ? DataGridFromMap(
                                                            showSrNo: true,
                                                            exportFileName:
                                                                "Traffic Order Correction",
                                                            mode: PlutoGridMode
                                                                .normal,
                                                            mapData: (controller
                                                                .infoModel
                                                                ?.lstToCorrection
                                                                ?.map((e) =>
                                                                    e.toJson())
                                                                .toList())!,

                                                            // mapData: (controllerX.dataList)!,
                                                            widthRatio:
                                                                Get.width / 9 -
                                                                    1,
                                                            onload:
                                                                (PlutoGridOnLoadedEvent
                                                                    load) {
                                                              controller
                                                                      .gridManager =
                                                                  load.stateManager;
                                                              load.stateManager.setSelectingMode(PlutoGridSelectingMode.row);
                                                            },
                                                            onRowDoubleTap:
                                                                (pluto) {
                                                              controller
                                                                  .rowDoubleTap(
                                                                      pluto
                                                                          .row);
                                                            },
                                                            hideCode: false,
                                                            hideKeys: [
                                                              "bookingNumber",
                                                              "recordNumber",
                                                              "commercialCode"
                                                            ],

                                                            colorCallback: (row) => (row
                                                                        .rowIdx ==
                                                                    controller
                                                                        .gridManager
                                                                        ?.currentRowIdx)
                                                                ? Colors
                                                                    .deepPurple
                                                                    .shade200
                                                                : Colors.white,
                                                            widthSpecificColumn: (controller
                                                                .userDataSettings
                                                                ?.userSetting
                                                                ?.firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .controlName ==
                                                                        "gridManager",
                                                                    orElse: () =>
                                                                        UserSetting())
                                                                .userSettings),
                                                          )
                                                        : Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ),
                                                  );
                                                }),

                                            sizedBoxHeight(5),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                FormButton1(
                                                  btnText: "Deal",
                                                  callback: () {
                                                    controller.dealClick();
                                                  },
                                                ),
                                                sizedBoxWidth(100),
                                                FormButton1(
                                                  btnText: "Modify",
                                                  callback: () {
                                                    controller.modifyClick();
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Get.find<HomeController>().getCommonButton(
                        Routes.TRAFFIC_ORDER_CORRECTION,
                        // handleAutoClear: false,
                        // disableBtns: ['Save', 'Refresh'],
                        (btnName) {
                          controller.formHandler(btnName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
