import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/s_a_p_b_ill_check_report_controller.dart';

class SAPBIllCheckReportView extends GetView<SAPBIllCheckReportController> {
   SAPBIllCheckReportView({Key? key}) : super(key: key);

   SAPBIllCheckReportController controllerX =
   Get.put<SAPBIllCheckReportController>(SAPBIllCheckReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateWithThreeTextField(
                  title: "From Date",
                  mainTextController: TextEditingController(),
                  widthRation: .16,
                  // isEnable: controllerX.isEnable.value,
                ),
                SizedBox(
                  width: 7,
                ),
                DateWithThreeTextField(
                  title: "ToDate",
                  mainTextController: TextEditingController(),
                  widthRation: .16,
                  // isEnable: controllerX.isEnable.value,
                ),SizedBox(
                  width: 7,
                ),
                DropDownField.formDropDown1WidthMap(
                   [],
                      (value) {
                    // controllerX.selectedBMSVersionList = value;
                    // controllerX.getMatchDetails(programCode: value.key??"");
                  },
                  "R4",
                  .16,
                  // isEnable: controllerX.isEnable.value,
                  // selected: controllerX.selectedBMSVersionList,
                  dialogHeight: Get.height * .35,
                  autoFocus: true,
                ),
                SizedBox(
                  width: 7,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                  child: FormButtonWrapper(
                    btnText: "Generate",
                    callback: () {
                      // controllerX.showApiCall();
                    },
                    showIcon: true,
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
            )),
            SizedBox(height: 5),
            // const SizedBox(height: 8),
            Align(
              alignment: Alignment.topLeft,
              child: GetBuilder<HomeController>(
                  id: "buttons",
                  init: Get.find<HomeController>(),
                  builder: (controller) {
                    PermissionModel formPermissions =
                    Get
                        .find<MainController>()
                        .permissionList!
                        .lastWhere(
                            (element) =>
                        element.appFormName == "frmAuditStatus");
                    if (controller.buttons != null) {
                      return ButtonBar(
                        alignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        // buttonPadding: EdgeInsets.only(left: 0,right: 5,top: 4,bottom: 4),
                        children: [
                          for (var btn in controller.buttons!)
                            FormButtonWrapper(
                              btnText: btn["name"],
                              callback: Utils.btnAccessHandler2(btn['name'],
                                  controller, formPermissions) ==
                                  null
                                  ? null
                                  : () =>
                                  controllerX.formHandler(
                                    btn['name'],
                                  ),
                            )
                        ],
                      );
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
