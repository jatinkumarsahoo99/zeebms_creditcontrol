import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/sized_box_widget.dart';
import '../../../controller/HomeController.dart';
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
        body: GetBuilder(
      init: controller,
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                                            controller.locationList.value,
                                            (value) {
                                              controller.selectedLocation =
                                                  value;
                                            },
                                            "Location",
                                            // .23,
                                            autoFocus: true,
                                            selected:
                                                controller.selectedLocation,
                                            // titleInLeft: true,
                                          );
                                        }),
                                      ),
                                      sizedBoxWidth(10),
                                      Expanded(
                                        child: Obx(() {
                                          return DropDownField
                                              .formDropDown1WidthMapExpand(
                                            controller.ChannelList.value,
                                            (value) {
                                              controller.selectedChannel =
                                                  value;
                                            },
                                            "Channel",
                                            // .23,
                                            autoFocus: true,
                                            selected:
                                                controller.selectedChannel,
                                            // titleInLeft: true,
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  sizedBoxHeight(5),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // InputFields.
                                      Expanded(
                                        child: Obx(() {
                                          return InputFields.formFieldExpand2(
                                            hintTxt: "Booking No",
                                            controller:
                                                controller.tecBookingNo.value,
                                            // titleInLeft: true,
                                            titleSizeboxWidth: 60,
                                            bottomPadding: false,
                                          );
                                        }),
                                      ),
                                      sizedBoxWidth(5),
                                      Obx(() {
                                        return DateWithThreeTextField(
                                          title: "From",
                                          mainTextController:
                                              controller.tecFrom.value,
                                          widthRation: .10,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      sizedBoxWidth(5),

                                      Obx(() {
                                        return DateWithThreeTextField(
                                          title: "To",
                                          mainTextController:
                                              controller.tecTo.value,
                                          widthRation: .10,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      sizedBoxWidth(5),

                                      FormButtonWrapper(
                                        btnText: "Show Details",
                                        callback: () {
                                          // controller.pickFile();
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
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return InputFields.formFieldExpand2(
                                    hintTxt: "Zone",
                                    controller: controller.tecZone.value,
                                    // titleInLeft: true,
                                    titleSizeboxWidth: 60,
                                    bottomPadding: false,
                                  );
                                }),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: Obx(() {
                                  return DropDownField
                                      .formDropDown1WidthMapExpand(
                                    controller.zoneList.value,
                                    (value) {
                                      controller.selectedZone = value;
                                    },
                                    "Zone",
                                    // .23,
                                    autoFocus: true,
                                    selected: controller.selectedZone,
                                    // titleInLeft: true,
                                  );
                                }),
                              ),
                            ],
                          ),
                          sizedBoxHeight(5),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return InputFields.formFieldExpand2(
                                    hintTxt: "Client",
                                    controller: controller.tecClient.value,
                                    // titleInLeft: true,
                                    titleSizeboxWidth: 60,
                                    bottomPadding: false,
                                  );
                                }),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: Obx(() {
                                  return DropDownField
                                      .formDropDown1WidthMapExpand(
                                    controller.clientList.value,
                                    (value) {
                                      controller.selectedClient = value;
                                    },
                                    "Client",
                                    // .23,
                                    autoFocus: true,
                                    selected: controller.selectedClient,
                                    // titleInLeft: true,
                                  );
                                }),
                              ),
                            ],
                          ),
                          sizedBoxHeight(5),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return InputFields.formFieldExpand2(
                                    hintTxt: "Agency",
                                    controller: controller.tecAgency.value,
                                    // titleInLeft: true,
                                    titleSizeboxWidth: 60,
                                    bottomPadding: false,
                                  );
                                }),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: Obx(() {
                                  return DropDownField
                                      .formDropDown1WidthMapExpand(
                                    controller.agencyList.value,
                                    (value) {
                                      controller.selectedAgency = value;
                                    },
                                    "Agency",
                                    // .23,
                                    autoFocus: true,
                                    selected: controller.selectedAgency,
                                    // titleInLeft: true,
                                  );
                                }),
                              ),
                            ],
                          ),
                          sizedBoxHeight(5),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return InputFields.formFieldExpand2(
                                    hintTxt: "Brand",
                                    controller: controller.tecBrand.value,
                                    // titleInLeft: true,
                                    titleSizeboxWidth: 60,
                                    bottomPadding: false,
                                  );
                                }),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: Obx(() {
                                  return DropDownField
                                      .formDropDown1WidthMapExpand(
                                    controller.brandList.value,
                                    (value) {
                                      controller.selectedBrand = value;
                                    },
                                    "Brand",
                                    // .23,
                                    autoFocus: true,
                                    selected: controller.selectedBrand,
                                    // titleInLeft: true,
                                  );
                                }),
                              ),
                            ],
                          ),
                          sizedBoxHeight(5),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return InputFields.formFieldExpand2(
                                    hintTxt: "Ad Revenue",
                                    controller: controller.tecAdRevenue.value,
                                    // titleInLeft: true,
                                    titleSizeboxWidth: 60,
                                    bottomPadding: false,
                                  );
                                }),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: Obx(() {
                                  return DropDownField
                                      .formDropDown1WidthMapExpand(
                                    controller.adRevenueList.value,
                                    (value) {
                                      controller.selectedAdRevenue = value;
                                    },
                                    "Ad Revenue",
                                    // .23,
                                    autoFocus: true,
                                    selected: controller.selectedAdRevenue,
                                    // titleInLeft: true,
                                  );
                                }),
                              ),
                            ],
                          ),
                          sizedBoxHeight(5),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return InputFields.formFieldExpand2(
                                    hintTxt: "Pay Route",
                                    controller: controller.tecPayRoute.value,
                                    // titleInLeft: true,
                                    titleSizeboxWidth: 60,
                                    bottomPadding: false,
                                  );
                                }),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: Obx(() {
                                  return DropDownField
                                      .formDropDown1WidthMapExpand(
                                    controller.payRouteList.value,
                                    (value) {
                                      controller.selectedPayRoute = value;
                                    },
                                    "Pay Route",
                                    // .23,
                                    autoFocus: true,
                                    selected: controller.selectedPayRoute,
                                    // titleInLeft: true,
                                  );
                                }),
                              ),
                            ],
                          ),
                          sizedBoxHeight(5),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return InputFields.formFieldExpand2(
                                    hintTxt: "Booking Reference Number",
                                    controller:
                                        controller.tecBookingRefNo.value,
                                    // titleInLeft: true,
                                    titleSizeboxWidth: 60,
                                    bottomPadding: false,
                                  );
                                }),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: Obx(() {
                                  return DropDownField
                                      .formDropDown1WidthMapExpand(
                                    controller.bookingRefNoList.value,
                                    (value) {
                                      controller.selectedBookingRefNo = value;
                                    },
                                    "Booking Reference Number",
                                    // .23,
                                    autoFocus: true,
                                    selected: controller.selectedBookingRefNo,
                                    // titleInLeft: true,
                                  );
                                }),
                              ),
                            ],
                          ),
                          sizedBoxHeight(5),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return InputFields.formFieldExpand2(
                                    hintTxt: "Plant",
                                    controller: controller.tecPlant.value,
                                    // titleInLeft: true,
                                    titleSizeboxWidth: 60,
                                    bottomPadding: false,
                                  );
                                }),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: Obx(() {
                                  return DropDownField
                                      .formDropDown1WidthMapExpand(
                                    controller.plantList.value,
                                    (value) {
                                      controller.selectedPlant = value;
                                    },
                                    "Plant",
                                    // .23,
                                    autoFocus: true,
                                    selected: controller.selectedPlant,
                                    // titleInLeft: true,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    sizedBoxWidth(10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Obx(() {
                                                return DropDownField
                                                    .formDropDown1WidthMapExpand(
                                                        controller.tapeID_List
                                                            .value, (value) {
                                                  controller.selectedTapeId =
                                                      value;
                                                }, "Tape Id",
                                                        // .23,
                                                        autoFocus: true,
                                                        selected: controller
                                                            .selectedTapeId
                                                        // titleInLeft: true,
                                                        );
                                              }),
                                            ),
                                            sizedBoxWidth(10),
                                            Expanded(
                                              child: Obx(() {
                                                return InputFields
                                                    .formFieldExpand2(
                                                  hintTxt: "Duration",
                                                  controller: controller
                                                      .tecDuration.value,
                                                  // titleInLeft: true,
                                                  // titleSizeboxWidth: 60,
                                                  bottomPadding: false,
                                                  isEnable: false,
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                        sizedBoxHeight(5),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Obx(() {
                                                return InputFields
                                                    .formFieldExpand2(
                                                  hintTxt: "Amount",
                                                  controller: controller
                                                      .tecAmount.value,
                                                  // titleInLeft: true,
                                                  // titleSizeboxWidth: 60,
                                                  bottomPadding: false,
                                                );
                                              }),
                                            ),
                                            sizedBoxWidth(10),
                                            Expanded(
                                              child: Obx(() {
                                                return DropDownField
                                                    .formDropDown1WidthMapExpand(
                                                  controller
                                                      .spotStatusList.value,
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
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizedBoxWidth(5),
                                  Expanded(
                                    child: Obx(() {
                                      return InputFields.formFieldExpand2(
                                        hintTxt: "Caption",
                                        controller: controller.tecCaption.value,
                                        // titleInLeft: true,
                                        // titleSizeboxWidth: 60,
                                        height: 60,
                                        bottomPadding: false,
                                      );
                                    }),
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
                                      controller: TextEditingController(),
                                      // titleInLeft: true,
                                      // titleSizeboxWidth: 60,
                                      bottomPadding: false,
                                    ),
                                    sizedBoxHeight(5),

                                    // Spacer()
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                      ),
                                    ),

                                    sizedBoxHeight(5),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FormButton1(
                                          btnText: "Deal",
                                          callback: () {},
                                        ),
                                        sizedBoxWidth(100),
                                        FormButton1(
                                          btnText: "Modify",
                                          callback: () {},
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
                  ],
                ),
              ),

              // SizedBox(
              //   // width: 40,
              //   height: 10,
              // ),
              // Spacer(),

              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Get.find<HomeController>().getCommonButton(
                  Routes.TRAFFIC_ORDER_CORRECTION,
                  // handleAutoClear: false,
                  // disableBtns: ['Save', 'Refresh'],
                  (btnName) {
                    // controller.formHandler(btnName);
                  },
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
