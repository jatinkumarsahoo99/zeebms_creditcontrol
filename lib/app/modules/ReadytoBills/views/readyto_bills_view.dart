import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/pluto_grid.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
import 'package:bms_creditcontrol/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/readyto_bills_controller.dart';

class ReadytoBillsView extends GetView<ReadytoBillsController> {
  ReadytoBillsView({Key? key}) : super(key: key);
  ReadytoBillsController controller =
      Get.put<ReadytoBillsController>(ReadytoBillsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
      id: "update",
      init: controller,
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                runSpacing: 5,
                spacing: 5,
                children: [
                  DropDownField.formDropDown1WidthMap(
                    controller.location,
                    (data) {
                      controller.selectLocation.value = data;
                      controller.getChannel(data.key);
                    },
                    "Loaction",
                    .18,
                    selected: controller.selectLocation.value,
                    autoFocus: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    controller.channel,
                    (data) {
                      controller.selectChannel.value = data;
                    },
                    "Channel",
                    .18,
                    selected: controller.selectChannel.value,
                  ),
                  DateWithThreeTextField(
                    title: "From Date",
                    mainTextController: controller.fromDate,
                    widthRation: .100,
                  ),
                  DateWithThreeTextField(
                    title: "To Date",
                    mainTextController: controller.toDate,
                    widthRation: .100,
                    onFocusChange: (date) {
                      controller.getBillingStatus();
                    },
                  ),
                  FormButtonWrapper(
                    btnText: "Mark For Billing",
                    callback: () {
                      controller.mark();
                    },
                    showIcon: false,
                  ),
                  Obx(() {
                    return CheckBoxWidget1(
                      title: "R4",
                      value: controller.isR4.value,
                      onChanged: (val) {
                        controller.isR4.value = !(controller.isR4.value);
                      },
                    );
                  }),
                  DropDownField.formDropDownSearchAPI2(
                    GlobalKey(),
                    context,
                    title: "Agency",
                    parseKeyForKey: "agencycode",
                    parseKeyForValue: "agencyname",
                    url: ApiFactory.READY_TO_BILLS_GET_AGENCIES,
                    onchanged: (data) {
                      controller.selectAgency.value = data;
                    },
                    width: Get.width * 0.19,
                  ),
                  FormButtonWrapper(
                    btnText: "Check Duplocate",
                    callback: () {
                      controller.duplicateCheck();
                    },
                    showIcon: false,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  children: [
                    Obx(
                      () => Expanded(
                        child: controller.billingsList.isEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                              )
                            : DataGridFromMap4(
                                mapData: controller.billingsList.value
                                    .map((e) => e.toJson())
                                    .toList(),
                                onload: (value) {
                                  controller.billingGrid = value.stateManager;
                                },
                                editKeys: const ['remark'],
                                exportFileName: "Ready to Bills",
                                noEditcheckBoxColumnKey: const [
                                  'asRunImport',
                                  'asRunVerification',
                                  'schedulingVerification',
                                  'schedulingClearance',
                                  'finalCheck',
                                ],
                                checkBoxColumnKey: const [
                                  'asRunImport',
                                  'asRunVerification',
                                  'schedulingVerification',
                                  'schedulingClearance',
                                  'finalCheck',
                                  'readyToBill',
                                ],
                                checkBoxStrComparison: "true",
                                uncheckCheckBoxStr: "false",
                                actionIconKey: ['readyToBill'],
                                actionOnPress: (position, isSpaceCalled) {
                                  controller.lastSelectedIdx =
                                      position.rowIdx ?? 0;
                                  if (isSpaceCalled) {
                                    controller.billingGrid!.changeCellValue(
                                      controller.billingGrid!.currentCell!,
                                      controller.billingGrid!.currentCell!
                                                  .value ==
                                              "true"
                                          ? "false"
                                          : "true",
                                      force: true,
                                      callOnChangedEvent: true,
                                      notify: true,
                                    );
                                  }
                                },
                                onEdit: (row) {
                                  print(row.column.field);
                                  print('===========');
                                  controller.lastSelectedIdx = row.rowIdx ?? 0;

                                  if (row.column.field == 'remark') {
                                    controller.billingsList[row.rowIdx].remark =
                                        row.value.toString();
                                  } else {
                                    controller.billingsList[row.rowIdx]
                                            .readyToBill =
                                        row.value != "true" ? false : true;
                                  }

                                  print(controller
                                      .billingsList[row.rowIdx].readyToBill);
                                },
                                columnAutoResize: false,
                                widthSpecificColumn: Get.find<HomeController>()
                                    .getGridWidthByKey(
                                        userGridSettingList:
                                            controller.userGridSetting1?.value,
                                        key: 'key1'),
                                // sort: PlutoColumnSort.descending,
                                // enableSort: true,
                                onColumnHeaderSingleTap: () {
                                  // print(controller
                                  //     .billingGrid!.refColumns[8].key);
                                  if (controller
                                          .billingGrid!.refColumns[8].field ==
                                      "remark") {
                                    controller.filterList();
                                  }
                                },
                              ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 350,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Get.find<HomeController>().getCommonButton(
                        Routes.READYTO_BILLS,
                        handleAutoClear: false,
                        buttonNameList: [
                          'Delete',
                          'Refresh',
                          'Clear',
                          'Exit',
                          'Search',
                          'Docs'
                        ],
                        (btnName) {
                          controller.formHandler(btnName);
                        },
                      ),
                      for (int index = 0;
                          index < (controller.extraButtonName.length);
                          index++) ...{
                        const SizedBox(
                          width: 5,
                        ),
                        FormButtonWrapper(
                          btnText: controller.extraButtonName[index],
                          callback: () {
                            controller
                                .formHandler(controller.extraButtonName[index]);
                          },
                          showIcon: false,
                        )
                      }
                    ],
                  )),
            ],
          ),
        );
      },
    ));
  }
}
