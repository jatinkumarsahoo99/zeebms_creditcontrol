import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/view_deal_change_history_controller.dart';

class ViewDealChangeHistoryView
    extends GetView<ViewDealChangeHistoryController> {
  ViewDealChangeHistoryView({Key? key}) : super(key: key);

  final controller = Get.put<ViewDealChangeHistoryController>(
    ViewDealChangeHistoryController(),
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
                  Obx(() => DropDownField.formDropDown1WidthMap(
                        controller.locationList.value,
                        (value) {
                          controller.selectedLocation = value;
                        },
                        "Location",
                        .20,
                        autoFocus: true,
                        titleInLeft: true,
                        selected: controller.selectedLocation,
                      )),
                  Obx(() => DropDownField.formDropDown1WidthMap(
                        controller.channelList.value,
                        (data) {
                          controller.selectedChannel = data;
                        },
                        "Channel",
                        titleInLeft: true,
                        .20,
                        selected: controller.selectedChannel,
                      )),
                  Obx(() => DropDownField.formDropDown1WidthMap(
                        controller.clientList.value,
                        (data) {
                          controller.selectedClient = data;
                        },
                        "Client",
                        titleInLeft: true,
                        .23,
                        selected: controller.selectedClient,
                      )),
                  Obx(() => DropDownField.formDropDown1WidthMap(
                          controller.dealNoList.value, (data) {
                        controller.selectedDealNo = data;
                      },
                          "Deal No",
                          titleInLeft: true,
                          .15,
                          selected: controller.selectedDealNo)),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormButtonWrapper(
                    btnText: "Show Deal History",
                    callback: () {
                      // controller.pickFile();
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
                    // colorCallback: (row) {
                    //   if (row == controller.sm?.currentRow) {
                    //     return Colors.deepPurple.shade100;
                    //   } else {
                    //     return Colors.white;
                    //   }
                    // },
                    exportFileName: "View Deal Change History",
                    mapData: controller.gridData.value
                        .map((e) => e.toJson())
                        .toList(),
                    // formatDate: false,
                    // onRowDoubleTap: (event) {
                    //   controller.sm?.setCurrentCell(event.cell,
                    //       event.rowIdx); // to give focus to selected row
                    //   controller.onRowDounleTap(event);
                    // },
                    onload: (event) {
                      // // controller.sm =  event.stateManager;
                      // var smNew = event.stateManager;
                      controller.sm = event.stateManager;
                    },
                    // mode: PlutoGridMode.selectWithOneTap,
                    witdthSpecificColumn:
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
                  Routes.VIEW_DEAL_CHANGE_HISTORY,
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
