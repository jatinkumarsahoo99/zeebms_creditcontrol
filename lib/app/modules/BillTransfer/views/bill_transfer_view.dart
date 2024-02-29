import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/SizeDefine.dart';
import '../../../routes/app_pages.dart';
import '../controllers/bill_transfer_controller.dart';

class BillTransferView extends GetView<BillTransferController> {
  BillTransferView({Key? key}) : super(key: key);

  BillTransferController controllerX =
  Get.put<BillTransferController>(BillTransferController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
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
                    title: Text('Bill Transfer'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return DropDownField.formDropDown1WidthMap(
                              controllerX.locationList.value ?? [],
                                  (value) {
                                controllerX.selectLocation = value;
                                // controllerX.getChannel(locationCode: value.key);
                              },
                              "Location",
                              .425,
                              // isEnable: controllerX.isEnable.value,
                              selected: controllerX.selectLocation,
                              dialogHeight: Get.height * .4,
                              autoFocus: true,
                            );
                          }),
                          SizedBox(
                            height: 4,
                          ),
                          Obx(() {
                            return DropDownField.formDropDown1WidthMap(
                              controllerX.companyList.value ?? [],
                                  (value) {
                                controllerX.selectCompany = value;
                                // controllerX.getChannel(locationCode: value.key);
                              },
                              "Company",
                              .425,
                              // isEnable: controllerX.isEnable.value,
                              selected: controllerX.selectCompany,
                              dialogHeight: Get.height * .4,
                              autoFocus: true,
                            );
                          }),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            width: Get.width * 0.425,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DateWithThreeTextField(
                                  title: "From Date",
                                  mainTextController: controllerX.fromDateController,
                                  widthRation: 0.2,
                                  isEnable: true,
                                ),
                                DateWithThreeTextField(
                                  title: "To Date",
                                  mainTextController: controllerX.toDateController,
                                  widthRation: 0.2,
                                  isEnable: true,
                                  onFocusChange: (val) {
                                    controllerX.toDateLeave();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            width: Get.width * 0.425,
                            child: const Text(
                              "Transfer Summary",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            width: Get.width * 0.425,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InputFields.formField1WidthBox(
                                  hintTxt: "Total To",
                                  widthRatio: 0.1,
                                  // height: Get.height * 0.1,
                                  paddingLeft: 0,
                                  maxLen: 1,
                                  // focus: controllerX.remarkFocus,
                                  controller: controllerX.totalToController,
                                ),
                                InputFields.formField1WidthBox(
                                  hintTxt: "Total SAP Bills",
                                  widthRatio: 0.1,
                                  // height: Get.height * 0.1,
                                  paddingLeft: 0,
                                  maxLen: 1,
                                  // focus: controllerX.remarkFocus,
                                  controller: controllerX.totalSAPBillsController,
                                ),
                                InputFields.formField1WidthBox(
                                  hintTxt: "Total Bills Transferred",
                                  widthRatio: 0.1,
                                  // height: Get.height * 0.1,
                                  paddingLeft: 0,
                                  maxLen: 1,
                                  // focus: controllerX.remarkFocus,
                                  controller: controllerX.totalBillsTransferredController,
                                ),
                                InputFields.formField1WidthBox(
                                  hintTxt: "Pending To Transfer",
                                  widthRatio: 0.1,
                                  // height: Get.height * 0.1,
                                  paddingLeft: 0,
                                  maxLen: 1,
                                  // focus: controllerX.remarkFocus,
                                  controller: controllerX.pendingToTransferController,
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 6),

                  //  List? sourceButtons = [{"id": 1, "name": "Save", "isDisabled": false}]
                  /// bottom common buttons
                  /*Get.find<HomeController>().getCommonButtonWithSourceBtnLst(
                    Routes.BILL_TRANSFER,
                        (btnName) {
                    }, sourceButtons: [{"id": 1, "name": "Transfer", "isDisabled": false},{"id": 1, "name": "Refresh", "isDisabled": false},{"id": 1, "name": "Clear", "isDisabled": false},{"id": 1, "name": "Exit", "isDisabled": false}],
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                        child: Obx(() {
                          return FormButtonWrapper(
                            btnText: "Transfer",
                            callback: () {
                              // controllerX.showDetails(name: controllerX.selectTab.value);
                            },
                            showIcon: true,
                            isEnabled: controllerX.transferBtn.value,
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Refresh",
                          callback: () {
                            // controllerX.showDetails(name: controllerX.selectTab.value);
                          },
                          showIcon: true,
                          isEnabled: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Clear",
                          callback: () {
                           controllerX.clearAll();
                          },
                          showIcon: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Exit",
                          callback: () {
                            // controllerX.showDetails(name: controllerX.selectTab.value);
                          },
                          showIcon: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
