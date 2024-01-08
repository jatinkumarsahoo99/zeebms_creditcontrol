import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextFieldExpanded.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../routes/app_pages.dart';
import '../controllers/clear_secondary_spots_controller.dart';

class ClearSecondarySpotsView extends GetView<ClearSecondarySpotsController> {
  const ClearSecondarySpotsView({Key? key}) : super(key: key);
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
                  title: const Text('Clear Secondary Spots'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InputFields.formFieldExpand2(
                              hintTxt: "YearMonth",
                              controller: TextEditingController(),
                              titleInLeft: true,
                              titleSizeboxWidth: 90,
                              bottomPadding: false,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: FormButton(
                              btnText: "Scroll/Aston",
                              callback: () {},
                              showIcon: false,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropDownField.formDropDown1WidthMapExpand(
                              [],
                              (value) {},
                              "Location",
                              // .23,
                              // autoFocus: true,
                              titleInLeft: true,
                              titleSizeBoxWidth: 85,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: FormButton(
                              btnText: "Astro",
                              callback: () {},
                              showIcon: false,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropDownField.formDropDown1WidthMapExpand(
                              [],
                              (value) {},
                              "Channel",
                              // .23,
                              // autoFocus: true,
                              titleInLeft: true,
                              titleSizeBoxWidth: 85,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 200,
                            // child: FormButton(
                            //   btnText: "Astro",
                            //   callback: () {},
                            //   showIcon: false,
                            // ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DateWithThreeTextFieldExpanded(
                              title: "Telecast Date",
                              mainTextController: TextEditingController(),
                              // widthRation: .135,
                              titleInLeft: true,
                              titleInSizeBox: 85,

                              // isExpanded: true,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 200,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Get.find<HomeController>().getCommonButton(
                        Routes.CLEAR_SECONDARY_SPOTS,
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
