import 'package:bms_creditcontrol/widgets/dropdown.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../../../../widgets/CheckBoxWidget.dart';
import '../../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../../widgets/FormButton.dart';
import '../../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../../widgets/gridFromMap.dart';
import '../../../../../widgets/input_fields.dart';
import '../../../../controller/HomeController.dart';
import '../../../../controller/MainController.dart';
import '../../../../data/PermissionModel.dart';
import '../../../../providers/ApiFactory.dart';
import '../../../../providers/Utils.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/audit_reschedule_controller.dart';

class AuditRescheduleView extends StatelessWidget {
  AuditRescheduleView({Key? key}) : super(key: key);

  AuditRescheduleController controllerX =
  Get.put<AuditRescheduleController>(AuditRescheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, child) {
            return Padding(
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
                            controllerX.selectedLocation?.value = value;
                            // controllerX.getChannels(locationCode: value.key ?? "");
                            // controllerX.getChannel(value.key??"");
                          },
                          "Location",
                          .2,
                          selected: controllerX.selectedLocation?.value,
                          // isEnable: controllerX.isEnable.value,
                          // selected: controllerX.selectedLocation,
                          // dialogHeight: Get.height * .15,
                          autoFocus: true,
                        );
                      }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controllerX.channelList.value ?? [],
                              (value) {
                            controllerX.selectedChannel?.value = value;
                            // controllerX.getChannel(value.key??"");
                          },
                          "Channel",
                          .2,
                          selected: controllerX.selectedChannel?.value,
                          // isEnable: controllerX.isEnable.value,
                          // selected: controllerX.selectedLocation,
                          // dialogHeight: Get.height * .15,
                          autoFocus: true,
                        );
                      }),
                      DateWithThreeTextField(
                        title: "FPC Eff. Dt.",
                        mainTextController: controllerX.fpcEffectiveDateController,
                        widthRation: .1,
                        // isEnable: controllerX.isEnable.value,
                      ),
                      DateWithThreeTextField(
                        title: "Resch Dt.",
                        mainTextController: controllerX.reschDateController,
                        widthRation: .1,
                        // isEnable: controllerX.isEnable.value,
                      ),
                      InputFields.formField1WidthBox(
                        hintTxt: "Ref No",
                        widthRatio: 0.1,
                        // height: 70,
                        paddingLeft: 0,
                        // focus: controllerX.remarkFocus,
                        controller: controllerX.refNoController,
                      ),
                      DateWithThreeTextField(
                        title: "Ref. Date",
                        mainTextController: controllerX.refDateController,
                        widthRation: .1,
                        // isEnable: controllerX.isEnable.value,
                      ),
                      InputFields.formField1WidthBox(
                        hintTxt: "Booking No",
                        widthRatio: 0.1,
                        // height: 70,
                        paddingLeft: 0,
                        isEnable: false,
                        // focus: controllerX.remarkFocus,
                        controller: controllerX.bookingNoController,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InputFields.formField1WidthBox(
                        hintTxt: "Deal No",
                        widthRatio: 0.1,
                        isEnable: false,
                        // height: 70,
                        paddingLeft: 0,
                        // focus: controllerX.remarkFocus,
                        controller: controllerX.dealNoController,
                      ),
                      InputFields.formField1WidthBox(
                        hintTxt: "Resch. No",
                        widthRatio: 0.1,
                        // height: 70,
                        paddingLeft: 0,
                        // focus: controllerX.remarkFocus,
                        controller: controllerX.reschNoController,
                      ),
                      InputFields.formField1WidthBox(
                        hintTxt: "",
                        widthRatio: 0.1,
                        // height: 70,
                        paddingLeft: 0,
                        // focus: controllerX.remarkFocus,
                        controller: controllerX.reschNo_Controller,
                      ),
                      Obx(() {
                        return DropDownField.formDropDownSearchAPI2(
                            GlobalKey(), context,
                            title: "Client",
                            autoFocus: false,
                            // customInData: "empList",
                            url: ApiFactory.RO_AUDIT_AUDIT_RESCHEDULE_GET_CLIENT,
                            // inkwellFocus: controllerX.employeeFocus,
                            // parseKeyForTitle: "programName",
                            parseKeyForKey: "clientcode",
                            parseKeyForValue: "clientname",
                            selectedValue: controllerX.selectedClient?.value,
                            // selectedValue: controllerX.selectedClient.value,
                            // selectedValue: controllerX.selectedEmployee.value,
                            onchanged: (data) {
                              // controllerX.selectedClient.value = data;
                              // controllerX.getClientNameClick(clientCode: data.key ?? "");
                            },
                            dialogHeight: 200,
                            width: (Get.width * 0.2));
                      }),
                      Obx(() {
                        return DropDownField.formDropDownSearchAPI2(
                            GlobalKey(), context,
                            title: "Agency",
                            autoFocus: false,
                            // customInData: "empList",
                            url: ApiFactory.RO_AUDIT_AUDIT_RESCHEDULE_GET_AGENCY,
                            // inkwellFocus: controllerX.employeeFocus,
                            // parseKeyForTitle: "programName",
                            parseKeyForKey: "agencycode",
                            parseKeyForValue: "agencyname",
                            selectedValue: controllerX.selectedAgency?.value,
                            // selectedValue: controllerX.selectedClient.value,
                            // selectedValue: controllerX.selectedEmployee.value,
                            onchanged: (data) {
                              // controllerX.selectedClient.value = data;
                              // controllerX.getClientNameClick(clientCode: data.key ?? "");
                            },
                            dialogHeight: 200,
                            width: (Get.width * 0.2));
                      }),
                      Obx(() {
                        return DropDownField.formDropDownSearchAPI2(
                            GlobalKey(), context,
                            title: "Brand",
                            autoFocus: false,
                            // customInData: "empList",
                            url: ApiFactory.RO_AUDIT_AUDIT_RESCHEDULE_GET_BRAND,
                            // inkwellFocus: controllerX.employeeFocus,
                            // parseKeyForTitle: "programName",
                            parseKeyForKey: "brandcode",
                            parseKeyForValue: "brandname",
                            selectedValue: controllerX.selectedBrand?.value,
                            // selectedValue: controllerX.selectedClient.value,
                            // selectedValue: controllerX.selectedEmployee.value,
                            onchanged: (data) {
                              // controllerX.selectedClient.value = data;
                              // controllerX.getClientNameClick(clientCode: data.key ?? "");
                            },
                            dialogHeight: 200,
                            width: (Get.width * 0.2));
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CheckBoxOnRight(
                                title: "Select All",
                                value: false,
                                top: 3,
                                left: 3,
                                isEnable: false,
                                onChanged: (val) {
                                  // controller.wed.value = val!;
                                },
                                // fn: controller.wedDayFocus
                              ),
                            ],
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 3.0, right: 3, bottom: 3, top: 0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GetBuilder<AuditRescheduleController>(
                                        id: "leftGrid",
                                        builder: (controllerX) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey)),
                                            child: (controllerX
                                                .reScheduleRetriveDataModel != null && controllerX
                                                .reScheduleRetriveDataModel
                                                ?.infoReschduleBookingList !=
                                                null &&
                                                controllerX
                                                    .reScheduleRetriveDataModel
                                                    ?.infoReschduleBookingList?.reschduleDisplay !=
                                                    null &&
                                                controllerX
                                                    .reScheduleRetriveDataModel
                                                    ?.infoReschduleBookingList?.reschduleDisplay
                                                    ?.reschdule != null &&
                                                (controllerX
                                                    .reScheduleRetriveDataModel
                                                    ?.infoReschduleBookingList?.reschduleDisplay
                                                    ?.reschdule?.length ?? 0) > 0) ?
                                            DataGridFromMap3(
                                              showSrNo: true,
                                              hideCode: false,
                                              formatDate: false,
                                              columnAutoResize: false,
                                              doPasccal: true,
                                                minimumWidth:130,
                                              colorCallback: (row) =>
                                              (row.row.cells
                                                  .containsValue(
                                                  controllerX.stateManagerLeft?.currentCell))
                                                  ? Colors.deepPurple.shade200
                                                  : Colors.white,
                                              exportFileName: "Secondary Asrun Modification",
                                              mode: PlutoGridMode.normal,
                                              checkBoxColumnKey: ["auditStatus"],
                                              checkBoxStrComparison: true,
                                              hideKeys: const ['dealRowNumber'],
                                              onRowDoubleTap: (
                                                  PlutoGridOnRowDoubleTapEvent event) {},
                                              // hideKeys: const [],
                                              mapData: controllerX
                                                  .reScheduleRetriveDataModel!
                                                  .infoReschduleBookingList!
                                                  .reschduleDisplay!.reschdule!
                                                  .map((e) => e.toJson())
                                                  .toList(),
                                              // mapData: (controllerX.dataList)!,
                                              widthRatio: Get.width / 9 - 1,
                                              onload: (PlutoGridOnLoadedEvent load) {
                                                controllerX.stateManagerLeft = load.stateManager;
                                              },
                                            ) : Container(),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                    child: GetBuilder<AuditRescheduleController>(
                                        id: "wrightGrid",
                                        builder: (controllerX) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey)),
                                            child: (controllerX
                                                .reScheduleRetriveDataModel != null && controllerX
                                                .reScheduleRetriveDataModel
                                                ?.infoReschduleBookingList !=
                                                null &&
                                                controllerX
                                                    .reScheduleRetriveDataModel
                                                    ?.infoReschduleBookingList?.reschduleDisplay !=
                                                    null &&
                                                controllerX
                                                    .reScheduleRetriveDataModel
                                                    ?.infoReschduleBookingList?.reschduleDisplay
                                                    ?.originalBookings != null &&
                                                (controllerX
                                                    .reScheduleRetriveDataModel
                                                    ?.infoReschduleBookingList?.reschduleDisplay
                                                    ?.originalBookings?.length ?? 0) > 0) ?
                                            DataGridFromMap(
                                              showSrNo: true,
                                              hideCode: false,
                                              formatDate: false,
                                              columnAutoResize: true,
                                              doPasccal: true,
                                              colorCallback: (row) =>
                                              (row.row.cells
                                                  .containsValue(
                                                  controllerX.stateManagerRight?.currentCell))
                                                  ? Colors.deepPurple.shade200
                                                  : Colors.white,
                                              exportFileName: "Secondary Asrun Modification",
                                              mode: PlutoGridMode.normal,

                                              onRowDoubleTap: (
                                                  PlutoGridOnRowDoubleTapEvent event) {},
                                              // hideKeys: const [],
                                              mapData: controllerX
                                                  .reScheduleRetriveDataModel!
                                                  .infoReschduleBookingList!
                                                  .reschduleDisplay!.originalBookings!
                                                  .map((e) => e.toJson())
                                                  .toList(),
                                              // mapData: (controllerX.dataList)!,
                                              widthRatio: Get.width / 9 - 1,
                                              onload: (PlutoGridOnLoadedEvent load) {
                                                controllerX.stateManagerRight = load.stateManager;
                                              },
                                            ) : Container(),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),

                  Get.find<HomeController>().getCommonButton(
                    Routes.R_O_AUDIT,
                        (btnName) {
                          if (btnName == "Save") {
                            controllerX.saveFunCall();
                          } else if (btnName == "Clear") {
                            controllerX.clearAll();
                          } else if (btnName == "Docs") {
                            controllerX.docs();
                          }
                        },
                  ),
                  /*  Align(
                  alignment: Alignment.topLeft,
                  child: GetBuilder<HomeController>(
                      id: "buttons",
                      init: Get.find<HomeController>(),
                      builder: (controller) {
                        PermissionModel formPermissions = Get.find<MainController>()
                            .permissionList!
                            .lastWhere(
                                (element) => element.appFormName == "frmSecondaryAsRunModification");
                        if (controller.buttons != null) {
                          return ButtonBar(
                            alignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            // buttonPadding: EdgeInsets.only(left: 0,right: 5,top: 4,bottom: 4),
                            children: [
                              for (var btn in controller.buttons!)
                                FormButtonWrapper(
                                  btnText: btn["name"],
                                  callback:
                                      Utils.btnAccessHandler2(btn['name'], controller, formPermissions) ==
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
                )*/
                ],
              ),
            );
          }
      ),
    );
  }
}
