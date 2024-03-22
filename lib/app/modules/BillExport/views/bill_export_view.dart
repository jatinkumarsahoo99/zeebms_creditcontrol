import 'dart:async';

import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextFieldExpanded.dart';
import 'package:bms_creditcontrol/widgets/sized_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../controllers/bill_export_controller.dart';

class BillExportView extends GetView<BillExportController> {
  BillExportView({Key? key}) : super(key: key);

  BillExportController controller =
      Get.put<BillExportController>(BillExportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: Obx(() {
        return controller.canDialogShow.value
            ? DraggableFab(
                initPosition: Offset((Get.width / 3.83), Get.height / 4),
                child: controller.dialogWidget!,
              )
            : SizedBox();
      }),
      body: GetBuilder(
          init: controller,
          id: "init",
          builder: (controller) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .55,
                // height: MediaQuery,
                // height: MediaQuery.of(context).size.width * 1,

                child: Dialog(
                  backgroundColor: Colors.grey[100],
                  child: SizedBox(
                    height: Get.height * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AppBar(
                          title: const Text('Bill Export'),
                          centerTitle: true,
                          backgroundColor: Colors.deepPurple,
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropDownField.formDropDown1WidthMapExpand(
                                  controller.initModel?.lstLocation ?? [],
                                  (value) {
                                    controller.selectedLocation = value;
                                  },
                                  "Location",
                                  selected: controller.selectedLocation,
                                ),
                                sizedBoxHeight(5),
                                DropDownField.formDropDown1WidthMapExpand(
                                  controller.initModel?.lstChannel ?? [],
                                  (value) {
                                    controller.selectedChannel = value;
                                  },
                                  "Channel",
                                  selected: controller.selectedChannel,
                                ),
                                sizedBoxHeight(5),
                                DropDownField.formDropDown1WidthMapExpand(
                                  controller.initModel?.lstAgency ?? [],
                                  (value) {
                                    controller.selectedAgency = value;
                                  },
                                  "Agency",
                                  selected: controller.selectedAgency,
                                ),

                                sizedBoxHeight(5),

                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // InputFields.
                                    // sizedBoxWidth(5),
                                    Obx(() {
                                      return Expanded(
                                        child: DateWithThreeTextFieldExpanded(
                                          title: "From",
                                          mainTextController:
                                              controller.tecFrom.value,
                                          // widthRation: .10,
                                          // titleInLeft: true,
                                        ),
                                      );
                                    }),
                                    sizedBoxWidth(5),

                                    Obx(() {
                                      return Expanded(
                                        child: DateWithThreeTextFieldExpanded(
                                          title: "To",
                                          mainTextController:
                                              controller.tecTo.value,
                                          widthRation: .10,
                                          onFocusChange: (date, focus) {
                                            if (!focus) controller.getDetails();
                                          },
                                          // titleInLeft: true,
                                        ),
                                      );
                                    }),
                                  ],
                                ),

                                sizedBoxHeight(5),

                                // from
                                GetBuilder<BillExportController>(
                                    init: controller,
                                    id: "grid",
                                    builder: (logic) {
                                      return Expanded(
                                        child: (controller.gridData != null &&
                                                controller.gridData.isNotEmpty)
                                            ? DataGridFromMap(
                                                mapData: controller.gridData
                                                    .map((e) => e.toJson())
                                                    .toList(),
                                                exportFileName: "Bill Export",
                                                checkRowKey: "Select",
                                                hideKeys: ["select"],
                                                checkRow: true,
                                                widthSpecificColumn: {
                                                  "printBillNumber":200
                                                },
                                                onload: (plutoGridRow) {
                                                  controller.stateManager =
                                                      plutoGridRow.stateManager;
                                                  int i = -1;
                                                  controller.gridData
                                                      .map((e) => e.toJson())
                                                      .toList()
                                                      .forEach((element) {
                                                    i = ++i;
                                                    plutoGridRow.stateManager
                                                        .setRowChecked(
                                                            plutoGridRow
                                                                .stateManager
                                                                .rows[i],
                                                            element["select"]);
                                                  });
                                                },
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                      );
                                    }),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                // Column(
                                //   // mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     SizedBox(
                                //       width: 80,
                                //       child: FormButton(
                                //         btnText: "Add",
                                //         callback: () {},
                                //         showIcon: false,
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       height: 10,
                                //     ),
                                //     SizedBox(
                                //       width: 80,
                                //       child: FormButton(
                                //         btnText: "Remove",
                                //         callback: () {},
                                //         showIcon: false,
                                //       ),
                                //     )
                                //   ],
                                // ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FormButton1(
                                      btnText: "Save",
                                      callback: () {
                                        controller.saveDetails();
                                      },
                                    ),
                                    sizedBoxWidth(10),
                                    FormButton1(
                                      btnText: "Clear",
                                      callback: () {
                                        Get.delete<BillExportController>();
                                        Get.find<HomeController>().clearPage1();
                                      },
                                    ),
                                    sizedBoxWidth(10),
                                    FormButtonWrapper(
                                      btnText: "Exit",
                                      callback: (){},
                                    ),
                                    sizedBoxWidth(10),
                                    FormButton1(
                                      btnText: "Data",
                                      callback: () {
                                        controller.getDataDetails();
                                        showData();
                                      },
                                    ),
                                  ],
                                )
                                // Get.find<HomeController>().getCommonButton(
                                //   Routes.BILL_EXPORT,
                                //   (btnName) {},
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<bool>? showData() {
    controller.completerDialog = Completer<bool>();
    // Completer<bool> completer = Completer<bool>();
    controller.dialogWidget = Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<BillExportController>(
                init: controller,
                id: "grid1",
                builder: (logic) {
                  return SizedBox(
                    height: Get.height * 0.5,
                    width: Get.height * 0.85,
                    child: (controller.modelData != null &&
                            (controller.modelData?.isNotEmpty ?? false))
                        ? DataGridFromMap(
                            mapData: controller.modelData!,
                            exportFileName: "Bill Export",
                            onload: (plutoGridRow) {
                              controller.stateManager1 =
                                  plutoGridRow.stateManager;
                            },
                          )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                          ),
                  );
                }),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormButton(
                  btnText: "Done",
                  callback: () {
                    controller.dialogWidget = null;
                    controller.canDialogShow.value = false;
                    // completer.complete(true);
                    controller.completerDialog?.complete(true);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
    controller.canDialogShow.value = true;
    return controller.completerDialog?.future;
  }
}
