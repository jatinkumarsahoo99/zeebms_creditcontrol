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
import '../../../routes/app_pages.dart';
import '../controllers/client_deals_controller.dart';

class ClientDealsView extends GetView<ClientDealsController> {
  ClientDealsView({Key? key}) : super(key: key);

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
                    child: DropDownField.formDropDown1WidthMapExpand(
                      [], (value) {}, "Location",
                      // .20,
                      autoFocus: true,
                      titleInLeft: true,
                      titleSizeBoxWidth: 45,
                    ),
                  ),
                  sizedBoxWidth(10),
                  Expanded(
                    child: DropDownField.formDropDown1WidthMapExpand(
                      [],
                      (data) {},
                      "",
                      titleInLeft: true,
                      titleSizeBoxWidth: 50,
                      // .20,
                    ),
                  ),
                  sizedBoxWidth(10),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: DropDownField.formDropDown1WidthMapExpand(
                      [],
                      (data) {},
                      "Pay Mode",
                      titleInLeft: true,
                      titleSizeBoxWidth: 50,
                      // .23,
                    ),
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
                            controller: TextEditingController(),
                            titleInLeft: true,
                            titleSizeboxWidth: 50,
                            bottomPadding: false,
                          ),
                        ),

                        sizedBoxWidth(5),
                        Expanded(
                          child: DateWithThreeTextFieldExpanded(
                            title: "Date",
                            mainTextController: TextEditingController(),
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
                            mainTextController: TextEditingController(),
                            // widthRation: .135,
                            titleInLeft: true,
                            titleInSizeBox: 50,
                          ),
                        ),

                        sizedBoxWidth(5),
                        Expanded(
                          child: DateWithThreeTextFieldExpanded(
                            title: "To",
                            mainTextController: TextEditingController(),
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
                    child: DropDownField.formDropDown1WidthMapExpand(
                      [],
                      (data) {},
                      "Currency",
                      titleInLeft: true,
                      titleSizeBoxWidth: 50,
                      // .23,
                    ),
                  ),
                  sizedBoxWidth(10),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: DropDownField.formDropDown1WidthMapExpand(
                      [],
                      (data) {},
                      "Location",
                      titleInLeft: true,
                      titleSizeBoxWidth: 50,
                      // .23,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              Row(
                children: [
                  Expanded(
                    child: DropDownField.formDropDownSearchAPI2Expand(
                      GlobalKey(),
                      context,
                      title: "Client",
                      url: "",
                      onchanged: (value) {},
                      textSizeboxWidth: 55,
                      titleInLeft: true,
                    ),
                  ),
                  sizedBoxWidth(10),
                  Expanded(
                    child: DropDownField.formDropDown1WidthMapExpand(
                      [],
                      (data) {},
                      "Agency",
                      titleInLeft: true,
                      titleSizeBoxWidth: 50,
                      // .20,
                    ),
                  ),
                  sizedBoxWidth(10),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: DropDownField.formDropDown1WidthMapExpand(
                      [],
                      (data) {},
                      "Deal Type",
                      titleInLeft: true,
                      titleSizeBoxWidth: 50,
                      // .23,
                    ),
                  ),
                  sizedBoxWidth(10),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: DropDownField.formDropDown1WidthMapExpand(
                      [],
                      (data) {},
                      "Channel",
                      titleInLeft: true,
                      titleSizeBoxWidth: 50,
                      // .23,
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
                            hintTxt: "Reference",
                            controller: TextEditingController(),
                            titleInLeft: true,
                            titleSizeboxWidth: 50,
                            bottomPadding: false,
                          ),
                        ),

                        sizedBoxWidth(5),
                        Expanded(
                          child: DateWithThreeTextFieldExpanded(
                            title: "Reference Date",
                            mainTextController: TextEditingController(),
                            // widthRation: .135,
                            titleInLeft: true,
                            titleInSizeBox: 50,
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
                    child: DropDownField.formDropDown1WidthMapExpand(
                      [],
                      (data) {},
                      "Brand",
                      titleInLeft: true,
                      titleSizeBoxWidth: 50,
                      // .20,
                    ),
                  ),
                  sizedBoxWidth(10),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: InputFields.numbers4(
                      hintTxt: "Bk Dur",
                      controller: TextEditingController(),
                      titleInLeft: true,
                      titleSizeboxWidth: 45,
                    ),
                  ),
                  sizedBoxWidth(10),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: DropDownField.formDropDown1WidthMapExpand(
                      [],
                      (data) {},
                      "Client",
                      titleInLeft: true,
                      titleSizeBoxWidth: 50,
                      // .23,
                    ),
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
                                      controller: TextEditingController(),
                                      titleInLeft: true,
                                      titleSizeboxWidth: 40,
                                    ),
                                  ),

                                  sizedBoxWidth(5),
                                  Expanded(
                                    child: InputFields.numbers4(
                                      hintTxt: "Amount",
                                      controller: TextEditingController(),
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
                                      controller: TextEditingController(),
                                      titleInLeft: true,
                                      titleSizeboxWidth: 45,
                                    ),
                                  ),

                                  sizedBoxWidth(5),
                                  Expanded(
                                    child: CheckBoxWidget1(
                                      title: "Effective Rate",
                                    ),
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
                                controller: TextEditingController(),
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
                                    child: LabelText2.style(hint: "Executive"),
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
                      controller: TextEditingController(),
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
                  CheckBoxOnRight(title: "Type"),

                  DropDownField.formDropDown1WidthMap(
                    [],
                    (p0) => null,
                    "Account",
                    .30,
                    titleInLeft: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (p0) => null,
                    "Sub Type",
                    .20,
                    titleInLeft: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (p0) => null,
                    "Spot Type",
                    .25,
                    titleInLeft: true,
                  )
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
                      onchanged: (value) {},
                      // width: Get.width * 0.3,
                      titleInLeft: true,
                      textSizeboxWidth: 60,
                    ),
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (p0) => null,
                    "Band",
                    .20,
                    titleInLeft: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (p0) => null,
                    "AddInfo",
                    .30,
                    titleInLeft: true,
                  ),
                  // Spacer(),

                  CheckBoxWidget1(title: "Week End"),

                  sizedBoxWidth(100),
                  CheckBoxWidget1(title: "Week Day"),
                  sizedBoxWidth(50),
                  CheckBoxOnRight(title: "Mon"),
                  CheckBoxOnRight(title: "Tue"),
                  CheckBoxOnRight(title: "Wed"),
                  CheckBoxOnRight(title: "Thu"),
                  CheckBoxOnRight(title: "Fri"),
                  CheckBoxOnRight(title: "Sat"),
                  CheckBoxOnRight(title: "Sun"),

                  SizedBox(
                    width: Get.width * 0.15,
                    child: InputFields.formFieldExpand2(
                      hintTxt: "Start time",
                      controller: TextEditingController(),
                      titleInLeft: true,
                      titleSizeboxWidth: 50,
                      bottomPadding: false,
                    ),
                  ),

                  SizedBox(
                    width: Get.width * 0.15,
                    child: InputFields.formFieldExpand2(
                      hintTxt: "End time",
                      controller: TextEditingController(),
                      titleInLeft: true,
                      titleSizeboxWidth: 50,
                      bottomPadding: false,
                    ),
                  ),

                  // Spacer(),

                  SizedBox(
                    width: Get.width * 0.20,
                    child: InputFields.numbers4(
                      hintTxt: "Seconds",
                      controller: TextEditingController(),
                      titleInLeft: true,
                      // titleSizeboxWidth: 45,
                      fieldWidth: 0.15,
                    ),
                  ),

                  SizedBox(
                    width: Get.width * 0.25,
                    child: InputFields.numbers4(
                      hintTxt: "Rate per 100 seconds",
                      controller: TextEditingController(),
                      titleInLeft: true,
                      // titleSizeboxWidth: 45,
                      fieldWidth: 0.15,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.20,
                    child: InputFields.numbers4(
                      hintTxt: "Amount",
                      controller: TextEditingController(),
                      titleInLeft: true,
                      // titleSizeboxWidth: 45,
                      fieldWidth: 0.15,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.20,
                    child: InputFields.numbers4(
                      hintTxt: "Val Rate",
                      controller: TextEditingController(),
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
