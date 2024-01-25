import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/controller/MainController.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/pluto_grid.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
import 'package:bms_creditcontrol/widgets/gridFromMap.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../controllers/combo_deal_entry_controller.dart';

class ComboDealEntryView extends GetView<ComboDealEntryController> {
  ComboDealEntryView({Key? key}) : super(key: key);

  ComboDealEntryController controller =
      Get.put<ComboDealEntryController>(ComboDealEntryController());
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
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                runSpacing: 5,
                spacing: 5,
                children: [
                  Obx(
                    () => InputFields.numbersWithFocus(
                      hintTxt: "Group No",
                      controller: controller.groupNo,
                      isNegativeReq: false,
                      width: 0.135,
                      isEnabled: controller.isAllEnabels.value,
                      focusNode: controller.groupNoFN,
                      autoFocus: true,
                    ),
                  ),
                  Obx(
                    () => DateWithThreeTextField(
                      title: "Date",
                      mainTextController: controller.date,
                      widthRation: .135,
                      isEnable: controller.isAllEnabels.value,
                    ),
                  ),
                  Obx(() {
                    return CheckBoxWidget1(
                      title: "Show Selected",
                      value: controller.isShow.value,
                      onChanged: (val) async {
                        controller.isShow.value = !(controller.isShow.value);
                        if (controller.tabelDealList.isNotEmpty) {
                          if (controller.isShow.isTrue) {
                            controller.doubleClickFilterGrid(
                                controller.tabelDealGrid, "selected", "true");
                          } else {
                            if (Get.find<MainController>().filters1.containsKey(
                                controller.tabelDealGrid.hashCode.toString())) {
                              await controller.clearFirstDataTableFilter(
                                  controller.tabelDealGrid!);
                            }
                          }
                        }
                      },
                      fn: controller.showSelectedFN,
                    );
                  }),
                  Obx(
                    () => DropDownField.formDropDownSearchAPI2(
                      GlobalKey(),
                      context,
                      title: "Client",
                      parseKeyForKey: "ClientCode",
                      parseKeyForValue: "ClientName",
                      url: ApiFactory.COMBO_DEAL_ENTRY_SEARCH_CLIENT,
                      onchanged: (data) {
                        controller.selectClient.value = data;
                        controller.getAgency(data.key);
                      },
                      width: Get.width * 0.25,
                      selectedValue: controller.selectClient.value,
                      isEnable: controller.isAllEnabels.value,
                      inkwellFocus: controller.clientFN,
                    ),
                  ),
                  Obx(
                    () => DropDownField.formDropDown1WidthMap(
                      controller.agency,
                      (data) {
                        controller.selectAgency.value = data;
                        controller.getAgencyLeave(
                            controller.selectClient.value?.key ?? "",
                            data.key,
                            controller.date.text);
                      },
                      "Agency",
                      .25,
                      selected: controller.selectAgency.value,
                      isEnable: controller.isAgencyEnabels.value,
                      inkWellFocusNode: controller.agencyFN,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(
                () => Expanded(
                  child: controller.tabelDealList.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                        )
                      : DataGridFromMap3(
                          focusNode: controller.tabelDealFN,
                          mapData: controller.tabelDealList.value
                              .map((e) => e.toJson())
                              .toList(),
                          onload: (value) {
                            controller.tabelDealGrid = value.stateManager;
                            value.stateManager.setCurrentCell(
                              value.stateManager
                                  .getRowByIdx(0)
                                  ?.cells['selected'],
                              0,
                              notify: true,
                            );
                          },
                          exportFileName: "Combo Deal Entry",
                          checkBoxColumnKey: ['selected'],
                          checkBoxStrComparison: "true",
                          uncheckCheckBoxStr: "false",
                          actionIconKey: ['selected'],
                          actionOnPress: (position, isSpaceCalled) {
                            controller.handleactionOnPressChangeInward(
                                position, isSpaceCalled);
                          },
                          onEdit: (row) {
                            controller.handleOnCheckBoxChangeInward(row);
                          },
                          colorCallback: (colorEvent) {
                            if (colorEvent.row.cells.containsValue(
                                controller.tabelDealGrid?.currentCell)) {
                              return Colors.deepPurple.shade100;
                            }

                            return Colors.white;
                          },
                          widthSpecificColumn:
                              Get.find<HomeController>().getGridWidthByKey(
                            userGridSettingList:
                                controller.userGridSetting1?.value,
                            key: "key1",
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Expanded(
                  child: controller.tabelLinkDealList.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                        )
                      : DataGridFromMap3(
                          mapData: controller.tabelLinkDealList.value,
                          onload: (value) {
                            controller.tabelLinkDealGrid = value.stateManager;
                          },
                          hideCode: false,
                          columnAutoResize: false,
                          exportFileName: "Mix Master Delivery Status",
                          colorCallback: (colorEvent) {
                            if (colorEvent.row.cells.containsValue(
                                controller.tabelLinkDealGrid?.currentCell)) {
                              return Colors.deepPurple.shade100;
                            }

                            return Colors.white;
                          },
                          widthSpecificColumn:
                              Get.find<HomeController>().getGridWidthByKey(
                            userGridSettingList:
                                controller.userGridSetting1?.value,
                            key: "key2",
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Get.find<HomeController>().getCommonButton(
                  Routes.COMBO_DEAL_ENTRY,
                  handleAutoClear: false,
                  (btnName) {
                    controller.formHandler(btnName);
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
