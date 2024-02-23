import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextFieldExpanded.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                    return FocusTraversalGroup(
                      policy: OrderedTraversalPolicy(),
                      child: Column(
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
                                          FocusTraversalOrder(
                                            order: NumericFocusOrder(0),
                                            child: InputFields.formFieldExpand2(
                                              hintTxt: "YearMonth",
                                              controller:
                                                  controller.tecYearMonth,
                                              // titleInLeft: true,
                                              titleSizeboxWidth: 90,
                                              inputformatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              maxLen: 4,
                                            ),
                                          ),
                                          Obx(() => FocusTraversalOrder(
                                                order: NumericFocusOrder(1),
                                                child: DropDownField
                                                    .formDropDown1WidthMapExpand(
                                                  controller.locationList.value,
                                                  (value) {
                                                    controller
                                                            .selectedLocation =
                                                        value;
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                    // controller.channelFn
                                                    //     .requestFocus();
                                                  },
                                                  "Location",
                                                  dialogHeight: 200,
                                                  selected: controller
                                                      .selectedLocation,
                                                  // .23,
                                                  // autoFocus: true,
                                                  // titleInLeft: true,
                                                  titleSizeBoxWidth: 85,
                                                ),
                                              )),
                                          sizedBoxHeight(5),
                                          Obx(() => FocusTraversalOrder(
                                                order: NumericFocusOrder(2),
                                                child: DropDownField
                                                    .formDropDown1WidthMapExpand(
                                                  controller.channelList.value,
                                                  (value) {
                                                    controller.selectedChannel =
                                                        value;
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  },
                                                  "Channel",
                                                  dialogHeight: 200,
                                                  selected: controller
                                                      .selectedChannel,
                                                  // .23,
                                                  // autoFocus: true,
                                                  // titleInLeft: true,
                                                  titleSizeBoxWidth: 85,
                                                ),
                                              )),
                                          sizedBoxHeight(5),
                                          FocusTraversalOrder(
                                            order: NumericFocusOrder(3),
                                            child:
                                                DateWithThreeTextFieldExpanded(
                                              title: "Telecast Date",
                                              mainTextController:
                                                  controller.tecTelecastDate,

                                              // TextEditingController(),
                                              // widthRation: .135,
                                              // titleInLeft: true,
                                              titleInSizeBox: 85,
                                              // onFocusChange:  ,

                                              // isExpanded: true,
                                            ),
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
                                            child: FocusTraversalOrder(
                                              order: NumericFocusOrder(4),
                                              child: FormButton(
                                                btnText: "Scroll/Aston",
                                                callback: () {
                                                  controller.onScrollClick();
                                                },
                                                showIcon: false,
                                              ),
                                            ),
                                          ),
                                          sizedBoxHeight(20),
                                          SizedBox(
                                            width: 200,
                                            child: FocusTraversalOrder(
                                              order: NumericFocusOrder(5),
                                              child: FormButton(
                                                btnText: "Astro",
                                                callback: () {
                                                  controller.onAstro();
                                                },
                                                showIcon: false,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FocusTraversalOrder(
                                  order: NumericFocusOrder(6),
                                  child: Get.find<HomeController>()
                                      .getCommonButton(
                                    Routes.CLEAR_SECONDARY_SPOTS,
                                    (btnName) {
                                      controller.formHandler(btnName);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
        ),
      ),
    );
  }
}
