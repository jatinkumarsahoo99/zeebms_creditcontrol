import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/agency_embargo_controller.dart';

class AgencyEmbargoView extends GetView<AgencyEmbargoController> {
  AgencyEmbargoView({Key? key}) : super(key: key);

  AgencyEmbargoController controller =
      Get.put<AgencyEmbargoController>(AgencyEmbargoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (controller) {
          return Center(
            child: SizedBox(
              width: Get.width * .60,
              child: Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      title: const Text('Agency Embargo'),
                      centerTitle: true,
                      backgroundColor: Colors.deepPurple,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        runSpacing: 5,
                        spacing: Get.width * 0.01,
                        children: [
                          DropDownField.formDropDownSearchAPI2(
                            GlobalKey(),
                            context,
                            title: "Agency Name",
                            parseKeyForKey: "programCode",
                            parseKeyForValue: "programName",
                            url: "",
                            onchanged: (data) {},
                            width: Get.width * 0.26,
                          ),
                          DateWithThreeTextField(
                            title: "Billing Period",
                            mainTextController: controller.date,
                            widthRation: .140,
                          ),
                          InputFields.formField1(
                            hintTxt: "Embargo No.",
                            controller: controller.embargoNo,
                            width: .107,
                            readOnly: true,
                          ),
                          InputFields.formFieldExpand2(
                            hintTxt: "Reason",
                            controller: controller.reson,
                            height: 70,
                            expands: true,
                          )
                        ],
                      ),
                    ),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: CupertinoSlidingSegmentedControl<String>(
                          thumbColor: CupertinoColors.white,
                          groupValue: controller.selectedTab.value,
                          children: Map.fromEntries(controller.mainTabs
                              .map((e) => MapEntry(e, Text(e)))),
                          onValueChanged: (value) {
                            controller.pageController.jumpToPage(controller
                                .mainTabs
                                .indexWhere((element) => element == value));
                            controller.selectedTab.value = value!;
                          },
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        child: PageView(
                          controller: controller.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            //Embargo Grid
                            // controller.showList.isEmpty
                            //     ?
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                            ),
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

                            //Agency Grid
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Get.find<HomeController>().getCommonButton(
                        Routes.AGENCY_EMBARGO,
                        handleAutoClear: false,
                        (btnName) {
                          controller.formHandler(btnName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  embargoListGrid() {
    // controller.showList.isEmpty
    //     ?
    Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
    );
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
  }

  agencyHistoryGrid() {
    // controller.showList.isEmpty
    //     ?
    Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
    );
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
  }
}
