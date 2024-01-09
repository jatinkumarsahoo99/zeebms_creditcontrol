import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../controllers/export_billing_f_p_c_controller.dart';

class ExportBillingFPCView extends GetView<ExportBillingFPCController> {
  const ExportBillingFPCView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      DropDownField().formDropDownCheckBoxMap(
                        [],
                        (value) {},
                        "Location",
                        0.16,
                        onChanged: (index, selectValue) {
                          // controller.locations[index].isSelected = selectValue;
                        },
                        // showData:
                      ),
                      DropDownField().formDropDownCheckBoxMap(
                        [],
                        (value) {
                          print(value);
                        },
                        "Channel",
                        0.16,
                        onChanged: (index, selectValue) {},
                      ),
                      DropDownField().formDropDownCheckBoxMap(
                        [],
                        (value) {
                          print(value);
                        },
                        "Program Type",
                        0.16,
                        onChanged: (index, selectValue) {},
                      ),
                      DropDownField().formDropDownCheckBoxMap(
                        [],
                        (value) {
                          print(value);
                        },
                        "Original/Repeat",
                        0.16,
                        onChanged: (index, selectValue) {},
                      ),
                      DropDownField().formDropDownCheckBoxMap(
                        [],
                        (value) {
                          print(value);
                        },
                        "List of Programs",
                        0.16,
                        onChanged: (index, selectValue) {},
                      ),
                      // const SizedBox(
                      //   width: 5,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      FocusTraversalOrder(
                        order: const NumericFocusOrder(3),
                        child: DateWithThreeTextField(
                          title: "From Date",
                          splitType: "-",
                          widthRation: 0.12,
                          // isEnable: controller.isEnable.value,
                          onFocusChange: (data) async {
                            // LoadingDialog.call();
                            // await controller.loadAsrunData();
                            // await controller.loadviewFPCData();
                            // Get.back();
                          },
                          mainTextController: TextEditingController(),
                        ),
                      ),
                      FocusTraversalOrder(
                        order: const NumericFocusOrder(4),
                        child: DateWithThreeTextField(
                          title: "To Date",
                          splitType: "-",
                          widthRation: 0.12,
                          // isEnable: controller.isEnable.value,
                          onFocusChange: (data) async {
                            // LoadingDialog.call();
                            // await controller.loadAsrunData();
                            // await controller.loadviewFPCData();
                            // Get.back();
                          },
                          mainTextController: TextEditingController(),
                        ),
                      ),
                      FormButton(
                        btnText: "Genrate",
                        callback: () {
                          // controller.genrate();
                        },
                        showIcon: false,
                      ),
                      FormButton(
                        btnText: "Clear",
                        callback: () {
                          // controller.genrate();
                        },
                        showIcon: false,
                      ),
                      FormButton(
                        btnText: "Exit",
                        callback: () {
                          // controller.genrate();
                        },
                        showIcon: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    ));
  }
}
