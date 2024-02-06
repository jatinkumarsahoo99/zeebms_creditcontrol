import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/client_embargo_controller.dart';

class ClientEmbargoView extends StatelessWidget {
  ClientEmbargoView({Key? key}) : super(key: key);

  ClientEmbargoController controllerX =
  Get.put<ClientEmbargoController>(ClientEmbargoController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * .55,
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text('Client Embargo'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropDownField.formDropDownSearchAPI2(
                            GlobalKey(), context,
                            title: "Client Name",
                            autoFocus: false,
                            // customInData: "empList",
                            url: ApiFactory.CLIENT_EMBARGO_GET_CLIENT ?? "",
                            // inkwellFocus: controllerX.employeeFocus,
                            // parseKeyForTitle: "programName",
                            parseKeyForKey: "ClientCode",
                            parseKeyForValue: "ClientName",
                            selectedValue: controllerX.selectedClient.value,
                            // selectedValue: controllerX.selectedEmployee.value,
                            onchanged: (data) {},
                            dialogHeight: 0.3,
                            width: (Get.width * controllerX.fixedWidth)),
                        SizedBox(
                          width: Get.width * controllerX.fixedWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DateWithThreeTextField(
                                title: "Date",
                                mainTextController: controllerX.dateController,
                                widthRation: 0.22,
                                isEnable: true,
                              ),
                              InputFields.formField1WidthBox(
                                  hintTxt: "Embargo No",
                                  widthRatio: 0.22,
                                  // height: 70,
                                  paddingLeft: 0,
                                  // focus: controllerX.remarkFocus,
                                  controller: controllerX.embargoNoController),
                            ],
                          ),
                        ),
                        InputFields.formField1WidthBox(
                            hintTxt: "Reason",
                            widthRatio: controllerX.fixedWidth,
                            height: Get.height * 0.1,
                            paddingLeft: 0,
                            maxLen: 5,
                            // focus: controllerX.remarkFocus,
                            controller: controllerX.reasonController
                        ),
                        Obx(() {
                          // controllerX.selectedTab.value;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 8, bottom: 8, left: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoSlidingSegmentedControl(
                                  onValueChanged: (value) {
                                    controllerX.selectedTab.value = value ?? 0;
                                    controllerX.selectedTab.refresh();
                                    print("fun jks call");
                                    // controllerX.update(['all']);
                                  },
                                  key: GlobalKey(),
                                  children: <int, Widget>{
                                    0: Text(
                                      'Employee List',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: SizeDefine.fontSizeTab,
                                      ),
                                    ),
                                    1: Text(
                                      'Client History',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: SizeDefine.fontSizeTab,
                                      ),
                                    ),
                                  },
                                  groupValue: controllerX.selectedTab.value,
                                ),
                              ],
                            ),
                          );
                        }),
                        Obx(() {
                          if (controllerX.selectedTab.value == 0) {
                            return SizedBox(
                                height: Get.height * 0.4,
                                child: GetBuilder<ClientEmbargoController>
                                  (
                                    id: "grid1",
                                    builder: (controllerX) {
                                  return Container(decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                    child: (controllerX
                                        .clientEmbargoModel != null && controllerX
                                        .clientEmbargoModel?.ceLoad != null && controllerX
                                        .clientEmbargoModel?.ceLoad?.result != null &&
                                        controllerX
                                            .clientEmbargoModel?.ceLoad?.result?.lstclientEmbs !=
                                            null &&
                                        (controllerX
                                            .clientEmbargoModel?.ceLoad?.result?.lstclientEmbs
                                            ?.length ?? 0) > 0
                                    ) ? DataGridFromMap(
                                      showSrNo: true,
                                      hideCode: false,
                                      formatDate: false,
                                      columnAutoResize: false,
                                      doPasccal: true,
                                      colorCallback: (row) =>
                                      (row.row.cells
                                          .containsValue(
                                          controllerX.stateManager?.currentCell))
                                          ? Colors.deepPurple.shade200
                                          : Colors.white,
                                      exportFileName: "Client Embargo",
                                      mode: PlutoGridMode.normal,

                                      mapData: (controllerX
                                          .clientEmbargoModel!.ceLoad!.result!.lstclientEmbs!
                                          .map((e) => e.toJson())
                                          .toList()),
                                      // mapData: (controllerX.dataList)!,
                                      widthRatio: Get.width / 9 - 1,
                                      onload: (PlutoGridOnLoadedEvent? load) {
                                        controllerX.stateManager =
                                            load?.stateManager;
                                      },
                                    ) : const Center(child: Text("Data not found"),),
                                  );
                                }));
                          }
                          else {
                            return Container(
                              height: Get.height * 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: const Center(child: Text("Data not found2"),),
                            );
                          }
                        }),
                      ]
                  ),
                ),
                SizedBox(height: 6),

                /// bottom common buttons
                Align(
                  alignment: Alignment.topCenter,
                  child: GetBuilder<HomeController>(
                      id: "buttons",
                      init: Get.find<HomeController>(),
                      builder: (controller) {
                        try {
                          PermissionModel formPermissions =
                          Get
                              .find<MainController>()
                              .permissionList!
                              .lastWhere((element) =>
                          element.appFormName ==
                              "frmClientEmbargo");
                          if (controller.buttons != null) {
                            return Wrap(
                              spacing: 5,
                              runSpacing: 15,
                              alignment: WrapAlignment.center,
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
                          } else {
                            return Container();
                          }
                        } catch (e) {
                          return const Text("No Access");
                        }
                      }),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      key: GlobalKey(),
    );
  }
}
