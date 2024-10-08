import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/sized_box_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
              Expanded(
                  child: GetBuilder<AuditBookingsController>(
                      id: "all",
                      builder: (controller) {
                        return Container(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: (
                                controller.spotFilterList !=
                                    null &&
                                (controller.spotFilterList?.length ??
                                    0) >
                                    0)
                                ? DataGridFromMap3(
                              showSrNo: true,
                              hideCode: false,
                              formatDate: false,
                              columnAutoResize: false,
                              doPasccal: true,
                              minimumWidth: 180,
                              colorCallback: (row) {
                                return (row.row.cells
                                    .containsValue(controller.spotGridManager?.currentCell))
                                    ? Colors.deepPurple.shade200
                                    : Colors.white;
                              },
                              exportFileName: "Audit Booking",
                              mode: PlutoGridMode.normal,
                              // hideKeys: ["isrequired", "allowedvalues"],
                              mapData: controller.spotFilterList!
                                  .map((e) => e.toJson1())
                                  .toList(),
                              // mapData: (controllerX.dataList)!,
                              widthRatio: Get.width / 9 - 1,
                              onload: (PlutoGridOnLoadedEvent load) {
                                controller.spotGridManager = load.stateManager;
                              },
                            )
                                : Container(),
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

  dragValidation({bool? dealRows = false,
    bool? buildValue = false,
    bool? bookingExceeds = false,
    bool? clientUnder = false,
    bool? agencyUnder = false,
    bool? commercialDur = false}) {
    controller.initialOffset.value = 1;
    // Completer<bool> completer = Completer<bool>();
    controller.dialogWidget = Material(
      color: Colors.white,
      // borderRadius: BorderRadius.circular(7),
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.35,
          height: Get.height * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 24,
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
              CheckBoxWidget1(
                title: "Deal Rows With Negative Balances",
                isEnable: dealRows ?? false,
                value: dealRows ?? false,
              ),
              CheckBoxWidget1(
                  title: "Build Value is Less than Booked Value",
                  isEnable: buildValue ?? false,
                  value: buildValue ?? false),
              CheckBoxWidget1(
                  title: "Booking Exceeds Max Spend in Deal",
                  isEnable: bookingExceeds ?? false,
                  value: bookingExceeds ?? false),
              CheckBoxWidget1(
                title: "Client Under embargo",
                isEnable: clientUnder ?? false,
                value: clientUnder ?? false,
              ),
              CheckBoxWidget1(
                  title: "Agency Under Embargo",
                  isEnable: agencyUnder ?? false,
                  value: agencyUnder ?? false),
              CheckBoxWidget1(
                  title: "Commercial Duration Mismatch",
                  isEnable: commercialDur ?? false,
                  value: commercialDur ?? false),
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
                    },
                  )
                ],
              ),
              SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
    controller.canDialogShow.value = true;
  }

  dealDialogView() {
    controller.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.65,
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
              InputFields.formField2(
                  hintTxt: "Max Spend",
                  controller: controller.maxSpendControllerDialog,
                  isEnable: false,
                  width: 0.57
              ),
              SizedBox(
                height: 2,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                        )),
                  ],
                ),
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
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
                AppBar(
                  title: const Text('Audit Bookings'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(result: true),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
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
                                  return DropDownField.formDropDown1WidthMapExpand(
                                      controller.locationList.value, (value) {
                                    controller.selectedLocation.value = value;
                                  }, "Location",
                                      // titleInLeft: true,
                                      selected: controller.selectedLocation.value,
                                      titleSizeBoxWidth: 75,
                                      isEnable: controller.isEnable.value);
                                }),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Obx(() {
                                  return DropDownField.formDropDown1WidthMapExpand(
                                      controller.channelList.value, (value) {
                                    controller.selectedChannel.value = value;
                                  }, "Channel",
                                      // titleInLeft: true,
                                      selected: controller.selectedChannel.value,
                                      titleSizeBoxWidth: 75,
                                      isEnable: controller.isEnable.value);
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
                                child: InputFields.formFieldExpand2(
                                    hintTxt: "",
                                    controller: controller.refDateController,
                                    autoFocus: true,
                                    titleSizeboxWidth: 80,
                                    isEnable: controller.isEnable.value,
                                    bottomPadding: false),
                              ),
                             /* Expanded(
                                child: GetBuilder<AuditBookingsController>(
                                    id: "date",
                                    builder: (controller) {
                                      return DateWithThreeTextField(
                                        title: "",
                                        mainTextController: controller.refDateController,
                                        isEnable: controller.isEnable.value,
                                        splitType: "-",
                                        startDate: (DateFormat("dd-MM-yyyy").parse(
                                            "28-03-2023")).subtract(Duration(days: 3)),
                                        // intailDate:(DateFormat("dd-MM-yyyy").parse(controller.refDateController.text)),


                                      );
                                    }),
                              ),*/
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
                                callback: () {
                                  controller.maxSpendControllerDialog.text =
                                      (controller.auditBookingModel?.infoShowBookingList
                                          ?.dislpayDealDetails?.dealMaxSpend ?? "").toString();
                                  dealDialogView();
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FormButton(
                                btnText: "Validation",
                                showIcon: false,
                                isEnabled: true,
                                callback: () {
                                  dragValidation(
                                    dealRows: controller.auditBookingModel?.infoShowBookingList
                                        ?.dislpayDealDetails?.chkDealNegativeBalance ??
                                        false,
                                    buildValue: controller.auditBookingModel?.infoShowBookingList
                                        ?.dislpayDealDetails?.chkValuation ??
                                        false,
                                    bookingExceeds: controller
                                        .auditBookingModel
                                        ?.infoShowBookingList
                                        ?.dislpayDealDetails
                                        ?.chkMaxSpendcheck ??
                                        false,
                                    clientUnder: controller.auditBookingModel?.infoShowBookingList
                                        ?.dislpayDealDetails?.chkClientEmbargo ??
                                        false,
                                    agencyUnder: controller.auditBookingModel?.infoShowBookingList
                                        ?.dislpayDealDetails?.chkAgencyEmbargo ??
                                        false,
                                    commercialDur: controller.auditBookingModel?.infoShowBookingList
                                        ?.dislpayDealDetails?.chkCommDurMismatch ??
                                        false,
                                  );
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DateWithThreeTextField(
                                  title: "FPC Eff Dt",
                                  mainTextController: controller.fpcEffDtController,
                                  isEnable: controller.isEnable.value,
                                  widthRation: 0.15,
                                ),
                              ),
                              // SizedBox(width: 5),
                              Expanded(
                                child: DateWithThreeTextField(
                                  title: "Book Dt",
                                  mainTextController: controller.bookedDtController,
                                  isEnable: controller.isEnable.value,
                                  widthRation: 0.15,
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
                          sizedBoxHeight(5),
                          Obx(() {
                            return Container(
                              child: (controller.isPDCEntered.value)
                                  ? InputFields.formFieldExpand2(
                                  hintTxt: "Remark",
                                  controller: controller.remarkController,
                                  autoFocus: true,
                                  titleSizeboxWidth: 80,
                                  isEnable: controller.isEnable.value,
                                  bottomPadding: false)
                                  : Container(),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Obx(() {
                      return Container(
                        child: (controller.isPDCEntered.value)
                            ? Expanded(
                          child: InputFields.formFieldExpand2(
                              hintTxt: "PDC",
                              controller: controller.pdcController,
                              backgroundColor: Colors.orangeAccent.withOpacity(0.2),
                              autoFocus: true,
                              titleSizeboxWidth: 80,
                              isEnable: controller.isEnable.value,
                              bottomPadding: false),
                        )
                            : Container(),
                      );
                    }),
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
                              controller
                                  .auditBookingModel?.infoShowBookingList?.displayDetails !=
                                  null &&
                              controller.auditBookingModel?.infoShowBookingList?.displayDetails
                                  ?.lstSpot !=
                                  null &&
                              (controller.auditBookingModel?.infoShowBookingList?.displayDetails
                                  ?.lstSpot?.length ??
                                  0) >
                                  0)
                              ? DataGridFromMap3(
                            showSrNo: true,
                            hideCode: false,
                            formatDate: false,
                            columnAutoResize: true,
                            doPasccal: true,
                            minimumWidth: 180,
                            colorCallback: (row) {
                              if (row.row.cells['auditedSpots']?.value == "" ||
                                  row.row.cells['auditedSpots']?.value == null) {
                                return const Color(0xFF96FF96);
                              } else if (int.parse(
                                  (row.row.cells['auditedSpots']?.value ?? '0').toString()) <
                                  int.parse(
                                      (row.row.cells['totalspots']?.value ?? '0').toString())) {
                                return const Color(0xFFFF9696);
                              }
                              return (row.row.cells
                                  .containsValue(controller.stateManager?.currentCell))
                                  ? Colors.deepPurple.shade200
                                  : Colors.white;
                            },
                            exportFileName: "Audit Bookings",
                            mode: PlutoGridMode.normal,
                            checkBoxColumnKey: ["audited"],
                            checkBoxStrComparison: true,
                            noEditcheckBoxColumnKey: ["audited"],
                            onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent? event) {
                              String rowNumber = (event?.cell.row.cells['rowNumber']?.value ?? "").toString();
                              controller.spotFilterList?.clear();
                              controller.auditBookingModel?.infoShowBookingList?.displayBookingStatus?.lstBookingDetails?.forEach((element) {
                                print(">>>>>>>>>> ${element.packagecode} ${rowNumber}");
                                if((element.packagecode??"").toString().toLowerCase().trim() == rowNumber.toLowerCase().trim()){
                                  controller.spotFilterList?.add(element);
                                }
                              });
                              print(">>>>>>>>>${controller.spotFilterList}");

                              dragSpotsDialog();
                            },
                            // hideKeys: const [],
                            mapData: controller.auditBookingModel!.infoShowBookingList!
                                .displayDetails!.lstSpot!
                                .map((e) => e.toJson1())
                                .toList(),
                            // mapData: (controllerX.dataList)!,
                            widthRatio: Get.width / 9 - 1,
                            onload: (PlutoGridOnLoadedEvent load) {
                              controller.stateManager = load.stateManager;
                            },
                          )
                              : Container(
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
                      callback: () {
                        controller.btnAudit();
                      },
                    ),
                  ],
                ),
                Get.find<HomeController>().getCommonButton1(
                  Routes.R_O_AUDIT,
                      disableBtns: ["Delete"],
                      (btnName) {
                    if (btnName == "Save") {
                      controller.saveFunCall();
                    } else if (btnName == "Clear") {
                      // controller.clearAll();
                      Get.back(result: true);
                    } else if (btnName == "Docs") {
                      controller.docs();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
