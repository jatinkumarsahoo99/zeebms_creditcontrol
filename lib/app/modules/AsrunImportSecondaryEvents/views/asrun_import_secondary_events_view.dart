import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../controllers/asrun_import_secondary_events_controller.dart';

class AsrunImportSecondaryEventsView
    extends GetView<AsrunImportSecondaryEventsController> {
  AsrunImportSecondaryEventsView({Key? key}) : super(key: key);
  AsrunImportSecondaryEventsController controller =
      Get.put<AsrunImportSecondaryEventsController>(
          AsrunImportSecondaryEventsController());
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
                runSpacing: 5,
                spacing: 5,
                children: [
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (value) {},
                    "Location",
                    .23,
                    autoFocus: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (data) {},
                    "Channel",
                    .23,
                  ),
                  DateWithThreeTextField(
                    title: "Log Date",
                    mainTextController: controller.logDate,
                    widthRation: .135,
                  ),
                  FormButtonWrapper(
                    btnText: "Import File",
                    callback: () {
                      controller.pickFile();
                    },
                    showIcon: false,
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
                  disableBtns: ['Save', 'Refresh'],
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
