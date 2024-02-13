import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/TimeWithTwoTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/asrun_specification_ad_revenue_controller.dart';

class AsrunSpecificationAdRevenueView
    extends GetView<AsrunSpecificationAdRevenueController> {
  AsrunSpecificationAdRevenueView({Key? key}) : super(key: key);

  AsrunSpecificationAdRevenueController controllerX =
      Get.put<AsrunSpecificationAdRevenueController>(
          AsrunSpecificationAdRevenueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.width * 0.54,
          child: Dialog(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppBar(
                      title: Text('Channel Asrun Specification'),
                      centerTitle: true,
                      backgroundColor: Colors.deepPurple,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: Get.height * 0.79,
                        child: SingleChildScrollView(
                          child: Material(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetBuilder<
                                        AsrunSpecificationAdRevenueController>(
                                    id: "init",
                                    init: controllerX,
                                    builder: (logic) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 26,
                                              top: 8,
                                              bottom: 8),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              DropDownField.formDropDown1WidthMap(
                                                  controllerX.lstlocation ?? [],
                                                  (value) {
                                                controllerX.selectLocation =
                                                    value;
                                                controllerX.getChannel();
                                              }, "Location ", .4,
                                                  // isEnable: controllerX.isEnable.value,
                                                  // selected: controllerX.selectedBMSVersionList,
                                                  dialogHeight:
                                                      Get.height * .35,
                                                  autoFocus: true,
                                                  selected: controllerX
                                                      .selectLocation,
                                                  titleInLeft: true),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              DropDownField
                                                  .formDropDown1WidthMap(
                                                      controllerX.lstChannel ??
                                                          [], (value) {
                                                controllerX.selectChannel =
                                                    value;
                                              }, "Channel  ", .4,
                                                      dialogHeight:
                                                          Get.height * .35,
                                                      selected: controllerX
                                                          .selectChannel,
                                                      titleInLeft: true),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              DropDownField
                                                  .formDropDown1WidthMap(
                                                      controllerX.lstfiletype ??
                                                          [], (value) {
                                                controllerX.selectFileType =
                                                    value;
                                                controllerX.getPopulate();
                                                controllerX.visibleSelected();
                                              }, "File Type ", .4,
                                                      dialogHeight:
                                                          Get.height * .35,
                                                      selected: controllerX
                                                          .selectFileType,
                                                      titleInLeft: true),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.15,
                                    ),
                                    SizedBox(
                                        width: Get.width * 0.155,
                                        child: Text(
                                          "Column",
                                          style: TextStyle(
                                            fontSize: SizeDefine.labelSize1,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.155,
                                      child: Text(
                                        "Length",
                                        style: TextStyle(
                                          fontSize: SizeDefine.labelSize1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                GetBuilder<
                                        AsrunSpecificationAdRevenueController>(
                                    id: "main1",
                                    init: controllerX,
                                    builder: (logic) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "Embargo No",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: true,
                                                  isEnable: controllerX
                                                      .isEnableLeftSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.embarNo1),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: false,
                                                  isEnable: controllerX
                                                      .isEnableRightSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.embarNo2),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "Telecast Date",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: true,
                                                  isEnable: controllerX
                                                      .isEnableLeftSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.telDt1),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: false,
                                                  isEnable: controllerX
                                                      .isEnableRightSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.telDt2),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "Telecast Time",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: true,
                                                  isEnable: controllerX
                                                      .isEnableLeftSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.telTime1),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: false,
                                                  isEnable: controllerX
                                                      .isEnableRightSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.telTime2),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "Export Tape Code",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: true,
                                                  isEnable: controllerX
                                                      .isEnableLeftSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.expTapeCode1),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: false,
                                                  isEnable: controllerX
                                                      .isEnableRightSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.expTapeCode2),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "Segment No",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  isEnable: controllerX
                                                      .isEnableLeftSide,
                                                  showTitle: true,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.segNo1),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: false,
                                                  isEnable: controllerX
                                                      .isEnableRightSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.segNo2),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              InputFields.formField1WidthBox1(
                                                  hintTxt:
                                                      "Export Tape Caption",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: true,
                                                  isEnable: controllerX
                                                      .isEnableLeftSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.expCap1),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: false,
                                                  // focus: controllerX.remarkFocus,
                                                  isEnable: controllerX
                                                      .isEnableRightSide,
                                                  controller:
                                                      controllerX.expCap2),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "Tape Duration",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: true,
                                                  isEnable: controllerX
                                                      .isEnableLeftSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.tapDur1),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: false,
                                                  isEnable: controllerX
                                                      .isEnableRightSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.tapDur2),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "Recon Key",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: true,
                                                  isEnable: controllerX
                                                      .isEnableLeftSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.reconKey1),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: false,
                                                  isEnable: controllerX
                                                      .isEnableRightSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.reconKey2),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "End Time",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: true,
                                                  isEnable: controllerX
                                                      .isEnableLeftSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.endTime1),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InputFields.formField1WidthBox1(
                                                  hintTxt: "",
                                                  widthRatio: 0.155,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  showTitle: false,
                                                  isEnable: controllerX
                                                      .isEnableRightSide,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.endTime2),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                SizedBox(
                                  height: 5,
                                ),
                                GetBuilder<
                                        AsrunSpecificationAdRevenueController>(
                                    id: "main2",
                                    init: controllerX,
                                    builder: (logic) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              top: 8,
                                              bottom: 8),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.45,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    DropDownField.formDropDown1WidthMap([
                                                      DropDownValue(
                                                          key: "1", value: "+"),
                                                      DropDownValue(
                                                          key: "2", value: "-"),
                                                    ], (value) {
                                                      controllerX
                                                              .selectTimeDiff =
                                                          value;
                                                      // controllerX.getMatchDetails(programCode: value.key??"");
                                                    }, "Time Diff:", .12,
                                                        // isEnable: controllerX.isEnable.value,
                                                        // selected: controllerX.selectedBMSVersionList,
                                                        dialogHeight:
                                                            Get.height * .2,
                                                        autoFocus: true,
                                                        selected: controllerX
                                                            .selectTimeDiff,
                                                        titleInLeft: false),
                                                    Row(
                                                      children: [
                                                        TimeWithTwoTextField(
                                                          title: " ",
                                                          mainTextController:
                                                              controllerX.hhMM,
                                                          widthRation: 0.12,
                                                          isTime: false,
                                                          isEnable: true,
                                                          hideTitle: false,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 1.0,
                                                                  bottom: 1,
                                                                  top: 26),
                                                          child: Text("(hh:mm)",
                                                              style: TextStyle(
                                                                fontSize: SizeDefine
                                                                    .labelSize1,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    InputFields
                                                        .formField1WidthBox(
                                                            hintTxt:
                                                                "Date Format",
                                                            widthRatio: 0.12,
                                                            // height: 70,
                                                            paddingLeft: 0,
                                                            // showTitle: true,
                                                            // width: Get.width*0.05,
                                                            // focus: controllerX.remarkFocus,
                                                            controller:
                                                                controllerX
                                                                    .dateFormat),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              InputFields.formField1WidthBox(
                                                  hintTxt: "File Name",
                                                  widthRatio: 0.45,
                                                  // height: 70,
                                                  paddingLeft: 0,
                                                  // showTitle: true,
                                                  // width: Get.width*0.03956,
                                                  // focus: controllerX.remarkFocus,
                                                  controller:
                                                      controllerX.fileName),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.45,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InputFields
                                                        .formField1WidthBox(
                                                            hintTxt:
                                                                "As Run Type",
                                                            widthRatio: 0.12,
                                                            // height: 70,
                                                            paddingLeft: 0,
                                                            // showTitle: true,
                                                            // width: Get.width*0.05,
                                                            // focus: controllerX.remarkFocus,
                                                            controller:
                                                                controllerX
                                                                    .asRunType),
                                                    InputFields
                                                        .formField1WidthBox(
                                                            hintTxt: "SAP Flag",
                                                            widthRatio: 0.12,
                                                            // height: 70,
                                                            paddingLeft: 0,
                                                            // showTitle: true,
                                                            // width: Get.width*0.05,
                                                            // focus: controllerX.remarkFocus,
                                                            controller:
                                                                controllerX
                                                                    .sapFlag),
                                                    InputFields
                                                        .formField1WidthBox(
                                                            hintTxt:
                                                                "New Format",
                                                            widthRatio: 0.12,
                                                            // height: 70,
                                                            paddingLeft: 0,
                                                            // showTitle: true,
                                                            // width: Get.width*0.05,
                                                            // focus: controllerX.remarkFocus,
                                                            controller:
                                                                controllerX
                                                                    .newFormat),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.45,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value: controllerX
                                                                .isFpc,
                                                            onChanged: (val) {
                                                              controllerX
                                                                      .isFpc =
                                                                  val ?? false;
                                                            },
                                                            visualDensity:
                                                                const VisualDensity(
                                                                    vertical:
                                                                        -4,
                                                                    horizontal:
                                                                        -4)),
                                                        Text("FPC",
                                                            style: TextStyle(
                                                              fontSize: SizeDefine
                                                                  .labelSize1,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            )),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value: controllerX
                                                                .isMarkSlot,
                                                            onChanged: (val) {
                                                              controllerX
                                                                      .isMarkSlot =
                                                                  val ?? false;
                                                            }),
                                                        Text("Mark Slot",
                                                            style: TextStyle(
                                                              fontSize: SizeDefine
                                                                  .labelSize1,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            )),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value: controllerX
                                                                .isDontUpdate,
                                                            onChanged: (val) {
                                                              controllerX
                                                                      .isDontUpdate =
                                                                  val ?? false;
                                                            }),
                                                        Text(
                                                            "Don't Update Exposure",
                                                            style: TextStyle(
                                                              fontSize: SizeDefine
                                                                  .labelSize1,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            )),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value: controllerX
                                                                .revRunOrder,
                                                            onChanged: (val) {
                                                              controllerX
                                                                      .revRunOrder =
                                                                  val!;
                                                            }),
                                                        Text(
                                                            "Reverse As Run Order",
                                                            style: TextStyle(
                                                              fontSize: SizeDefine
                                                                  .labelSize1,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            )),
                                                      ],
                                                    ),
                                                    InputFields
                                                        .formField1WidthBox(
                                                            hintTxt:
                                                                "Max Duration Difference",
                                                            widthRatio: 0.12,
                                                            // height: 70,
                                                            paddingLeft: 0,
                                                            // showTitle: true,
                                                            // width: Get.width*0.09,
                                                            // focus: controllerX.remarkFocus,
                                                            controller:
                                                                controllerX
                                                                    .maxDuration),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GetBuilder<HomeController>(
                          id: "buttons",
                          init: Get.find<HomeController>(),
                          builder: (controller) {
                            try {
                              PermissionModel formPermissions =
                                  Get.find<MainController>()
                                      .permissionList!
                                      .lastWhere((element) =>
                                          element.appFormName ==
                                          "frmAsrunSpecification");
                              if (controller.buttons != null) {
                                return Wrap(
                                  spacing: 5,
                                  runSpacing: 15,
                                  alignment: WrapAlignment.center,
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
                                );
                              } else {
                                return Container();
                              }
                            } catch (e) {
                              return const Text("No Access");
                            }
                          }),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
