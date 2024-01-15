import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/CheckBoxWidget.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/currency_type_master_controller.dart';

class CurrencyTypeMasterView extends GetView<CurrencyTypeMasterController> {
  CurrencyTypeMasterView({Key? key}) : super(key: key);

  // final controller = Get.put<CurrencyTypeMasterController>(
  //   CurrencyTypeMasterController(),
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .55,
          child: Dialog(
            backgroundColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: const Text('Currency Type Master'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputFields.formFieldExpand2(
                        hintTxt: "Currency Name",
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: 90,
                        // bottomPadding: false,
                      ),
                      InputFields.formFieldExpand2(
                        hintTxt: "Short Name",
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: 90,
                        // bottomPadding: false,
                      ),

                      Row(
                        children: [
                          // Expanded(
                          //   child: InputFields.formFieldExpand2(
                          //     hintTxt: "City",
                          //     controller: TextEditingController(),
                          //     titleInLeft: true,
                          //   ),
                          // ),
                          Expanded(
                            child: InputFields.formFieldExpand2(
                              hintTxt: "Currency Code",
                              controller: TextEditingController(),
                              titleInLeft: true,
                              titleSizeboxWidth: 90,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DropDownField.formDropDown1WidthMapExpand(
                              [],
                              (p0) => null,
                              "Location",
                              titleInLeft: true,
                              titleSizeBoxWidth: 75,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: InputFields.formFieldExpand2(
                              hintTxt: "Lower Currency Name",
                              controller: TextEditingController(),
                              titleInLeft: true,
                              titleSizeboxWidth: 90,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InputFields.formFieldExpand2(
                              hintTxt: "Currency",
                              controller: TextEditingController(),
                              titleInLeft: true,
                              titleSizeboxWidth: 80,
                            ),
                          ),
                        ],
                      ),

                      CheckBoxWidget1(title: "Default Currency"),

                      // DropDownField.formDropDownSearchAPI2Expand(
                      //   GlobalKey(),
                      //   context,
                      //   title: "Related Zone",
                      //   url: "",
                      //   onchanged: (value) {},
                      //   titleInLeft: true,
                      //   textSizeboxWidth: 95,
                      // ),

                      SizedBox(
                        height: 10,
                      ),
                      Get.find<HomeController>().getCommonButton(
                        Routes.CURRENCY_TYPE_MASTER,
                        (btnName) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
