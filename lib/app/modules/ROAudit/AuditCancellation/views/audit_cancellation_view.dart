import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../widgets/CheckBoxWidget.dart';
import '../../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../../widgets/FormButton.dart';
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
                                        controller.selectedLocation = value;
                                      },
                                      "Location",
                                      // titleInLeft: true,
                                      selected: controller.selectedLocation,
                                      titleSizeBoxWidth: 75,
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
                                        controller.selectedChannel = value;
                                      },
                                      "Channel",
                                      // titleInLeft: true,
                                      selected: controller.selectedChannel,
                                      titleSizeBoxWidth: 75,
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
                                      controller: controller.tecRefNo,
                                      autoFocus: true,
                                      titleSizeboxWidth: 80,
                                      bottomPadding: false),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DateWithThreeTextField(
                                          title: "Ref Date",
                                          mainTextController:
                                              TextEditingController(),
                                          isEnable: false,
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Expanded(
                                        child: InputFields.formFieldExpand2(
                                            hintTxt: "Book No",
                                            controller: controller.tecBookNo,
                                            autoFocus: true,
                                            titleSizeboxWidth: 80,
                                            bottomPadding: false),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxHeight(5),
                            DropDownField.formDropDownSearchAPI2Expand(
                              GlobalKey(),
                              context,
                              title: "Client",
                              url: "",
                              onchanged: (value) {
                                controller.selectedClient = value;
                              },
                              selectedValue: controller.selectedClient,
                              parseKeyForKey: "",
                              parseKeyForValue: "",
                              textSizeboxWidth: 85,
                            ),
                            sizedBoxHeight(5),
                            DropDownField.formDropDownSearchAPI2Expand(
                              GlobalKey(),
                              context,
                              title: "Agency",
                              url: "",
                              onchanged: (value) {
                                controller.selectedAgency = value;
                              },
                              selectedValue: controller.selectedAgency,
                              parseKeyForKey: "",
                              parseKeyForValue: "",
                              textSizeboxWidth: 85,
                            ),
                            sizedBoxHeight(5),
                            DropDownField.formDropDownSearchAPI2Expand(
                              GlobalKey(),
                              context,
                              title: "Brand",
                              url: "",
                              onchanged: (value) {
                                controller.selectedBrand = value;
                              },
                              selectedValue: controller.selectedBrand,
                              parseKeyForKey: "",
                              parseKeyForValue: "",
                              textSizeboxWidth: 85,
                            ),
                            sizedBoxHeight(5),
                            InputFields.formFieldExpand2(
                                hintTxt: "Executive",
                                controller: controller.tecRefNo,
                                autoFocus: true,
                                titleSizeboxWidth: 80,
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
                                              controller.tecFpcDate,
                                          isEnable: false,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: DateWithThreeTextField(
                                          title: "Book Dt",
                                          mainTextController:
                                              controller.tecBookDate,
                                          isEnable: false,
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
                                          controller: controller.tecCancelNo,
                                          autoFocus: true,
                                          titleSizeboxWidth: 80,
                                          bottomPadding: false,
                                        ),
                                      ),
                                      sizedBoxWidth(5),
                                      SizedBox(
                                        width: 100,
                                        child: InputFields.formFieldExpand2(
                                          hintTxt: "",
                                          controller: controller.tecBlankYear,
                                          // autoFocus: true,
                                          titleSizeboxWidth: 80,
                                          bottomPadding: false,
                                        ),
                                      ),
                                      sizedBoxWidth(5),
                                      SizedBox(
                                        width: 150,
                                        child: InputFields.formFieldExpand2(
                                          hintTxt: "",
                                          controller: controller.tecRefNo,
                                          // autoFocus: true,
                                          titleSizeboxWidth: 80,
                                          bottomPadding: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Deal No",
                                    controller: controller.tecDealNo,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Pay route",
                                    controller: controller.tecPayRoute,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Pay Mode",
                                    controller: controller.tecPayMode,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Spot Amt",
                                    controller: controller.tecSpotAmt,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                  SizedBox(height: 5),
                  CheckBoxWidget1(title: "Select All"),
                  Expanded(
                    child: Obx(() {
                      return DataGridFromMap3(
                        // colorCallback: (row) {
                        //   if (row == controller.sm?.currentRow) {
                        //     return Colors.deepPurple.shade100;
                        //   } else {
                        //     return Colors.white;
                        //   }
                        // },
                        // colorCallback: (row) => (row.row.cells
                        //         .containsValue(controller.sm?.currentCell))
                        //     ? Colors.deepPurple.shade200
                        //     : Colors.white,
                        // showSecondaryDialog: false,

                        // exportFileName: "Returns Blank Tapes",
                        mapData: controller.gridData.value,
                        // controller.gridDataTableData.value,
                        // .map((e) => e.toJson())
                        // .toList(),
                        // formatDate: false,
                        // onRowDoubleTap: (event) {
                        //   controller.sm?.setCurrentCell(event.cell,
                        //       event.rowIdx); // to give focus to selected row
                        //   controller.onRowDounleTap(event);
                        //   controller.isVisibleRight.value = true;
                        // },
                        // onload: (event) {
                        //   var smNew = event.stateManager;
                        //   controller.sm = smNew;
                        //   event.stateManager
                        //       .setSelectingMode(PlutoGridSelectingMode.row);
                        //   event.stateManager
                        //       .setCurrentCell(event.stateManager.firstCell, 0);
                        //   controller.sm = event.stateManager;
                        // },
                        // hideCode: false,
                        // mode: PlutoGridMode.normal,
                        // witdthSpecificColumn: controller.showFirstGridData.value
                        //     ? {
                        //         "vouchernumber": 120,
                        //         "description": 240,
                        //         "tapeid": 120,
                        //         "partyname": 240,
                        //         "programname": 240,
                        //         "channelname": 240,
                        //         "modifiedby": 120,
                        //         "gatepassno": 120,
                        //         "epsno": 120,
                        //         "GatePassDate": 120,
                        //         "status": 120,
                        //         "exporttapecode": 120,
                        //         "VoucherDate": 120,
                        //         "record": 120
                        //       }
                        //     : {
                        //         "voucherNumber": 120,
                        //         "description": 240,
                        //         "tapeID": 120,
                        //         "partyName": 240,
                        //         "programName": 240,
                        //         "channelName": 240,
                        //         "modifiedBy": 120,
                        //         "gatePassNo": 120,
                        //         "epsNo": 120,
                        //         "GatePassDate": 120,
                        //         "status": 120,
                        //         "exportTapeCode": 120,
                        //         "VoucherDate": 180,
                        //         "record": 120,
                        //         "yearcode": 120
                        //       },
                        // witdthSpecificColumn:
                        //     Get.find<HomeController>().getGridWidthByKey(
                        //   userGridSettingList:
                        //       controller.userGridSetting1?.value,
                        // ),
                      );
                    }),
                  ),
                  Get.find<HomeController>().getCommonButton(
                    Routes.AUDIT_CANCELLATION,
                    (btnName) {},
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
