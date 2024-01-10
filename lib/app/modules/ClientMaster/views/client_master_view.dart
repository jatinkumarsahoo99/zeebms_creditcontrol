import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/client_master_controller.dart';

class ClientMasterView extends GetView<ClientMasterController> {
   ClientMasterView({Key? key}) : super(key: key);

   ClientMasterController controllerX =
   Get.put<ClientMasterController>(ClientMasterController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 11,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)),
                      child: SingleChildScrollView(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            DropDownField.formDropDownSearchAPI2(
                                GlobalKey(), context,
                                title: "Agency Name",
                                autoFocus: false,
                                customInData: "empList",
                                url: "",
                                // inkwellFocus: controllerX.employeeFocus,
                                // parseKeyForTitle: "programName",
                                parseKeyForKey: "employeecode",
                                parseKeyForValue: "employeename",
                                // selectedValue: controllerX.selectedEmployee.value,
                                onchanged: (data) {},
                                width: (Get.width * controllerX.fixedWidth)),
                            InputFields.formField1(
                              hintTxt: "Short Name",
                              // autoFocus: true,
                              // controller: controllerX.productLevel1Controller,
                              controller: TextEditingController(),
                              width: controllerX.fixedWidth,
                              // isEnable: controllerX.isEnable,
                              onchanged: (value) {},
                              autoFocus: false,
                              // focusNode: controllerX.productLevel1Focus
                              // autoFocus: true,
                            ),
                            InputFields.formField1(
                              hintTxt: "Address",
                              // autoFocus: true,
                              // controller: controllerX.productLevel1Controller,
                              controller: TextEditingController(),
                              width: controllerX.fixedWidth,
                              // isEnable: controllerX.isEnable,
                              onchanged: (value) {},
                              autoFocus: false,
                              // focusNode: controllerX.productLevel1Focus
                              // autoFocus: true,
                            ),
                            InputFields.formField1(
                              hintTxt: "",
                              // autoFocus: true,
                              // controller: controllerX.productLevel1Controller,
                              controller: TextEditingController(),
                              width: controllerX.fixedWidth,
                              // isEnable: controllerX.isEnable,
                              onchanged: (value) {},
                              autoFocus: false,
                              // focusNode: controllerX.productLevel1Focus
                              // autoFocus: true,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width*0.005,
                                ),
                                DropDownField.formDropDown1WidthMap(
                                  [],
                                      (value) {
                                    // controllerX.selectedCensorShipType = value;
                                  },
                                  "City",
                                  controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  autoFocus: false,
                                ),
                                SizedBox(
                                  width: Get.width*0.035,
                                ),
                                SizedBox(
                                  width: Get.width*0.034,
                                ),
                                InputFields.formField1(
                                  hintTxt: "Pin",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                               /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width*0.005,
                                ),
                                DropDownField.formDropDown1WidthMap(
                                  [],
                                      (value) {
                                    // controllerX.selectedCensorShipType = value;
                                  },
                                  "Country",
                                  controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  autoFocus: false,
                                ),
                                SizedBox(
                                  width: Get.width*0.035,
                                ),
                                SizedBox(
                                  width: Get.width*0.034,
                                ),
                                InputFields.formField1(
                                  hintTxt: "IBF Code",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                               /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width*0.005,
                                ),
                                InputFields.formField1(
                                  hintTxt: "Phone",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                                SizedBox(
                                  width: Get.width*0.035,
                                ),
                                SizedBox(
                                  width: Get.width*0.034,
                                ),
                                InputFields.formField1(
                                  hintTxt: "Mobile",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                               /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width*0.005,
                                ),
                                InputFields.formField1(
                                  hintTxt: "Fax",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                                SizedBox(
                                  width: Get.width*0.035,
                                ),
                                SizedBox(
                                  width: Get.width*0.034,
                                ),
                                InputFields.formField1(
                                  hintTxt: "Email",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                               /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width*0.005,
                                ),
                                InputFields.formField1(
                                  hintTxt: "Contact",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                                SizedBox(
                                  width: Get.width*0.035,
                                ),
                                SizedBox(
                                  width: Get.width*0.034,
                                ),
                                InputFields.formField1(
                                  hintTxt: "SAP Client",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                               /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width*0.005,
                                ),
                                InputFields.formField1(
                                  hintTxt: "Sector",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                                SizedBox(
                                  width: Get.width*0.035,
                                ),
                                SizedBox(
                                  width: Get.width*0.034,
                                ),
                                InputFields.formField1(
                                  hintTxt: "Industry",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                               /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width*0.005,
                                ),
                                DropDownField.formDropDown1WidthMap(
                                  [],
                                      (value) {
                                    // controllerX.selectedCensorShipType = value;
                                  },
                                  "Payment",
                                  controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  autoFocus: false,
                                ),
                                SizedBox(
                                  width: Get.width*0.035,
                                ),
                                SizedBox(
                                  width: Get.width*0.034,
                                ),
                                DropDownField.formDropDown1WidthMap(
                                  [],
                                      (value) {
                                    // controllerX.selectedCensorShipType = value;
                                  },
                                  "Credit",
                                  controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  autoFocus: false,
                                ),
                                /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width*0.005,
                                ),
                                InputFields.formField1(
                                  hintTxt: "Credit Days",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                                SizedBox(
                                  width: Get.width*0.035,
                                ),
                                SizedBox(
                                  width: Get.width*0.034,
                                ),
                                InputFields.formField1(
                                  hintTxt: "Credit Limit",
                                  // autoFocus: true,
                                  // controller: controllerX.productLevel1Controller,
                                  controller: TextEditingController(),
                                  width: controllerX.fixedWidth1,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  autoFocus: false,
                                  // focusNode: controllerX.productLevel1Focus
                                  // autoFocus: true,
                                ),
                                /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                              ],
                            ),
                            InputFields.formField1(
                              hintTxt: "Number 1",
                              // autoFocus: true,
                              // controller: controllerX.productLevel1Controller,
                              controller: TextEditingController(),
                              width: controllerX.fixedWidth,
                              // isEnable: controllerX.isEnable,
                              onchanged: (value) {},
                              autoFocus: false,
                              // focusNode: controllerX.productLevel1Focus
                              // autoFocus: true,
                            ),
                            InputFields.formField1(
                              hintTxt: "Number 2",
                              // autoFocus: true,
                              // controller: controllerX.productLevel1Controller,
                              controller: TextEditingController(),
                              width: controllerX.fixedWidth,
                              // isEnable: controllerX.isEnable,
                              onchanged: (value) {},
                              autoFocus: false,
                              // focusNode: controllerX.productLevel1Focus
                              // autoFocus: true,
                            ),
                            InputFields.formField1(
                              hintTxt: "Number 3",
                              // autoFocus: true,
                              // controller: controllerX.productLevel1Controller,
                              controller: TextEditingController(),
                              width: controllerX.fixedWidth,
                              // isEnable: controllerX.isEnable,
                              onchanged: (value) {},
                              autoFocus: false,
                              // focusNode: controllerX.productLevel1Focus
                              // autoFocus: true,
                            ),
                            InputFields.formField1(
                              hintTxt: "IBF Remarks",
                              // autoFocus: true,
                              // controller: controllerX.productLevel1Controller,
                              controller: TextEditingController(),
                              width: controllerX.fixedWidth,
                              // isEnable: controllerX.isEnable,
                              onchanged: (value) {},
                              autoFocus: false,
                              // focusNode: controllerX.productLevel1Focus
                              // autoFocus: true,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                                  child: FormButtonWrapper(
                                    btnText: "Block Client",
                                    callback: () {
                                      // controllerX.showApiCall();
                                    },
                                    showIcon: true,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                                  child: FormButtonWrapper(
                                    btnText: "Un-Block Client",
                                    callback: () {
                                      // controllerX.showApiCall();
                                    },
                                    showIcon: true,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,)


                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          /*SizedBox(
                                            width: Get.width*0.005,
                                          ),*/
                                          DropDownField.formDropDown1WidthMap(
                                            [],
                                                (value) {
                                              // controllerX.selectedCensorShipType = value;
                                            },
                                            "Location",
                                            controllerX.fixedWidth2,
                                            // isEnable: controllerX.isEnable,
                                            autoFocus: false,
                                          ),
                                          /*SizedBox(
                                            width: Get.width*0.035,
                                          ),
                                          SizedBox(
                                            width: Get.width*0.034,
                                          ),*/
                                          DropDownField.formDropDown1WidthMap(
                                            [],
                                                (value) {
                                              // controllerX.selectedCensorShipType = value;
                                            },
                                            "Channel",
                                            controllerX.fixedWidth2,
                                            // isEnable: controllerX.isEnable,
                                            autoFocus: false,
                                          ),
                                          /* SizedBox(
                                              width: Get.width*0.01,
                                            ),*/
                                        ],
                                      ),
                                      DropDownField.formDropDownSearchAPI2(
                                          GlobalKey(), context,
                                          title: "Agency",
                                          autoFocus: false,
                                          customInData: "empList",
                                          url: "",
                                          // inkwellFocus: controllerX.employeeFocus,
                                          // parseKeyForTitle: "programName",
                                          parseKeyForKey: "employeecode",
                                          parseKeyForValue: "employeename",
                                          // selectedValue: controllerX.selectedEmployee.value,
                                          onchanged: (data) {},
                                          width: (Get.width * controllerX.fixedWidth3)),
                                      DropDownField.formDropDownSearchAPI2(
                                          GlobalKey(), context,
                                          title: "Executive",
                                          autoFocus: false,
                                          customInData: "empList",
                                          url: "",
                                          // inkwellFocus: controllerX.employeeFocus,
                                          // parseKeyForTitle: "programName",
                                          parseKeyForKey: "employeecode",
                                          parseKeyForValue: "employeename",
                                          // selectedValue: controllerX.selectedEmployee.value,
                                          onchanged: (data) {},
                                          width: (Get.width * controllerX.fixedWidth3)),
                                      DropDownField.formDropDownSearchAPI2(
                                          GlobalKey(), context,
                                          title: "Payrouote",
                                          autoFocus: false,
                                          customInData: "empList",
                                          url: "",
                                          // inkwellFocus: controllerX.employeeFocus,
                                          // parseKeyForTitle: "programName",
                                          parseKeyForKey: "employeecode",
                                          parseKeyForValue: "employeename",
                                          // selectedValue: controllerX.selectedEmployee.value,
                                          onchanged: (data) {},
                                          width: (Get.width * controllerX.fixedWidth3)),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(left: 2.0),
                                            child: DateWithThreeTextField(
                                              title: "Schedule Date",
                                              mainTextController:TextEditingController(),
                                              widthRation: controllerX.fixedWidth2,
                                              // isEnable: controllerX.isEnable.value,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width*0.005,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      DropDownField.formDropDown1WidthMap(
                                        [],
                                            (value) {
                                          // controllerX.selectedCensorShipType = value;
                                        },
                                        "Plant",
                                        0.413,
                                        // isEnable: controllerX.isEnable,
                                        autoFocus: false,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 14.0, left: 10, right: 1),
                                            child: FormButtonWrapper(
                                              btnText: "Add",
                                              callback: () {
                                                // controllerX.showApiCall();
                                              },
                                              showIcon: true,
                                            ),
                                          )

                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        width:Get.width * controllerX.fixedWidth3,
                                        height: Get.height*0.23,

                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          /*SizedBox(
                                            width: Get.width*0.005,
                                          ),*/
                                          DropDownField.formDropDown1WidthMap(
                                            [],
                                                (value) {
                                              // controllerX.selectedCensorShipType = value;
                                            },
                                            "Agency",
                                            0.3,
                                            // isEnable: controllerX.isEnable,
                                            autoFocus: false,
                                          ),
                                          /*SizedBox(
                                            width: Get.width*0.035,
                                          ),
                                          SizedBox(
                                            width: Get.width*0.034,
                                          ),*/
                                          InkWell(
                                            onTap: (){

                                            },
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(top: 14.0, left: 10, right: 1),
                                              child: Container(
                                                width: Get.width*0.0502,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey)),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Center(child: Text("...")),
                                                ),
                                              ),
                                            ),
                                          ),

                                          /* SizedBox(
                                              width: Get.width*0.01,
                                            ),*/
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          DropDownField.formDropDown1WidthMap(
                                            [],
                                                (value) {
                                              // controllerX.selectedCensorShipType = value;
                                            },
                                            "Pay Mode",
                                            0.3,
                                            // isEnable: controllerX.isEnable,
                                            autoFocus: false,
                                          ),
                                          SizedBox(
                                            width: Get.width*0.035,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          /*SizedBox(
                                        width: Get.width*0.005,
                                      ),*/
                                          DropDownField.formDropDown1WidthMap(
                                            [],
                                                (value) {
                                              // controllerX.selectedCensorShipType = value;
                                            },
                                            "IBF Remark",
                                            0.3,
                                            // isEnable: controllerX.isEnable,
                                            autoFocus: false,
                                          ),
                                          /*SizedBox(
                                        width: Get.width*0.035,
                                      ),
                                      SizedBox(
                                        width: Get.width*0.034,
                                      ),*/
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 14.0, left: 10, right: 1),
                                            child: FormButtonWrapper(
                                              btnText: "Add",
                                              callback: () {
                                                // controllerX.showApiCall();
                                              },
                                              showIcon: true,
                                            ),
                                          ),

                                          /* SizedBox(
                                          width: Get.width*0.01,
                                        ),*/
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width:Get.width * controllerX.fixedWidth3,
                                        height: Get.height*0.12,

                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5),
            // const SizedBox(height: 8),
            Align(
              alignment: Alignment.topLeft,
              child: GetBuilder<HomeController>(
                  id: "buttons",
                  init: Get.find<HomeController>(),
                  builder: (controller) {
                    PermissionModel formPermissions =
                    Get
                        .find<MainController>()
                        .permissionList!
                        .lastWhere(
                            (element) =>
                        element.appFormName == "frmAuditStatus");
                    if (controller.buttons != null) {
                      return ButtonBar(
                        alignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        // buttonPadding: EdgeInsets.only(left: 0,right: 5,top: 4,bottom: 4),
                        children: [
                          for (var btn in controller.buttons!)
                            FormButtonWrapper(
                              btnText: btn["name"],
                              callback: Utils.btnAccessHandler2(btn['name'],
                                  controller, formPermissions) ==
                                  null
                                  ? null
                                  : () =>
                                  controllerX.formHandler(
                                    btn['name'],
                                  ),
                            )
                        ],
                      );
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ),
      key: GlobalKey(),
    );
  }
}
