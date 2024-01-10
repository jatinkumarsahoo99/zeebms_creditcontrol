import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/NeumorphismButtonList.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/r_o_audit_controller.dart';

class ROAuditView extends GetView<ROAuditController> {
  ROAuditView({Key? key}) : super(key: key);

  ROAuditController controllerX =
  Get.put<ROAuditController>(ROAuditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                        () =>
                        DropDownField.formDropDown1WidthMap(
                          controllerX.progTypeList.value ?? [],
                              (value) {
                            controllerX.selectedProgTypeList = value;
                            // controllerX.getBMSVersion(programTypeCode: value.key??"");
                          },
                          "Location",
                          .17,
                          isEnable: controllerX.isEnable.value,
                          selected: controllerX.selectedProgTypeList,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,
                        ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Obx(
                        () =>
                        DropDownField.formDropDown1WidthMap(
                          controllerX.bmsVersionList.value ?? [],
                              (value) {
                            controllerX.selectedBMSVersionList = value;
                            // controllerX.getMatchDetails(programCode: value.key??"");
                          },
                          "Channel",
                          .17,
                          isEnable: controllerX.isEnable.value,
                          selected: controllerX.selectedBMSVersionList,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,
                        ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DateWithThreeTextField(
                    title: "Schedule Date",
                    mainTextController: controllerX.fromDateController,
                    widthRation: .1,
                    isEnable: controllerX.isEnable.value,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    child: FormButtonWrapper(
                      btnText: "Show Details",
                      callback: () {
                        // controllerX.showApiCall();
                      },
                      showIcon: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              /*  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          controllerX.additionClick.value =
                              !(controllerX.additionClick.value);
                          controllerX.additionClick.refresh();
                        },
                        child: Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            color: controllerX.additionClick.value
                                ? Colors.grey[300]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[
                                      (controllerX.additionClick.value)
                                          ? 500
                                          : 300]!,
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  inset: controllerX.additionClick.value),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Press me',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),*/
              SizedBox(
                // height: Get.height*0.13,
                  child: NeumorphismButtonList(
                    btnName: const [
                      "Additions",
                      "Cancellation",
                      "Re-Schedule",
                      "Deal Approval",
                      "Additions Pending"
                    ],
                    fun: (index, name) {
                      print(">>>>>>>>name&index" + name + index.toString());
                      controllerX.selectedInt.value = index;
                      controllerX.selectedInt.refresh();
                    },
                  )),
              SizedBox(
                height: 8,
              ),
              /*  Expanded(
                // flex: 9,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: GetBuilder<ROAuditController>(
                      id: "grid",
                      builder: (controllerX) {
                        return Container();
                      }),
                ),
              ),*/
              Obx(() {
                return getSelectedWidget(index: controllerX.selectedInt.value);
              }),
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
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    switch (index) {
      case 0:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return SizedBox(
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
                    child: Center(child: Text("data not found0")),
                  );
                }),
          ),
        );
        break;
      case 1:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return SizedBox(
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
                    child: Center(child: Text("data not found1")),
                  );
                }),
          ),
        );
        break;
      case 2:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return SizedBox(
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
                    child: Center(child: Text("data not found2")),
                  );
                }),
          ),
        );
        break;
      case 3:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return SizedBox(
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
                    child: Center(child: Text("data not found3")),
                  );
                }),
          ),
        );
        break;
      case 4:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return SizedBox(
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
                    child: Center(child: Text("data not found4")),
                  );
                }),
          ),
        );
        break;
      default:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return Container();
                }),
          ),
        );
        break;
    }
  }
}
