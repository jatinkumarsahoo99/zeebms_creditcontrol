import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/secondary_asrun_modification_controller.dart';

class SecondaryAsrunModificationView extends StatelessWidget {
  SecondaryAsrunModificationView({Key? key}) : super(key: key);

  SecondaryAsrunModificationController controllerX =
  Get.put<SecondaryAsrunModificationController>(SecondaryAsrunModificationController());



  dragInfoDialog() {
    controllerX.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controllerX.dialogWidget = Material(
      color: Colors.white,
      // borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.86,
          height: Get.height * 0.65,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                // color: Colors.grey[200],
                child: Stack(
                  fit: StackFit.expand,
                  // alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controllerX.dialogWidget = null;
                          controllerX.canDialogShow.value = false;
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                height: Get.height * 0.55,
                child: GetBuilder<SecondaryAsrunModificationController>(
                    id: "diaGrid",
                    builder: (controllerX) {
                      return Container(
                        child: (controllerX.lstFinalAsRunDataList != null &&
                            (controllerX.lstFinalAsRunDataList
                                ?.length ??
                                0) >
                                0)
                            ? DataGridFromMap(
                          showSrNo: true,
                          hideCode: false,minimumWidth: 150,
                          formatDate: false,
                          columnAutoResize: false,
                          doPasccal: true,
                          colorCallback: (row) =>
                          (row.row.cells
                              .containsValue(controllerX.stateManagerDialog?.currentCell))
                              ? Colors.deepPurple.shade200
                              : Colors.white,
                          exportFileName: "Secondary Asrun Modification",
                          mode: PlutoGridMode.normal,
                          onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {
                            print(">>>>>>>>>>>onRowDoubleTapColField${event.cell.column.field ??
                                ""}");
                            print(">>>>>>>>>>>onRowDoubleTapColField${event.cell.row
                                .cells['spotStatus']?.value ?? ""}");

                            try {
                              if (controllerX.stateManagerDialog?.rows[controllerX
                                  .stateManagerDialog?.currentRowIdx ?? 0].cells['spotStatus']
                                  ?.value ==
                                  "T") {
                                LoadingDialog.showErrorDialog(
                                    "Sorry, clicked tape id is already mapped");
                              } else {
                                controllerX.dialogWidget = null;
                                controllerX.canDialogShow.value = false;
                                controllerX.tapeIdEditingController.text =
                                    event.cell.row.cells['exportTapeCode']?.value ?? "";
                                controllerX.finalProgramEditingController.text =
                                    event.cell.row.cells['programname']?.value ?? "";
                                controllerX.finalTelecastTimeEditingController.text =
                                    event.cell.row.cells['telecastTime']?.value ?? "";
                                controllerX.finalDurationEditingController.text =
                                    event.cell.row.cells['tapeDuration']?.value ?? "";

                                controllerX.finalMidPreEditingController.text =
                                (event.cell.row.cells['spotPosition']?.value == "" ||
                                    (event.cell.row.cells['spotPosition']?.value)
                                        .toString()
                                        .trim() == "null") ? "MID" : event.cell.row
                                    .cells['spotPosition']?.value;

                                dragInfoDialog2();
                              }
                            } catch (e) {
                              LoadingDialog.showErrorDialog("Something went wrong");
                            }

                            // spotStatus
                          },
                          mapData: controllerX
                              .lstFinalAsRunDataList!
                              .map((e) => e.toJson())
                              .toList(),
                          // mapData: (controllerX.dataList)!,
                          widthRatio: Get.width / 9 - 1,
                          onload: (PlutoGridOnLoadedEvent load) {
                            controllerX.stateManagerDialog = load.stateManager;
                          },
                        )
                            : Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            )),
                      );
                    }),
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormButtonWrapper(
                    btnText: "DONE",
                    showIcon: false,
                    // isEnabled: btn['isDisabled'],
                    callback: () {
                      controllerX.dialogWidget = null;
                      controllerX.canDialogShow.value = false;
                      // controller.gridStateManagerLeft?.setFilter((element) => true);
                      // controller.gridStateManagerLeft?.notifyListeners();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    controllerX.canDialogShow.value = true;
  }

  dragInfoDialog2() {
    controllerX.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controllerX.dialogWidget = Material(
      color: Colors.white,
      // borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.4,
          height: Get.height * 0.48,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                // color: Colors.grey[200],
                child: Stack(
                  fit: StackFit.expand,
                  // alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Info',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controllerX.dialogWidget = null;
                          controllerX.canDialogShow.value = false;
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              InputFields.formField1(
                hintTxt: "Tape Id",
                controller: controllerX.tapeIdEditingController,
                width: .38,
                readOnly: true,
                isEnable: false,
              ),
              InputFields.formField1(
                hintTxt: "Final Program",
                controller: controllerX.finalProgramEditingController,
                width: .38,
                readOnly: true,
                isEnable: false,
              ),
              InputFields.formField1(
                hintTxt: "Final MID/Pre",
                controller: controllerX.finalMidPreEditingController,
                width: .38,
                readOnly: true,
                isEnable: false,
              ),
              InputFields.formField1(
                hintTxt: "Final Telecast Time",
                controller: controllerX.finalTelecastTimeEditingController,
                width: .38,
                readOnly: true,
                isEnable: false,
              ),

              SizedBox(
                width: Get.width * 0.38,
                child: InputFields.numbers3(
                  hintTxt: "Final Duration",
                  controller: controllerX.finalDurationEditingController,
                  width: .38, padLeft: 0,

                  // readOnly: true,
                  // isEnable: false,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormButtonWrapper(
                    btnText: "OK",
                    showIcon: false,
                    // isEnabled: btn['isDisabled'],
                    callback: () {
                      controllerX.dialogOkClick();
                      Get.back();

                      // controller.gridStateManagerLeft?.setFilter((element) => true);
                      // controller.gridStateManagerLeft?.notifyListeners();
                    },
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  FormButtonWrapper(
                    btnText: "Cancel",
                    showIcon: false,
                    // isEnabled: btn['isDisabled'],
                    callback: () {
                      controllerX.dialogWidget = null;
                      controllerX.canDialogShow.value = false;
                      // controller.gridStateManagerLeft?.setFilter((element) => true);
                      // controller.gridStateManagerLeft?.notifyListeners();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    controllerX.canDialogShow.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
        key: controllerX.rebuildSecModKey,
        floatingActionButton: Obx(() {
          return controllerX.canDialogShow.value
              ? DraggableFab(
            initPosition: controllerX.getOffSetValue(constraints),
            child: controllerX.dialogWidget!,
            dragEndCall: () {
              controllerX.update(['diaGrid']);
            },
          )
              : const SizedBox();
        }),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value ?? [],
                            (value) {
                          controllerX.selectedLocation = value;
                          controllerX.getChannels(locationCode: value.key ?? "");
                          // controllerX.getChannel(value.key??"");
                        },
                        "Location",
                        .3,
                        selected: controllerX.selectedLocation,
                        // isEnable: controllerX.isEnable.value,
                        // selected: controllerX.selectedLocation,
                        // dialogHeight: Get.height * .15,
                        autoFocus: true,
                        isEnable: controllerX.isEnable.value
                    );
                  }),
                  SizedBox(
                    width: 5,
                  ),
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                        controllerX.channelList.value ?? [],
                            (value) {
                          controllerX.selectedChannel = value;
                          // controllerX.getChannel(value.key??"");
                        },
                        "Channel",
                        .3,
                        selected: controllerX.selectedChannel,
                        // isEnable: controllerX.isEnable.value,
                        // selected: controllerX.selectedLocation,
                        // dialogHeight: Get.height * .15,
                        autoFocus: true,
                        isEnable: controllerX.isEnable.value
                    );
                  }),
                  SizedBox(
                    width: 5,
                  ),
                  Obx(() {
                    return DateWithThreeTextField(
                      title: "Log Date",
                      mainTextController: controllerX.logDateController,
                      widthRation: .1,
                      isEnable: controllerX.isEnable.value,
                      // isEnable: controllerX.isEnable.value,
                    );
                  }),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    child: Obx(() {
                      return FormButtonWrapper(
                        btnText: "Retrieve Data",
                        callback: () {
                          // controllerX.showApiCall();
                          controllerX.getBindData();
                        },
                        showIcon: true,
                        isEnabled: controllerX.isEnable.value,

                      );
                    }),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    child: FormButtonWrapper(
                      btnText: "Clear Mismatch",
                      callback: () {
                        controllerX.btnClearMisMatch();
                      },
                      showIcon: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Expanded(
                  child: GetBuilder<SecondaryAsrunModificationController>(
                      id: "grid",
                      builder: (controllerX) {
                        return Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                          child: (controllerX.secondaryAsrunGridModel != null &&
                              controllerX.secondaryAsrunGridModel?.bindGrid != null &&
                              controllerX.secondaryAsrunGridModel?.bindGrid
                                  ?.lstAsRunBookingDetails !=
                                  null &&
                              (controllerX.secondaryAsrunGridModel?.bindGrid
                                  ?.lstAsRunBookingDetails?.length ??
                                  0) >
                                  0)
                              ? DataGridFromMap6(
                            showSrNo: true,
                            hideCode: false,
                            formatDate: false,
                            columnAutoResize: true,
                            doPasccal: false,
                            colorCallback: (row) =>
                            (row.row.cells
                                .containsValue(controllerX.stateManager?.currentCell))
                                ? Colors.deepPurple.shade200
                                : Colors.white,
                            exportFileName: "Secondary Asrun Modification",
                            mode: PlutoGridMode.normal,
                            onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {
                              // print(">>>>>>>>>>>onRowDoubleTapColField${event.cell.column.field ?? ""}");
                              // print(">>>>>>>>>>>onRowDoubleTapColField${event.cell.row.cells['spotStatus']?.value ?? ""}");
                              // spotStatus
                              if ((event.cell.column.field ?? "").toString().trim() ==
                                  "spotStatus") {
                                if ((event.cell.row.cells['spotStatus']?.value ?? "")
                                    .toString()
                                    .toLowerCase()
                                    .trim() ==
                                    "telecasted") {
                                  /*LoadingDialog.modify3(
                                            "Want to change the status to NOT TELECASTED", () {
                                          controllerX
                                              .stateManager
                                              ?.rows[controllerX.stateManager?.currentRowIdx ?? 0]
                                              .cells['spotStatus']
                                              ?.value = "NOT TELECASTED";
                                          controllerX.stateManager?.notifyListeners();
                                        }, () {}, cancelTitle: "No", confirmTitle: "Yes");*/

                                  controllerX.stateManager?.setCurrentCell(event.cell, event.rowIdx);
                                  controllerX.onDoubleClick(
                                      controllerX.stateManager?.currentRowIdx ?? -1, event);
                                } else {
                                  dragInfoDialog();
                                }
                              }
                            },
                            hideKeys: const [
                              "clearBySys",
                              "spotPositionShortName",
                              "telecastProgramcode",
                              "telprogname",
                              "telpos",
                              "bookingDetailCode1",
                              "dealno",
                              "packagecode",
                              "recordnumber",
                              "modifyStatus",
                              "locationCode",
                              "channelCode",
                              ""
                            ],
                            mapData: controllerX
                                .secondaryAsrunGridModel!.bindGrid!.lstAsRunBookingDetails!
                                .map((e) => e.toJson())
                                .toList(),
                            // mapData: (controllerX.dataList)!,
                            widthRatio: Get.width / 9 - 1,
                            onload: (PlutoGridOnLoadedEvent load) {
                              controllerX.stateManager = load.stateManager;
                            },
                          )
                              : Container(),
                        );
                      })),
              SizedBox(
                height: 4,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: GetBuilder<HomeController>(
                    id: "buttons",
                    init: Get.find<HomeController>(),
                    builder: (controller) {
                      PermissionModel formPermissions = Get
                          .find<MainController>()
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
                                callback: Utils.btnAccessHandler2(
                                    btn['name'], controller, formPermissions) ==
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
    });
  }
}
