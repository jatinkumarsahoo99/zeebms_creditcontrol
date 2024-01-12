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
                  0.19,
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
                  0.19,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  [],
                  (value) {
                    print(value);
                  },
                  "Program Type",
                  0.19,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  [],
                  (value) {
                    print(value);
                  },
                  "Original/Repeat",
                  0.19,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  [],
                  (value) {
                    print(value);
                  },
                  "List of Programs",
                  0.19,
                  onChanged: (index, selectValue) {},
                ),
                DateWithThreeTextField(
                  title: "From Date",
                  widthRation: 0.13,
                  mainTextController: TextEditingController(),
                ),
                DateWithThreeTextField(
                  title: "To Date",
                  widthRation: 0.13,
                  mainTextController: TextEditingController(),
                ),
                FormButton(
                  btnText: "Genrate",
                  callback: () {},
                  showIcon: false,
                ),
                FormButton(
                  btnText: "Clear",
                  callback: () {},
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
    );
  }
}
