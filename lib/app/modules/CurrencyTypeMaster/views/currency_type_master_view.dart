import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                              inputformatters: [
                                UpperCaseTextFormatter(),
                              ],
                              focusNode: controller.currencyNameFN,
                            ),
                            InputFields.formFieldExpand2(
                              hintTxt: "Short Name",
                              controller: controller.shortName,
                              focusNode: controller.shortNameFN,
                            ),
                            Obx(
                              () => InputFields.formField1(
                                hintTxt: "Currency Code",
                                controller: controller.currencyCode,
                                width: .24,
                                maxLen: 10,
                                focusNode: controller.currencyCodeFN,
                                isEnable: controller.isCurrencyCode.value,
                                inputformatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\d')),
                                ],
                              ),
                            ),
                            Obx(
                              () => DropDownField.formDropDown1WidthMap(
                                controller.location.value,
                                (value) {
                                  controller.selectLocation.value = value;
                                },
                                "Location",
                                .24,
                                selected: controller.selectLocation.value,
                                dialogHeight: 250,
                                inkWellFocusNode: controller.locationFN,
                              ),
                            ),
                            InputFields.formField1(
                              hintTxt: "Lower Currency Name",
                              controller: controller.lowerCurrencyName,
                              width: .24,
                              maxLen: 10,
                              focusNode: controller.lowerCurrencyCodeFN,
                            ),
                            InputFields.formField1(
                              hintTxt: "Currency",
                              controller: controller.currency,
                              width: .24,
                              maxLen: 3,
                              focusNode: controller.currencyFN,
                            ),
                            Obx(() {
                              return CheckBoxWidget1(
                                title: "Default Currency",
                                value: controller.isDefultCurrency.value,
                                onChanged: (val) {
                                  controller.isDefultCurrency.value =
                                      !(controller.isDefultCurrency.value);
                                },
                              );
                            }),
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
