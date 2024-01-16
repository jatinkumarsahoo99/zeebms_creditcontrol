import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../controllers/export_billing_f_p_c_controller.dart';

class ExportBillingFPCView extends GetView<ExportBillingFPCController> {
  ExportBillingFPCView({Key? key}) : super(key: key);

  ExportBillingFPCController controller =
      Get.put<ExportBillingFPCController>(ExportBillingFPCController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                runSpacing: 10,
                spacing: 10,
                children: [
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(1),
                    child: DropDownField().formDropDownCheckBoxMap(
                      controller.locations,
                      (value) {},
                      "Location",
                      0.19,
                      onChanged: (index, selectValue) {
                        controller.locations[index].isSelected = selectValue;
                      },
                      autoFocus: true,
                      inkWellFocusNode: controller.loactionFN,
                    ),
                  ),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(2),
                    child: DropDownField().formDropDownCheckBoxMap(
                      controller.channels,
                      (value) {
                        print(value);
                      },
                      "Channel",
                      0.19,
                      onChanged: (index, selectValue) {},
                    ),
                  ),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(5),
                    child: DropDownField().formDropDownCheckBoxMap(
                      controller.programType,
                      (value) {},
                      "Program Type",
                      0.19,
                      onChanged: (index, selectValue) {},
                    ),
                  ),
                  DropDownField().formDropDownCheckBoxMap(
                    controller.orignalRepeat,
                    (value) {},
                    "Original/Repeat",
                    0.19,
                    onChanged: (index, selectValue) {},
                  ),
                  DropDownField().formDropDownCheckBoxMap(
                    controller.listOfProgram,
                    (value) {},
                    "List of Programs",
                    0.19,
                    onChanged: (index, selectValue) {},
                  ),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(3),
                    child: DateWithThreeTextField(
                      title: "From Date",
                      widthRation: 0.13,
                      mainTextController: controller.fromDate,
                    ),
                  ),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(4),
                    child: DateWithThreeTextField(
                      title: "To Date",
                      widthRation: 0.13,
                      mainTextController: controller.toDate,
                      onFocusChange: (value) {
                        controller.dateLeave();
                      },
                    ),
                  ),
                  FormButton(
                    btnText: "Genrate",
                    callback: () {
                      controller.generate();
                    },
                    showIcon: false,
                  ),
                  FormButton(
                    btnText: "Clear",
                    callback: () {
                      Get.delete<ExportBillingFPCController>();
                      Get.find<HomeController>().clearPage1();
                    },
                    showIcon: false,
                  ),
                  FormButton(
                    btnText: "Exit",
                    callback: () {},
                    showIcon: false,
                  ),
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}
