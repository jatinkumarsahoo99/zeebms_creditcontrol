import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_route_master_controller.dart';

class PaymentRouteMasterView extends GetView<PaymentRouteMasterController> {
  PaymentRouteMasterView({Key? key}) : super(key: key);

  PaymentRouteMasterController controller =
      Get.put<PaymentRouteMasterController>(PaymentRouteMasterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (controller) {
          return Center(
              child: SizedBox(
            width: Get.width * .50,
            child: Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    title: const Text('Payment Route Master'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      runSpacing: 5,
                      spacing: Get.width * 0.01,
                      children: [
                        InputFields.formField1(
                          hintTxt: "Pay Route Name",
                          controller: controller.payRouteName,
                          width: .34,
                          titleInLeft: true,
                          padLeft: 35,
                        ),
                        InputFields.formField1(
                          hintTxt: "Short Name",
                          controller: controller.shortName,
                          width: .143,
                          titleInLeft: true,
                          padLeft: 58,
                        ),
                        DropDownField.formDropDown1WidthMap(
                          [],
                          (data) {},
                          "Currency",
                          .147,
                          titleInLeft: true,
                        ),
                        DropDownField.formDropDown1WidthMap(
                          [],
                          (data) {},
                          "Loaction Name",
                          .34,
                          titleInLeft: true,
                          padLeft: 42,
                        ),
                        DropDownField.formDropDown1WidthMap(
                          [],
                          (data) {},
                          "Channel Name",
                          .34,
                          titleInLeft: true,
                          padLeft: 45,
                        ),
                        InputFields.formField1(
                          hintTxt: "Main Company Share",
                          controller: controller.mainCompanyShare,
                          width: .34,
                          titleInLeft: true,
                          padLeft: 12,
                        ),
                        InputFields.formField1(
                          hintTxt: "Collection Agent Share",
                          controller: controller.collectionAgentShare,
                          width: .34,
                          titleInLeft: true,
                        ),
                        InputFields.formField1(
                          hintTxt: "Agency Share",
                          controller: controller.agencyShare,
                          width: .34,
                          titleInLeft: true,
                          padLeft: 50,
                        ),
                        DropDownField.formDropDown1WidthMap(
                          [],
                          (data) {},
                          "SAP Cust Grp",
                          .34,
                          titleInLeft: true,
                          padLeft: 51,
                        ),
                        DropDownField.formDropDown1WidthMap(
                          [],
                          (data) {},
                          "Billing Pay Route",
                          .34,
                          titleInLeft: true,
                          padLeft: 35,
                        ),
                        DropDownField.formDropDown1WidthMap(
                          [],
                          (data) {},
                          "Pay Route Category",
                          .34,
                          titleInLeft: true,
                          padLeft: 21,
                        ),
                        const SizedBox(
                          width: 150,
                        ),
                        Obx(() {
                          return CheckBoxWidget1(
                            title: "To be billed",
                            value: controller.isToBeBilled.value,
                            onChanged: (val) {
                              controller.isToBeBilled.value =
                                  !(controller.isToBeBilled.value);
                            },
                          );
                        }),
                        Obx(() {
                          return CheckBoxWidget1(
                            title: "Active",
                            value: controller.isActive.value,
                            onChanged: (val) {
                              controller.isActive.value =
                                  !(controller.isActive.value);
                            },
                          );
                        }),
                        FormButtonWrapper(
                          btnText: "Service Tax",
                          callback: () {
                            serviceTaxDilogBox();
                          },
                          showIcon: false,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Get.find<HomeController>().getCommonButton(
                      Routes.PAYMENT_ROUTE_MASTER,
                      handleAutoClear: false,
                      (btnName) {
                        controller.formHandler(btnName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  serviceTaxDilogBox() {
    showDialog(
      context: Get.context!,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: Get.width * 0.45,
            height: Get.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (data) {},
                    "Loaction",
                    .39,
                    titleInLeft: true,
                    padLeft: 10,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (data) {},
                    "Channel",
                    .39,
                    titleInLeft: true,
                    padLeft: 13,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Obx(
                  //   () =>
                  Expanded(
                      child:
                          // controller.showList.isEmpty
                          //     ?
                          Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                  )
                      // : DataGridFromMap3(
                      //     mapData: [],
                      //     onload: (value) {

                      //     },
                      //     exportFileName: "Mix Master Delivery Status",
                      //     witdthSpecificColumn: Get.find<HomeController>()
                      //         .getGridWidthByKey(
                      //             userGridSettingList:
                      //                 controller.userGridSetting1?.value),
                      //   ),
                      ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Get.find<HomeController>().getCommonButton(
                      Routes.ASRUN_IMPORT_SECONDARY_EVENTS,
                      handleAutoClear: false,
                      disableBtns: ['Save', 'Delete'],
                      (btnName) {
                        controller.serviceTaxFormHandler(btnName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
