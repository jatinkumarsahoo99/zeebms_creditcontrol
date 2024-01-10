import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
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
                    [],
                    (data) {},
                    "Loaction",
                    .18,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (data) {},
                    "Channel",
                    .18,
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
                  ),
                  FormButtonWrapper(
                    btnText: "Mark For Billing",
                    callback: () {},
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
                    parseKeyForKey: "programCode",
                    parseKeyForValue: "programName",
                    url: "",
                    onchanged: (data) {},
                    width: Get.width * 0.19,
                  ),
                  // SizedBox(
                  //   width: Get.width * .550,
                  // ),
                  FormButtonWrapper(
                    btnText: "Check Duplocate",
                    callback: () {},
                    showIcon: false,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  children: [
                    // Obx(
                    //   () =>
                    Expanded(
                        child:
                            // controller.showList.isEmpty
                            //     ?
                            Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                    )
                        // : DataGridFromMap3(
                        //     mapData: [],
                        //     onload: (value) {
                        //     },
                        //     exportFileName: "Mix Master Delivery Status",
                        //     witdthSpecificColumn: Get.find<HomeController>()
                        //         .getGridWidthByKey(
                        //             userGridSettingList:
                        //                 controller.userGridSetting1?.value),
                        //   ),
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
