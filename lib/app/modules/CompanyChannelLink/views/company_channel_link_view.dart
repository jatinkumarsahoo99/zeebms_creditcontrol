import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/sized_box_widget.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/company_channel_link_controller.dart';

class CompanyChannelLinkView extends GetView<CompanyChannelLinkController> {
  CompanyChannelLinkView({Key? key}) : super(key: key);

  final controller = Get.put<CompanyChannelLinkController>(
    CompanyChannelLinkController(),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DropDownField.formDropDown1WidthMapExpand(
                                [],
                                (value) {},
                                "Location Name",
                                // .23,
                                autoFocus: true,
                                // titleInLeft: true,
                              ),
                            ),
                            sizedBoxWidth(10),
                            Expanded(
                              child: DropDownField.formDropDown1WidthMapExpand(
                                [],
                                (value) {},
                                "Channel Name",
                                // .23,
                                autoFocus: true,
                                // titleInLeft: true,
                              ),
                            ),
                          ],
                        ),
                        sizedBoxHeight(5),
                        DropDownField.formDropDown1WidthMapExpand(
                          [],
                          (value) {},
                          "Collection Agent",
                          // .23,
                          autoFocus: true,
                          // titleInLeft: true,
                        ),
                        sizedBoxHeight(5),
                        DropDownField.formDropDown1WidthMapExpand(
                          [],
                          (value) {},
                          "Parent Company",
                          // .23,
                          autoFocus: true,
                          // titleInLeft: true,
                        ),
                        sizedBoxHeight(5),
                        DropDownField.formDropDown1WidthMapExpand(
                          [],
                          (value) {},
                          "Sap Profit Center",
                          // .23,
                          autoFocus: true,
                          // titleInLeft: true,
                        ),
                      ],
                    ),
                  ),
                  sizedBoxWidth(10),
                  SizedBox(
                    width: Get.width * .4,
                    child: Expanded(
                      child: Column(
                        children: [
                          DropDownField.formDropDown1WidthMapExpand(
                            [],
                            (value) {},
                            "Payroute Category",
                            // .23,
                            autoFocus: true,
                            // titleInLeft: true,
                          ),
                          sizedBoxHeight(5),
                          DropDownField().formDropDownCheckBoxMapExpanded(
                            [],
                            (value) {},
                            "Currency",
                            // 0.16,
                            onChanged: (index, selectValue) {
                              // controller.locations[index].isSelected = selectValue;
                            },
                            // showData:
                          ),
                        ],
                      ),
                    ),
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
                  Routes.COMPANY_CHANNEL_LINK,
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
