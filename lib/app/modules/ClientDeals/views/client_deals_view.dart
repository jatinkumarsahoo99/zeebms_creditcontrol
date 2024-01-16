import 'package:bms_creditcontrol/app/providers/SizeDefine.dart';
import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextFieldExpanded.dart';
import 'package:bms_creditcontrol/widgets/LabelTextStyle.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/sized_box_widget.dart';
import '../../../../widgets/texts.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';
import '../../../routes/app_pages.dart';
import '../controllers/client_deals_controller.dart';

class ClientDealsView extends GetView<ClientDealsController> {
  ClientDealsView({Key? key}) : super(key: key);

  @override
  final controller = Get.put<ClientDealsController>(
    ClientDealsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
          init: controller,
          builder: (controller) {
            print(Get.width * 0.2);
            print(Get.width * 0.1);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return DropDownField.formDropDown1WidthMapExpand(
                            controller.locationList.value ?? [],
                                (value) {
                              controller.selectedLocation?.value = value;
                              controller.update(['client']);
                              controller.getChannel(
                                  locationCode:
                                  value.key ??
                                      "");
                            },
                            "Location",
                            // .20,
                            autoFocus: true,
                            titleInLeft: true,
                            selected: controller.selectedLocation?.value,
                            titleSizeBoxWidth: 45,
                          );
                        }),
                      ),
                      sizedBoxWidth(10),
                      Expanded(
                        child: DropDownField.formDropDown1WidthMapExpand(
                            controller.channelList.value ?? [],
                                (data) {
                              controller.selectedChannel?.value = data;
                              controller.update(['client']);
                              print(">>>>>>>>>>>client"+(controller.selectedChannel?.value).toString());
                            },
                            "",
                            titleInLeft: true,
                            titleSizeBoxWidth: 50,
                            selected: controller.selectedChannel?.value
                          // .20,
                        ),
                      ),
                      sizedBoxWidth(10),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: Obx(() {
                          return DropDownField.formDropDown1WidthMapExpand(
                            controller.payMode.value ?? [],
                                (data) {
                              controller.selectPayMode?.value = data;
                            },
                            "Pay Mode",
                            titleInLeft: true,
                            selected: controller.selectPayMode?.value,
                            titleSizeBoxWidth: 50,
                            // .23,
                          );
                        }),
                      ),
                      sizedBoxWidth(10),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              // width: 50,
                              color: Colors.grey.shade400,
                              child: text_m_w700(
                                "Search Deal",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: InputFields.formFieldExpand2(
                                hintTxt: "Deal No",
                                controller: controller.dealNoController,
                                titleInLeft: true,
                                titleSizeboxWidth: 50,
                                bottomPadding: false,
                              ),
                            ),

                            sizedBoxWidth(5),
                            Expanded(
                              child: DateWithThreeTextFieldExpanded(
                                title: "Date",
                                mainTextController: controller.dateController,
                                // widthRation: .135,
                                titleInLeft: true,
                              ),
                            ),

                            // InputFields.formField(hintTxt: hintTxt, controller: controller)
                          ],
                        ),
                        // child: DropDownField.formDropDown1WidthMapExpand(
                        //   [],
                        //   (value) {},
                        //   "Location",
                        //   // .20,
                        //   autoFocus: true,
                        //   titleInLeft: true,
                        // ),
                      ),
                      sizedBoxWidth(10),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: DateWithThreeTextFieldExpanded(
                                title: "From",
                                mainTextController: controller
                                    .fromDateController,
                                // widthRation: .135,
                                titleInLeft: true,
                                titleInSizeBox: 50,
                              ),
                            ),

                            sizedBoxWidth(5),
                            Expanded(
                              child: DateWithThreeTextFieldExpanded(
                                title: "To",
                                mainTextController: controller.toDateController,
                                // widthRation: .135,
                                titleInLeft: true,
                              ),
                            ),

                            // InputFields.formField(hintTxt: hintTxt, controller: controller)
                          ],
                        ),
                      ),
                      sizedBoxWidth(10),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: Obx(() {
                          return DropDownField.formDropDown1WidthMapExpand(
                            controller.currency.value ?? [],
                                (data) {
                              controller.selectCurrency?.value = data;
                            },
                            "Currency",
                            titleInLeft: true,
                            selected: controller.selectCurrency?.value,
                            titleSizeBoxWidth: 50,
                            // .23,
                          );
                        }),
                      ),
                      sizedBoxWidth(10),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: Obx(() {
                          return DropDownField.formDropDown1WidthMapExpand(
                            controller.locationList2.value ?? [],
                                (data) {
                              controller.selectedLocation2?.value = data;
                            },
                            "Location",
                            titleInLeft: true,
                            selected: controller.selectedLocation2?.value,
                            titleSizeBoxWidth: 50,
                            // .23,
                          );
                        }),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Expanded(
                        child: GetBuilder<ClientDealsController>(
                          assignId: true,
                          id: "client",
                          builder: (controller) {
                            return DropDownField.formDropDownSearchAPI2Expand(
                              GlobalKey(),
                              context,
                              title: "Client",
                              url: "${ApiFactory
                                  .Client_Deal_GET_CLIENTS}?locationCode=${controller
                                  .selectedLocation?.value
                                  ?.key}&channelCode=${controller
                                  .selectedChannel?.value?.key}&clientName=",
                              onchanged: (value) {
                                controller.selectedClient?.value = value;
                              },
                              selectedValue: controller.selectedClient?.value,
                              textSizeboxWidth: 55,
                              customInData: "clients",
                              parseKeyForValue: "clientname",
                              parseKeyForKey: "clientcode",
                              titleInLeft: true,
                            );
                          },
                        ),
                      ),
                      sizedBoxWidth(5),
                      FormButton1(
                        btnText: "@",
                        callback: () {},
                      ),
                      sizedBoxWidth(10),
                      Expanded(
                        child: Obx(() {
                          return DropDownField.formDropDown1WidthMapExpand(
                            controller.agencyList.value ?? [],
                                (data) {
                              controller.selectAgency?.value = data;
                            },
                            "Agency",
                            titleInLeft: true,
                            selected: controller.selectAgency?.value,
                            titleSizeBoxWidth: 50,
                            // .20,
                          );
                        }),
                      ),
                      sizedBoxWidth(5),
                      FormButton1(
                        btnText: "@",
                        callback: () {},
                      ),
                      sizedBoxWidth(10),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: Obx(() {
                          return DropDownField.formDropDown1WidthMapExpand(
                            controller.dealType.value ?? [],
                                (data) {
                              controller.selectDealType?.value = data;
                            },
                            "Deal Type",
                            selected: controller.selectDealType?.value,
                            titleInLeft: true,
                            titleSizeBoxWidth: 50,
                            // .23,
                          );
                        }),
                      ),
                      sizedBoxWidth(10),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: Obx(() {
                          return DropDownField.formDropDown1WidthMapExpand(
                            controller.channelList2.value ?? [],
                                (data) {
                              controller.selectedChannel2?.value = data;
                            },
                            "Channel",
                            titleInLeft: true,
                            selected: controller.selectedChannel2?.value,
                            titleSizeBoxWidth: 50,
                            // .23,
                          );
                        }),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: InputFields.formFieldExpand2(
                                hintTxt: "Reference",
                                controller: controller.referenceController,
                                titleInLeft: true,
                                titleSizeboxWidth: 50,
                                bottomPadding: false,
                              ),
                            ),

                            sizedBoxWidth(5),
                            Expanded(
                              child: DateWithThreeTextFieldExpanded(
                                title: "Reference Date",
                                mainTextController:
                                controller.referenceDateController,
                                // widthRation: .135,
                                titleInLeft: true,
                                titleInSizeBox: 50,
                              ),
                            ),
                            // sizedBoxWidth(100),
                            // InputFields.formField(hintTxt: hintTxt, controller: controller)
                          ],
                        ),
                        // child: DropDownField.formDropDown1WidthMapExpand(
                        //   [],
                        //   (value) {},
                        //   "Location",
                        //   // .20,
                        //   autoFocus: true,
                        //   titleInLeft: true,
                        // ),
                      ),
                      sizedBoxWidth(70),
                      Expanded(
                        child: Obx(() {
                          return DropDownField.formDropDown1WidthMapExpand(
                            controller.brandList.value ?? [],
                                (data) {
                              controller.selectBrand?.value = data;
                            },
                            "Brand",
                            selected: controller.selectBrand?.value,
                            titleInLeft: true,
                            titleSizeBoxWidth: 50,
                            // .20,
                          );
                        }),
                      ),
                      sizedBoxWidth(5),
                      FormButton1(
                        btnText: "...",
                        callback: () {},
                      ),
                      sizedBoxWidth(10),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: InputFields.numbers4(
                          hintTxt: "Bk Dur",
                          controller: controller.bkDurationController,
                          titleInLeft: true,
                          titleSizeboxWidth: 45,
                        ),
                      ),
                      sizedBoxWidth(10),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: Obx(() {
                          return DropDownField.formDropDown1WidthMapExpand(
                            controller.clientList2.value ?? [],
                                (data) {
                              controller.selectedClient2?.value = data;
                            },
                            "Client",
                            titleInLeft: true,
                            selected: controller.selectedClient2?.value,
                            titleSizeBoxWidth: 50,
                            // .23,
                          );
                        }),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InputFields.numbers4(
                                          hintTxt: "Max Speed",
                                          controller: controller
                                              .maxSpeedController,
                                          titleInLeft: true,
                                          titleSizeboxWidth: 40,
                                        ),
                                      ),

                                      sizedBoxWidth(5),
                                      Expanded(
                                        child: InputFields.numbers4(
                                          hintTxt: "Amount",
                                          controller: controller
                                              .amountController,
                                          titleInLeft: true,
                                          // titleSizeboxWidth: 45,
                                        ),
                                      ),

                                      // InputFields.formField(hintTxt: hintTxt, controller: controller)
                                    ],
                                  ),
                                  // child: DropDownField.formDropDown1WidthMapExpand(
                                  //   [],
                                  //   (value) {},
                                  //   "Location",
                                  //   // .20,
                                  //   autoFocus: true,
                                  //   titleInLeft: true,
                                  // ),
                                ),
                                sizedBoxWidth(10),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InputFields.numbers4(
                                          hintTxt: "Seconds",
                                          controller: controller
                                              .secondsController,
                                          titleInLeft: true,
                                          titleSizeboxWidth: 45,
                                        ),
                                      ),

                                      sizedBoxWidth(5),
                                      Expanded(
                                        child: Obx(() {
                                          return CheckBoxWidget1(
                                            title: "Effective Rate",
                                            value: controller.effectiveRate
                                                .value,
                                            onChanged: (val) {
                                              controller.effectiveRate.value =
                                              !(controller.effectiveRate.value);
                                              controller.effectiveRate
                                                  .refresh();
                                            },
                                          );
                                        }),
                                      ),

                                      // InputFields.formField(hintTxt: hintTxt, controller: controller)
                                    ],
                                  ),
                                ),
                                sizedBoxWidth(10),
                                SizedBox(
                                  width: Get.width * 0.2,
                                  child: InputFields.numbers4(
                                    hintTxt: "Bk Amt",
                                    controller: controller.bkAmountController,
                                    titleInLeft: true,
                                    titleSizeboxWidth: 45,
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxHeight(5),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: LabelText2.style(
                                            hint: "Executive"),
                                      ),
                                      text_m_w700("Executive"),
                                    ],
                                  ),
                                ),
                                sizedBoxWidth(10),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child:
                                            LabelText2.style(hint: "Payroute"),
                                          ),
                                          text_m_w700(
                                            "Payroute",
                                          ),
                                        ],
                                      ),
                                      text_m_w700(
                                        "sssssss",
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                sizedBoxWidth(10),
                                SizedBox(
                                  width: Get.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: text_m_w700(
                                      "sssssss",
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxHeight(5),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: LabelText2.style(hint: "Zone"),
                                      ),
                                      text_m_w700("Zone"),
                                    ],
                                  ),
                                ),
                                sizedBoxWidth(10),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: LabelText2.style(
                                                hint: "Agency Pan Card"),
                                          ),
                                          text_m_w700(
                                            "Payroute",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                sizedBoxWidth(10),
                                SizedBox(
                                  width: Get.width * 0.2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      sizedBoxWidth(10),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: InputFields.formFieldExpand2(
                          hintTxt: "",
                          controller: controller.textFormFieldController,
                          showTitle: false,
                          height: 60,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: text_m_w700(
                          "GST Plant Name",
                          color: Colors.green,
                        ),
                      ),
                      text_m_w700(
                        "Label44",
                        color: Colors.green,
                      ),
                    ],
                  ),

                  sizedBoxHeight(5),

                  Row(
                    children: [
                      SizedBox(
                          width: 150,
                          child: LabelText2.style(hint: "AgencyGSTNumber")),
                      text_m_w700(
                        "Label42",
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      // LabelText2.style(hint: "Type")
                      Obx(() {
                        return CheckBoxOnRight(
                          title: "Type",
                          onChanged: (val) {
                            controller.type.value = !(controller.type.value);
                            controller.type.refresh();
                          },
                          value: controller.type.value,
                        );
                      }),

                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.accountList.value ?? [],
                              (val) {
                            controller.selectAccount?.value = val;
                          },
                          "Account",
                          .30,
                          selected: controller.selectAccount?.value,
                          titleInLeft: true,
                        );
                      }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.subTypeList.value ?? [],
                              (val) {
                            controller.selectSubType?.value = val;
                          },
                          "Sub Type",
                          .20,
                          selected: controller.selectSubType?.value,
                          titleInLeft: true,
                        );
                      }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.spotTypeList.value ?? [],
                              (val) {
                            controller.selectSpotType?.value = val;
                          },
                          "Spot Type",
                          .25,
                          selected: controller.selectSpotType?.value,
                          titleInLeft: true,
                        );
                      })
                    ],
                  ),

                  // const SizedBox(height: 5),

                  Wrap(
                    runSpacing: 5,
                    spacing: 10,
                    children: [
                      // LabelText2.style(hint: "Type")
                      SizedBox(
                        width: Get.width * .35,
                        child: DropDownField.formDropDownSearchAPI2Expand(
                          GlobalKey(),
                          context,
                          title: "Program",
                          url: "",
                          selectedValue: controller.selectProgram?.value,
                          onchanged: (value) {
                            controller.selectProgram?.value = value;
                          },
                          // width: Get.width * 0.3,
                          titleInLeft: true,
                          textSizeboxWidth: 60,
                        ),
                      ),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.brandList2.value ?? [],
                              (val) {
                            controller.selectBrand2?.value = val;
                          },
                          "Band",
                          .20,
                          selected: controller.selectBrand2?.value,
                          titleInLeft: true,
                        );
                      }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.addInfoList.value ?? [],
                              (val) {
                            controller.selectAddInfo?.value = val;
                          },
                          "AddInfo",
                          .30,
                          selected: controller.selectAddInfo?.value,
                          titleInLeft: true,
                        );
                      }),
                      // Spacer(),

                      Obx(() {
                        return CheckBoxWidget1(
                          title: "Week End",
                          value: controller.weekEnd.value,
                          onChanged: (val) {
                            controller.weekEnd.value =
                            !(controller.weekEnd.value);
                            controller.weekEnd.refresh();
                          },
                        );
                      }),

                      sizedBoxWidth(100),
                      Obx(() {
                        return CheckBoxWidget1(
                          title: "Week Day",
                          value: controller.weekDay.value,
                          onChanged: (val) {
                            controller.weekDay.value = val!;
                            controller.weekDay.refresh();
                          },
                        );
                      }),
                      sizedBoxWidth(50),
                      Obx(() {
                        return CheckBoxOnRight(
                          title: "Mon",
                          onChanged: (val) {
                            controller.mon.value = val!;
                            controller.mon.refresh();
                          },
                          value: controller.mon.value,
                        );
                      }),
                      Obx(() {
                        return CheckBoxOnRight(
                          title: "Tue",
                          onChanged: (val) {
                            controller.tue.value = val!;
                            controller.tue.refresh();
                          },
                          value: controller.tue.value,
                        );
                      }),
                      Obx(() {
                        return CheckBoxOnRight(
                          title: "Wed",
                          value: controller.wed.value,
                          onChanged: (val) {
                            controller.wed.value = val!;
                            controller.wed.refresh();
                          },
                        );
                      }),
                      Obx(() {
                        return CheckBoxOnRight(
                          title: "Thu",
                          onChanged: (val) {
                            controller.thu.value = val!;
                            controller.thu.refresh();
                          },
                          value: controller.thu.value,
                        );
                      }),
                      Obx(() {
                        return CheckBoxOnRight(
                          title: "Fri",
                          value: controller.fri.value,
                          onChanged: (val) {
                            controller.fri.value = val!;
                            controller.fri.refresh();
                          },
                        );
                      }),
                      Obx(() {
                        return CheckBoxOnRight(
                          title: "Sat",
                          onChanged: (val) {
                            controller.sat.value = val!;
                            controller.sat.refresh();
                          },
                          value: controller.sat.value,
                        );
                      }),
                      Obx(() {
                        return CheckBoxOnRight(
                          title: "Sun",
                          value: controller.sun.value,
                          onChanged: (val) {
                            controller.sun.value = val!;
                            controller.sun.refresh();
                          },
                        );
                      }),

                      SizedBox(
                        width: Get.width * 0.15,
                        child: InputFields.formFieldNumberMask(
                          hintTxt: "Start Time",
                          controller: controller.startTime,
                          widthRatio: 0.15,

                          // isEnable: controllerX.isEnable,
                          onEditComplete: (val) {
                            // controllerX.calculateDuration();
                          },
                          // isTime: true,
                          // isEnable: controller.isEnable.value,
                          paddingLeft: 0,
                        ),
                      ),

                      SizedBox(
                        width: Get.width * 0.15,
                        child: InputFields.formFieldNumberMask(
                          hintTxt: "End Time",
                          controller: controller.startTime,
                          widthRatio: 0.15,
                          // isEnable: controllerX.isEnable,
                          onEditComplete: (val) {
                            // controllerX.calculateDuration();
                          },
                          // isTime: true,
                          // isEnable: controller.isEnable.value,
                          paddingLeft: 0,
                        ),
                      ),

                      // SizedBox(
                      //   width: Get.width * 0.15,
                      //   child: InputFields.formFieldExpand2(
                      //     hintTxt: "End time",
                      //     controller: TextEditingController(),
                      //     titleInLeft: true,
                      //     titleSizeboxWidth: 50,
                      //     bottomPadding: false,
                      //   ),
                      // ),

                      // Spacer(),

                      SizedBox(
                        width: Get.width * 0.20,
                        child: InputFields.numbers4(
                          hintTxt: "Seconds",
                          controller: controller.secondsController2,
                          titleInLeft: true,
                          // titleSizeboxWidth: 45,
                          fieldWidth: 0.15,
                        ),
                      ),

                      SizedBox(
                        width: Get.width * 0.25,
                        child: InputFields.numbers4(
                          hintTxt: "Rate per 100 seconds",
                          controller: controller.ratePerTenSecondsController,
                          titleInLeft: true,
                          // titleSizeboxWidth: 45,
                          fieldWidth: 0.15,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.20,
                        child: InputFields.numbers4(
                          hintTxt: "Amount",
                          controller: controller.amountController2,
                          titleInLeft: true,
                          // titleSizeboxWidth: 45,
                          fieldWidth: 0.15,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.20,
                        child: InputFields.numbers4(
                          hintTxt: "Val Rate",
                          controller: controller.valueRateController,
                          titleInLeft: true,
                          // titleSizeboxWidth: 45,
                          fieldWidth: 0.15,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 5,
                    spacing: 10,
                    children: [
                      FormButton1(
                        btnText: "Add",
                        callback: () {},
                      ),
                      FormButton1(
                        btnText: "Clear",
                        callback: () {},
                      ),
                      FormButton1(
                        btnText: "Duplicate",
                        callback: () {},
                      ),
                      sizedBoxWidth(100),
                      FormButton1(
                        btnText: "Remarks",
                        callback: () {},
                      ),
                      FormButton1(
                        btnText: "Compare",
                        callback: () {},
                      ),
                      sizedBoxWidth(100),
                      FormButton1(
                        btnText: "Import",
                        callback: () {},
                      ),
                      text_m_w700("xxx", color: Colors.blue)
                    ],
                  ),

                  const SizedBox(height: 5),
                  // Obx(
                  //   () =>
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  ),

                  SizedBox(
                    // width: 40,
                    height: 10,
                  ),

                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Get.find<HomeController>().getCommonButton(
                      Routes.CLIENT_DEALS,
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
