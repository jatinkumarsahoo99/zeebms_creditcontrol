import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
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
                  InputFields.numbers(
                    hintTxt: "Group No",
                    padLeft: 0,
                    inputformatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    controller: controller.groupNo,
                    onchanged: (v) {},
                    isNegativeReq: false,
                    width: 0.135,
                  ),
                  DateWithThreeTextField(
                    title: "Date",
                    mainTextController: controller.date,
                    widthRation: .135,
                  ),
                  Obx(() {
                    return CheckBoxWidget1(
                      title: "Show Selected",
                      value: controller.isShow.value,
                      onChanged: (val) {
                        controller.isShow.value = !(controller.isShow.value);
                      },
                    );
                  }),
                  DropDownField.formDropDownSearchAPI2(
                    GlobalKey(),
                    context,
                    title: "Client",
                    parseKeyForKey: "programCode",
                    parseKeyForValue: "programName",
                    url: "",
                    onchanged: (data) {},
                    width: Get.width * 0.25,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (data) {},
                    "Agency",
                    .25,
                  ),
                ],
              ),
              const SizedBox(height: 10),

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
              const SizedBox(height: 10),

              // ),
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
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Get.find<HomeController>().getCommonButton(
                  Routes.COMBO_DEAL_ENTRY,
                  handleAutoClear: false,
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
