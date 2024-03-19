import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/input_fields.dart';
import '../../../../widgets/radio_column.dart';
import '../../../providers/SizeDefine.dart';
import '../controllers/e_bills_for_bonus_activity_controller.dart';

class EBillsForBonusActivityView
    extends GetView<EBillsForBonusActivityController> {
  EBillsForBonusActivityView({Key? key}) : super(key: key);
  EBillsForBonusActivityController controller =
      Get.put<EBillsForBonusActivityController>(
          EBillsForBonusActivityController());

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
                          child: GetBuilder<EBillsForBonusActivityController>(
                              init: controller,
                              id: "checkListCompany",
                              builder: (context) {
                                return (controller.lstCheckListCompany !=
                                            null &&
                                        (controller.lstCheckListCompany
                                                ?.isNotEmpty ??
                                            false))
                                    ? Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Focus(
                                          skipTraversal: true,
                                          child: ListView.builder(
                                            itemBuilder: (c, i) {
                                              return Row(
                                                children: [
                                                  Checkbox(
                                                      value: controller
                                                          .lstCheckListCompany![
                                                              i]
                                                          .isSelected,
                                                      onChanged: (v) {
                                                        controller
                                                            .lstCheckListCompany![
                                                                i]
                                                            .isSelected = v;
                                                        controller.update([
                                                          "checkListCompany"
                                                        ]);
                                                      }),
                                                  Text(
                                                    controller
                                                            .lstCheckListCompany![
                                                                i]
                                                            .value ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                  )
                                                ],
                                              );
                                            },
                                            itemCount: controller
                                                    .lstCheckListCompany
                                                    ?.length ??
                                                0,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
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
                              // height: Get.height * 0.25,
                              margin: const EdgeInsets.fromLTRB(6, 20, 1, 10),
                              padding: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Text(
                                            "Telecast Period",
                                            style: TextStyle(
                                              fontSize: SizeDefine.labelSize1,
                                            ),
                                          ),
                                        ),
                                        DateWithThreeTextField(
                                          title: "",
                                          mainTextController:
                                              controller.telecastPeriod,
                                          widthRation: 0.15,
                                          isEnable: true,
                                          onFocusChange: (date) {
                                            controller.manageBillingPeriod();
                                          },
                                        ),
                                        DateWithThreeTextField(
                                          title: "",
                                          mainTextController:
                                              controller.telecastPeriod2,
                                          widthRation: 0.15,
                                          isEnable: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Text(
                                            "Telecast Period",
                                            style: TextStyle(
                                                fontSize: SizeDefine.labelSize1,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          width: Get.width * 0.15,
                                          height: Get.height * 0.12,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Center(
                                            child: Obx(
                                              () => RadioColumn(
                                                items: const [
                                                  "Agency",
                                                  "Group"
                                                ],
                                                groupValue: controller
                                                        .selectExportType
                                                        .value ??
                                                    "",
                                                onchange: (val) {
                                                  controller.selectExportType
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
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0,
                                                          left: 1,
                                                          right: 0,
                                                          bottom: 2),
                                                  child: FormButtonWrapper(
                                                    btnText: "Clear",
                                                    callback: () {},
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
                              // height: Get.height*0.35,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: Get.width * 0.15,
                                          height: Get.height * 0.12,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Center(
                                            child: Obx(
                                              () => RadioColumn(
                                                items: const [
                                                  "Domestic",
                                                  "ATL"
                                                ],
                                                groupValue:
                                                    controller.selRadio.value ??
                                                        "",
                                                onchange: (val) {
                                                  controller.selRadio.value =
                                                      val;
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
                                                  !(controller
                                                      .isTestMail.value);
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
                      child: GetBuilder<EBillsForBonusActivityController>(
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
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "  Check",
                                                  style: const TextStyle(
                                                      fontSize: 13),
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
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                                              .agencyGroupList![
                                                                  i]
                                                              .isSelected,
                                                          onChanged: (v) {
                                                            controller
                                                                .agencyGroupList![
                                                                    i]
                                                                .isSelected = v;
                                                            controller.update([
                                                              "agencyGroupList"
                                                            ]);
                                                          }),
                                                    ),
                                                  ),
                                                  Text(
                                                    controller
                                                            .agencyGroupList![i]
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 14.0, left: 10, right: 0),
                    child: FormButtonWrapper(
                      btnText: "Create TC Xml",
                      callback: () {
                        controller.createXML();
                      },
                      showIcon: true,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
