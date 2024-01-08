import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/secondary_asrun_modification_controller.dart';

class SecondaryAsrunModificationView
    extends GetView<SecondaryAsrunModificationController> {
   SecondaryAsrunModificationView({Key? key}) : super(key: key);

   SecondaryAsrunModificationController controllerX =
   Get.put<SecondaryAsrunModificationController>(SecondaryAsrunModificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownField.formDropDown1WidthMap(
                  [],
                      (value) {
                    // controllerX.selectedLocation = value;
                    // controllerX.getChannel(value.key??"");
                  }, "Location", .3,
                  // isEnable: controllerX.isEnable.value,
                  // selected: controllerX.selectedLocation,
                  dialogHeight: Get.height * .15,
                  autoFocus: true,),
                SizedBox(
                  width: 5,
                ),
                DropDownField.formDropDown1WidthMap(
                  [],
                      (value) {
                    // controllerX.selectedLocation = value;
                    // controllerX.getChannel(value.key??"");
                  }, "Channel", .3,
                  // isEnable: controllerX.isEnable.value,
                  // selected: controllerX.selectedLocation,
                  dialogHeight: Get.height * .15,
                  autoFocus: true,),
                SizedBox(
                  width: 5,
                ),
                DateWithThreeTextField(
                  title: "Log Date",
                  mainTextController: TextEditingController(),
                  widthRation: .1,
                  // isEnable: controllerX.isEnable.value,
                ),
                SizedBox(
                  width: 5,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                  child: FormButtonWrapper(
                    btnText: "Retrieve Data",
                    callback: () {
                      // controllerX.showApiCall();
                    },
                    showIcon: true,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                  child: FormButtonWrapper(
                    btnText: "Clear Mismatch",
                    callback: () {
                      // controllerX.showApiCall();
                    },
                    showIcon: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Expanded(child: Container(
              decoration:
              BoxDecoration(border: Border.all(color: Colors.grey)),
            )),
            SizedBox(
              height: 4,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GetBuilder<HomeController>(
                  id: "buttons",
                  init: Get.find<HomeController>(),
                  builder: (controller) {
                    PermissionModel formPermissions = Get.find<MainController>()
                        .permissionList!
                        .lastWhere((element) =>
                    element.appFormName == "frmSecondaryAsRunModification");
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
                                  : () => controllerX.formHandler(
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
