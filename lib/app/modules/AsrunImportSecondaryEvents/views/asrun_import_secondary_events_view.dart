import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/pluto_grid.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
import 'package:bms_creditcontrol/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../controllers/asrun_import_secondary_events_controller.dart';

class AsrunImportSecondaryEventsView
    extends GetView<AsrunImportSecondaryEventsController> {
  AsrunImportSecondaryEventsView({Key? key}) : super(key: key);
  AsrunImportSecondaryEventsController controller =
      Get.put<AsrunImportSecondaryEventsController>(
          AsrunImportSecondaryEventsController());
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
                    () => DropDownField.formDropDown1WidthMap(
                      controller.location.value,
                      (value) {
                        controller.selectLocation.value = value;
                        controller.getChannel(value.key);
                      },
                      "Location",
                      .23,
                      autoFocus: true,
                      selected: controller.selectLocation.value,
                      isEnable: controller.isEnabel.value,
                      inkWellFocusNode: controller.locationFN,
                    ),
                  ),
                  Obx(
                    () => DropDownField.formDropDown1WidthMap(
                      controller.channel.value,
                      (data) {
                        controller.selectChannel.value = data;
                      },
                      "Channel",
                      .23,
                      selected: controller.selectChannel.value,
                      isEnable: controller.isEnabel.value,
                      inkWellFocusNode: controller.channelFN,
                    ),
                  ),
                  DateWithThreeTextField(
                    title: "Log Date",
                    mainTextController: controller.logDate,
                    widthRation: .135,
                    onFocusChange: (date) {
                      controller.isEnabel.value = false;
                    },
                  ),
                  FormButtonWrapper(
                    btnText: "Import File",
                    callback: () {
                      controller.pickFile();
                    },
                    showIcon: false,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(
                () => Expanded(
                  child: controller.asrunImportList.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                        )
                      : DataGridFromMap3(
                          mapData: controller.asrunImportList.value
                              .map((e) => e.toJson())
                              .toList(),
                          mode: PlutoGridMode.normal,
                          onload: (load) {
                            controller.asrunGrid = load.stateManager;
                            load.stateManager
                                .setSelectingMode(PlutoGridSelectingMode.row);
                          },
                          colorCallback: (colorEvent) {
                            if (colorEvent.row.cells.containsValue(
                                controller.asrunGrid?.currentCell)) {
                              return Colors.deepPurple.shade100;
                            }
                            return Colors.white;
                          },
                          hideCode: false,
                          exportFileName: "Asrun Import Secondary Events",
                          widthSpecificColumn: Get.find<HomeController>()
                              .getGridWidthByKey(
                                  userGridSettingList:
                                      controller.userGridSetting1?.value),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Get.find<HomeController>().getCommonButton(
                  Routes.ASRUN_IMPORT_SECONDARY_EVENTS,
                  handleAutoClear: false,
                  disableBtns: ['Save', 'Refresh'],
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
