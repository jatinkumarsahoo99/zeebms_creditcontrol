import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/pluto_grid.dart';
import 'package:bms_creditcontrol/widgets/radio_row.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../../widgets/radio_row1.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/undo_cancelation_controller.dart';

class UndoCancelationView extends GetView<UndoCancelationController> {
  UndoCancelationView({Key? key}) : super(key: key);

  final controller =
      Get.put<UndoCancelationController>(UndoCancelationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  GetBuilder<UndoCancelationController>(
                    init: controller,
                    id: "updateView",
                    builder: (control) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 6,
                            spacing: 6,
                            children: [
                              Obx(
                                () => DropDownField.formDropDown1WidthMap(
                                  controller.locations.value,
                                  (value) {
                                    controller.selectLocation = value;
                                    controller.getChannelList(
                                        controller.selectLocation?.key ?? "");
                                  },
                                  "Location",
                                  0.15,
                                  isEnable: controller.isEnable.value,
                                  selected: controller.selectLocation,
                                  autoFocus: true,
                                  // dialogWidth: 330,
                                  dialogHeight: Get.height * .7,
                                ),
                              ),

                              /// channel
                              Obx(
                                () => DropDownField.formDropDown1WidthMap(
                                  controller.channels.value,
                                  (value) {
                                    controller.selectChannel = value;
                                    // controller.getChannelFocusOut();
                                  },
                                  "Channel",
                                  0.15,
                                  isEnable: controller.isEnable.value,
                                  selected: controller.selectChannel,
                                  autoFocus: true,
                                  // dialogWidth: 330,
                                  dialogHeight: Get.height * .7,
                                ),
                              ),

                              Obx(
                                () => DateWithThreeTextField(
                                  title: "Tele Date",
                                  splitType: "-",
                                  widthRation: 0.15,
                                  isEnable: controller.isEnable.value,
                                  onFocusChange: (data) {},
                                  mainTextController: controller.scheduleDate,
                                ),
                              ),

                              InputFields.formField1(
                                hintTxt: "BookingNumber",
                                controller: controller.bookingNumber,
                                width: 0.15,
                                capital: true,
                                // focusNode: controllerX.level1Node,

                                // autoFocus: true,
                                // focusNode: controllerX.brandName,
                                // isEnable: controllerX.isEnable,
                                onchanged: (value) {},
                                // autoFocus: true,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: Obx(
                                  () => RadioRow1(
                                    items: [
                                      "Booked",
                                      "On Hold",
                                      "Expsoure Spots"
                                    ],
                                    groupValue:
                                        controller.selectValue.value ?? "",
                                    onchange: (String v) {
                                      controller.selectValue.value = v;
                                      controller.selectValue.refresh();
                                      controller.getStatus();
                                    },
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 14.0, left: 10, right: 10),
                                child: FormButtonWrapper(
                                  btnText: "Show",
                                  callback: () {
                                    controller.getShow();
                                    // controller.getColorList();
                                  },
                                  showIcon: true,
                                ),
                              ),

                              Row(
                                children: [
                                  Checkbox(value: false, onChanged: (val) {}),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Select All")
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    // flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: GetBuilder<UndoCancelationController>(
                            id: "grid",
                            builder: (controller) {
                              return (controller.responseData != null)
                                  ? Container(
                                      child: DataGridFromMap(
                                        showSrNo: true,
                                        hideCode: false,
                                        formatDate: false,
                                        columnAutoResize: true,
                                        doPasccal: true,
                                        colorCallback: (row) => (row.row.cells
                                                .containsValue(controller
                                                    .stateManager?.currentCell))
                                            ? Colors.deepPurple.shade200
                                            : Colors.white,
                                        // widthSpecificColumn:  Get.find<HomeController>().getGridWidthByKey(key: controllerX.getTableNo(controllerX.selectValue.value)?? "tbl1",userGridSettingList: controllerX.userGridSetting1),
                                        exportFileName: "Amagi Spot Planning",
                                        mode: PlutoGridMode.normal,
                                        mapData: controller.responseData!,
                                        // mapData: (controllerX.dataList)!,
                                        widthRatio: Get.width / 9 - 1,
                                        onload: (PlutoGridOnLoadedEvent load) {
                                          controller.stateManager =
                                              load.stateManager;
                                        },
                                      ),
                                    )
                                  : Container();
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: FormButtonWrapper(
                    btnText: "Undo Spot",
                    callback: () {
                      // controller.callRetrieve();
                      // controller.getColorList();
                    },
                    showIcon: true,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Get.find<HomeController>().getCommonButton(
                Routes.UNDO_CANCELATION,
                (btnName) {},
              ),
            ),

            /// bottom common buttons
            /*  Align(
              alignment: Alignment.topLeft,
              child: GetBuilder<HomeController>(
                  id: "buttons",
                  init: Get.find<HomeController>(),
                  builder: (control) {
                    PermissionModel formPermissions = Get.find<MainController>()
                        .permissionList!
                        .lastWhere((element) =>
                            element.appFormName == "frmmovieupdate");
                    if (control.buttons != null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 15,
                          alignment: WrapAlignment.center,
                          children: [
                            for (var btn in control.buttons!)
                              FormButtonWrapper(
                                btnText: btn["name"],
                                callback: Utils.btnAccessHandler2(btn['name'],
                                    control, formPermissions) ==
                                        null
                                    ? null
                                    : () => controller.formHandler(
                                          btn['name'],
                                        ),
                              )
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),
            ),*/
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
