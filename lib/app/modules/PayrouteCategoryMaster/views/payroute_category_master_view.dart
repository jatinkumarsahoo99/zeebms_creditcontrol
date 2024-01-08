import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/CheckBoxWidget.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/payroute_category_master_controller.dart';

class PayrouteCategoryMasterView
    extends GetView<PayrouteCategoryMasterController> {
  const PayrouteCategoryMasterView({Key? key}) : super(key: key);
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputFields.formFieldExpand2(
                        hintTxt: "Pay Route Category Name",
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: null,
                        // bottomPadding: false,
                      ),
                      CheckBoxWidget1(title: "Is R4 Yes/No"),
                      SizedBox(
                        height: 10,
                      ),
                      Get.find<HomeController>().getCommonButton(
                        Routes.PAYROUTE_CATEGORY_MASTER,
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
