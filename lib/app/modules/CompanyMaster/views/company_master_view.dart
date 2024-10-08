import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/company_master_controller.dart';

class CompanyMasterView extends GetView<CompanyMasterController> {
  CompanyMasterView({Key? key}) : super(key: key);

  var controller = Get.put<CompanyMasterController>(CompanyMasterController());

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          // height: Get.height * 0.9,
          // width: MediaQuery.of(context).size.width * .55,
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
                        title: const Text('Company Master'),
                        centerTitle: true,
                        backgroundColor: Colors.deepPurple,
                      ),
                      // const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: FocusTraversalGroup(
                          policy: OrderedTraversalPolicy(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(0),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "Company Name",
                                              controller: controller
                                                  .tecCompanyName.value,
                                              focusNode:
                                                  controller.companyNameFN,
                                              // bottomPadding: false,
                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),

                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(1),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "Short Name",
                                              // bottomPadding: false,

                                              controller:
                                                  controller.tecShortName.value,
                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),

                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(2),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "Corp Address",
                                              // bottomPadding: false,
                                              controller: controller
                                                  .tecCorpAddress.value,
                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),

                                        FocusTraversalOrder(
                                          order: NumericFocusOrder(3),
                                          child: InputFields.formFieldExpand2(
                                            bottomPaddingHeight: 3,
                                            hintTxt: "",
                                            controller:
                                                controller.tecCorpAddress2,
                                            // bottomPadding: false,

                                            // showTitle: false,
                                            // titleInLeft: true,
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Obx(() =>
                                                  FocusTraversalOrder(
                                                    order: NumericFocusOrder(4),
                                                    child: DropDownField
                                                        .formDropDown1WidthMapExpand(
                                                      controller.cityList.value,
                                                      (value) {
                                                        controller
                                                                .selectedCity =
                                                            value;
                                                      },
                                                      "City",
                                                      // titleInLeft: true,
                                                      selected: controller
                                                          .selectedCity,

                                                      titleSizeBoxWidth: 75,
                                                    ),
                                                  )),
                                            ),
                                            // Expanded(
                                            //   child: InputFields.formFieldExpand2(
                                            // bottomPaddingHeight: 3,
                                            //     hintTxt: "City",
                                            //     controller: TextEditingController(),
                                            // titleInLeft: true,
                                            //   ),
                                            // ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Obx(() {
                                                return FocusTraversalOrder(
                                                  order: NumericFocusOrder(5),
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                    hintTxt: "Pin",
                                                    controller:
                                                        controller.tecPin.value,
                                                    bottomPaddingHeight: 3,
                                                    maxLen: 7,
                                                    // bottomPadding: false,

                                                    // titleInLeft: true,
                                                  ),
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Obx(() {
                                                return FocusTraversalOrder(
                                                  order: NumericFocusOrder(6),
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                    hintTxt: "TelePhone",
                                                    controller: controller
                                                        .tecTelephone.value,
                                                    bottomPaddingHeight: 3,
                                                    maxLen: 20,
                                                    // bottomPadding: false,

                                                    // titleInLeft: true,
                                                  ),
                                                );
                                              }),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Obx(() {
                                                return FocusTraversalOrder(
                                                  order: NumericFocusOrder(7),
                                                  child: InputFields
                                                      .formFieldExpand2(
                                                    hintTxt: "Fax",
                                                    bottomPaddingHeight: 3,

                                                    // bottomPadding: false,

                                                    controller:
                                                        controller.tecFax.value,
                                                    maxLen: 20,
                                                    // titleInLeft: true,
                                                  ),
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(8),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "Regd. Address",
                                              controller: controller
                                                  .tecRegdAddress.value,
                                              // bottomPadding: false,

                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(9),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "",
                                              controller: controller
                                                  .tecRegdAddress2.value,
                                              // bottomPadding: false,

                                              // showTitle: false,
                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(10),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "Pan Card No",
                                              controller:
                                                  controller.tecPanCardNo.value,
                                              maxLen: 20,
                                              // bottomPadding: false,

                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(11),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "STC No",
                                              controller:
                                                  controller.tecSTC_No.value,
                                              // bottomPadding: false,

                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(12),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "Former Company",
                                              controller: controller
                                                  .tecFormerCompany.value,
                                              // bottomPadding: false,

                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(13),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "Email Address",
                                              controller: controller
                                                  .tecEmailAdreess.value,
                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(14),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "Website",
                                              controller:
                                                  controller.tecWebSite.value,
                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(15),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "CIN Number",
                                              controller: controller
                                                  .tecCIN_Number.value,
                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(16),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "Logo File",
                                              controller:
                                                  controller.tecLogoFile.value,
                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(17),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "SAP code",
                                              controller:
                                                  controller.tecSAP_Code.value,
                                              // titleInLeft: true,
                                            ),
                                          );
                                        }),
                                        Obx(() {
                                          return FocusTraversalOrder(
                                            order: NumericFocusOrder(18),
                                            child: InputFields.formFieldExpand2(
                                              bottomPaddingHeight: 3,
                                              hintTxt: "Remarks",
                                              controller:
                                                  controller.tecRemarks.value,
                                              // keyboardType: TextInputType.multiline,
                                              inputformatters: [],
                                              height: 60,
                                              expands: true,
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              // SizedBox(height: 10),
                              Get.find<HomeController>()
                                  .getCommonButton<CompanyMasterController>(
                                Routes.COMPANY_MASTER,
                                (btnName) {
                                  controller.formHandler(btnName);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
