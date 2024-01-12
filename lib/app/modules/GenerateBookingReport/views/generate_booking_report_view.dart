import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../controllers/generate_booking_report_controller.dart';

class GenerateBookingReportView
    extends GetView<GenerateBookingReportController> {
   GenerateBookingReportView({Key? key}) : super(key: key);


   GenerateBookingReportController controllerX =
   Get.put<GenerateBookingReportController>(GenerateBookingReportController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownField.formDropDown1WidthMap(
                  [],
                      (value) {
                    // controllerX.selectedBMSVersionList = value;
                    // controllerX.getMatchDetails(programCode: value.key??"");
                  },
                  "Location",
                  .16,
                  // isEnable: controllerX.isEnable.value,
                  // selected: controllerX.selectedBMSVersionList,
                  dialogHeight: Get.height * .35,
                  autoFocus: true,
                ),
                SizedBox(
                  width: 7,
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controllerX.channels,
                      (value) {
                    print(value);
                  },
                  "Channel",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                SizedBox(
                  width: 7,
                ),
                DateWithThreeTextField(
                  title: "From",
                  mainTextController: TextEditingController(),
                  widthRation: .16,
                  // isEnable: controllerX.isEnable.value,
                ),
                SizedBox(
                  width: 7,
                ),
                DateWithThreeTextField(
                  title: "To",
                  mainTextController: TextEditingController(),
                  widthRation: .16,
                  // isEnable: controllerX.isEnable.value,
                ),
                SizedBox(
                  width: 7,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                  child: FormButtonWrapper(
                    btnText: "Retrieve",
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
            Expanded(child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
