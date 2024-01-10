import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/agency_group_master_controller.dart';

class AgencyGroupMasterView extends GetView<AgencyGroupMasterController> {
   AgencyGroupMasterView({Key? key}) : super(key: key);

   AgencyGroupMasterController controllerX =
   Get.put<AgencyGroupMasterController>(AgencyGroupMasterController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * .55,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('Agency Group Master'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  Column(
                    // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        InputFields.formField1WidthBox(
                            hintTxt: "Group Name",
                            widthRatio: controllerX.fixedWidth,
                            // height: Get.height*0.1,
                            paddingLeft: 0,
                            // maxLen: 5,
                            // focus: controllerX.remarkFocus,
                            controller: TextEditingController()),
                        InputFields.formField1WidthBox(
                            hintTxt: "Short Name",
                            widthRatio: controllerX.fixedWidth,
                            // height: Get.height*0.1,
                            paddingLeft: 0,
                            // maxLen: 5,
                            // focus: controllerX.remarkFocus,
                            controller: TextEditingController()),
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
                        InputFields.formField1WidthBox(
                            hintTxt: "Group Name",
                            widthRatio: controllerX.fixedWidth,
                            // height: Get.height*0.1,
                            paddingLeft: 0,
                            // maxLen: 5,
                            // focus: controllerX.remarkFocus,
                            controller: TextEditingController()),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: Get.height*0.4,
                                  child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey))
                              )),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
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
                                SizedBox(
                                  height: 4,
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
                      ]
                  ),

                  SizedBox(height: 5),
                  /// bottom common buttons
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
                                "frmAgencyGroupMaster");
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
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
      key: GlobalKey(),
    );
  }
}
