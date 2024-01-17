import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/sales_executive_master_controller.dart';

class SalesExecutiveMasterView extends StatelessWidget {
  SalesExecutiveMasterView({Key? key}) : super(key: key);
  SalesExecutiveMasterController controllerX =
      Get.put<SalesExecutiveMasterController>(SalesExecutiveMasterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.width * 0.54,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    title: Text('Executive Master'),
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
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 26, top: 8, bottom: 8),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropDownField.formDropDownSearchAPI2(
                              GlobalKey(), context,
                              title: "SAP Name",
                              autoFocus: true,
                              customInData: "empList",
                              url: ApiFactory.SALES_EXECUTIVE_GET_SAPNAME,
                              // inkwellFocus: controllerX.employeeFocus,
                              // parseKeyForTitle: "programName",
                              parseKeyForKey: "employeecode",
                              parseKeyForValue: "employeename",
                              selectedValue: controllerX.selectSapName,
                              onchanged: (data) {
                            controllerX.selectSapName = data;
                          }, width: (Get.width * controllerX.widthRatio)),
                          SizedBox(
                            height: 6,
                          ),
                          InputFields.formFieldDisable(
                              hintTxt: "SAP Code",
                              value: controllerX.sapCode.value,
                              widthRatio: controllerX.widthRatio),
                          SizedBox(
                            height: 6,
                          ),
                          InputFields.formFieldDisable(
                              hintTxt: "Executive Name",
                              value: controllerX.executiveName.value,
                              widthRatio: controllerX.widthRatio),
                          SizedBox(
                            height: 6,
                          ),
                          InputFields.formFieldDisable(
                              hintTxt: "Department",
                              value: controllerX.department.value,
                              widthRatio: controllerX.widthRatio),
                          SizedBox(
                            height: 6,
                          ),
                          InputFields.formFieldDisable(
                              hintTxt: "Designation",
                              value: controllerX.designation.value,
                              widthRatio: controllerX.widthRatio),
                          SizedBox(
                            height: 6,
                          ),
                          DropDownField.formDropDown1WidthMap(
                            [],
                            (value) {
                              // controllerX.selectedBMSVersionList = value;
                              // controllerX.getMatchDetails(programCode: value.key??"");
                              controllerX.selectCompany = value;
                            },
                            "Company",
                            controllerX.widthRatio,
                            dialogHeight: Get.height * controllerX.widthRatio,
                            selected: controllerX.selectCompany,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (value) {
                                  // controllerX.selectedBMSVersionList = value;
                                  // controllerX.getMatchDetails(programCode: value.key??"");
                                  controllerX.selectLocation = value;
                                },
                                "Location",
                                (controllerX.widthRatio / 2),
                                // isEnable: controllerX.isEnable.value,
                                selected: controllerX.selectLocation,
                                dialogHeight:
                                    Get.height * controllerX.widthRatio,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (value) {
                                  controllerX.selectStation = value;
                                },
                                "Station",
                                (controllerX.widthRatio / 2),
                                // isEnable: controllerX.isEnable.value,
                                selected: controllerX.selectStation,
                                dialogHeight:
                                    Get.height * controllerX.widthRatio,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropDownField.formDropDown1WidthMap(
                                [],
                                (value) {
                                  controllerX.selectPlace = value;
                                },
                                "Place",
                                (controllerX.widthRatio / 2),
                                dialogHeight:
                                    Get.height * controllerX.widthRatio,
                                selected: controllerX.selectPlace,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              InputFields.formFieldDisable(
                                  hintTxt: "Mobile No",
                                  widthRatio: controllerX.widthRatio / 2,
                                  value: controllerX.mobileno.value),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          InputFields.formFieldDisable(
                              hintTxt: "Email ID",
                              widthRatio: controllerX.widthRatio,
                              value: controllerX.email.value),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width * 0.022,
                              ),
                              SizedBox(
                                width: Get.width * 0.079,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 5),
                                    Obx(() => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Checkbox(
                                            value: controllerX.isActive.value,
                                            onChanged: (val) {
                                              controllerX.isActive.value = val!;
                                            },
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 5),
                                      child: Text(
                                        "Is Active",
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
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
                                        "frmExecutiveMaster");
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
