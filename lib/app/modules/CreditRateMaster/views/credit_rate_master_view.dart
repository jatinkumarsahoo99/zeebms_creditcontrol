import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/credit_rate_master_controller.dart';

class CreditRateMasterView extends GetView<CreditRateMasterController> {
  const CreditRateMasterView({Key? key}) : super(key: key);
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
                      InputFields.formFieldExpand2(
                        hintTxt: "Description",
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: 90,
                        // bottomPadding: false,
                      ),
                      InputFields.formFieldExpand2(
                        hintTxt: "Grade In Short",
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: 90,
                        // bottomPadding: false,
                      ),
                      InputFields.formFieldExpand2(
                        hintTxt: "Lower Limit",
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: 90,
                        // bottomPadding: false,
                      ),
                      InputFields.formFieldExpand2(
                        hintTxt: "Upper Limit",
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: 90,
                        // bottomPadding: false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Get.find<HomeController>().getCommonButton(
                        Routes.CREDIT_RATE_MASTER,
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
