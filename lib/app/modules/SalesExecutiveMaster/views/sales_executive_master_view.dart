import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
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
                              autoFocus: false,
                              customInData: "empList",
                              url: "",
                              // inkwellFocus: controllerX.employeeFocus,
                              // parseKeyForTitle: "programName",
                              parseKeyForKey: "employeecode",
                              parseKeyForValue: "employeename",
                              // selectedValue: controllerX.selectedEmployee.value,
                              onchanged: (data) {},
                              width: (Get.width * 0.18)),
                          SizedBox(
                            height: 4,
                          ),

                          SizedBox(
                            height: 4,
                          ),
                          InputFields.formFieldDisable(hintTxt: "SAP Code", value: ""),
                          InputFields.formFieldDisable(hintTxt: "Executive Name", value: ""),
                          InputFields.formFieldDisable(hintTxt: "Department", value: ""),
                          InputFields.formFieldDisable(hintTxt: "Designation", value: ""),
                          DropDownField.formDropDown1WidthMap([], (value) {
                            // controllerX.selectedBMSVersionList = value;
                            // controllerX.getMatchDetails(programCode: value.key??"");
                          }, "Company  ", .4,
                              // isEnable: controllerX.isEnable.value,
                              // selected: controllerX.selectedBMSVersionList,
                              dialogHeight: Get.height * .35,
                              autoFocus: true,
                              titleInLeft: true),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      DropDownField.formDropDown1WidthMap([], (value) {
                        // controllerX.selectedBMSVersionList = value;
                        // controllerX.getMatchDetails(programCode: value.key??"");
                      }, "Location", .4,
                          // isEnable: controllerX.isEnable.value,
                          // selected: controllerX.selectedBMSVersionList,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,
                          titleInLeft: true),
                      SizedBox(
                        width: 10,
                      ),
                      DropDownField.formDropDown1WidthMap([], (value) {
                        // controllerX.selectedBMSVersionList = value;
                        // controllerX.getMatchDetails(programCode: value.key??"");
                      }, "Station", .4,
                          // isEnable: controllerX.isEnable.value,
                          // selected: controllerX.selectedBMSVersionList,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,
                          titleInLeft: true),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      DropDownField.formDropDown1WidthMap([], (value) {
                        // controllerX.selectedBMSVersionList = value;
                        // controllerX.getMatchDetails(programCode: value.key??"");
                      }, "Place", .4,
                          // isEnable: controllerX.isEnable.value,
                          // selected: controllerX.selectedBMSVersionList,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,
                          titleInLeft: true),
                      SizedBox(
                        width: 10,
                      ),
                      InputFields.formFieldDisable(
                          hintTxt: "Mobile No",
                          widthRatio: 0.155,
                          value: ""
                          ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InputFields.formFieldDisable(
                      hintTxt: "Email ID",
                      widthRatio: 0.155,
                      value: ""
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
