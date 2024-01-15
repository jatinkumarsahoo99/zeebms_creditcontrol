import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:bms_creditcontrol/widgets/radio_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/radio_row1.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/email_bill_details_controller.dart';

class EmailBillDetailsView extends GetView<EmailBillDetailsController> {
  EmailBillDetailsView({Key? key}) : super(key: key);
  EmailBillDetailsController controllerX =
      Get.put<EmailBillDetailsController>(EmailBillDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DateWithThreeTextField(
                        title: "Date",
                        mainTextController: TextEditingController(),
                        widthRation: controllerX.widthRatio,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropDownField.formDropDown1WidthMap(
                        [],
                        (value) {
                          // controllerX.selectStation = value;
                        },
                        "Company",
                        controllerX.widthRatio,
                        // isEnable: controllerX.isEnable.value,
                        // selected: controllerX.selectStation,
                        dialogHeight: Get.height * controllerX.widthRatio,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CupertinoSlidingSegmentedControl<Mode>(
                            children: <Mode, Widget>{
                              Mode.bills: Text(
                                'Bills',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeDefine.fontSizeTab,
                                ),
                              ),
                              Mode.body: Text(
                                'Body',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeDefine.fontSizeTab,
                                ),
                              ),
                            },
                            onValueChanged: (Mode? value) {
                              print("Index1 is>>" + value.toString());
                              controllerX.calendarView.value = value!;
                            },
                            groupValue: controllerX.calendarView.value,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Divider(),
                          controllerX.calendarView == Mode.bills
                              ? getBills()
                              : getBody()
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          GetBuilder<HomeController>(
              id: "buttons",
              init: Get.find<HomeController>(),
              builder: (controller) {
                try {
                  PermissionModel formPermissions = Get.find<MainController>()
                      .permissionList!
                      .lastWhere(
                          (element) => element.appFormName == "frmBilling");
                  if (controller.buttons != null) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 15,
                        alignment: WrapAlignment.start,
                        children: [
                          for (var btn in controller.buttons!)
                            FormButtonWrapper(
                              btnText: btn["name"],
                              callback: Utils.btnAccessHandler2(btn['name'],
                                          controller, formPermissions) ==
                                      null
                                  ? null
                                  : () => controllerX.formHandler(
                                        btn['name'],
                                      ),
                            )
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                } catch (e) {
                  return const Text("No Access");
                }
              })
        ],
      ),
    );
  }

  Widget getBills() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: RadioRow1(
                    items: ["Summary", "Bills", "TC"],
                    groupValue: controllerX.selectRadio.value,
                    onchange: (v) {
                      controllerX.selectRadio.value = v;
                    },
                    rightPad: 15,
                  ),
                );
              }),
              SizedBox(
                width: Get.width * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5),
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Checkbox(
                            value: controllerX.all1.value,
                            onChanged: (val) {
                              controllerX.all1.value = val!;
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 5),
                      child: Text(
                        "All",
                        style: TextStyle(
                            fontSize: SizeDefine.labelSize1,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width * 0.079,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5),
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Checkbox(
                            value: controllerX.sendTest.value,
                            onChanged: (val) {
                              controllerX.sendTest.value = val!;
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 5),
                      child: Text(
                        "Send Only Test",
                        style: TextStyle(
                            fontSize: SizeDefine.labelSize1,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: InputFields.numbersWithoutHint(
                  hintTxt: "",
                  controller: controllerX.counter1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: InputFields.numbersWithoutHint(
                  hintTxt: "",
                  controller: controllerX.counter2,
                ),
              ),
              SizedBox(
                width: Get.width * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5),
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Checkbox(
                            value: controllerX.all2.value,
                            onChanged: (val) {
                              controllerX.all2.value = val!;
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 5),
                      child: Text(
                        "All",
                        style: TextStyle(
                            fontSize: SizeDefine.labelSize1,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  // height: 350,
                  // width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black26)),
                ),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormButtonWrapper(
                    btnText: "Summary",
                    callback: () => controllerX.formHandler(
                      "Summary",
                    ),
                  ),
                  SizedBox(height: 4,),
                  FormButtonWrapper(
                    btnText: "Bills",
                    callback: () => controllerX.formHandler(
                      "Bills",
                    ),
                  ),
                  SizedBox(height: 4,),
                  FormButtonWrapper(
                    btnText: "TC",
                    callback: () => controllerX.formHandler(
                      "TC",
                    ),
                  ),
                  SizedBox(height: 4,),
                  FormButtonWrapper(
                    btnText: "test",
                    callback: () => controllerX.formHandler(
                      "test",
                    ),
                  ),
                  SizedBox(height: 4,),
                  FormButtonWrapper(
                    btnText: "Save Config",
                    callback: () => controllerX.formHandler(
                      "Save Config",
                    ),
                  ),
                  SizedBox(height: 4,),
                  FormButtonWrapper(
                    btnText: "Load Config",
                    callback: () => controllerX.formHandler(
                      "Load Config",
                    ),
                  ),
                  SizedBox(height: 4,),
                  FormButtonWrapper(
                    btnText: "Send All\nTogether",
                    callback: () => controllerX.formHandler(
                      "Send All Together",
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return Column(
      children: [],
    );
  }
}

enum Mode { bills, body }
