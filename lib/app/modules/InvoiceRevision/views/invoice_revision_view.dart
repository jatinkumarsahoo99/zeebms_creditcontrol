import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/invoice_revision_controller.dart';

class InvoiceRevisionView extends GetView<InvoiceRevisionController> {
  InvoiceRevisionView({Key? key}) : super(key: key);

  final controller =
      Get.put<InvoiceRevisionController>(InvoiceRevisionController());

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
                    titleInLeft: true,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (data) {},
                    "Channel",
                    titleInLeft: true,
                    .23,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DateWithThreeTextField(
                    title: "From Date",
                    mainTextController: TextEditingController(),
                    widthRation: .135,
                    titleInLeft: true,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FormButtonWrapper(
                    btnText: "Retrieve",
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

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InputFields.formFieldExpand2(
                                hintTxt: "Location",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 300,
                              child: InputFields.formFieldExpand2(
                                hintTxt: "Channel",
                                controller: TextEditingController(),
                                titleInLeft: true,
                                titleSizeboxWidth: 55,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InputFields.formFieldExpand2(
                                hintTxt: "SAP Invoice No",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 300,
                              child: DateWithThreeTextField(
                                title: "Bill Date",
                                mainTextController: TextEditingController(),
                                widthRation: .135,
                                titleInLeft: true,
                              ),
                            ),
                            // Expanded(
                            //   child: InputFields.formFieldExpand2(
                            //     hintTxt: "Channel",
                            //     controller: TextEditingController(),
                            //     titleInLeft: true,
                            //   ),
                            // ),
                          ],
                        ),
                        // InputFields.formFieldExpand2(
                        //   hintTxt: "Short Name",
                        //   controller: TextEditingController(),
                        //   titleInLeft: true,
                        // ),
                        InputFields.formFieldExpand2(
                          hintTxt: "Client",
                          controller: TextEditingController(),
                          titleInLeft: true,
                        ),
                        InputFields.formFieldExpand2(
                          hintTxt: "Agency",
                          controller: TextEditingController(),
                          titleInLeft: true,
                        ),
                        InputFields.formFieldExpand2(
                          hintTxt: "Pay Route",
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
                        Row(
                          children: [
                            Expanded(
                              child: InputFields.formFieldExpand2(
                                hintTxt: "Booking No",
                                controller: TextEditingController(),
                                titleInLeft: true,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 300,
                              child: InputFields.formFieldExpand2(
                                hintTxt: "Booking Amt",
                                controller: TextEditingController(),
                                titleInLeft: true,
                                titleSizeboxWidth: 55,
                              ),
                            ),
                          ],
                        ),
                        DropDownField.formDropDown1WidthMapExpand(
                          [],
                          (value) {},
                          "Brand",
                          // .23,
                          autoFocus: true,
                          titleInLeft: true,
                          titleSizeBoxWidth: 75,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropDownField.formDropDownSearchAPI2Expand(
                          GlobalKey(),
                          context,
                          title: "New Client",
                          url: "",
                          onchanged: (value) {},
                          titleInLeft: true,
                          textSizeboxWidth: 85,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropDownField.formDropDown1WidthMapExpand(
                          [],
                          (value) {},
                          "New Agency",
                          // .23,
                          autoFocus: true,
                          titleInLeft: true,
                          titleSizeBoxWidth: 75,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropDownField.formDropDown1WidthMapExpand(
                          [],
                          (value) {},
                          "New Payroute",
                          // .23,
                          autoFocus: true,
                          titleInLeft: true,
                          titleSizeBoxWidth: 75,
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Get.find<HomeController>().getCommonButton(
                  Routes.INVOICE_REVISION,
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
