import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/CheckBoxWidget.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/payroute_category_master_controller.dart';

class PayrouteCategoryMasterView
    extends GetView<PayrouteCategoryMasterController> {
  PayrouteCategoryMasterView({Key? key}) : super(key: key);

  final controller = Get.put<PayrouteCategoryMasterController>(
      PayrouteCategoryMasterController());

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
                  title: const Text('Pay Route Category Master'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                // const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GetBuilder(
                        init: controller,
                        builder: (builder) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: InputFields.formFieldExpand2(
                                        hintTxt: "Pay Route Category Name",
                                        controller: controller
                                            .tecPayRouteCategory.value,
                                        // titleInLeft: true,
                                        titleSizeboxWidth: null,
                                        focusNode: controller.payRouteFocus
                                        // bottomPadding: false,
                                        ),
                                  )),
                              Obx(() => CheckBoxWidget1(
                                    title: "Is R4 Yes/No",
                                    value: controller.checkBoxSelected.value,
                                    onChanged: (val) {
                                      controller.checkBoxSelected.value =
                                          val ?? false;
                                    },
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child:
                                    Get.find<HomeController>().getCommonButton(
                                  Routes.PAYROUTE_CATEGORY_MASTER,
                                  (btnName) {
                                    // UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil);
                                    controller.formHandler(btnName);
                                  },
                                ),
                              ),
                            ],
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
