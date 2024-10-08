import 'package:bms_creditcontrol/app/providers/SizeDefine.dart';
import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:bms_creditcontrol/widgets/radio_column.dart';
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
            children: [
              Expanded(
                flex: 4,
                child: Column(
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
                      height: 4,
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(6, 20, 1, 10),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        "Billing Period",
                                        style: TextStyle(
                                          fontSize: SizeDefine.labelSize1,
                                        ),
                                      ),
                                    ),
                                    DateWithThreeTextField(
                                      title: "",
                                      mainTextController:
                                          controller.billingPeriod,
                                      widthRation: 0.15,
                                      isEnable: true,
                                      onFocusChange: (date) {
                                        controller.manageBillingPeriod();
                                      },
                                    ),
                                    DateWithThreeTextField(
                                      title: "",
                                      mainTextController:
                                          controller.billingPeriod2,
                                      widthRation: 0.15,
                                      isEnable: true,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Text(
                                        "Billing Period",
                                        style: TextStyle(
                                            fontSize: SizeDefine.labelSize1,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.15,
                                      height: Get.height * 0.12,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Center(
                                        child: Obx(
                                          () => RadioColumn(
                                            items: const ["Agency", "Group"],
                                            groupValue: controller
                                                    .selectionCurrentType
                                                    .value ??
                                                "",
                                            onchange: (val) {
                                              controller.selectionCurrentType
                                                  .value = val;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.15,
                                      height: Get.height * 0.12,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Obx(
                                            () => SizedBox(
                                              width: Get.width * 0.1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0,
                                                    left: 1,
                                                    right: 0,
                                                    bottom: 1),
                                                child: FormButtonWrapper(
                                                  btnText: "Get Agency",
                                                  callback: () {
                                                    controller.postAgency();
                                                  },
                                                  showIcon: true,
                                                  isEnabled: !controller
                                                      .isConsolidated.value,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0,
                                                  left: 1,
                                                  right: 0,
                                                  bottom: 2),
                                              child: FormButtonWrapper(
                                                btnText: "Clear",
                                                callback: () {
                                                  controller.clear();
                                                },
                                                showIcon: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 50,
                          top: 12,
                          child: Container(
                            color: Colors.white,
                            child: const Text(
                              "SELECTION OPTION",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(6, 20, 1, 10),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: Get.width * 0.15,
                                      height: Get.height * 0.12,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Center(
                                        child: Obx(
                                          () => RadioColumn(
                                            items: const ["Domestic", "ATL"],
                                            groupValue: controller
                                                    .sendingCurrentType.value ??
                                                "",
                                            onchange: (val) {
                                              // print("Response>>>" + val);
                                              controller.sendingCurrentType
                                                  .value = val;
                                              controller
                                                  .sendingOptionRadioButtion(
                                                      val);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InputFields.formField1(
                                hintTxt: "From Mail ID:",
                                controller: controller.mailID,
                                width: 0.37,
                                onchanged: (value) {},
                                autoFocus: false,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Obx(
                                    () => Checkbox(
                                        value: controller.isTestMail.value,
                                        onChanged: (val) {
                                          controller.isTestMail.value =
                                              !(controller.isTestMail.value);
                                        }),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text("Test Mail"),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                ],
                              ),
                              InputFields.formField1(
                                hintTxt: "To:",
                                controller: controller.toTEC,
                                width: 0.37,
                                onchanged: (value) {},
                                autoFocus: false,
                                maxLen: 200,
                              ),
                              InputFields.formField1(
                                hintTxt: "CC:",
                                controller: controller.ccTEC,
                                width: 0.37,
                                onchanged: (value) {},
                                autoFocus: false,
                                maxLen: 200,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 50,
                          top: 12,
                          child: Container(
                            color: Colors.white,
                            child: const Text(
                              "SENDING OPTION",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  flex: 5,
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
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "  Check",
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                            ),
                                            child: const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "  AgencyName",
                                                style: const TextStyle(
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (c, i) {
                                          return Row(
                                            children: [
                                              Container(
                                                width: 80,
                                                child: Center(
                                                  child: Checkbox(
                                                      value: controller
                                                          .agencyGroupList![i]
                                                          .isSelected,
                                                      onChanged: (v) {
                                                        controller
                                                            .agencyGroupList![i]
                                                            .isSelected = v;
                                                        controller.update([
                                                          "agencyGroupList"
                                                        ]);
                                                      }),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller.agencyGroupList![i]
                                                        .value ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 13),
                                              )
                                            ],
                                          );
                                        },
                                        itemCount: controller
                                                .agencyGroupList?.length ??
                                            0,
                                      ),
                                    ),
                                  ],
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
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(1, 10, 1, 5),
                        padding: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: GetBuilder(
                          init: controller,
                          id: 'eBills',
                          builder: (controller) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
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
                                        print("All");
                                      } else {
                                        controller.isBills.value =
                                            !controller.isBills.value;
                                      }
                                      if (controller.isBills.isTrue &&
                                          controller.isTC.isTrue &&
                                          controller.isSummary.isTrue) {
                                        controller.isAll.value = true;
                                        print("All true");
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
                                        controller.isTC.value =
                                            !controller.isTC.value;
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
                                        controller.isSummary.value =
                                            !controller.isSummary.value;
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
                              ],
                            );
                          },
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 3,
                        child: Container(
                          color: Colors.white,
                          child: const Text(
                            "Agency/Group",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  FormButtonWrapper(
                    btnText: "Create Xml",
                    callback: () {
                      controller.createXML();
                    },
                    showIcon: true,
                  ),
                ],
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
