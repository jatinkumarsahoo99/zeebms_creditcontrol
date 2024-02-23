import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
// import 'package:flutter/services.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
// import 'dart:math' as math;
import '../controllers/credit_rate_master_controller.dart';

class CreditRateMasterView extends GetView<CreditRateMasterController> {
  CreditRateMasterView({Key? key}) : super(key: key);

  final controller =
      Get.put<CreditRateMasterController>(CreditRateMasterController());

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
                          title: const Text('Credit Rate Master'),
                          centerTitle: true,
                          backgroundColor: Colors.deepPurple,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => InputFields.formFieldExpand2(
                                  hintTxt: "Description",
                                  controller: controller.tecDescription.value,
                                  // titleInLeft: true,
                                  titleSizeboxWidth: 90,
                                  focusNode: controller.descriptionFocus,
                                  maxLen: 40,
                                  // capital: true,
                                  inputformatters: [
                                    UpperCaseTextFormatter(),
                                  ],

                                  // t
                                  // bottomPadding: false,
                                ),
                              ),
                              Obx(
                                () => InputFields.formFieldExpand2(
                                  hintTxt: "Grade In Short",
                                  controller: controller.tecGradeInShort.value,
                                  // titleInLeft: true,
                                  titleSizeboxWidth: 90,
                                  maxLen: 2,
                                  // capital: true,
                                  inputformatters: [
                                    UpperCaseTextFormatter(),
                                  ],

                                  // bottomPadding: false,
                                ),
                              ),
                              Obx(
                                () => InputFields.formFieldExpand2(
                                  hintTxt: "Lower Limit",
                                  controller: controller.tecLowerLimit.value,
                                  // titleInLeft: true,
                                  titleSizeboxWidth: 90,
                                  maxLen: 9,
                                  // bottomPadding: false,
                                  inputformatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,4}'))
                                  ],
                                ),
                              ),
                              Obx(
                                () => InputFields.formFieldExpand2(
                                  hintTxt: "Upper Limit",
                                  controller: controller.tecUpperLimit.value,
                                  // titleInLeft: true,
                                  titleSizeboxWidth: 90,
                                  maxLen: 2,
                                  inputformatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,4}'))
                                  ],
                                  // bottomPadding: false,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Get.find<HomeController>().getCommonButton(
                                Routes.CREDIT_RATE_MASTER,
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
