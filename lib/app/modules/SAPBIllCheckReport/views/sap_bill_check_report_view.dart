import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/pluto_grid.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../data/user_data_settings_model.dart';
import '../../../providers/Utils.dart';
import '../controllers/sap_bill_check_report_controller.dart';

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
                  mainTextController: controllerX.fromDt,
                  widthRation: .16,
                  // isEnable: controllerX.isEnable.value,
                ),
                SizedBox(
                  width: 7,
                ),
                DateWithThreeTextField(
                  title: "ToDate",
                  mainTextController: controllerX.toDt,
                  widthRation: .16,
                  // isEnable: controllerX.isEnable.value,
                ),
                SizedBox(
                  width: 7,
                ),
                DropDownField.formDropDown1WidthMap(
                  [
                    DropDownValue(key: "Yes", value: "Yes"),
                    DropDownValue(key: "No", value: "No")
                  ],
                  (value) {
                    controllerX.selectedR4 = value;
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
                      controllerX.showApiCall();
                    },
                    showIcon: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            GetBuilder<SAPBIllCheckReportController>(
                id: "grid",
                init: controllerX,
                builder: (logic) {
                  return Expanded(
                      child: (controllerX.dataList != null &&
                              (controllerX.dataList?.isNotEmpty ?? false))
                          ? DataGridFromMap(
                              showSrNo: true,
                              exportFileName: "Sap Bill Check Report",
                              mode: PlutoGridMode.normal,
                              mapData: controller.dataList!,
                              colorCallback: (row) => (row.rowIdx ==
                                      controller.gridManager?.currentRowIdx)
                                  ? Colors.deepPurple.shade200
                                  : Colors.white,
                              // mapData: (controllerX.dataList)!,
                              widthRatio: Get.width / 9 - 1,
                              onload: (PlutoGridOnLoadedEvent load) {
                                controller.gridManager = load.stateManager;
                                load.stateManager.setSelectingMode(
                                    PlutoGridSelectingMode.row);
                              },
                              widthSpecificColumn: (controller
                                  .userDataSettings?.userSetting
                                  ?.firstWhere(
                                      (element) =>
                                          element.controlName == "gridManager",
                                      orElse: () => UserSetting())
                                  .userSettings),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                            ));
                }),
            SizedBox(height: 5),
            // const SizedBox(height: 8),
            Align(
              alignment: Alignment.topLeft,
              child: GetBuilder<HomeController>(
                  id: "buttons",
                  init: Get.find<HomeController>(),
                  builder: (controller) {
                    PermissionModel formPermissions = Get.find<MainController>()
                        .permissionList!
                        .lastWhere((element) =>
                            element.appFormName == "frmSapBillcheckreport");
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
