import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/sized_box_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../../widgets/dropdown.dart';
import '../../../../../widgets/floating_dialog.dart';
import '../../../../../widgets/gridFromMap.dart';
import '../../../../../widgets/input_fields.dart';
import '../../../../controller/HomeController.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/audit_bookings_controller.dart';

class AuditBookingsView extends GetView<AuditBookingsController> {
  AuditBookingsView({Key? key}) : super(key: key);

  @override
  var controller = Get.put<AuditBookingsController>(AuditBookingsController());
  var rebuildKey = GlobalKey<ScaffoldState>();

  dragSpotsDialog() {
    controller.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.55,
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
                          controller.dialogWidget = null;
                          controller.canDialogShow.value = false;
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
              Expanded(child:
              GetBuilder<AuditBookingsController>(
                  id: "all",
                  builder: (controller) {
                return Container(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: (controller.auditBookingModel != null &&
                        controller.auditBookingModel?.infoShowBookingList !=
                            null &&
                        controller.auditBookingModel?.infoShowBookingList?.displayBookingStatus !=
                            null &&

                        controller.auditBookingModel?.infoShowBookingList?.displayBookingStatus
                            ?.lstBookingDetails != null &&
                        (controller.auditBookingModel?.infoShowBookingList?.displayBookingStatus
                            ?.lstBookingDetails?.length ?? 0) > 0
                    ) ? DataGridFromMap3(
                      showSrNo: true,
                      hideCode: false,
                      formatDate: false,
                      columnAutoResize: true,
                      doPasccal: true,
                      minimumWidth: 180,
                      colorCallback: (row) =>
                      (row.row.cells
                          .containsValue(
                          controller.spotGridManager?.currentCell))
                          ? Colors.deepPurple.shade200
                          : Colors.white,
                      exportFileName: "Client Deals",
                      mode: PlutoGridMode.normal,
                      // hideKeys: ["isrequired", "allowedvalues"],
                      mapData: controller.auditBookingModel!.infoShowBookingList!
                          .displayBookingStatus!.lstBookingDetails!.
                      map((e) => e.toJson()).toList(),
                      // mapData: (controllerX.dataList)!,
                      widthRatio: Get.width / 9 - 1,
                      onload: (PlutoGridOnLoadedEvent load) {
                        controller.spotGridManager =
                            load.stateManager;
                      },
                    ) : Container(),
                  ),
                );
              })),
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
                      controller.dialogWidget = null;
                      controller.canDialogShow.value = false;
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
    controller.canDialogShow.value = true;
  }

  dragValidation(){
    controller.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.35,
          height: Get.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Validation',
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
                          controller.dialogWidget = null;
                          controller.canDialogShow.value = false;
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
              CheckBoxWidget1(title: "Deal Rows With Negative Balances", isEnable: false),
              CheckBoxWidget1(title: "Build Value is Less than Booked Value", isEnable: false),
              CheckBoxWidget1(title: "Booking Exceeds Max Spend in Deal", isEnable: false),
              CheckBoxWidget1(title: "Client Under embargo", isEnable: false),
              CheckBoxWidget1(title: "Agency Under Embargo", isEnable: false),
              CheckBoxWidget1(title: "Commercial Duration Mismatch", isEnable: false),


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
    controller.canDialogShow.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Scaffold(
            key: rebuildKey,
            floatingActionButton: Obx(() {
              return controller.canDialogShow.value
                  ? DraggableFab(
                initPosition: controller.getOffSetValue(constraints),
                child: controller.dialogWidget!,
                dragEndCall: () {
                  controller.update(['all']);
                },
              )
                  : const SizedBox();
            }),
            body: SizedBox(
              width: context.width,
              height: context.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(() {
                                      return DropDownField
                                          .formDropDown1WidthMapExpand(
                                          controller.locationList.value,
                                              (value) {
                                            controller.selectedLocation.value = value;
                                          },
                                          "Location",
                                          // titleInLeft: true,
                                          selected: controller.selectedLocation.value,
                                          titleSizeBoxWidth: 75,
                                          isEnable: controller.isEnable.value
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Obx(() {
                                      return DropDownField
                                          .formDropDown1WidthMapExpand(
                                          controller.channelList.value,
                                              (value) {
                                            controller.selectedChannel.value = value;
                                          },
                                          "Channel",
                                          // titleInLeft: true,
                                          selected: controller.selectedChannel.value,
                                          titleSizeBoxWidth: 75,
                                          isEnable: controller.isEnable.value
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(5),
                              Row(
                                children: [
                                  Expanded(
                                    child: InputFields.formFieldExpand2(
                                        hintTxt: "Ref No",
                                        controller: controller.refNoController,
                                        autoFocus: true,
                                        titleSizeboxWidth: 80,
                                        isEnable: controller.isEnable.value,
                                        bottomPadding: false),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DateWithThreeTextField(
                                      title: "",
                                      mainTextController: controller.refDateController,
                                      isEnable: controller.isEnable.value,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(5),
                              Obx(() {
                                return DropDownField.formDropDownSearchAPI2Expand(
                                  GlobalKey(),
                                  context,
                                  title: "Client",
                                  url: "",
                                  onchanged: (value) {
                                    controller.selectedClient.value = value;
                                  },
                                  selectedValue: controller.selectedClient.value,
                                  parseKeyForKey: "",
                                  parseKeyForValue: "",
                                  textSizeboxWidth: 85,
                                  isEnable: controller.isEnable.value,
                                );
                              }),
                              sizedBoxHeight(5),
                              Obx(() {
                                return DropDownField.formDropDownSearchAPI2Expand(
                                  GlobalKey(),
                                  context,
                                  title: "Agency",
                                  url: "",
                                  onchanged: (value) {
                                    controller.selectedAgency.value = value;
                                  },
                                  selectedValue: controller.selectedAgency.value,
                                  parseKeyForKey: "",
                                  parseKeyForValue: "",
                                  textSizeboxWidth: 85,
                                  isEnable: controller.isEnable.value,
                                );
                              }),
                              sizedBoxHeight(5),
                              Obx(() {
                                return DropDownField.formDropDownSearchAPI2Expand(
                                  GlobalKey(),
                                  context,
                                  title: "Brand",
                                  url: "",
                                  onchanged: (value) {
                                    controller.selectedBrand.value = value;
                                  },
                                  selectedValue: controller.selectedBrand.value,
                                  parseKeyForKey: "",
                                  parseKeyForValue: "",
                                  textSizeboxWidth: 85,
                                  isEnable: controller.isEnable.value,
                                );
                              }),
                              sizedBoxHeight(5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: InputFields.formFieldExpand2(
                                        hintTxt: "Executive",
                                        controller: controller.executiveController,
                                        autoFocus: true,
                                        titleSizeboxWidth: 80,
                                        isEnable: controller.isEnable.value,
                                        bottomPadding: false),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FormButton(
                                    btnText: "Deal",
                                    showIcon: false,
                                    isEnabled: true,
                                    callback: () {},
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FormButton(
                                    btnText: "Validation",
                                    showIcon: false,
                                    isEnabled: true,
                                    callback: () {
                                     dragValidation();
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FormButton(
                                    btnText: "Spots",
                                    showIcon: false,
                                    isEnabled: true,
                                    callback: () {
                                      dragSpotsDialog();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: DateWithThreeTextField(
                                      title: "FPC Eff Dt",
                                      mainTextController:
                                      controller.fpcEffDtController,
                                      isEnable: controller.isEnable.value,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: DateWithThreeTextField(
                                      title: "Book Dt",
                                      mainTextController:
                                      controller.bookedDtController,
                                      isEnable: controller.isEnable.value,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(5),
                              Row(
                                children: [
                                  Expanded(
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "Booking No",
                                      controller: controller.bookingNoController,
                                      autoFocus: true,
                                      titleSizeboxWidth: 80,
                                      bottomPadding: false,
                                      isEnable: controller.isEnable.value,
                                    ),
                                  ),
                                  sizedBoxWidth(5),
                                  SizedBox(
                                    width: 100,
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "",
                                      controller: controller.textController1,
                                      // autoFocus: true,
                                      titleSizeboxWidth: 80,
                                      bottomPadding: false,
                                      isEnable: controller.isEnable.value,
                                    ),
                                  ),
                                  sizedBoxWidth(5),
                                  SizedBox(
                                    width: 150,
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "",
                                      controller: controller.textController2,
                                      // autoFocus: true,
                                      titleSizeboxWidth: 80,
                                      bottomPadding: false,
                                      isEnable: controller.isEnable.value,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(5),
                              InputFields.formFieldExpand2(
                                hintTxt: "Deal No",
                                controller: controller.dealNoController,
                                titleSizeboxWidth: 80,
                                bottomPadding: false,
                                isEnable: controller.isEnable.value,
                              ),
                              sizedBoxHeight(5),
                              InputFields.formFieldExpand2(
                                hintTxt: "Pay route",
                                controller: controller.payRouteController,
                                titleSizeboxWidth: 80,
                                bottomPadding: false,
                                isEnable: controller.isEnable.value,
                              ),
                              sizedBoxHeight(5),
                              InputFields.formFieldExpand2(
                                hintTxt: "Pay Mode",
                                controller: controller.payModeController,
                                titleSizeboxWidth: 80,
                                bottomPadding: false,
                                isEnable: controller.isEnable.value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    CheckBoxWidget1(title: "Select All", isEnable: false),
                    Expanded(
                      child: GetBuilder<AuditBookingsController>(
                          id: "grid",
                          builder: (controller) {
                            return Container(
                              child: (controller.auditBookingModel != null &&
                                  controller.auditBookingModel?.infoShowBookingList != null &&
                                  controller.auditBookingModel?.infoShowBookingList
                                      ?.displayDetails !=
                                      null &&
                                  controller.auditBookingModel?.infoShowBookingList?.displayDetails
                                      ?.lstSpot != null &&
                                  (controller.auditBookingModel?.infoShowBookingList?.displayDetails
                                      ?.lstSpot?.length ?? 0) > 0
                              ) ?
                              DataGridFromMap3(
                                showSrNo: true,
                                hideCode: false,
                                formatDate: false,
                                columnAutoResize: true,
                                doPasccal: true,
                                minimumWidth: 180,
                                colorCallback: (row) =>
                                (row.row.cells
                                    .containsValue(controller.stateManager?.currentCell))
                                    ? Colors.deepPurple.shade200
                                    : Colors.white,
                                exportFileName: "Secondary Asrun Modification",
                                mode: PlutoGridMode.normal,
                                checkBoxColumnKey: ["audited"],
                                checkBoxStrComparison: true,
                                noEditcheckBoxColumnKey: ["audited"],
                                onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent? event) {
                                  dragSpotsDialog();
                                },
                                // hideKeys: const [],
                                mapData: controller.auditBookingModel!.infoShowBookingList!
                                    .displayDetails
                                !.lstSpot!
                                    .map((e) => e.toJson())
                                    .toList(),
                                // mapData: (controllerX.dataList)!,
                                widthRatio: Get.width / 9 - 1,
                                onload: (PlutoGridOnLoadedEvent load) {
                                  controller.stateManager = load.stateManager;
                                },
                              ) : Container(
                                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                              ),
                            );
                          }),
                    ),
                    sizedBoxHeight(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // FormButton1(btnText: "OS"),

                        FormButton(
                          btnText: "OS",
                          showIcon: false,
                          isEnabled: true,
                          callback: () {},
                        ),
                        sizedBoxWidth(10),

                        FormButton(
                          btnText: "Mark As Un-Audit",
                          showIcon: false,
                          isEnabled: true,
                          callback: () {},
                        ),
                      ],
                    ),
                    Get.find<HomeController>().getCommonButton(
                      Routes.R_O_AUDIT,
                          (btnName) {},
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
