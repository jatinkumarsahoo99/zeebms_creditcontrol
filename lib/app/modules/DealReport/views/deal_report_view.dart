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
                Obx(() {
                  return DropDownField.formDropDown1WidthMap(
                    controllerX.locationList.value ?? [],
                        (value) {
                      controllerX.selectedLocation.value = value;
                    },
                    "Location",
                    0.16,
                    selected: controllerX.selectedLocation.value,
                    // isEnable: controllerX.isEnable,
                    autoFocus: false,
                  );
                }),
                Focus(
                  focusNode: controllerX.channelFocus,
                  onFocusChange: (val) {
                    if (!val) {
                      controllerX.channelLeave();
                    }
                  },
                  child: DropDownField().formDropDownCheckBoxMap(
                    controllerX.channelsList,
                        (value) {
                      print(value);
                    },
                    "Channel",
                    0.16,
                    onChanged: (index, selectValue) {},
                  ),
                ),
                Focus(
                  focusNode: controllerX.clientFocus,
                  onFocusChange: (val) {
                    if (!val) {
                      controllerX.clientLeave();
                    }
                  },
                  child: DropDownField().formDropDownCheckBoxMap(
                    controllerX.clientList,
                        (value) {
                      print(value);
                    },
                    "Client",
                    0.16,
                    onChanged: (index, selectValue) {},
                  ),
                ),
                DropDownField().formDropDownCheckBoxMap(
                  controllerX.agencyList,
                      (value) {
                    print(value);
                  },
                  "Agency",
                  0.16,
                  onChanged: (index, selectValue) {},
                ),
                DateWithThreeTextField(
                  title: "From Date",
                  mainTextController: controllerX.formDateController,
                  widthRation: 0.1,
                  isEnable: true,
                ),
                DateWithThreeTextField(
                  title: "To Date",
                  mainTextController: controllerX.toDateController,
                  widthRation: 0.1,
                  isEnable: true,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 14.0, left: 10, right: 1),
                  child: FormButtonWrapper(
                    btnText: "Generate",
                    callback: () {
                      controllerX.generateCall();
                    },
                    showIcon: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(child: GetBuilder<DealReportController>(
              assignId: true,
              id: "grid",
              builder: (controllerX) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)),
                  child: (controllerX.dealReportModel != null &&
                      controllerX.dealReportModel?.genrate != null &&
                      (controllerX.dealReportModel?.genrate?.length ?? 0) > 0)
                      ? DataGridFromMap(
                    showSrNo: true,
                    hideCode: false,
                    formatDate: false,
                    columnAutoResize: false,
                    doPasccal: true,
                    colorCallback: (row) =>
                    (row.row.cells
                        .containsValue(
                        controller.stateManager?.currentCell))
                        ? Colors.deepPurple.shade200
                        : Colors.white,
                    widthSpecificColumn: Get.find<
                        HomeController>()
                        .getGridWidthByKey(
                        key: "tbl1",
                        userGridSettingList:
                        controller.userGridSetting1),
                    exportFileName: "Client Deals",
                    mode: PlutoGridMode.normal,
                    mapData: (controller
                        .dealReportModel!
                        .genrate!
                        .map((e) => e.toJson())
                        .toList()),
                    // mapData: (controllerX.dataList)!,
                    widthRatio: Get.width / 9 - 1,
                    onload: (PlutoGridOnLoadedEvent load) {
                      controller.stateManager =
                          load.stateManager;
                    },
                  )
                      : Container(),
                );
              },
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
