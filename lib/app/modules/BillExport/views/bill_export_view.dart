import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextFieldExpanded.dart';
import 'package:bms_creditcontrol/widgets/sized_box_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/bill_export_controller.dart';

class BillExportView extends GetView<BillExportController> {
  BillExportView({Key? key}) : super(key: key);

  final controller = Get.put<BillExportController>(BillExportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .55,
                // height: MediaQuery,
                // height: MediaQuery.of(context).size.width * 1,

                child: Dialog(
                  backgroundColor: Colors.grey[100],
                  child: SizedBox(
                    height: Get.height * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AppBar(
                          title: const Text('Bill Export'),
                          centerTitle: true,
                          backgroundColor: Colors.deepPurple,
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.locationList.value,
                                      (value) {
                                        controller.selectedLocation = value;
                                      },
                                      "Location",
                                      selected: controller.selectedLocation,
                                    );
                                  }),
                                  sizedBoxHeight(5),
                                  Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.ChannelList.value,
                                      (value) {
                                        controller.selectedChannel = value;
                                      },
                                      "Channel",
                                      selected: controller.selectedChannel,
                                    );
                                  }),
                                  sizedBoxHeight(5),
                                  Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.agencyList.value,
                                      (value) {
                                        controller.selectedAgency = value;
                                      },
                                      "Agency",
                                      selected: controller.selectedAgency,
                                    );
                                  }),

                                  sizedBoxHeight(5),

                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // InputFields.
                                      // sizedBoxWidth(5),
                                      Obx(() {
                                        return Expanded(
                                          child: DateWithThreeTextFieldExpanded(
                                            title: "From",
                                            mainTextController:
                                                controller.tecFrom.value,
                                            // widthRation: .10,
                                            // titleInLeft: true,
                                          ),
                                        );
                                      }),
                                      sizedBoxWidth(5),

                                      Obx(() {
                                        return Expanded(
                                          child: DateWithThreeTextFieldExpanded(
                                            title: "To",
                                            mainTextController:
                                                controller.tecTo.value,
                                            widthRation: .10,
                                            // titleInLeft: true,
                                          ),
                                        );
                                      }),
                                    ],
                                  ),

                                  sizedBoxHeight(5),

                                  // from
                                  Expanded(
                                    child: Obx(() {
                                      return DataGridFromMap3(
                                        mapData: controller.gridData.value,
                                        exportFileName: "Bill Export",
                                      );
                                    }),
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  // Column(
                                  //   // mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     SizedBox(
                                  //       width: 80,
                                  //       child: FormButton(
                                  //         btnText: "Add",
                                  //         callback: () {},
                                  //         showIcon: false,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 10,
                                  //     ),
                                  //     SizedBox(
                                  //       width: 80,
                                  //       child: FormButton(
                                  //         btnText: "Remove",
                                  //         callback: () {},
                                  //         showIcon: false,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FormButton1(
                                        btnText: "Save",
                                        callback: () {},
                                      ),
                                      sizedBoxWidth(10),
                                      FormButton1(
                                        btnText: "Clear",
                                        callback: () {},
                                      ),
                                      sizedBoxWidth(10),
                                      FormButton1(
                                        btnText: "Exit",
                                        callback: () {},
                                      ),
                                      sizedBoxWidth(10),
                                      FormButton1(
                                        btnText: "Data",
                                        callback: () {},
                                      ),
                                    ],
                                  )
                                  // Get.find<HomeController>().getCommonButton(
                                  //   Routes.BILL_EXPORT,
                                  //   (btnName) {},
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
