import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
import 'package:bms_creditcontrol/widgets/floating_dialog.dart';
import 'package:bms_creditcontrol/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/asrun_verification_controller.dart';

class AsrunVerificationView extends GetView<AsrunVerificationController> {
  AsrunVerificationView({Key? key}) : super(key: key);

  AsrunVerificationController controller =
      Get.put<AsrunVerificationController>(AsrunVerificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Obx(() => controller.drgabbleDialog.value != null
            ? DraggableFab(
                key: controller.valueKey,
                child: controller.drgabbleDialog.value!,
              )
            : const SizedBox()),
        body: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (value) {
            if (value.isKeyPressed(LogicalKeyboardKey.escape)) {
              controller.drgabbleDialog.value = null;
            }
          },
          child: GetBuilder(
            init: controller,
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      runSpacing: 5,
                      spacing: 5,
                      children: [
                        Obx(
                          () => DropDownField.formDropDown1WidthMap(
                            controller.location.value,
                            (value) {
                              controller.selectLocation.value = value;
                              controller.getChannel(value.key);
                            },
                            "Location",
                            .23,
                            autoFocus: true,
                            selected: controller.selectLocation.value,
                            isEnable: controller.isEnabel.value,
                            inkWellFocusNode: controller.locationFN,
                          ),
                        ),
                        Obx(
                          () => DropDownField.formDropDown1WidthMap(
                            controller.channel.value,
                            (data) {
                              controller.selectChannel.value = data;
                            },
                            "Channel",
                            .23,
                            selected: controller.selectChannel.value,
                            isEnable: controller.isEnabel.value,
                            inkWellFocusNode: controller.channelFN,
                          ),
                        ),
                        Obx(
                          () => DateWithThreeTextField(
                            title: "Log Date",
                            mainTextController: controller.logDate,
                            widthRation: .135,
                            isEnable: controller.isEnabel.value,
                          ),
                        ),
                        Obx(
                          () => FormButtonWrapper(
                            btnText: "Retrieve Data",
                            callback: () {
                              controller.getRetrieve();
                            },
                            showIcon: false,
                            isEnabled: controller.isEnabel.value,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Expanded(
                        child: controller.asRunDataList.isEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                              )
                            : DataGridFromMap3(
                                mapData: controller.asRunDataList.value
                                    .map((e) => e.toJson())
                                    .toList(),
                                onload: (value) {
                                  controller.asRunDataGrid = value.stateManager;
                                },
                                colorCallback: (colorEvent) {
                                  if (colorEvent.row.cells.containsValue(
                                      controller.asRunDataGrid?.currentCell)) {
                                    return Colors.deepPurple.shade100;
                                  }
                                  return Colors.white;
                                },
                                exportFileName: "As-Run Modification",
                                columnAutoResize: false,
                                hideCode: false,
                                onRowDoubleTap: (event) {
                                  controller.asRunDataGrid?.setCurrentCell(
                                      event.cell, event.rowIdx);
                                  if (event.cell.column.field.toString() ==
                                      'spotStatus') {
                                    if (event.row.cells['spotStatus']?.value ==
                                        'TELECASTED') {
                                      LoadingDialog.recordExists(
                                          "Want to change the status to NOT TELECASTED?",
                                          () {
                                        controller.spotStatusChanged(event);
                                      });
                                    } else {
                                      controller.notTelecastedFunction(event);
                                    }
                                  }
                                },
                                widthSpecificColumn: Get.find<HomeController>()
                                    .getGridWidthByKey(
                                        userGridSettingList:
                                            controller.userGridSetting1?.value,
                                        key: 'key1'),
                                keyMapping: const {
                                  "bookingNumber": "BookingNumber",
                                  "clientName": "ClientName",
                                  "agencyName": "AgencyName",
                                  "brandName": "BrandName",
                                  "tapeID": "TapeID",
                                  "caption": "Caption",
                                  "tapeDuration": "TapeDuration",
                                  "programName": "ProgramName",
                                  "midPre": "Mid/Pre",
                                  "spotAmount": 'SpotAmount',
                                  "spotStatus": "SpotStatus",
                                  "telecastDuration": "TelecastDuration",
                                  "telecastTime": "TelecastTime",
                                  // "billnumber": "",
                                  "scheduleTime": "ScheduleTime",
                                  // "status": "",
                                  "rosTimeBand": "ROSTimeBand",
                                  // "remarks": '',
                                  "clearBy": "ClearBy",
                                  "clearBySys": "ClearBySys",
                                  "spotPositionShortName":
                                      "SpotPositionShortName",
                                  "telecastProgramcode": "TelecastProgramcode",
                                  "telprogname": "telprogname",
                                  "telpos": "telpos",
                                  "bookingDetailCode": "BookingDetailCode",
                                  "dealno": "dealno",
                                  "packagecode": "packagecode",
                                  "recordnumber": 'recordnumber',
                                  "modifyStatus": "ModifyStatus",
                                  "locationCode": "LocationCode",
                                  "channelCode": "ChannelCode",
                                  "telecastMidPre": "TelecastMidPre",
                                  "accountName": "AccountName",
                                  "accountCode": "AccountCode",
                                  "bookedProgramCode": "BookedProgramCode",
                                  "breakNumber": 'BreakNumber',
                                  "positionNumber": 'PositionNumber',
                                },
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Get.find<HomeController>().getCommonButton(
                        Routes.ASRUN_IMPORT_SECONDARY_EVENTS,
                        handleAutoClear: false,
                        (btnName) {
                          controller.formHandler(btnName);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
