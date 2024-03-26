import 'package:bms_creditcontrol/app/modules/CompanyChannelLink/ChannelLinkMasterData.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/pluto_grid.dart';
import 'package:bms_creditcontrol/widgets/gridFromMap.dart';
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder(
                    init: controllerX,
                    builder: (builder) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              DateWithThreeTextField(
                                title: "Date",
                                mainTextController: controllerX.tecDate,
                                widthRation: controllerX.widthRatio,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(() => DropDownField.formDropDown1WidthMap(
                                    controllerX.companyList.value,
                                    (value) {
                                      controllerX.selectedCompany = value;
                                      controllerX.onGenerate();
                                      // controllerX.selectStation = value;
                                    },
                                    "Company",
                                    controllerX.widthRatio,
                                    // isEnable: controllerX.isEnable.value,
                                    // selected: controllerX.selectStation,
                                    dialogHeight: 250,
                                  )),
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
                                                      SizeDefine.fontSizeTab +
                                                          2,
                                                  color: Colors.black),
                                            )),
                                        Mode.body: SizedBox(
                                            width: controllerX.widthOfTab,
                                            child: Text(
                                              'Body',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                      SizeDefine.fontSizeTab +
                                                          2,
                                                  color: Colors.black),
                                            )),
                                      },
                                      onValueChanged: (Mode? value) {
                                        print("Index1 is>>" + value.toString());
                                        controllerX.calendarView.value = value!;
                                      },
                                      groupValue:
                                          controllerX.calendarView.value,
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
                      );
                    })),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Get.find<HomeController>().getCommonButton(
              Routes.EMAIL_BILL_DETAILS,
              // handleAutoClear: false,
              // disableBtns: ['Save', 'Refresh'],
              (btnName) {
                controllerX.formHandler(btnName);
              },
            ),
          ),
          // GetBuilder<HomeController>(
          //     id: "buttons",
          //     init: Get.find<HomeController>(),
          //     builder: (controller) {
          //       try {
          //         PermissionModel formPermissions = Get.find<MainController>()
          //             .permissionList!
          //             .lastWhere(
          //                 (element) => element.appFormName == "frmBilling");
          //         if (controller.buttons != null) {
          //           return Padding(
          //             padding: const EdgeInsets.only(left: 5.0, bottom: 5),
          //             child: Wrap(
          //               spacing: 5,
          //               runSpacing: 15,
          //               alignment: WrapAlignment.start,
          //               children: [
          //                 for (var btn in controller.buttons!)
          //                   FormButtonWrapper(
          //                     btnText: btn["name"],
          //                     callback: Utils.btnAccessHandler2(btn['name'],
          //                                 controller, formPermissions) ==
          //                             null
          //                         ? null
          //                         : () => controllerX.formHandler(
          //                               btn['name'],
          //                             ),
          //                   )
          //               ],
          //             ),
          //           );
          //         } else {
          //           return Container();
          //         }
          //       } catch (e) {
          //         return const Text("No Access");
          //       }
          //     })
        ],
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
                              // onChanged: (val) {
                              //   controllerX.all1.value = val!;
                              // },
                              onChanged: (val) {
                                controllerX.all1.value =
                                    !controllerX.all1.value;
                                for (var i = 0;
                                    i < controllerX.gridData.length;
                                    i++) {
                                  controllerX.gridData.value[controllerX
                                          .stateManager!
                                          .refRows[i]
                                          .sortIdx]['selected'] =
                                      controllerX.all1.value.toString();
                                  controllerX.stateManager!.changeCellValue(
                                    controllerX.stateManager!
                                        .getRowByIdx(i)!
                                        .cells['selected']!,
                                    controllerX.all1.value.toString(),
                                    callOnChangedEvent: false,
                                    force: true,
                                    notify: true,
                                  );
                                  // print(controller.responseData);
                                  controllerX.gridData.refresh();
                                }
                                // controller.checkAll(val ?? false);
                                // for (var element in controllerX.gridData.value) {
                                //   element['selected'] = controllerX.all1.value;
                                //   return element;
                                // }
                                // for (var i = 0;
                                //     i < controller.gridData.length;
                                //     i++) {
                                //   controller.gridData.value[controller
                                //           .stateManager!.refRows[i].sortIdx]
                                //       ['selected'] = controller.all1.value;
                                //   controller.stateManager!.changeCellValue(
                                //     controller.stateManager!
                                //         .getRowByIdx(i)!
                                //         .cells['selected']!,
                                //     controller.all1.value.toString(),
                                //     callOnChangedEvent: false,
                                //     force: true,
                                //     notify: true,
                                //   );
                                //   controllerX.gridData.value =F
                                //       controllerX.gridData.value;

                                //   // print(controller.responseData);
                                //   // controller.gridData.refresh();
                                // }
                                // controllerX.selectUnselectAll();
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
                  // width: Get.width * 0.079,
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
                  child: InputFields.numbersWithoutHint1(
                    hintTxt: "",
                    controller: controllerX.counter1_,
                    isNegativeReq: false,
                    width: 0.10,
                    removeArrowFocus: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: InputFields.numbersWithoutHint1(
                    hintTxt: "",
                    controller: controllerX.counter2_,
                    isNegativeReq: false,
                    width: 0.10,
                    removeArrowFocus: true,
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
                                controllerX.callChangeAllFromTo(
                                  isChecked: controllerX.all2.value,
                                  txtToRowValue: int.tryParse(
                                          controllerX.counter2_.text) ??
                                      0,
                                  txtFromNoValue: int.tryParse(
                                          controllerX.counter1_.text) ??
                                      0,
                                );
                                // controllerX.callChangeAllFromTo(
                                //   controllerX.all2.value,
                                //   int.tryParse(controllerX.),
                                //   txtFromNoValue,
                                //   tblLogRows,
                                // );
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
                  // Expanded(
                  //   child: Container(
                  //     // height: 350,
                  //     // width: 400,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(0)),
                  //         border: Border.all(color: Colors.black26)),
                  //     child: Container(),
                  //   ),
                  // ),
                  Expanded(
                      child: Obx(() => DataGridFromMap3(
                            mode: PlutoGridMode.normal,
                            doPasccal: true,
                            mapData: controllerX.gridData.value,
                            checkBoxColumnKey: ["selected"],
                            exportFileName: "Email bill details",
                            checkBoxStrComparison: "true",
                            uncheckCheckBoxStr: "false",
                            actionIconKey: ["selected"],
                            onload: (PlutoGridOnLoadedEvent load) {
                              controllerX.stateManager = load.stateManager;
                            },
                            actionOnPress: (position, isSpaceCalled) {
                              controllerX.handleactionOnPressChangeInward(
                                position,
                                isSpaceCalled,
                              );
                            },
                            colorCallback: (colorEvent) {
                              if (colorEvent.row.cells.containsValue(
                                  controllerX.stateManager?.currentCell)) {
                                return Colors.deepPurple.shade100;
                              }

                              return Colors.white;
                            },
                            onEdit: (event) {
                              controllerX.inwardLastSelectedIdx = event.rowIdx;
                              controllerX.gridData[event.rowIdx]['selected'] =
                                  (event.value.toString()) == "true";
                            },
                          ))),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormButtonWrapper(
                        btnText: "       Summary          ",
                        callback: () {
                          controllerX.onSummary();
                        },
                        showIcon: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "            Bills              ",
                        callback: () {
                          controllerX.onBills(true);
                        },
                        // => controllerX.formHandler(send a
                        //   "Bills",
                        // ),
                        showIcon: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "              TC               ",
                        callback: () => controllerX.formHandler(
                          "TC",
                        ),
                        showIcon: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "             test              ",
                        callback: () => controllerX.formHandler(
                          "test",
                        ),
                        showIcon: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "       Save Config      ",
                        callback: () {
                          // controllerX.onSaveConfig();
                          controllerX.onSaveConfig(showDailog: true);
                        },
                        showIcon: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "       Load Config      ",
                        callback: () {
                          controllerX.loadConfig();
                        },
                        showIcon: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FormButtonWrapper(
                        btnText: "  Send All Together ",
                        callback: () {
                          controllerX.onBills(false);

                          // controllerX.
                        },

                        // => controllerX.formHandler(
                        //   "Send All Together",
                        // ),
                        showIcon: false,
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
          Obx(
            () => DropDownField.formDropDown1WidthMap(
              controllerX.fromList.value,
              (value) {
                controllerX.selectedFrom = value;
                // controllerX.selectStation = value;
              },
              "From",
              (controllerX.widthRatio1),
              // isEnable: controllerX.isEnable.value,
              // selected: controllerX.selectStation,
              dialogHeight: Get.height * controllerX.widthRatio,
              selected: controllerX.selectedFrom,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          InputFields.formField1(
            hintTxt: "Test To",
            controller: controllerX.tecTestTo,
            width: (controllerX.widthRatio1),
          ),
          Row(
            children: [
              InputFields.formField1(
                hintTxt: "Path",
                controller: controllerX.tecPath,
                width: (controllerX.widthRatio1) - 0.024,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: IconButton(
                    onPressed: () {
                      // controllerX.selectFiles();
                      // controllerX.pickFolder();
                      // controllerX.pickFolder();
                      // var resp = controllerX._getFolderPath();
                      // controllerX._getFolderPath;
                    },
                    icon: Icon(Icons.upload)),
              )
            ],
          ),

          Expanded(
            child: InputFields.formFieldExpandedVertical(
              hintTxt: "",
              controller: controllerX.tecbody,
              expands: true,
            ),
          )

          // Expanded(
          //   child: TextField(
          //     controller: controllerX.tecbody,
          //     maxLines: null, // AcontrollerX.tecbodyllows unlimited lines
          //     expands: true,
          //     textAlign: TextAlign.start,
          //     textAlignVertical: TextAlignVertical.top,
          //     decoration: InputDecoration(
          //       hintText: 'Enter your text here...',
          //       border: InputBorder.none,
          //       // filled: true,
          //     ),
          //   ),
          // ),
          // InputFields.formField1WidthBox(
          //   hintTxt: "",
          //   controller: controllerX.tecbody,
          //   widthRatio: Get.width * 0.58,
          //   // height: Get.height * 0.43,
          //   maxLen: 10000,
          //   paddingLeft: 0,
          // ),
          // Container(
          //   height: 200.0, // Set the desired height here
          //   // decoration: BoxDecoration(
          //   //   border: Border.all(color: Colors.grey),
          //   //   borderRadius: BorderRadius.circular(10.0),
          //   // ),
          //   child: TextField(
          //     controller: controllerX.tecbody,
          //     maxLines: null, // Allows unlimited lines
          //     decoration: InputDecoration(
          //       contentPadding: EdgeInsets.all(16.0),
          //       hintText: 'Enter your text here...',
          //       border: InputBorder.none,
          //     ),
          //   ),
          // ),

          // Expanded(
          //   child: Container(
          //     // decoration: BoxDecoration(
          //     //   border: Border.all(color: Colors.grey),
          //     //   borderRadius: BorderRadius.circular(10.0),
          //     // ),
          //     padding: EdgeInsets.all(16.0),
          //     child: TextField(
          //       controller: controllerX.tecbody,
          //       maxLines: null, // Allows unlimited lines
          //       decoration: InputDecoration(
          //         hintText: 'Enter your text here...',
          //         border: InputBorder.none,
          //       ),
          //     ),
          //   ),
          // ),

          // InputFields.formFieldExpand2(
          //   // bottomPaddingHeight: 3,
          //   hintTxt: "",
          //   controller: controllerX.tecbody,
          //   // keyboardType: TextInputType.multiline,
          //   inputformatters: [],

          //   maxLen: null,
          //   // height: 60,
          //   expands: true,
          // ),
          // Expanded(
          //   child: Container(
          //     color: Colors.amber,
          //     child: InputFields.formFieldExpand2(
          //       hintTxt: "Remarks",
          //       // titleInLeft: true,
          //       controller: controllerX.tecbody,
          //       titleSizeboxWidth: 80,
          //       removeHeight: true,
          //       expands: true,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

enum Mode { bills, body }
