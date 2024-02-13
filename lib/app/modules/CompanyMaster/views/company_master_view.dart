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
                        padding: const EdgeInsets.all(5),
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
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "Company Name",
                                          controller:
                                              controller.tecCompanyName.value,
                                          focusNode: controller.companyNameFN,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "Short Name",
                                          controller:
                                              controller.tecShortName.value,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "Corp Address",
                                          controller:
                                              controller.tecCorpAddress.value,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      InputFields.formFieldExpand2(
                                        hintTxt: "",
                                        controller: controller.tecCorpAddress2,
                                        // showTitle: false,
                                        // titleInLeft: true,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Obx(() => DropDownField
                                                    .formDropDown1WidthMapExpand(
                                                  controller.cityList.value,
                                                  (value) {
                                                    controller.selectedCity =
                                                        value;
                                                  },
                                                  "City",
                                                  // titleInLeft: true,
                                                  selected:
                                                      controller.selectedCity,
                                                  titleSizeBoxWidth: 75,
                                                )),
                                          ),
                                          // Expanded(
                                          //   child: InputFields.formFieldExpand2(
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
                                              return InputFields
                                                  .formFieldExpand2(
                                                hintTxt: "Pin",
                                                controller:
                                                    controller.tecPin.value,
                                                // titleInLeft: true,
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Obx(() {
                                              return InputFields
                                                  .formFieldExpand2(
                                                hintTxt: "TelePhone",
                                                controller: controller
                                                    .tecTelephone.value,
                                                // titleInLeft: true,
                                              );
                                            }),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Obx(() {
                                              return InputFields
                                                  .formFieldExpand2(
                                                hintTxt: "Fax",
                                                controller:
                                                    controller.tecFax.value,
                                                // titleInLeft: true,
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "Regd. Address",
                                          controller:
                                              controller.tecRegdAddress.value,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "",
                                          controller:
                                              controller.tecRegdAddress2.value,
                                          // showTitle: false,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "Pan Card No",
                                          controller:
                                              controller.tecPanCardNo.value,
                                          // titleInLeft: true,
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
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "STC No",
                                          controller:
                                              controller.tecSTC_No.value,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "Former Company",
                                          controller:
                                              controller.tecFormerCompany.value,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "Email Address",
                                          controller:
                                              controller.tecEmailAdreess.value,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "Website",
                                          controller:
                                              controller.tecWebSite.value,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "CIN Number",
                                          controller:
                                              controller.tecCIN_Number.value,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "Logo File",
                                          controller:
                                              controller.tecLogoFile.value,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "SAP code",
                                          controller:
                                              controller.tecSAP_Code.value,
                                          // titleInLeft: true,
                                        );
                                      }),
                                      Obx(() {
                                        return InputFields.formFieldExpand2(
                                          hintTxt: "Remarks",
                                          controller:
                                              controller.tecRemarks.value,
                                          // keyboardType: TextInputType.multiline,
                                          inputformatters: [],
                                          height: 60,
                                          expands: true,
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
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
