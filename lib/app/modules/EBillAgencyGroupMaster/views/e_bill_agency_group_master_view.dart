import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../controllers/e_bill_agency_group_master_controller.dart';

class EBillAgencyGroupMasterView
    extends GetView<EBillAgencyGroupMasterController> {
  EBillAgencyGroupMasterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.width*0.84,
          // height: Get.height*0.7,
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text('Ebill Agency Group Master'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropDownField.formDropDown1WidthMap(
                            [],
                                (value) {
                              // controllerX.selectedBMSVersionList = value;
                              // controllerX.getMatchDetails(programCode: value.key??"");
                            },
                            "Group Name",
                            .36,
                            // isEnable: controllerX.isEnable.value,
                            // selected: controllerX.selectedBMSVersionList,
                            dialogHeight: Get.height * .35,
                            autoFocus: true,
                          ),
                          DropDownField.formDropDown1WidthMap(
                            [],
                                (value) {
                              // controllerX.selectedBMSVersionList = value;
                              // controllerX.getMatchDetails(programCode: value.key??"");
                            },
                            "Agency Name",
                            .36,
                            // isEnable: controllerX.isEnable.value,
                            // selected: controllerX.selectedBMSVersionList,
                            dialogHeight: Get.height * .35,
                            autoFocus: true,
                          ),
                          InputFields.formField5(
                            hintTxt: "Mail To",
                            controller: TextEditingController(),
                            width: 0.36,
                            maxLines: 10,
                            height: Get.height * 0.15,
                            contentPad: 12,
                            maxLen: 1000,
                            // autoFocus: true,
                            // focusNode: controllerX.level2Node,
                            // isEnable: controllerX.isEnable,
                            onchanged: (value) {

                            },
                            // autoFocus: true,
                          ),
                          InputFields.formField5(
                            hintTxt: "MailCC",
                            controller: TextEditingController(),
                            width: 0.36,
                            maxLines: 10,
                            height: Get.height * 0.15,
                            contentPad: 12,
                            maxLen: 1000,
                            // autoFocus: true,
                            // focusNode: controllerX.level2Node,
                            // isEnable: controllerX.isEnable,
                            onchanged: (value) {

                            },
                            // autoFocus: true,
                          ),
                          SizedBox(
                            width: Get.width*0.36,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 14.0, left: 0, right: 10),
                                  child: FormButtonWrapper(
                                    btnText: "Add to Group",
                                    callback: () {
                                      // controllerX.showApiCall();
                                    },
                                    showIcon: true,
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                                  child: FormButtonWrapper(
                                    btnText: "Remove from Group",
                                    callback: () {
                                      // controllerX.showApiCall();
                                    },
                                    showIcon: true,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 17.0, left: 8, right: 8),
                        child: FormButtonWrapper(
                          btnText: "(+)Add New Group",
                          callback: () {
                            // controllerX.showApiCall();
                          },
                          showIcon: true,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: Get.height*0.45,
                          // width: Get.width*0.25,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 5,top: 0),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 14.0, left: 0, right: 5),
                        child: FormButtonWrapper(
                          btnText: "Save",
                          callback: () {
                            // controllerX.showApiCall();
                          },
                          showIcon: true,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 14.0, left: 5, right: 5),
                        child: FormButtonWrapper(
                          btnText: "Clear",
                          callback: () {
                            // controllerX.showApiCall();
                          },
                          showIcon: true,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 14.0, left: 5, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Exit",
                          callback: () {
                            // controllerX.showApiCall();
                          },
                          showIcon: true,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
