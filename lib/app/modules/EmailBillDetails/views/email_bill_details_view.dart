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
      body: Center(
        child: SizedBox(
          width: Get.width * 0.6,
          child: Dialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text('Email Bill Details'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                SizedBox(
                  height: 5,
                ),
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
                            child: Container(
                              // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CupertinoSlidingSegmentedControl<Mode>(
                                    children: <Mode, Widget>{
                                      Mode.bills: SizedBox(
                                          width: controllerX.widthOfTab,
                                          child: Text(
                                            'Bills',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize:
                                                    SizeDefine.fontSizeTab + 2,
                                                color: Colors.black),
                                          )),
                                      Mode.body: SizedBox(
                                          width: controllerX.widthOfTab,
                                          child: Text(
                                            'Body',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize:
                                                    SizeDefine.fontSizeTab + 2,
                                                color: Colors.black),
                                          )),
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
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  controllerX.calendarView == Mode.bills
                                      ? getBills()
                                      : getBody()
                                ],
                              ),
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
                        PermissionModel formPermissions =
                            Get.find<MainController>()
                                .permissionList!
                                .lastWhere((element) =>
                                    element.appFormName == "frmBilling");
                        if (controller.buttons != null) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, bottom: 5),
                            child: Wrap(
                              spacing: 5,
                              runSpacing: 15,
                              alignment: WrapAlignment.start,
                              children: [
                                for (var btn in controller.buttons!)
                                  FormButtonWrapper(
                                    btnText: btn["name"],
                                    callback: Utils.btnAccessHandler2(
                                                btn['name'],
                                                controller,
                                                formPermissions) ==
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
          ),
        ),
      ),
    );
  }

  Widget getBills() {
    return Expanded(
      child: Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                      rightPad: 2,
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
                      controller: controllerX.counter1_,
                      width: 0.10),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: InputFields.numbersWithoutHint(
                      hintTxt: "",
                      controller: controllerX.counter2_,
                      width: 0.10),
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
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // height: 350,
                      // width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          border: Border.all(color: Colors.black26)),
                      child: Container(),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormButtonWrapper(
                        btnText: "       Summary          ",
                        callback: () => controllerX.formHandler(
                          "Summary",
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "            Bills              ",
                        callback: () => controllerX.formHandler(
                          "Bills",
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "              TC               ",
                        callback: () => controllerX.formHandler(
                          "TC",
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "             test              ",
                        callback: () => controllerX.formHandler(
                          "test",
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "       Save Config      ",
                        callback: () => controllerX.formHandler(
                          "Save Config",
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "       Load Config      ",
                        callback: () => controllerX.formHandler(
                          "Load Config",
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "  Send All Together ",
                        callback: () => controllerX.formHandler(
                          "Send All Together",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropDownField.formDropDown1WidthMap(
            [],
            (value) {
              // controllerX.selectStation = value;
            },
            "From",
            (controllerX.widthRatio1),
            // isEnable: controllerX.isEnable.value,
            // selected: controllerX.selectStation,
            dialogHeight: Get.height * controllerX.widthRatio,
          ),
          SizedBox(
            height: 5,
          ),
          InputFields.formField1(
            hintTxt: "Test To",
            controller: controllerX.testTo_,
            width: (controllerX.widthRatio1),
          ),
          Row(
            children: [
              InputFields.formField1(
                hintTxt: "Path",
                controller: controllerX.path_,
                width: (controllerX.widthRatio1) - 0.024,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.upload)),
              )
            ],
          ),
          InputFields.formField1WidthBox(
              hintTxt: "",
              controller: controllerX.body_,
              widthRatio: Get.width * 0.58,
              height: Get.height * 0.43,
              maxLen: 10000,
              paddingLeft: 0)
        ],
      ),
    );
  }
}

enum Mode { bills, body }
