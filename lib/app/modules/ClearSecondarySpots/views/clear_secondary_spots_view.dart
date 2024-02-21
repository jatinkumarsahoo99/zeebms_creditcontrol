import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextFieldExpanded.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../../widgets/sized_box_widget.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../routes/app_pages.dart';
import '../controllers/clear_secondary_spots_controller.dart';

class ClearSecondarySpotsView extends GetView<ClearSecondarySpotsController> {
  ClearSecondarySpotsView({Key? key}) : super(key: key);

  var controller =
      Get.put<ClearSecondarySpotsController>(ClearSecondarySpotsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .55,
          child: Dialog(
              backgroundColor: Colors.grey[100],
              child: GetBuilder(
                  init: controller,
                  builder: (builder) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppBar(
                          title: const Text('Clear Secondary Spots'),
                          centerTitle: true,
                          backgroundColor: Colors.deepPurple,
                        ),
                        const SizedBox(height: 20),
                        Padding(
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
                                        InputFields.formFieldExpand2(
                                          hintTxt: "YearMonth",
                                          controller: controller.tecYearMonth,
                                          // titleInLeft: true,
                                          titleSizeboxWidth: 90,
                                          // bottomPadding: false,
                                        ),
                                        Obx(() => DropDownField
                                                .formDropDown1WidthMapExpand(
                                              controller.locationList.value,
                                              (value) {
                                                controller.selectedLocation =
                                                    value;
                                              },
                                              "Location",
                                              dialogHeight: 200,
                                              selected:
                                                  controller.selectedLocation,
                                              // .23,
                                              // autoFocus: true,
                                              // titleInLeft: true,
                                              titleSizeBoxWidth: 85,
                                            )),
                                        sizedBoxHeight(5),
                                        Obx(() => DropDownField
                                                .formDropDown1WidthMapExpand(
                                              controller.channelList.value,
                                              (value) {
                                                controller.selectedChannel =
                                                    value;
                                              },
                                              "Channel",
                                              dialogHeight: 200,
                                              selected:
                                                  controller.selectedChannel,
                                              // .23,
                                              // autoFocus: true,
                                              // titleInLeft: true,
                                              titleSizeBoxWidth: 85,
                                            )),
                                        sizedBoxHeight(5),
                                        DateWithThreeTextFieldExpanded(
                                          title: "Telecast Date",
                                          mainTextController:
                                              controller.tecTelecastDate,
                                          // TextEditingController(),
                                          // widthRation: .135,
                                          // titleInLeft: true,
                                          titleInSizeBox: 85,

                                          // isExpanded: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    // width: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        sizedBoxHeight(18),
                                        SizedBox(
                                          width: 200,
                                          child: FormButton(
                                            btnText: "Scroll/Aston",
                                            callback: () {
                                              controller.onScrollClick();
                                            },
                                            showIcon: false,
                                          ),
                                        ),
                                        sizedBoxHeight(20),
                                        SizedBox(
                                          width: 200,
                                          child: FormButton(
                                            btnText: "Astro",
                                            callback: () {
                                              controller.onAstro();
                                            },
                                            showIcon: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.end,
                              //   children: [
                              //     Expanded(
                              //       child: DropDownField.formDropDown1WidthMapExpand(
                              //         [],
                              //         (value) {},
                              //         "Location",
                              //         // .23,
                              //         // autoFocus: true,
                              //         // titleInLeft: true,
                              //         titleSizeBoxWidth: 85,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     SizedBox(
                              //       width: 200,
                              //       child: FormButton(
                              //         btnText: "Astro",
                              //         callback: () {},
                              //         showIcon: false,
                              //       ),
                              //     )
                              //   ],
                              // ),

                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: DropDownField.formDropDown1WidthMapExpand(
                              //         [],
                              //         (value) {},
                              //         "Channel",
                              //         // .23,
                              //         // autoFocus: true,
                              //         // titleInLeft: true,
                              //         titleSizeBoxWidth: 85,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     SizedBox(
                              //       width: 200,
                              //       // child: FormButton(
                              //       //   btnText: "Astro",
                              //    au   //   callback: () {},
                              //       //   showIcon: false,
                              //       // ),
                              //     )
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: DateWithThreeTextFieldExpanded(
                              //         title: "Telecast Date",
                              //         mainTextController: TextEditingController(),
                              //         // widthRation: .135,
                              //         // titleInLeft: true,
                              //         titleInSizeBox: 85,

                              //         // isExpanded: true,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     SizedBox(
                              //       width: 200,
                              //     )
                              //   ],
                              // ),

                              SizedBox(
                                height: 10,
                              ),
                              Get.find<HomeController>().getCommonButton(
                                Routes.CLEAR_SECONDARY_SPOTS,
                                (btnName) {
                                  controller.formHandler(btnName);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  })),
        ),
      ),
    );
  }
}
