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
      id: 'init',
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
                    Expanded(
                      child: GetBuilder<EbillsController>(
                          init: controller,
                          id: "checkListCompany",
                          builder: (context) {
                            return (controller.lstCheckListCompany != null &&
                                    (controller
                                            .lstCheckListCompany?.isNotEmpty ??
                                        false))
                                ? Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    child: ListView.builder(
                                      itemBuilder: (c, i) {
                                        return Row(
                                          children: [
                                            Checkbox(
                                                value: controller
                                                    .lstCheckListCompany![i]
                                                    .isSelected,
                                                onChanged: (v) {
                                                  controller
                                                      .lstCheckListCompany![i]
                                                      .isSelected = v;
                                                  controller.update(
                                                      ["checkListCompany"]);
                                                }),
                                            Text(
                                              controller.lstCheckListCompany![i]
                                                      .value ??
                                                  "",
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            )
                                          ],
                                        );
                                      },
                                      itemCount: controller
                                              .lstCheckListCompany?.length ??
                                          0,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                    ),
                                  );
                          }),
                    ),
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
                            callback: () {
                              controller.postAgency();
                            },
                            showIcon: false,
                            isEnabled: !controller.isConsolidated.value,
                          ),
                        ),
                        FormButtonWrapper(
                          btnText: "Clear",
                          callback: () {
                            controller.clear();
                          },
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
                          controller: controller.toTEC,
                          width: .32,
                        ),
                        InputFields.formField1(
                          hintTxt: "Cc:",
                          controller: controller.ccTEC,
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
              Expanded(
                  child: GetBuilder<EbillsController>(
                      init: controller,
                      id: "agencyGroupList",
                      builder: (context) {
                        return (controller.agencyGroupList != null &&
                                (controller.agencyGroupList?.isNotEmpty ??
                                    false))
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: ListView.builder(
                                  itemBuilder: (c, i) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                            value: controller
                                                .agencyGroupList![i].isSelected,
                                            onChanged: (v) {
                                              controller.agencyGroupList![i]
                                                  .isSelected = v;
                                              controller
                                                  .update(["agencyGroupList"]);
                                            }),
                                        Text(
                                          controller
                                                  .agencyGroupList![i].value ??
                                              "",
                                          style: const TextStyle(fontSize: 13),
                                        )
                                      ],
                                    );
                                  },
                                  itemCount:
                                      controller.agencyGroupList?.length ?? 0,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                              );
                      })),
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
