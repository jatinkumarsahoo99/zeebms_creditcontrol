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
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<CompanyMasterController>(
        init: controller,
        // id: "clear",
        builder: (controller) {
          return Center(
            child: SizedBox(
              // width: w * 0.5,
              width: context.width,
              height: context.height,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              InputFields.formFieldExpand2(
                                hintTxt: "Company Name",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Short Name",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Corp Address",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: DropDownField
                                        .formDropDown1WidthMapExpand(
                                      [],
                                      (p0) => null,
                                      "City",
                                      titleInLeft: true,
                                      titleSizeBoxWidth: 75,
                                    ),
                                  ),
                                  // Expanded(
                                  //   child: InputFields.formFieldExpand2(
                                  //     hintTxt: "City",
                                  //     controller: TextEditingController(),
                                  //     titleInLeft: true,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "Pin",
                                      controller: TextEditingController(),
                                      titleInLeft: true,
                                      titleSizeboxWidth: 50,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "Telephone",
                                      controller: TextEditingController(),
                                      titleInLeft: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "Fax",
                                      controller: TextEditingController(),
                                      titleInLeft: true,
                                      titleSizeboxWidth: 50,
                                    ),
                                  ),
                                ],
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Regd. Address",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "PAN Card No",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              InputFields.formFieldExpand2(
                                hintTxt: "STC No",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Former Company",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Email Address",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Website",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "CIN Number",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Logo File",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "SAP code",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Remarks",
                                controller: TextEditingController(),
                                titleInLeft: true,
                                // titleSizeboxWidth: 50,
                                height: 55,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Get.find<HomeController>()
                        .getCommonButton<CompanyMasterController>(
                      Routes.COMPANY_MASTER,
                      (btnName) {},
                    ),
                  ],
                  // InputFields.formFieldExpand2(hintTxt: "hintTxt", controller: TextEditingController())
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
