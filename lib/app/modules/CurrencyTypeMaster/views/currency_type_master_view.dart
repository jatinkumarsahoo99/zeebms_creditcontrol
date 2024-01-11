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

  CurrencyTypeMasterController controller =
      Get.put<CurrencyTypeMasterController>(CurrencyTypeMasterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: GetBuilder(
          init: controller,
          builder: (controller) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .56,
                child: Dialog(
                  backgroundColor: Colors.grey[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          runSpacing: 5,
                          spacing: 5,
                          children: [
                            InputFields.formFieldExpand2(
                              hintTxt: "Currency Name",
                              controller: controller.currencyName,
                              autoFocus: true,
                            ),
                            InputFields.formFieldExpand2(
                              hintTxt: "Short Name",
                              controller: controller.shortName,
                              // width: .24, // bottomPadding: false,
                              // bottomPadding: false,
                            ),
                            InputFields.formField1(
                              hintTxt: "Currency Code",
                              controller: controller.crrrencyCode,
                              width: .24, // bottomPadding: false,
                            ),
                            DropDownField.formDropDown1WidthMap(
                              [],
                              (value) {},
                              "Location",
                              .24,
                            ),
                            InputFields.formField1(
                              hintTxt: "Lower Currency Name",
                              controller: controller.lowerCurrencyName,
                              width: .24, // bottomPadding: false,
                            ),
                            InputFields.formField1(
                              hintTxt: "Currency",
                              controller: controller.currency,
                              width: .24, // bottomPadding: false,
                            ),
                            CheckBoxWidget1(title: "Default Currency"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Get.find<HomeController>().getCommonButton(
                          Routes.CURRENCY_TYPE_MASTER,
                          handleAutoClear: false,
                          (btnName) {
                            controller.formHandler(btnName);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
