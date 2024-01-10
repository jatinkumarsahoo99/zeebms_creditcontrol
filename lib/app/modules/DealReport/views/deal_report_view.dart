import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/deal_report_controller.dart';

class DealReportView extends GetView<DealReportController> {
   DealReportView({Key? key}) : super(key: key);

   DealReportController controllerX =
  Get.put<DealReportController>(DealReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownField.formDropDown1WidthMap(
                  [],
                      (value) {
                    // controllerX.selectedCensorShipType = value;
                  },
                  "Location",
                  0.16,
                  // isEnable: controllerX.isEnable,
                  autoFocus: false,
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controllerX.channels,
                      (value) {
                    print(value);
                  },
                  "Channel",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controllerX.channels,
                      (value) {
                    print(value);
                  },
                  "Client",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controllerX.channels,
                      (value) {
                    print(value);
                  },
                  "Agency",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DateWithThreeTextField(
                  title: "From Date",
                  mainTextController:TextEditingController(),
                  widthRation: 0.1,
                  isEnable: true,
                ),
                DateWithThreeTextField(
                  title: "To Date",
                  mainTextController:TextEditingController(),
                  widthRation: 0.1,
                  isEnable: true,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 14.0, left: 10, right: 1),
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
              height: 5,
            ),
            Expanded(child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)),
              child: Container(),
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
                        element.appFormName == "frmdealreport");
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
