import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../widgets/CheckBoxWidget.dart';
import '../../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../../widgets/FormButton.dart';
import '../../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../../widgets/dropdown.dart';
import '../../../../../widgets/gridFromMap.dart';
import '../../../../../widgets/input_fields.dart';
import '../../../../../widgets/sized_box_widget.dart';
import '../../../../controller/HomeController.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/audit_cancellation_controller.dart';

class AuditCancellationView extends GetView<AuditCancellationController> {
  AuditCancellationView({Key? key}) : super(key: key);

  var controller =
  Get.put<AuditCancellationController>(AuditCancellationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuditCancellationController>(
        init: controller,
        id: "update",
        builder: (controller) {
          return SizedBox(
            width: context.width,
            height: context.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    title: const Text('Audit Cancellation'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(result: true),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
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
                                        controller.selectedLocation.value = value;
                                      },
                                      "Location",
                                      // titleInLeft: true,
                                      selected: controller.selectedLocation.value,
                                      titleSizeBoxWidth: 75,
                                      isEnable: controller.isEnable.value
                                    );
                                  }),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.channelList.value,
                                          (value) {
                                        controller.selectedChannel.value = value;
                                      },
                                      "Channel",
                                      // titleInLeft: true,
                                      selected: controller.selectedChannel.value,
                                      titleSizeBoxWidth: 75,
                                        isEnable: controller.isEnable.value
                                    );
                                  }),
                                ),
                              ],
                            ),
                            sizedBoxHeight(5),
                            Row(
                              children: [
                                Expanded(
                                  child: InputFields.formFieldExpand2(
                                      hintTxt: "Ref No",
                                      controller: controller.refNoController,
                                      autoFocus: true,
                                      titleSizeboxWidth: 80,
                                      isEnable: controller.isEnable.value,
                                      bottomPadding: false),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InputFields.formFieldExpand2(
                                            hintTxt: "Ref Date",
                                            controller: controller.refDateController,
                                            autoFocus: true,
                                            titleSizeboxWidth: 80,
                                            isEnable: controller.isEnable.value,
                                            bottomPadding: false),
                                      ),
                                      /*Expanded(
                                        child: DateWithThreeTextField(
                                          title: "Ref Date",
                                          mainTextController: controller.refDateController,
                                          // isEnable: false,
                                          isEnable: controller.isEnable.value,
                                        ),
                                      ),*/
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: InputFields.formFieldExpand2(
                                            hintTxt: "Book No",
                                            controller: controller.bookingNoController,
                                            autoFocus: true,
                                            isEnable: controller.isEnable.value,
                                            titleSizeboxWidth: 80,
                                            bottomPadding: false),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxHeight(5),
                            Obx(() {
                              return DropDownField.formDropDownSearchAPI2Expand(
                                GlobalKey(),
                                context,
                                title: "Client",
                                url: "",
                                onchanged: (value) {
                                  controller.selectedClient.value = value;
                                },
                                selectedValue: controller.selectedClient.value,
                                parseKeyForKey: "",
                                parseKeyForValue: "",
                                isEnable: controller.isEnable.value,
                                textSizeboxWidth: 85,
                              );
                            }),
                            sizedBoxHeight(5),
                            Obx(() {
                              return DropDownField.formDropDownSearchAPI2Expand(
                                GlobalKey(),
                                context,
                                title: "Agency",
                                url: "",
                                onchanged: (value) {
                                  controller.selectedAgency.value = value;
                                },
                                selectedValue: controller.selectedAgency.value,
                                parseKeyForKey: "",
                                parseKeyForValue: "",
                                isEnable: controller.isEnable.value,
                                textSizeboxWidth: 85,
                              );
                            }),
                            sizedBoxHeight(5),
                            Obx(() {
                              return DropDownField.formDropDownSearchAPI2Expand(
                                GlobalKey(),
                                context,
                                title: "Brand",
                                url: "",
                                onchanged: (value) {
                                  controller.selectedBrand.value = value;
                                },
                                selectedValue: controller.selectedBrand.value,
                                parseKeyForKey: "",
                                parseKeyForValue: "",
                                isEnable: controller.isEnable.value,
                                textSizeboxWidth: 85,
                              );
                            }),
                            sizedBoxHeight(5),
                            InputFields.formFieldExpand2(
                                hintTxt: "Executive",
                                controller: controller.executiveController,
                                autoFocus: true,
                                titleSizeboxWidth: 80,
                                isEnable: controller.isEnable.value,
                                bottomPadding: false),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      GetBuilder<AuditCancellationController>(
                          id: "updatePC",
                          builder: (controller) {
                            return Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DateWithThreeTextField(
                                          title: "FPC Eff Dt",
                                          mainTextController:
                                          controller.fpcEffDtController,
                                          isEnable: controller.isEnable.value,

                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: DateWithThreeTextField(
                                          title: "Book Dt",
                                          mainTextController:
                                          controller.bookedDtController,
                                          isEnable: controller.isEnable.value,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBoxHeight(5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InputFields.formFieldExpand2(
                                          hintTxt: "Cancel No",
                                          controller: controller.cancelNoController,
                                          autoFocus: true,
                                          titleSizeboxWidth: 80,
                                          bottomPadding: false,
                                          isEnable: controller.isEnable.value,
                                        ),
                                      ),
                                      sizedBoxWidth(5),
                                      SizedBox(
                                        width: 100,
                                        child: InputFields.formFieldExpand2(
                                          hintTxt: "",
                                          controller: controller.textController1,
                                          // autoFocus: true,
                                          titleSizeboxWidth: 80,
                                          isEnable: controller.isEnable.value,
                                          bottomPadding: false,
                                        ),
                                      ),
                                      sizedBoxWidth(5),
                                      SizedBox(
                                        width: 150,
                                        child: InputFields.formFieldExpand2(
                                          hintTxt: "",
                                          controller: controller.textController2,
                                          // autoFocus: true,
                                          titleSizeboxWidth: 80,
                                          isEnable: controller.isEnable.value,
                                          bottomPadding: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Deal No",
                                    controller: controller.dealNoController,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                    isEnable: controller.isEnable.value,
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Pay route",
                                    controller: controller.payRouteController,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                    isEnable: controller.isEnable.value,
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Pay Mode",
                                    controller: controller.payModeController,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                    isEnable: controller.isEnable.value,
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Spot Amt",
                                    controller: controller.spoyAmountController,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                    isEnable: controller.isEnable.value,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                  SizedBox(height: 5),
                  CheckBoxWidget1(title: "Select All", isEnable: false),
                  Expanded(
                    child: GetBuilder<AuditCancellationController>(
                        id: "grid",
                        builder: (controller) {
                          return Container(
                            child: (controller.cancellationRetrieveModel != null &&
                                controller.cancellationRetrieveModel?.infoCancellationBookingList !=
                                    null &&
                                controller.cancellationRetrieveModel?.infoCancellationBookingList
                                    ?.canDisplayDetails !=
                                    null &&
                                controller.cancellationRetrieveModel?.infoCancellationBookingList
                                    ?.canDisplayDetails
                                    ?.lstCancellations != null &&
                                (controller.cancellationRetrieveModel?.infoCancellationBookingList
                                    ?.canDisplayDetails
                                    ?.lstCancellations?.length ?? 0) > 0
                            ) ?
                            DataGridFromMap3(
                              showSrNo: true,
                              hideCode: false,
                              formatDate: false,
                              columnAutoResize: true,
                              doPasccal: true,
                              minimumWidth: 180,
                              colorCallback: (row) {
                              return (row.row.cells
                                  .containsValue(controller.stateManager?.currentCell))
                                  ? Colors.deepPurple.shade200
                                  : Colors.white ;
                              },
                              exportFileName: "Secondary Asrun Modification",
                              mode: PlutoGridMode.normal,
                              checkBoxColumnKey: const ["audited", "requested"],
                              checkBoxStrComparison: true,
                              noEditcheckBoxColumnKey: const ["audited", "requested"],
                              onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent? event) {
                                // dragSpotsDialog();
                              },
                              // hideKeys: const [],
                              mapData: controller.cancellationRetrieveModel!
                                  .infoCancellationBookingList!.canDisplayDetails
                              !.lstCancellations!
                                  .map((e) => e.toJson())
                                  .toList(),
                              // mapData: (controllerX.dataList)!,
                              widthRatio: Get.width / 9 - 1,
                              onload: (PlutoGridOnLoadedEvent load) {
                                controller.stateManager = load.stateManager;
                              },
                            ) : Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                            ),
                          );
                        }),
                  ),
                  Get.find<HomeController>().getCommonButton1(
                    Routes.R_O_AUDIT,
                        (btnName) {
                          if (btnName == "Save") {
                            controller.saveFunCall();
                          } else if (btnName == "Clear") {
                            // controller.clearAll();
                            Get.back(result: true);
                          } else if (btnName == "Docs") {
                            controller.docs();
                          }
                        },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
