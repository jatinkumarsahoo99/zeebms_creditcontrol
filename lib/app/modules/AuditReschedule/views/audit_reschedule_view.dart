import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/CheckBoxWidget.dart';
import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/audit_reschedule_controller.dart';

class AuditRescheduleView extends GetView<AuditRescheduleController> {
  AuditRescheduleView({Key? key}) : super(key: key);

  AuditRescheduleController controllerX =
      Get.put<AuditRescheduleController>(AuditRescheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context,child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropDownField.formDropDown1WidthMap(
                      controllerX.locationList.value ?? [],
                      (value) {
                        controllerX.selectedLocation = value;
                        // controllerX.getChannels(locationCode: value.key ?? "");
                        // controllerX.getChannel(value.key??"");
                      },
                      "Location",
                      .2,
                      selected: controllerX.selectedLocation,
                      // isEnable: controllerX.isEnable.value,
                      // selected: controllerX.selectedLocation,
                      // dialogHeight: Get.height * .15,
                      autoFocus: true,
                    ),
                    DropDownField.formDropDown1WidthMap(
                      controllerX.channelList.value ?? [],
                      (value) {
                        controllerX.selectedChannel = value;
                        // controllerX.getChannel(value.key??"");
                      },
                      "Channel",
                      .2,
                      selected: controllerX.selectedChannel,
                      // isEnable: controllerX.isEnable.value,
                      // selected: controllerX.selectedLocation,
                      // dialogHeight: Get.height * .15,
                      autoFocus: true,
                    ),
                    DateWithThreeTextField(
                      title: "FPC Eff. Dt.",
                      mainTextController: controllerX.logDateController,
                      widthRation: .1,
                      // isEnable: controllerX.isEnable.value,
                    ),
                    DateWithThreeTextField(
                      title: "Resch Dt.",
                      mainTextController: controllerX.logDateController,
                      widthRation: .1,
                      // isEnable: controllerX.isEnable.value,
                    ),
                    InputFields.formField1WidthBox(
                        hintTxt: "Ref No",
                        widthRatio: 0.1,
                        // height: 70,
                        paddingLeft: 0,
                        // focus: controllerX.remarkFocus,
                        controller: TextEditingController()),
                    DateWithThreeTextField(
                      title: "Ref. Date",
                      mainTextController: controllerX.logDateController,
                      widthRation: .1,
                      // isEnable: controllerX.isEnable.value,
                    ),
                    InputFields.formField1WidthBox(
                        hintTxt: "Booking No",
                        widthRatio: 0.1,
                        // height: 70,
                        paddingLeft: 0,
                        // focus: controllerX.remarkFocus,
                        controller: TextEditingController()),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputFields.formField1WidthBox(
                        hintTxt: "Deal No",
                        widthRatio: 0.1,
                        // height: 70,
                        paddingLeft: 0,
                        // focus: controllerX.remarkFocus,
                        controller: TextEditingController()),
                    InputFields.formField1WidthBox(
                        hintTxt: "Resch. No",
                        widthRatio: 0.1,
                        // height: 70,
                        paddingLeft: 0,
                        // focus: controllerX.remarkFocus,
                        controller: TextEditingController()),
                    InputFields.formField1WidthBox(
                        hintTxt: "",
                        widthRatio: 0.1,
                        // height: 70,
                        paddingLeft: 0,
                        // focus: controllerX.remarkFocus,
                        controller: TextEditingController()),
                    DropDownField.formDropDownSearchAPI2(
                        GlobalKey(), context,
                        title: "Client",
                        autoFocus: false,
                        // customInData: "empList",
                        url:  "",
                        // inkwellFocus: controllerX.employeeFocus,
                        // parseKeyForTitle: "programName",
                        parseKeyForKey: "ClientCode",
                        parseKeyForValue: "ClientName",
                        // selectedValue: controllerX.selectedClient.value,
                        // selectedValue: controllerX.selectedEmployee.value,
                        onchanged: (data) {
                          // controllerX.selectedClient.value = data;
                          // controllerX.getClientNameClick(clientCode: data.key ?? "");
                        },
                        dialogHeight: 200,
                        width: (Get.width * 0.2)),
                    DropDownField.formDropDownSearchAPI2(
                        GlobalKey(), context,
                        title: "Agency",
                        autoFocus: false,
                        // customInData: "empList",
                        url:  "",
                        // inkwellFocus: controllerX.employeeFocus,
                        // parseKeyForTitle: "programName",
                        parseKeyForKey: "ClientCode",
                        parseKeyForValue: "ClientName",
                        // selectedValue: controllerX.selectedClient.value,
                        // selectedValue: controllerX.selectedEmployee.value,
                        onchanged: (data) {
                          // controllerX.selectedClient.value = data;
                          // controllerX.getClientNameClick(clientCode: data.key ?? "");
                        },
                        dialogHeight: 200,
                        width: (Get.width * 0.2)),
                    DropDownField.formDropDownSearchAPI2(
                        GlobalKey(), context,
                        title: "Brand",
                        autoFocus: false,
                        // customInData: "empList",
                        url:  "",
                        // inkwellFocus: controllerX.employeeFocus,
                        // parseKeyForTitle: "programName",
                        parseKeyForKey: "ClientCode",
                        parseKeyForValue: "ClientName",
                        // selectedValue: controllerX.selectedClient.value,
                        // selectedValue: controllerX.selectedEmployee.value,
                        onchanged: (data) {
                          // controllerX.selectedClient.value = data;
                          // controllerX.getClientNameClick(clientCode: data.key ?? "");
                        },
                        dialogHeight: 200,
                        width: (Get.width * 0.2)),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CheckBoxOnRight(
                                title: "Select All",
                                value: true,
                                top: 3,
                                left: 3,
                                onChanged: (val) {
                                  // controller.wed.value = val!;
                                },
                                // fn: controller.wedDayFocus
                            ),
                          ],
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3.0,right: 3,bottom: 3,top: 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                    child: Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            .lastWhere(
                                (element) => element.appFormName == "frmSecondaryAsRunModification");
                        if (controller.buttons != null) {
                          return ButtonBar(
                            alignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            // buttonPadding: EdgeInsets.only(left: 0,right: 5,top: 4,bottom: 4),
                            children: [
                              for (var btn in controller.buttons!)
                                FormButtonWrapper(
                                  btnText: btn["name"],
                                  callback:
                                      Utils.btnAccessHandler2(btn['name'], controller, formPermissions) ==
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
