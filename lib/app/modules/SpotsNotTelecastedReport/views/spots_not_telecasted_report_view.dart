import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/spots_not_telecasted_report_controller.dart';

class SpotsNotTelecastedReportView
    extends GetView<SpotsNotTelecastedReportController> {
  SpotsNotTelecastedReportView({Key? key}) : super(key: key);

  final controller = Get.put<SpotsNotTelecastedReportController>(
    SpotsNotTelecastedReportController(),
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
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                runSpacing: 10,
                spacing: 10,
                children: [
                  Obx(
                    () => DropDownField.formDropDown1WidthMap(
                      controller.locationList.value,
                      (value) {
                        controller.selectedLocation = value;
                      },
                      "Location",
                      .23,
                      autoFocus: true,
                      // titleInLeft: true,
                      selected: controller.selectedLocation,
                    ),
                  ),
                  Obx(
                    () => DropDownField.formDropDown1WidthMap(
                      controller.channelList.value,
                      (data) {
                        controller.selectedChannel = data;
                      },
                      "Channel",
                      // titleInLeft: true,
                      .23,
                      selected: controller.selectedChannel,
                    ),
                  ),
                  Obx(
                    () => DateWithThreeTextField(
                      title: "From Date",
                      mainTextController: controller.tecFromDate.value,
                      widthRation: .135,
                      // titleInLeft: true,
                    ),
                  ),
                  Obx(
                    () => DateWithThreeTextField(
                      title: "To Date",
                      mainTextController: controller.tecToDate.value,
                      widthRation: .135,
                      // titleInLeft: true,
                    ),
                  ),
                  FormButtonWrapper(
                    btnText: "Generate",
                    callback: () {
                      // controller.pickFile();
                      controller.getReport();
                    },
                    showIcon: false,
                  ),
                ],
              ),

              const SizedBox(height: 10),
              // Obx(
              //   () =>
              // Expanded(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey),
              //     ),
              //   ),
              // ),

              Expanded(
                child: Obx(() {
                  return DataGridFromMap3(
                    exportFileName: "Spots Not Telecasted Report",
                    mapData: controller.gridData.value.map((e) {
                      if (e["telecastdate"] != null) {
                        e['telecastdate'] = DateFormat('dd-MM-yyyy').format(
                            DateFormat('yyyy-MM-ddThh:mm:ss')
                                .parse(e['telecastdate']));
                      }
                      if (e["billdate"] != null) {
                        if (e["billdate"] != "0001-01-01T00:00:00") {
                          e['billdate'] = DateFormat('dd-MM-yyyy').format(
                              DateFormat('yyyy-MM-ddThh:mm:ss')
                                  .parse(e['billdate']));
                        } else {
                          e['billdate'] = "";
                        }
                      }
                      return e;
                    }).toList(),
                    onload: (event) {
                      controller.sm = event.stateManager;
                      event.stateManager
                          .setSelectingMode(PlutoGridSelectingMode.row);
                    },
                    hideCode: false,
                    widthSpecificColumn:
                        Get.find<HomeController>().getGridWidthByKey(
                      userGridSettingList: controller.userGridSetting1?.value,
                    ),
                  );
                }),
              ),

              SizedBox(
                // width: 40,
                height: 10,
              ),

              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Get.find<HomeController>().getCommonButton(
                  Routes.SPOTS_NOT_TELECASTED_REPORT,
                  // handleAutoClear: false,
                  // disableBtns: ['Save', 'Refresh'],
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
