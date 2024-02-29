import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        body: GetBuilder<ViewDealChangeHistoryController>(
      init: controller,
      builder: (builder) {
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
                        // autoFocus: true,
                        // titleInLeft: true,
                        selected: controller.selectedLocation,
                      )),
                  Obx(() => DropDownField.formDropDown1WidthMap(
                        controller.channelList.value,
                        (data) {
                          controller.selectedChannel = data;
                          // if (controller.selectedChannel != null) {
                          controller.onChannelLeave();
                          // }
                        },
                        "Channel",
                        // titleInLeft: true,
                        .20,
                        selected: controller.selectedChannel,
                        // node
                        // onFocusChange: (value) {
                        //   // controller.onChannelLeave();
                        //   if (!value) {
                        //     if (controller.selectedChannel != null) {
                        //       controller.onChannelLeave();
                        //     }
                        //   }
                        // },
                      )),
                  Obx(() => DropDownField.formDropDown1WidthMap(
                        controller.clientList.value,
                        (data) {
                          controller.selectedClient = data;
                          controller.onClientLeave();
                        },
                        "Client",
                        // titleInLeft: true,
                        .30,
                        selected: controller.selectedClient,
                        // onFocusChange: (value) {
                        //   if (!value) {
                        //     if (controller.selectedClient != null) {
                        //       controller.onClientLeave();
                        //     }
                        //   }
                        // },
                      )),
                  Obx(() => DropDownField.formDropDown1WidthMap(
                          controller.dealNoList.value, (data) {
                        controller.selectedDealNo = data;
                      },
                          "Deal No",
                          // titleInLeft: true,
                          .15,
                          selected: controller.selectedDealNo)),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: FormButtonWrapper(
                      btnText: "Show Deal History",
                      callback: () {
                        controller.getDealHistory();
                      },
                      showIcon: false,
                      fontSize: 13,
                    ),
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
                    exportFileName: "View Deal Change History",
                    mapData: controller.gridData.value.map((e) {
                      if (e["changedon"] != null) {
                        e['changedon'] = DateFormat('dd-MM-yyyy hh:mm a')
                            .format(DateFormat('yyyy-MM-ddThh:mm:ss')
                                .parse(e['changedon']));
                      }
                      return e;
                    }).toList(),
                    onload: (event) {
                      controller.sm = event.stateManager;
                    },
                    keyMapping: const {"rowNO": "Row No", "dealNO": "Deal No"},
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
                  Routes.VIEW_DEAL_CHANGE_HISTORY,
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
