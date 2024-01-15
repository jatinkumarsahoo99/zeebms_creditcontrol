import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/spots_not_telecasted_report_controller.dart';

class SpotsNotTelecastedReportView
    extends GetView<SpotsNotTelecastedReportController> {
  SpotsNotTelecastedReportView({Key? key}) : super(key: key);

  final controller = Get.put<SpotsNotTelecastedReportController>(
    SpotsNotTelecastedReportController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
      init: controller,
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                runSpacing: 10,
                spacing: 10,
                children: [
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (value) {},
                    "Location",
                    .23,
                    autoFocus: true,
                    titleInLeft: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (data) {},
                    "Channel",
                    titleInLeft: true,
                    .23,
                  ),
                  DateWithThreeTextField(
                    title: "From Date",
                    mainTextController: TextEditingController(),
                    widthRation: .135,
                    titleInLeft: true,
                  ),
                  DateWithThreeTextField(
                    title: "To Date",
                    mainTextController: TextEditingController(),
                    widthRation: .135,
                    titleInLeft: true,
                  ),
                  FormButtonWrapper(
                    btnText: "Generate",
                    callback: () {
                      // controller.pickFile();
                    },
                    showIcon: false,
                  ),
                ],
              ),

              const SizedBox(height: 10),
              // Obx(
              //   () =>
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                ),
              ),

              SizedBox(
                // width: 40,
                height: 10,
              ),

              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Get.find<HomeController>().getCommonButton(
                  Routes.SPOTS_NOT_TELECASTED_REPORT,
                  // handleAutoClear: false,
                  // disableBtns: ['Save', 'Refresh'],
                  (btnName) {
                    // controller.formHandler(btnName);
                  },
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
