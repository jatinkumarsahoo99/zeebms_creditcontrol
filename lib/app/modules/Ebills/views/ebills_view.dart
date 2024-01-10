import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/CheckBoxWidget.dart';
import '../controllers/ebills_controller.dart';

class EbillsView extends GetView<EbillsController> {
  EbillsView({Key? key}) : super(key: key);
  EbillsController controller = Get.put<EbillsController>(EbillsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
      init: controller,
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 450,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      runSpacing: 5,
                      spacing: 5,
                      children: [
                        const Text(
                          "SELECTION OPTION",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(),
                        DateWithThreeTextField(
                          title: "Billing Period",
                          mainTextController: controller.billingPeriod,
                          widthRation: .160,
                        ),
                        DateWithThreeTextField(
                          title: "",
                          mainTextController: controller.billingPeriod2,
                          widthRation: .160,
                        ),
                        Obx(() => Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: controller.selectionTypes
                                  .map((e) => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Radio(
                                              value: e,
                                              groupValue: controller
                                                  .selectionCurrentType.value,
                                              onChanged: (value) {
                                                controller.selectionCurrentType
                                                    .value = e;
                                              }),
                                          Text(e)
                                        ],
                                      ))
                                  .toList(),
                            )),
                        const SizedBox(
                          width: 100,
                        ),
                        Obx(
                          () => FormButtonWrapper(
                            btnText: "Get Agency",
                            callback: () {},
                            showIcon: false,
                            isEnabled: !controller.isConsolidated.value,
                          ),
                        ),
                        FormButtonWrapper(
                          btnText: "Clear",
                          callback: () {},
                          showIcon: false,
                        ),
                        Row(),
                        const Text(
                          "SENDING OPTION",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(),
                        Obx(() => Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: controller.sendingTypes
                                  .map((e) => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Radio(
                                              value: e,
                                              groupValue: controller
                                                  .sendingCurrentType.value,
                                              onChanged: (value) {
                                                controller.sendingCurrentType
                                                    .value = e;
                                              }),
                                          Text(e)
                                        ],
                                      ))
                                  .toList(),
                            )),
                        const SizedBox(
                          width: 65,
                        ),
                        InputFields.formField1(
                          hintTxt: "Mail Id",
                          controller: controller.mailID,
                          width: .160,
                        ),
                        Obx(() {
                          return CheckBoxWidget1(
                            title: "Test Mail",
                            value: controller.isTestMail.value,
                            onChanged: (val) {
                              controller.isTestMail.value =
                                  !(controller.isTestMail.value);
                            },
                          );
                        }),
                        InputFields.formField1(
                          hintTxt: "To:",
                          controller: controller.mailID,
                          width: .32,
                        ),
                        InputFields.formField1(
                          hintTxt: "Cc:",
                          controller: controller.mailID,
                          width: .32,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
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
              const SizedBox(
                width: 8,
              ),
              GetBuilder(
                init: controller,
                id: 'eBills',
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Agency/Group",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(),
                      Obx(() {
                        return CheckBoxWidget1(
                          title: "All",
                          value: controller.isAll.value,
                          onChanged: (val) {
                            controller.checkAll();
                          },
                        );
                      }),
                      Obx(() {
                        return CheckBoxWidget1(
                          title: "Bills",
                          value: controller.isBills.value,
                          onChanged: (val) {
                            if (controller.isAll.isTrue) {
                              controller.checkAll();
                            } else {
                              controller.isBills.value = true;
                            }
                            if (controller.isBills.isTrue &&
                                controller.isTC.isTrue &&
                                controller.isSummary.isTrue) {
                              controller.isAll.value = true;
                            }
                          },
                        );
                      }),
                      Obx(() {
                        return CheckBoxWidget1(
                          title: "TC",
                          value: controller.isTC.value,
                          onChanged: (val) {
                            if (controller.isAll.isTrue) {
                              controller.checkAll();
                            } else {
                              controller.isTC.value = true;
                            }
                            if (controller.isBills.isTrue &&
                                controller.isTC.isTrue &&
                                controller.isSummary.isTrue) {
                              controller.isAll.value = true;
                            }
                          },
                        );
                      }),
                      Obx(() {
                        return CheckBoxWidget1(
                          title: "Summary",
                          value: controller.isSummary.value,
                          onChanged: (val) {
                            if (controller.isAll.isTrue) {
                              controller.checkAll();
                            } else {
                              controller.isSummary.value = true;
                            }
                            if (controller.isBills.isTrue &&
                                controller.isTC.isTrue &&
                                controller.isSummary.isTrue) {
                              controller.isAll.value = true;
                            }
                          },
                        );
                      }),
                      Obx(() {
                        return CheckBoxWidget1(
                          title: "Consolidated",
                          value: controller.isConsolidated.value,
                          onChanged: (val) {
                            controller.isConsolidated.value =
                                !(controller.isConsolidated.value);
                          },
                        );
                      }),
                      const SizedBox(
                        height: 50,
                      ),
                      FormButtonWrapper(
                        btnText: "Create Xml",
                        callback: () {},
                        showIcon: false,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        );
      },
    ));
  }
}
