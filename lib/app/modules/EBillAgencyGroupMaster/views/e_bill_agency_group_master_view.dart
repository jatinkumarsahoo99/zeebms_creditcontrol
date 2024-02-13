import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../controllers/e_bill_agency_group_master_controller.dart';

class EBillAgencyGroupMasterView extends StatelessWidget {
  EBillAgencyGroupMasterView({Key? key}) : super(key: key);

  EBillAgencyGroupMasterController controller =
      Get.put<EBillAgencyGroupMasterController>(
          EBillAgencyGroupMasterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.width * 0.84,
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
                GetBuilder<EBillAgencyGroupMasterController>(
                    init: controller,
                    id: "init",
                    builder: (logic) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                DropDownField.formDropDown1WidthMap(
                                  controller.grpList ?? [],
                                  (value) {
                                    controller.selectedGrp = value;
                                    controller.getClientLeave();
                                  },
                                  "Group Name",
                                  .36,
                                  // isEnable: controllerX.isEnable.value,
                                  selected: controller.selectedGrp,
                                  dialogHeight: Get.height * .35,
                                  autoFocus: true,
                                ),
                                SizedBox(height: 3,),
                                DropDownField.formDropDown1WidthMap(
                                  controller.lstagency ?? [],
                                  (value) {
                                    controller.selectedAgency = value;
                                    // controllerX.getMatchDetails(programCode: value.key??"");
                                  },
                                  "Agency Name",
                                  .36,
                                  // isEnable: controllerX.isEnable.value,
                                  selected: controller.selectedAgency,
                                  dialogHeight: Get.height * .35,
                                  autoFocus: true,
                                ),
                                SizedBox(height: 3,),
                                InputFields.formField5(
                                  hintTxt: "Mail To",
                                  controller: controller.mailTo,
                                  width: 0.36,
                                  maxLines: 10,
                                  height: Get.height * 0.15,
                                  contentPad: 12,
                                  maxLen: 1000,
                                  // autoFocus: true,
                                  // focusNode: controllerX.level2Node,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  // autoFocus: true,
                                ),
                                SizedBox(height: 3,),
                                InputFields.formField5(
                                  hintTxt: "MailCC",
                                  controller: controller.mailCC,
                                  width: 0.36,
                                  maxLines: 10,
                                  height: Get.height * 0.15,
                                  contentPad: 12,
                                  maxLen: 1000,
                                  // autoFocus: true,
                                  // focusNode: controllerX.level2Node,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {},
                                  // autoFocus: true,
                                ),
                                SizedBox(
                                  width: Get.width * 0.36,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 0, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Add to Group",
                                          callback: () {
                                            controller.addToGroup();
                                          },
                                          showIcon: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 10, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Remove from Group",
                                          callback: () {
                                            controller.removeToGroup();
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
                              padding: const EdgeInsets.only(
                                  top: 17.0, left: 8, right: 8),
                              child: FormButtonWrapper(
                                btnText: "(+)Add New Group",
                                callback: () {
                                  controller.addNewGroup();
                                },
                                showIcon: true,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  GetBuilder<EBillAgencyGroupMasterController>(
                                      id: "billMaster",
                                      init: controller,
                                      builder: (logic) {
                                        return (controller.lstagencymaster !=
                                                      null &&
                                                  (controller.lstagencymaster
                                                          ?.isNotEmpty ??
                                                      false))
                                              ? Container(
                                                  height: Get.height * 0.45,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  child: ListView.builder(
                                                    itemBuilder: (c, i) {
                                                      return Row(
                                                        children: [
                                                          Checkbox(
                                                              value: controller
                                                                  .lstagencymaster![
                                                                      i]
                                                                  .isSelected,
                                                              onChanged: (v) {
                                                                controller
                                                                    .lstagencymaster![
                                                                        i]
                                                                    .isSelected = v;
                                                                controller
                                                                    .update([
                                                                  "billMaster"
                                                                ]);
                                                              }),
                                                          Text(controller
                                                                  .lstagencymaster![
                                                                      i]
                                                                  .value ??
                                                              "")
                                                        ],
                                                      );
                                                    },
                                                    itemCount: controller
                                                            .lstagencymaster
                                                            ?.length ??
                                                        0,
                                                  ),
                                                )
                                              : Container(
                                                  height: Get.height * 0.45,
                                                  // width: Get.width*0.25,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                );

                                      }),
                                  SizedBox(height: 10,),
                                  Obx(() {
                                    return Visibility(
                                      visible: controller.grp.value,
                                      child: Row(
                                        children: [
                                          InputFields.formField1Width(
                                            paddingLeft: 0,
                                            hintTxt: "Group Name",
                                            controller: controller.grpName,
                                            widthRatio: 0.25
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10,top: 15.0),
                                            child: FormButton1(
                                              btnText: "Save",
                                              callback: () {
                                                controller.addNewGroup1();
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  })
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, bottom: 5, top: 0),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 14.0, left: 0, right: 5),
                        child: FormButtonWrapper(
                          btnText: "Save",
                          callback: () {
                            // controllerX.showApiCall();
                            controller.save();
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
                            Get.delete<EBillAgencyGroupMasterController>();
                            Get.find<HomeController>().clearPage1();
                          },
                          showIcon: true,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 5, right: 10),
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
