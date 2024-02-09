import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/agency_group_master_controller.dart';

class AgencyGroupMasterView extends GetView<AgencyGroupMasterController> {
  AgencyGroupMasterView({Key? key}) : super(key: key);

  AgencyGroupMasterController controllerX =
  Get.put<AgencyGroupMasterController>(AgencyGroupMasterController());

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('Agency Group Master'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  FocusTraversalGroup(
                    policy: OrderedTraversalPolicy(),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(0),
                            child: InputFields.formField1WidthBox(
                                hintTxt: "Group Name",
                                widthRatio: controllerX.fixedWidth,
                                // height: Get.height*0.1,
                                paddingLeft: 0,
                                focus: controllerX.groupNameFocus,
                                // maxLen: 5,
                                // focus: controllerX.remarkFocus,
                                controller: controllerX.groupNameController),
                          ),
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(1),
                            child: InputFields.formField1WidthBox(
                                hintTxt: "Short Name",
                                widthRatio: controllerX.fixedWidth,
                                // height: Get.height*0.1,
                                paddingLeft: 0,
                                focus: controllerX.shortNameFocus,
                                // maxLen: 5,
                                // focus: controllerX.remarkFocus,
                                controller: controllerX.shortNameController),
                          ),
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(2),
                            child: DropDownField.formDropDownSearchAPI2(
                                GlobalKey(), context,
                                title: "Agency Name",
                                autoFocus: false,
                                // customInData: "empList",
                                url:ApiFactory.AGENCY_GROUP_MASTER_GET_AGENCY,
                                // inkwellFocus: controllerX.employeeFocus,
                                // parseKeyForTitle: "programName",
                                parseKeyForKey: "AgencyCode",
                                parseKeyForValue: "AgencyName",
                                selectedValue: controllerX.selectedAgencyName.value,
                                // selectedValue: controllerX.selectedEmployee.value,
                                onchanged: (data) {
                                  controllerX.selectedAgencyName.value = data;
                                },
                                dialogHeight: 200,
                                inkwellFocus: controllerX.agencyNameFocus,
                                width: (Get.width * controllerX.fixedWidth)),
                          ),
                          SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: FocusTraversalOrder(
                                  order: const NumericFocusOrder(5),
                                  child: SizedBox(
                                      height: Get.height * 0.4,
                                      child: GetBuilder<AgencyGroupMasterController>
                                        (id: "grid",
                                          builder: (controllerX) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey)),
                                          child: (controllerX.agencyGroupMasterModel != null &&
                                              controllerX.agencyGroupMasterModel?.retrieveRecord !=
                                                  null &&
                                              controllerX.agencyGroupMasterModel?.retrieveRecord
                                                  ?.lstagencymaster != null &&
                                              (controllerX.agencyGroupMasterModel?.retrieveRecord
                                                  ?.lstagencymaster?.length ?? 0) > 0
                                          ) ? DataGridFromMap(
                                            showSrNo: true,
                                            hideCode: false,
                                            formatDate: false,
                                            columnAutoResize: true,
                                            doPasccal: true,
                                            colorCallback: (row) =>
                                            (row.row.cells
                                                .containsValue(
                                                controllerX.stateManager?.currentCell))
                                                ? Colors.deepPurple.shade200
                                                : Colors.white,
                                            exportFileName: "Agency Group Master",
                                            hideKeys: const ["agencyCode"],
                                            mode: PlutoGridMode.normal,
                                            mapData: (controllerX
                                                .agencyGroupMasterModel!.retrieveRecord!
                                                .lstagencymaster!
                                                .map((e) => e.toJson())
                                                .toList()),
                                            // mapData: (controllerX.dataList)!,
                                            widthRatio: Get.width / 9 - 1,
                                            onload: (PlutoGridOnLoadedEvent? load) {
                                              controllerX.stateManager =
                                                  load?.stateManager;
                                            },
                                          ) : Container(),
                                        );
                                      })),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FocusTraversalOrder(
                                    order: const NumericFocusOrder(3),
                                    child: SizedBox(
                                      width: Get.width*0.1,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(top: 14.0, left: 10, right: 0),
                                        child: FormButtonWrapper(
                                          btnText: "Add",
                                          callback: () {
                                            controllerX.addBtnCall();
                                          },
                                          showIcon: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  FocusTraversalOrder(
                                    order: const NumericFocusOrder(4),
                                    child: SizedBox(
                                      width: Get.width*0.1,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(top: 14.0, left: 10, right: 0),
                                        child: FormButtonWrapper(
                                          btnText: "Remove",
                                          callback: () {
                                            controllerX.removeCall();
                                          },
                                          showIcon: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ]
                    ),
                  ),

                  SizedBox(height: 5),

                  /// bottom common buttons
                  Align(
                    alignment: Alignment.topLeft,
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
                                "frmAgencyGroupMaster");
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
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
      key: GlobalKey(),
    );
  }
}
