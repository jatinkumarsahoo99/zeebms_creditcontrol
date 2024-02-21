import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/NeumorphismButtonList.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../controllers/r_o_audit_controller.dart';

class ROAuditView extends StatelessWidget {
  ROAuditView({Key? key}) : super(key: key);

  ROAuditController controllerX =
  Get.put<ROAuditController>(ROAuditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                        () =>
                        DropDownField.formDropDown1WidthMap(
                          controllerX.locationList.value ?? [],
                              (value) {
                            controllerX.selectLocation = value;
                            controllerX.getChannel(locationCode: value.key);
                          },
                          "Location",
                          .17,
                          isEnable: controllerX.isEnable.value,
                          selected: controllerX.selectLocation,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,
                        ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Obx(
                        () =>
                        DropDownField.formDropDown1WidthMap(
                          controllerX.channelList.value ?? [],
                              (value) {
                            controllerX.selectChannel = value;
                            // controllerX.getMatchDetails(programCode: value.key??"");
                          },
                          "Channel",
                          .17,
                          isEnable: controllerX.isEnable.value,
                          selected: controllerX.selectChannel,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,
                        ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DateWithThreeTextField(
                    title: "Schedule Date",
                    mainTextController: controllerX.scheduleDateController,
                    widthRation: .1,
                    isEnable: controllerX.isEnable.value,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    child: FormButtonWrapper(
                      btnText: "Show Details",
                      callback: () {
                        controllerX.showDetails(name: controllerX.selectTab.value);
                      },
                      showIcon: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                // height: Get.height*0.13,
                  child: NeumorphismButtonList(
                    btnName: const [
                      "Additions",
                      "Cancellation",
                      "Re-Schedule",
                      "Deal Approval",
                      "Additions Pending"
                    ],
                    fun: (index, name) {
                      print(">>>>>>>>name&index" + name + index.toString());
                      controllerX.selectedInt.value = index;
                      controllerX.selectTab.value = name;
                      controllerX.selectedInt.refresh();
                      controllerX.showDetails(name: controllerX.selectTab.value);
                    },
                  )),
              SizedBox(
                height: 8,
              ),
              Obx(() {
                return getSelectedWidget(index: controllerX.selectedInt.value);
              }),
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
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    switch (index) {
      case 0:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return SizedBox(
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
                    child:(controllerX.roAuditRetrieveModel != null &&
                        controllerX.roAuditRetrieveModel?.infoBindList != null &&
                        controllerX.roAuditRetrieveModel?.infoBindList?.lstAdditions != null &&
                        (controllerX.roAuditRetrieveModel?.infoBindList?.lstAdditions?.length??0) >0
                    )? DataGridFromMap6(
                      showSrNo: true,
                      hideCode: false,
                      formatDate: false,
                      columnAutoResize: true,
                      doPasccal: true,
                      colorCallback: (row) => (row.row.cells
                          .containsValue(controllerX.stateManager?.currentCell))
                          ? Colors.deepPurple.shade200
                          : Colors.white,
                      exportFileName: "Secondary Asrun Modification",
                      mode: PlutoGridMode.normal,
                      onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {},
                      // hideKeys: const [],
                      mapData: controllerX
                          .roAuditRetrieveModel!.infoBindList!.lstAdditions!
                          .map((e) => e.toJson())
                          .toList(),
                      // mapData: (controllerX.dataList)!,
                      widthRatio: Get.width / 9 - 1,
                      onload: (PlutoGridOnLoadedEvent load) {
                        controllerX.stateManager = load.stateManager;
                      },
                    ): Center(child: Text("data not found")),
                  );
                }),
          ),
        );
        break;
      case 1:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return SizedBox(
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
                    child:(controllerX.roAuditRetrieveModel != null &&
                        controllerX.roAuditRetrieveModel?.infoBindList != null &&
                        controllerX.roAuditRetrieveModel?.infoBindList?.lstCancellation != null &&
                        (controllerX.roAuditRetrieveModel?.infoBindList?.lstCancellation?.length??0) >0
                    )? DataGridFromMap6(
                      showSrNo: true,
                      hideCode: false,
                      formatDate: false,
                      columnAutoResize: true,
                      doPasccal: true,
                      colorCallback: (row) => (row.row.cells
                          .containsValue(controllerX.stateManager?.currentCell))
                          ? Colors.deepPurple.shade200
                          : Colors.white,
                      exportFileName: "Secondary Asrun Modification",
                      mode: PlutoGridMode.normal,
                      onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {},
                      // hideKeys: const [],
                      mapData: controllerX
                          .roAuditRetrieveModel!.infoBindList!.lstCancellation!
                          .map((e) => e.toJson())
                          .toList(),
                      // mapData: (controllerX.dataList)!,
                      widthRatio: Get.width / 9 - 1,
                      onload: (PlutoGridOnLoadedEvent load) {
                        controllerX.stateManager = load.stateManager;
                      },
                    ): Center(child: Text("data not found")),
                  );
                }),
          ),
        );
        break;
      case 2:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return SizedBox(
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
                    child:(controllerX.roAuditRetrieveModel != null &&
                        controllerX.roAuditRetrieveModel?.infoBindList != null &&
                        controllerX.roAuditRetrieveModel?.infoBindList?.lstReschedule != null &&
                        (controllerX.roAuditRetrieveModel?.infoBindList?.lstReschedule?.length??0) >0
                    )? DataGridFromMap6(
                      showSrNo: true,
                      hideCode: false,
                      formatDate: false,
                      columnAutoResize: true,
                      doPasccal: true,
                      colorCallback: (row) => (row.row.cells
                          .containsValue(controllerX.stateManager?.currentCell))
                          ? Colors.deepPurple.shade200
                          : Colors.white,
                      exportFileName: "Secondary Asrun Modification",
                      mode: PlutoGridMode.normal,
                      onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {
                        Get.toNamed(Routes.AUDIT_RESCHEDULE);
                      },
                      // hideKeys: const [],
                      mapData: controllerX
                          .roAuditRetrieveModel!.infoBindList!.lstReschedule!
                          .map((e) => e.toJson())
                          .toList(),
                      // mapData: (controllerX.dataList)!,
                      widthRatio: Get.width / 9 - 1,
                      onload: (PlutoGridOnLoadedEvent load) {
                        controllerX.stateManager = load.stateManager;
                      },
                    ): Center(child: Text("data not found")),
                  );
                }),
          ),
        );
        break;
      case 3:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return SizedBox(
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
                    child: Center(child: Text("data not found3")),
                  );
                }),
          ),
        );
        break;
      case 4:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return SizedBox(
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
                    child: Center(child: Text("data not found4")),
                  );
                }),
          ),
        );
        break;
      default:
        return Expanded(
          // flex: 9,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: GetBuilder<ROAuditController>(
                id: "grid",
                builder: (controllerX) {
                  return Container();
                }),
          ),
        );
        break;
    }
  }
}
