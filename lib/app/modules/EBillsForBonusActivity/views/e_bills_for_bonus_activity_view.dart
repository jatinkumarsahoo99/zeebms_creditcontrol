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
  const EBillsForBonusActivityView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Stack(
                        children: [
                          Container(
                            // height: Get.height*0.35,
                            margin: const EdgeInsets.fromLTRB(
                                6, 20, 1, 10),
                            padding: const EdgeInsets.only(
                                bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Padding(
                                      padding: EdgeInsets.only(top:15),
                                      child: Text("Telecast Period",style: TextStyle(fontSize:SizeDefine.labelSize1, ),),
                                    ),
                                    DateWithThreeTextField(
                                      title: "",
                                      mainTextController: TextEditingController(),
                                      widthRation: 0.15,
                                      isEnable: true,
                                    ),
                                    DateWithThreeTextField(
                                      title: "",
                                      mainTextController: TextEditingController(),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Padding(
                                      padding: EdgeInsets.only(top:15),
                                      child: Text("Telecast Period",style: TextStyle(fontSize:SizeDefine.labelSize1,
                                          color:Colors.white ),),
                                    ),
                                    Container(
                                      width:Get.width*0.15 ,
                                      height: Get.height*0.09,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey)),
                                      child:  Center(
                                        child: Obx(
                                              () => RadioColumn(
                                            items: const [
                                              "Agency",
                                              "Group"
                                            ],
                                            groupValue: controller.selectExportType.value ?? "",
                                            onchange: (val) {
                                              print("Response>>>" + val);
                                              controller.selectExportType.value = val;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width:Get.width*0.15 ,
                                      height: Get.height*0.09,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width:Get.width*0.1,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(top: 4.0, left: 1, right: 0,bottom: 1),
                                              child: FormButtonWrapper(
                                                btnText: "Get Agency",
                                                callback: () {
                                                  // controllerX.showApiCall();
                                                },
                                                showIcon: true,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width:Get.width*0.1,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(top: 4.0, left: 1, right: 0,bottom: 2),
                                              child: FormButtonWrapper(
                                                btnText: "Clear",
                                                callback: () {
                                                  // controllerX.showApiCall();
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

                            ],),
                          ),
                          Positioned(
                            left: 50,
                            top: 12,
                            child: Container(
                              color: Colors.white,
                              child: Text(
                                "SELECTION OPTION",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight
                                        .w700,
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
                            margin: const EdgeInsets.fromLTRB(
                                6, 20, 1, 10),
                            padding: const EdgeInsets.only(
                                bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Column(children: [
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width:Get.width*0.15 ,
                                      height: Get.height*0.09,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey)),
                                      child:  Center(
                                        child: Obx(
                                              () => RadioColumn(
                                            items: const [
                                              "Domestic",
                                              "ATL"
                                            ],
                                            groupValue: controller.selRadio.value ?? "",
                                            onchange: (val) {
                                              // print("Response>>>" + val);
                                              controller.selRadio.value = val;
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
                                // autoFocus: true,
                                // controller: controllerX.productLevel1Controller,
                                controller: TextEditingController(),
                                width: 0.37,
                                // isEnable: controllerX.isEnable,
                                onchanged: (value) {},
                                autoFocus: false,
                                // focusNode: controllerX.productLevel1Focus
                                // autoFocus: true,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Checkbox(value: false, onChanged: (val){}),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("Test Mail"),
                                  SizedBox(
                                    width: 40,
                                  ),
                                ],
                              ),
                              InputFields.formField1(
                                hintTxt: "To:",
                                // autoFocus: true,
                                // controller: controllerX.productLevel1Controller,
                                controller: TextEditingController(),
                                width: 0.37,
                                // isEnable: controllerX.isEnable,
                                onchanged: (value) {},
                                autoFocus: false,
                                // focusNode: controllerX.productLevel1Focus
                                // autoFocus: true,
                              ),
                              InputFields.formField1(
                                hintTxt: "CC:",
                                // autoFocus: true,
                                // controller: controllerX.productLevel1Controller,
                                controller: TextEditingController(),
                                width: 0.37,
                                // isEnable: controllerX.isEnable,
                                onchanged: (value) {},
                                autoFocus: false,
                                // focusNode: controllerX.productLevel1Focus
                                // autoFocus: true,
                              ),

                            ],),
                          ),
                          Positioned(
                            left: 50,
                            top: 12,
                            child: Container(
                              color: Colors.white,
                              child: Text(
                                "SENDING OPTION",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight
                                        .w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                    flex: 5,
                    child:Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)),
                )),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 14.0, left: 10, right: 0),
                  child: FormButtonWrapper(
                    btnText: "Create TC Xml",
                    callback: () {
                      // controllerX.showApiCall();
                    },
                    showIcon: true,
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
