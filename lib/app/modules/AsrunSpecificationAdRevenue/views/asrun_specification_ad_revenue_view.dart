import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/TimeWithTwoTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/asrun_specification_ad_revenue_controller.dart';

class AsrunSpecificationAdRevenueView
    extends GetView<AsrunSpecificationAdRevenueController> {
   AsrunSpecificationAdRevenueView({Key? key}) : super(key: key);


   AsrunSpecificationAdRevenueController controllerX =
   Get.put<AsrunSpecificationAdRevenueController>(AsrunSpecificationAdRevenueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.width*0.54,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    title: Text('Channel Asrun Specification'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 26,top: 8,bottom: 8),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropDownField.formDropDown1WidthMap(
                            [],
                                (value) {
                              // controllerX.selectedBMSVersionList = value;
                              // controllerX.getMatchDetails(programCode: value.key??"");
                            },
                            "Location ",
                            .4,
                            // isEnable: controllerX.isEnable.value,
                            // selected: controllerX.selectedBMSVersionList,
                            dialogHeight: Get.height * .35,
                            autoFocus: true,
                            titleInLeft: true
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          DropDownField.formDropDown1WidthMap(
                            [],
                                (value) {
                              // controllerX.selectedBMSVersionList = value;
                              // controllerX.getMatchDetails(programCode: value.key??"");
                            },
                            "Channel  ",
                            .4,
                            // isEnable: controllerX.isEnable.value,
                            // selected: controllerX.selectedBMSVersionList,
                            dialogHeight: Get.height * .35,
                            autoFocus: true,
                              titleInLeft: true
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          DropDownField.formDropDown1WidthMap(
                            [],
                                (value) {
                              // controllerX.selectedBMSVersionList = value;
                              // controllerX.getMatchDetails(programCode: value.key??"");
                            },
                            "File Type ",
                            .4,
                            // isEnable: controllerX.isEnable.value,
                            // selected: controllerX.selectedBMSVersionList,
                            dialogHeight: Get.height * .35,
                            autoFocus: true,
                              titleInLeft: true
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width*0.15,
                      ),
                      SizedBox(
                          width: Get.width*0.155,
                          child: Text("Column",
                            style: TextStyle(
                            fontSize: SizeDefine.labelSize1,
                            color: Colors.black ,
                            fontWeight: FontWeight.w500,
                          ),)),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: Get.width*0.155,
                          child: Text("Length",style: TextStyle(
                            fontSize: SizeDefine.labelSize1,
                            color: Colors.black ,
                            fontWeight: FontWeight.w500,
                          ))),

                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      InputFields.formField1WidthBox1(
                          hintTxt: "Embargo No",
                          widthRatio: 0.155,
                          // height: 70,
                          paddingLeft: 0,
                          showTitle: true,
                          // focus: controllerX.remarkFocus,
                          controller: TextEditingController()),
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
                          controller: TextEditingController()),
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
                          // focus: controllerX.remarkFocus,
                          controller: TextEditingController()),
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
                          controller: TextEditingController()),
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
                          // focus: controllerX.remarkFocus,
                          controller: TextEditingController()),
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
                          controller: TextEditingController()),
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
                          // focus: controllerX.remarkFocus,
                          controller: TextEditingController()),
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
                          controller: TextEditingController()),
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
                          showTitle: true,
                          // focus: controllerX.remarkFocus,
                          controller: TextEditingController()),
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
                          controller: TextEditingController()),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      InputFields.formField1WidthBox1(
                          hintTxt: "Export Tape Caption",
                          widthRatio: 0.155,
                          // height: 70,
                          paddingLeft: 0,
                          showTitle: true,
                          // focus: controllerX.remarkFocus,
                          controller: TextEditingController()),
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
                          controller: TextEditingController()),
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
                          // focus: controllerX.remarkFocus,
                          controller: TextEditingController()),
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
                          controller: TextEditingController()),
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
                          // focus: controllerX.remarkFocus,
                          controller: TextEditingController()),
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
                          controller: TextEditingController()),
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
                          // focus: controllerX.remarkFocus,
                          controller: TextEditingController()),
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
                          controller: TextEditingController()),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 1,top: 8,bottom: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              DropDownField.formDropDown1WidthMap(
                                  [],
                                      (value) {
                                    // controllerX.selectedBMSVersionList = value;
                                    // controllerX.getMatchDetails(programCode: value.key??"");
                                  },
                                  "Time Diff:",
                                  .07,
                                  // isEnable: controllerX.isEnable.value,
                                  // selected: controllerX.selectedBMSVersionList,
                                  dialogHeight: Get.height * .35,
                                  autoFocus: true,
                                  titleInLeft: true
                              ),
                              SizedBox(width: 4,),
                              TimeWithTwoTextField(
                                title: "",
                                mainTextController: TextEditingController(),
                                widthRation: 0.07,
                                isTime: false,
                                isEnable: true,
                                hideTitle: true,
                              ),
                              SizedBox(width: 4,),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0,bottom: 4,top: 14),
                                child: Text("(hh:mm)",style: TextStyle(
                                  fontSize: SizeDefine.labelSize1,
                                  color: Colors.black ,
                                  fontWeight: FontWeight.w500,
                                )),
                              ),
                              SizedBox(width: 4,),
                              InputFields.formField1WidthBox1(
                                  hintTxt: "Date Format",
                                  widthRatio: 0.155,
                                  // height: 70,
                                  paddingLeft: 0,
                                  showTitle: true,
                                  width: Get.width*0.05,
                                  // focus: controllerX.remarkFocus,
                                  controller: TextEditingController()),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InputFields.formField1WidthBox1(
                              hintTxt: "File Name",
                              widthRatio: 0.384,
                              // height: 70,
                              paddingLeft: 0,
                              showTitle: true,
                              width: Get.width*0.03956,
                              // focus: controllerX.remarkFocus,
                              controller: TextEditingController()),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width*0.384,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InputFields.formField1WidthBox1(
                                        hintTxt: "As Run Type",
                                        widthRatio: 0.07,
                                        // height: 70,
                                        paddingLeft: 0,
                                        showTitle: true,
                                        width: Get.width*0.05,
                                        // focus: controllerX.remarkFocus,
                                        controller: TextEditingController()),
                                    InputFields.formField1WidthBox1(
                                        hintTxt: "SAP Flag",
                                        widthRatio: 0.07,
                                        // height: 70,
                                        paddingLeft: 0,
                                        showTitle: true,
                                        width: Get.width*0.05,
                                        // focus: controllerX.remarkFocus,
                                        controller: TextEditingController()),
                                    InputFields.formField1WidthBox1(
                                        hintTxt: "New Format",
                                        widthRatio: 0.07,
                                        // height: 70,
                                        paddingLeft: 0,
                                        showTitle: true,
                                        width: Get.width*0.05,
                                        // focus: controllerX.remarkFocus,
                                        controller: TextEditingController()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width*0.384,
                                child: Row(children: [
                                  Checkbox(value: false, onChanged: (val){}),
                                  Text("FPC",style: TextStyle(
                                    fontSize: SizeDefine.labelSize1,
                                    color: Colors.black ,
                                    fontWeight: FontWeight.w500,
                                  )),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Checkbox(value: false, onChanged: (val){}),
                                  Text("Mark Slot",style: TextStyle(
                                    fontSize: SizeDefine.labelSize1,
                                    color: Colors.black ,
                                    fontWeight: FontWeight.w500,
                                  )),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Checkbox(value: false, onChanged: (val){}),
                                  Text("Don't Update Exposure",style: TextStyle(
                                    fontSize: SizeDefine.labelSize1,
                                    color: Colors.black ,
                                    fontWeight: FontWeight.w500,
                                  )),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Checkbox(value: false, onChanged: (val){}),
                                  Text("Reverse As Run Order",style: TextStyle(
                                    fontSize: SizeDefine.labelSize1,
                                    color: Colors.black ,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ],),
                              ),
                            ],
                          ),
                          InputFields.formField1WidthBox1(
                              hintTxt: "Max Duration Difference",
                              widthRatio:0.2,
                              // height: 70,
                              paddingLeft: 0,
                              showTitle: true,
                              width: Get.width*0.09,
                              // focus: controllerX.remarkFocus,
                              controller: TextEditingController()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GetBuilder<HomeController>(
                        id: "buttons",
                        init: Get.find<HomeController>(),
                        builder: (controller) {
                          try{
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
                                      callback: Utils.btnAccessHandler2(btn['name'],
                                          controller, formPermissions) ==
                                          null
                                          ? null
                                          : () => controllerX.formHandler(
                                        btn['name'],
                                      ),
                                    )
                                ],
                              );
                            }else{
                              return Container();
                            }
                          }catch(e){
                            return const Text("No Access");
                          }
                        }),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
