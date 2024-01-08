import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/view_deal_change_history_controller.dart';

class ViewDealChangeHistoryView
    extends GetView<ViewDealChangeHistoryController> {
  ViewDealChangeHistoryView({Key? key}) : super(key: key);

  final controller = Get.put<ViewDealChangeHistoryController>(
    ViewDealChangeHistoryController(),
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
                    .20,
                    autoFocus: true,
                    titleInLeft: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (data) {},
                    "Channel",
                    titleInLeft: true,
                    .20,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (data) {},
                    "Client",
                    titleInLeft: true,
                    .23,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (data) {},
                    "Deal No",
                    titleInLeft: true,
                    .15,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormButtonWrapper(
                    btnText: "Show Deal History",
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
                  Routes.VIEW_DEAL_CHANGE_HISTORY,
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
