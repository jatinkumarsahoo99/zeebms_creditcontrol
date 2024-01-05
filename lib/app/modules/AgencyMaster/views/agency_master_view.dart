import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/agency_master_controller.dart';

class AgencyMasterView extends GetView<AgencyMasterController> {
  AgencyMasterView({Key? key}) : super(key: key);

  AgencyMasterController controllerX =
      Get.put<AgencyMasterController>(AgencyMasterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  // flex: 15,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height:Get.height*0.73,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
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
                                            hintTxt: "Group Name",
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
                                            hintTxt: "Contact Person",
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
                                          SizedBox(
                                            width: Get.width * controllerX.fixedWidth,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
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
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * controllerX.fixedWidth,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InputFields.formField1(
                                                  hintTxt: "Tel",
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
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * controllerX.fixedWidth,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InputFields.formField1(
                                                  hintTxt: "SAP Code",
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
                                                InputFields.formField1(
                                                  hintTxt: "Cust Grp",
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
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * controllerX.fixedWidth,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
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
                                                InputFields.formField1(
                                                  hintTxt: "IBF Desc",
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
                                              ],
                                            ),
                                          ),
                                          InputFields.formField1(
                                            hintTxt: "Print Name",
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
                                            hintTxt: "Name 3",
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
                                            hintTxt: "PAN No.",
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
                                            hintTxt: "GST No.",
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                InputFields.formField1(
                  hintTxt: "Email To",
                  // autoFocus: true,
                  // controller: controllerX.productLevel1Controller,
                  controller: TextEditingController(),
                  width: 0.95,
                  // isEnable: controllerX.isEnable,
                  onchanged: (value) {},
                  autoFocus: false,
                  // focusNode: controllerX.productLevel1Focus

                  // autoFocus: true,
                ),
                InputFields.formField1(
                  hintTxt: "Email CC",
                  // autoFocus: true,
                  // controller: controllerX.productLevel1Controller,
                  controller: TextEditingController(),
                  width: 0.95,
                  // isEnable: controllerX.isEnable,
                  onchanged: (value) {},
                  autoFocus: false,
                  // focusNode: controllerX.productLevel1Focus

                  // autoFocus: true,
                ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                          child: FormButtonWrapper(
                            btnText: "Block Agency",
                            callback: () {
                              // controllerX.showApiCall();
                            },
                            showIcon: true,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 0),
                          child: FormButtonWrapper(
                            btnText: "Un-Block Agency",
                            callback: () {
                              // controllerX.showApiCall();
                            },
                            showIcon: true,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GetBuilder<HomeController>(
                      id: "buttons",
                      init: Get.find<HomeController>(),
                      builder: (controller) {
                        PermissionModel formPermissions = Get.find<MainController>()
                            .permissionList!
                            .lastWhere((element) =>
                        element.appFormName == "frmAgencyMaster");
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
                                      : () => controllerX.formHandler(
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
          );
        }
      ),
    );
  }
}
