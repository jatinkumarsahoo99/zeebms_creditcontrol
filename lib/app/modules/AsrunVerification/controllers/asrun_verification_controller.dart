import 'dart:async';

import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/controller/MainController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/data/PermissionModel.dart';
import 'package:bms_creditcontrol/app/modules/AsrunVerification/bindings/asrun_verification_model.dart';
import 'package:bms_creditcontrol/app/modules/CommonSearch/views/common_search_view.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/pluto_grid.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
import 'package:bms_creditcontrol/widgets/gridFromMap.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AsrunVerificationController extends GetxController {
  TextEditingController logDate = TextEditingController(),
      tapeId = TextEditingController(),
      finalProgram = TextEditingController(),
      finalMidPre = TextEditingController(),
      finalTelecastTime = TextEditingController(),
      finalDuration = TextEditingController();

  var location = RxList<DropDownValue>();
  var channel = RxList<DropDownValue>();

  var isEnabel = true.obs,
      isFinalProgramField = false.obs,
      isTapeId = false.obs,
      isFinalProgram = false.obs,
      isFinalMidPre = false.obs,
      isFinalTelecastTime = false.obs,
      isAllowUserToAddRows = false.obs;
  var asRunDataIndex = 0.obs;
  var finalAsRunindex = 0.obs;
  var intTapeDurationBuffer = 3.obs;

  var drgabbleDialog = Rxn<Widget>();
  ValueKey? valueKey;
  AsRunDataModel? asRunDataModel;

  var asRunDataList = <AsRunData>[].obs;
  var finalAsRunList = [].obs;
  var asRunModificationsList = [].obs;
  var finalFiltterAsrunList = [].obs;

  Rxn<DropDownValue> selectLocation = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectChannel = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectFinalProgram = Rxn<DropDownValue>();

  FocusNode locationFN = FocusNode(),
      channelFN = FocusNode(),
      notTelecastFN = FocusNode();

  PlutoGridStateManager? asRunDataGrid;
  PlutoGridStateManager? finalAsRunDataGrid;

  Rxn<List<Map<String, Map<String, double>>>>? userGridSetting1 = Rxn([]);
  fetchUserSetting1() async {
    userGridSetting1?.value =
        await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserSetting1();
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoad();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getOnLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ASRUN_MODIFICATION_GET_LOCATION,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('location')) {
            location.clear();
            map['location'].forEach((e) {
              location.add(DropDownValue(
                key: e['locationcode'],
                value: e['locationname'],
              ));
            });
          }
        });
  }

  getChannel(locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ASRUN_MODIFICATION_GET_CHANNEL(locationCode),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('channel')) {
            channel.clear();
            map['channel'].forEach((e) {
              channel.add(DropDownValue(
                key: e['channelcode'],
                value: e['channelName'],
              ));
            });
          }
        });
  }

  getRetrieve() {
    if (selectLocation.value == null) {
      LoadingDialog.showErrorDialog("Please select location.", callback: () {
        Get.back();
      });
    } else if (selectChannel.value == null) {
      LoadingDialog.showErrorDialog("Please select channel.", callback: () {
        Get.back();
      });
    } else {
      isEnabel.value = false;
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.ASRUN_MODIFICATION_RETRIEVE(
            selectLocation.value?.key ?? "",
            selectChannel.value?.key ?? "",
            dateConvertToyyyyMMdd(logDate.text),
          ),
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('model')) {
              asRunDataModel =
                  AsRunDataModel.fromJson(map as Map<String, dynamic>);
              asRunDataList.clear();
              asRunDataList.value = asRunDataModel?.model?.asRunData ?? [];
              if (map['model']['finalAsRun'].isNotEmpty) {
                finalAsRunList.clear();
                finalAsRunList.value = map['model']['finalAsRun'];
              }
            }
          });
    }
  }

  String dateConvertToyyyyMMdd(String date) {
    return (DateFormat('yyyy-MM-dd')
        .format(DateFormat('dd-MM-yyyy').parse(date)));
  }

  spotStatusChanged(PlutoGridOnRowDoubleTapEvent event) {
    var blnRowUpdated = false;
    var asRunIndex = event.cell.row.sortIdx;
    if (finalAsRunList.isNotEmpty) {
      for (var i = 0; i < finalAsRunList.length; i++) {
        if (finalAsRunList[i]['exportTapeCode'] ==
                asRunDataList.value[asRunIndex].tapeId &&
            finalAsRunList[i]['tapeDuration'] ==
                asRunDataList.value[asRunIndex].tapeDuration &&
            finalAsRunList[i]['telecastTime'] ==
                asRunDataList.value[asRunIndex].telecastTime) {
          finalAsRunList[i]['spotStatus'] = "U";
          blnRowUpdated = true;
        }
      }
      if (blnRowUpdated == false) {
        finalAsRunList.add({
          'exportTapeCode': asRunDataList.value[asRunIndex].tapeId,
          'exportTapeCaption': asRunDataList.value[asRunIndex].caption,
          'tapeDuration': asRunDataList.value[asRunIndex].tapeDuration,
          'programname': asRunDataList.value[asRunIndex].programName,
          'telecastTime': asRunDataList.value[asRunIndex].telecastTime,
          'spotStatus': "U",
          'spotPosition': asRunDataList.value[asRunIndex].spotPositionShortName,
          'segmentNumber': null,
          'programCode': null,
        });
      }
    } else {
      if (blnRowUpdated == false) {
        finalAsRunList.add({
          'exportTapeCode': asRunDataList.value[asRunIndex].tapeId,
          'exportTapeCaption': asRunDataList.value[asRunIndex].caption,
          'tapeDuration': asRunDataList.value[asRunIndex].tapeDuration,
          'programname': asRunDataList.value[asRunIndex].programName,
          'telecastTime': asRunDataList.value[asRunIndex].telecastTime,
          'spotStatus': "U",
          'spotPosition': asRunDataList.value[asRunIndex].spotPositionShortName,
          'segmentNumber': null,
          'programCode': null,
        });
      }
    }
    // Spot Status
    asRunDataList.value[event.cell.row.sortIdx].spotStatus = "NOT TELECASTED";
    asRunDataGrid!.changeCellValue(
      event.row.cells['spotStatus']!,
      'NOT TELECASTED',
      callOnChangedEvent: false,
      force: true,
    );
    // Modify Status
    asRunDataList.value[event.cell.row.sortIdx].modifyStatus = "M";
    asRunDataGrid!.changeCellValue(
      event.row.cells['modifyStatus']!,
      'M',
      callOnChangedEvent: false,
      force: true,
    );
    // Tape Duration
    asRunDataList.value[event.cell.row.sortIdx].telecastDuration = null;
    asRunDataGrid!.changeCellValue(
      event.row.cells['telecastDuration']!,
      '',
      callOnChangedEvent: false,
      force: true,
    );
    // Telecast Time
    asRunDataList.value[event.cell.row.sortIdx].telecastTime = '';
    asRunDataGrid!.changeCellValue(
      event.row.cells['telecastTime']!,
      '',
      callOnChangedEvent: false,
      force: true,
    );
    // Telprogname
    asRunDataList.value[event.cell.row.sortIdx].telprogname = '';
    asRunDataGrid!.changeCellValue(
      event.row.cells['telprogname']!,
      '',
      callOnChangedEvent: false,
      force: true,
    );
    // Telpos
    asRunDataList.value[event.cell.row.sortIdx].telpos = '';
    asRunDataGrid!.changeCellValue(
      event.row.cells['telpos']!,
      '',
      callOnChangedEvent: false,
      force: true,
    );
  }

  notTelecastedFunction(PlutoGridOnRowDoubleTapEvent event) {
    asRunDataIndex.value = event.cell.row.sortIdx;
    if (asRunDataList.value[event.cell.row.sortIdx].accountCode !=
        "I000100001") {
      isAllowUserToAddRows.value = true;
    } else {
      isAllowUserToAddRows.value = false;
    }
    if (isAllowUserToAddRows.isTrue) {
      finalAsRunList.removeWhere(
          (e) => e['exportTapeCode'] == "" || e['programname'] == "");
      finalAsRunList.add({
        'exportTapeCode': '',
        'exportTapeCaption': '',
        'tapeDuration': '',
        'programname': '',
        'telecastTime': '',
        'spotStatus': '',
        'spotPosition': '',
        'segmentNumber': null,
        'programCode': null,
      });
    } else {
      finalAsRunList.removeWhere(
          (e) => e['exportTapeCode'] == "" || e['programname'] == "");
    }
    notTelecastedDilogBox();
    Timer(const Duration(seconds: 1), () {
      var asRunIndex = event.cell.row.sortIdx;
      for (var i = 0; i < finalAsRunList.length; i++) {
        if (finalAsRunList[i]['exportTapeCode'] ==
            asRunDataList.value[asRunIndex].tapeId) {
          finalAsRunDataGrid!.setCurrentCell(
            finalAsRunDataGrid!.getRowByIdx(i)?.cells['exportTapeCode'],
            i,
            notify: true,
          );
        }
      }
    });
  }

  notTelecastedDilogBox() {
    valueKey = const ValueKey("notTelecastedDilogBox");
    drgabbleDialog.value = RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (value) {
        if (value.isKeyPressed(LogicalKeyboardKey.escape)) {
          drgabbleDialog.value = null;
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: SizedBox(
          width: Get.width * 0.60,
          height: Get.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Expanded(
                    child: finalAsRunList.isEmpty
                        ? Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                          )
                        : DataGridFromMap3(
                            mapData: finalAsRunList.value,
                            onload: (value) {
                              finalAsRunDataGrid = value.stateManager;
                            },
                            colorCallback: (colorEvent) {
                              if (colorEvent.row.cells.containsValue(
                                  finalAsRunDataGrid?.currentCell)) {
                                return Colors.deepPurple.shade100;
                              }
                              return Colors.white;
                            },
                            exportFileName: "As-Run Modification",
                            hideCode: false,
                            columnAutoResize: false,
                            onRowDoubleTap: (event) {
                              drgabbleDialog.value = null;
                              telecastedCellDoubleClick(event);
                            },
                            widthSpecificColumn:
                                Get.find<HomeController>().getGridWidthByKey(
                              userGridSettingList: userGridSetting1?.value,
                              key: "key2",
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  telecastedCellDoubleClick(PlutoGridOnRowDoubleTapEvent event) {
    if (finalAsRunList.value[event.cell.row.sortIdx]['spotStatus'] == "T") {
      LoadingDialog.showErrorDialog('Sorry, clicked tape id is already mapped.',
          callback: () {
        Get.back();
      });
    } else {
      tapeId.text = "";
      finalMidPre.text = "";
      finalTelecastTime.text = "";
      finalDuration.text = "0";
      if (finalAsRunList.value[event.cell.row.sortIdx]['spotStatus'] != "") {
        isTapeId.value = false;
        isFinalProgram.value = false;
        isFinalMidPre.value = false;
        isFinalTelecastTime.value = false;
        isFinalProgramField.value = false;
        tapeId.text =
            finalAsRunList.value[event.cell.row.sortIdx]['exportTapeCode'];
        finalProgram.text =
            finalAsRunList.value[event.cell.row.sortIdx]['programname'];
        finalMidPre.text =
            finalAsRunList.value[event.cell.row.sortIdx]['spotPosition'];
        finalTelecastTime.text =
            finalAsRunList.value[event.cell.row.sortIdx]['telecastTime'];
        finalDuration.text = finalAsRunList.value[event.cell.row.sortIdx]
                ['tapeDuration']
            .toString();
        selectFinalProgram.value = DropDownValue(
          key: asRunDataList.value[asRunDataIndex.value].bookedProgramCode,
          value: asRunDataList.value[asRunDataIndex.value].programName,
        );
      } else {
        isTapeId.value = false;
        isFinalProgram.value = false;
        isFinalMidPre.value = false;
        isFinalTelecastTime.value = true;
        isFinalProgramField.value = true;
        finalMidPre.text =
            finalAsRunList.value[event.cell.row.sortIdx]['spotPosition'] == ''
                ? "MID"
                : finalAsRunList.value[event.cell.row.sortIdx]['spotPosition'];
        finalTelecastTime.text = "00:00:00:00";
        selectFinalProgram.value = DropDownValue(
          key: asRunDataList.value[asRunDataIndex.value].bookedProgramCode,
          value: asRunDataList.value[asRunDataIndex.value].programName,
        );
      }
      finalAsRunindex.value = event.cell.row.sortIdx;
      bringToFrontDilogBox();
    }
  }

  bringToFrontDilogBox() {
    showDialog(
      context: Get.context!,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: Get.width * 0.26,
            height: Get.height * 0.51,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 5,
                    spacing: 5,
                    children: [
                      Obx(
                        () => InputFields.formField1(
                          hintTxt: "Tape ID",
                          controller: tapeId,
                          width: 0.24,
                          isEnable: isTapeId.value,
                        ),
                      ),
                      Obx(
                        () => isFinalProgramField.isTrue
                            ? DropDownField.formDropDownSearchAPI2(
                                GlobalKey(),
                                Get.context!,
                                title: "Final Program",
                                parseKeyForKey: "programCode",
                                parseKeyForValue: "programName",
                                url: ApiFactory.ASRUN_MODIFICATION_GET_PROGRAM,
                                onchanged: (data) {
                                  selectFinalProgram.value = data;
                                },
                                width: Get.width * 0.24,
                                selectedValue: selectFinalProgram.value,
                              )
                            : InputFields.formField1(
                                hintTxt: "Final Program",
                                controller: finalProgram,
                                width: 0.24,
                                isEnable: isFinalProgram.value,
                              ),
                      ),
                      Obx(
                        () => InputFields.formField1(
                          hintTxt: "Final MID/Pre",
                          controller: finalMidPre,
                          width: 0.24,
                          isEnable: isFinalMidPre.value,
                        ),
                      ),
                      Obx(
                        () => InputFields.formFieldNumberMask(
                          hintTxt: "Final Telecast Time",
                          controller: finalTelecastTime,
                          widthRatio: isFinalProgramField.isTrue ? .10 : 0.24,
                          isEnable: isFinalTelecastTime.value,
                          paddingLeft: 0,
                        ),
                      ),
                      InputFields.numbersWithFocus(
                        hintTxt: "Final Duration",
                        controller: finalDuration,
                        isNegativeReq: false,
                        width: 0.24,
                        padLeft: 0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormButton(
                        btnText: "OK",
                        callback: () {
                          btnOkClick();
                        },
                        showIcon: false,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FormButton(
                        btnText: "Cancel",
                        callback: () {
                          Get.back();
                        },
                        showIcon: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  btnOkClick() {
    PermissionModel formPermissions = Get.find<MainController>()
        .permissionList!
        .lastWhere((element) => element.appFormName == "frmAsRunModification");
    String strMessage = "";
    if (asRunDataList.value[asRunDataIndex.value].accountCode != "I000100004" &&
        selectLocation.value!.key != 'ZEEXX00001') {
      if (tapeId.text.trim() !=
              asRunDataList.value[asRunDataIndex.value].tapeId &&
          formPermissions.backDated == false) {
        strMessage = "- Tape ID does not match.\n";
      }
      var intTD = finalAsRunList.value[finalAsRunindex.value]['tapeDuration'];
      if (intTD < asRunDataList.value[asRunDataIndex.value].tapeDuration &&
              formPermissions.backDated == false ||
          intTD > asRunDataList.value[asRunDataIndex.value].tapeDuration &&
              formPermissions.backDated == false) {
        if ((intTD - asRunDataList.value[asRunDataIndex.value].tapeDuration)
                .abs() >
            intTapeDurationBuffer) {
          strMessage += "- Tape Duration does not match.\n";
        }
      }
    } else {
      if (asRunDataList.value[asRunDataIndex.value].tapeId !=
              tapeId.text.trim() &&
          formPermissions.backDated == false) {
        LoadingDialog.recordExists("Tape id does not matches, want to proceed?",
            () {
          asRunDataList.value[asRunDataIndex.value].tapeId = tapeId.text;
          asRunDataGrid!.changeCellValue(
            asRunDataGrid!.getRowByIdx(asRunDataIndex.value)!.cells['tapeId']!,
            tapeId.text,
            callOnChangedEvent: false,
            force: true,
          );
        });
      }
    }

    if (strMessage.isEmpty) {
      if (finalDuration.text !=
              asRunDataList.value[asRunDataIndex.value].tapeDuration
                  .toString() &&
          formPermissions.backDated == false) {
        strMessage += "- Tape Duration does not match.\n";
      }
    }

    if (strMessage.isNotEmpty) {
      LoadingDialog.showErrorDialog(strMessage);
    } else {
      if (selectFinalProgram.value == null) {
        LoadingDialog.showErrorDialog('Program name cannot be empty.');
      }
      if (selectFinalProgram.value!.value !=
          asRunDataList.value[asRunDataIndex.value].programName) {
        LoadingDialog.recordExists(
            'Program name not matching. Do you want to still continue?', () {
          asRunDataList.value[asRunDataIndex.value].telecastDuration =
              num.parse(finalDuration.text);
          asRunDataGrid!.changeCellValue(
            asRunDataGrid!
                .getRowByIdx(asRunDataIndex.value)!
                .cells['telecastDuration']!,
            finalDuration.text,
            callOnChangedEvent: false,
            force: true,
          );
          asRunDataList.value[asRunDataIndex.value].telecastTime =
              finalTelecastTime.text
                  .substring(0, finalTelecastTime.text.lastIndexOf(":"));
          asRunDataGrid!.changeCellValue(
            asRunDataGrid!
                .getRowByIdx(asRunDataIndex.value)!
                .cells['telecastTime']!,
            finalTelecastTime.text
                .substring(0, finalTelecastTime.text.lastIndexOf(":")),
            callOnChangedEvent: false,
            force: true,
          );
          asRunDataList.value[asRunDataIndex.value].telecastProgramcode =
              selectFinalProgram.value!.key;
          asRunDataGrid!.changeCellValue(
            asRunDataGrid!
                .getRowByIdx(asRunDataIndex.value)!
                .cells['telecastProgramcode']!,
            selectFinalProgram.value!.key,
            callOnChangedEvent: false,
            force: true,
          );
          asRunDataList.value[asRunDataIndex.value].telprogname =
              selectFinalProgram.value!.value;
          asRunDataGrid!.changeCellValue(
            asRunDataGrid!
                .getRowByIdx(asRunDataIndex.value)!
                .cells['telprogname']!,
            selectFinalProgram.value!.value,
            callOnChangedEvent: false,
            force: true,
          );
          asRunDataList.value[asRunDataIndex.value].modifyStatus = "M";
          asRunDataGrid!.changeCellValue(
            asRunDataGrid!
                .getRowByIdx(asRunDataIndex.value)!
                .cells['modifyStatus']!,
            "M",
            callOnChangedEvent: false,
            force: true,
          );

          asRunDataList.value[asRunDataIndex.value].spotStatus = "TELECASTED";
          asRunDataGrid!.changeCellValue(
            asRunDataGrid!
                .getRowByIdx(asRunDataIndex.value)!
                .cells['spotStatus']!,
            "TELECASTED",
            callOnChangedEvent: false,
            force: true,
          );
          finalAsRunList.value[finalAsRunindex.value]['spotStatus'] = 'T';
          finalAsRunDataGrid!.changeCellValue(
            finalAsRunDataGrid!
                .getRowByIdx(finalAsRunindex.value)!
                .cells['spotStatus']!,
            "T",
            callOnChangedEvent: false,
            force: true,
          );
          Get.back();
        });
      } else {
        asRunDataList.value[asRunDataIndex.value].telecastDuration =
            num.parse(finalDuration.text);
        asRunDataGrid!.changeCellValue(
          asRunDataGrid!
              .getRowByIdx(asRunDataIndex.value)!
              .cells['telecastDuration']!,
          finalDuration.text,
          callOnChangedEvent: false,
          force: true,
        );
        isFinalProgramField.isTrue
            ? asRunDataList.value[asRunDataIndex.value].telecastTime =
                finalTelecastTime.text
                    .substring(0, finalTelecastTime.text.lastIndexOf(":"))
            : asRunDataList.value[asRunDataIndex.value].telecastTime =
                finalTelecastTime.text;
        asRunDataGrid!.changeCellValue(
          asRunDataGrid!
              .getRowByIdx(asRunDataIndex.value)!
              .cells['telecastTime']!,
          isFinalProgramField.isTrue
              ? finalTelecastTime.text
                  .substring(0, finalTelecastTime.text.lastIndexOf(":"))
              : finalTelecastTime.text,
          callOnChangedEvent: false,
          force: true,
        );
        asRunDataList.value[asRunDataIndex.value].telecastProgramcode =
            asRunDataList.value[asRunDataIndex.value].bookedProgramCode;
        asRunDataGrid!.changeCellValue(
          asRunDataGrid!
              .getRowByIdx(asRunDataIndex.value)!
              .cells['telecastProgramcode']!,
          asRunDataList.value[asRunDataIndex.value].bookedProgramCode,
          callOnChangedEvent: false,
          force: true,
        );
        asRunDataList.value[asRunDataIndex.value].telprogname =
            finalProgram.text;
        asRunDataGrid!.changeCellValue(
          asRunDataGrid!
              .getRowByIdx(asRunDataIndex.value)!
              .cells['telprogname']!,
          finalProgram.text,
          callOnChangedEvent: false,
          force: true,
        );
        asRunDataList.value[asRunDataIndex.value].modifyStatus = "M";
        asRunDataGrid!.changeCellValue(
          asRunDataGrid!
              .getRowByIdx(asRunDataIndex.value)!
              .cells['modifyStatus']!,
          "M",
          callOnChangedEvent: false,
          force: true,
        );

        asRunDataList.value[asRunDataIndex.value].spotStatus = "TELECASTED";
        asRunDataGrid!.changeCellValue(
          asRunDataGrid!
              .getRowByIdx(asRunDataIndex.value)!
              .cells['spotStatus']!,
          "TELECASTED",
          callOnChangedEvent: false,
          force: true,
        );
        finalAsRunList.value[finalAsRunindex.value]['spotStatus'] = 'T';
        finalAsRunDataGrid!.changeCellValue(
          finalAsRunDataGrid!
              .getRowByIdx(finalAsRunindex.value)!
              .cells['spotStatus']!,
          "T",
          callOnChangedEvent: false,
          force: true,
        );
        Get.back();
      }
    }
  }

  save() {
    int asCount =
        asRunDataList.where((row) => row.modifyStatus == 'M').toList().length;
    int finalAsCount = finalAsRunList
        .where((row) => row['spotStatus'] == 'T' || row['spotStatus'] == 'U')
        .toList()
        .length;
    if (asCount <= 0 || finalAsCount <= 0) {
      LoadingDialog.callInfoMessage('Sorry! No record(s) to save.');
    } else {
      var filteredAsRunData =
          asRunDataList.where((row) => row.modifyStatus == 'M').toList();
      for (var e in filteredAsRunData) {
        asRunModificationsList.add({
          "locationCode": e.locationCode,
          "channelCode": e.channelCode,
          "bOOKINGNUMBER": e.bookingNumber,
          "bOOKINGDetailcode": e.bookingDetailCode,
          "spotStatus": e.spotStatus,
          "telecastProgramCode": e.telecastProgramcode,
          "telecastDuration": e.telecastDuration,
          "telecastMidPre": e.telecastMidPre,
          "telecastTime": e.telecastTime == "" ? null : e.telecastTime,
          "tapeID": e.tapeId,
        });
      }
      var filteredFinalAsRunData = finalAsRunList
          .where((row) => row['spotStatus'] == 'T' || row['spotStatus'] == 'U')
          .toList();
      for (var e in filteredFinalAsRunData) {
        finalFiltterAsrunList.add({
          "exportTapeCode": e['exportTapeCode'],
          "telecastTime": e['telecastTime'],
        });
      }
      var payload = {
        "locationcode": selectLocation.value?.key ?? "",
        "channelcode": selectChannel.value?.key ?? "",
        "logDate": dateConvertToyyyyMMdd(logDate.text),
        "asRunModifications": asRunModificationsList,
        "finalAsrun": finalFiltterAsrunList,
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.ASRUN_MODIFICATION_SAVE,
          json: payload,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('save')) {
              LoadingDialog.callDataSaved(
                  msg: map['save'],
                  callback: () {
                    Get.delete<AsrunVerificationController>();
                    Get.find<HomeController>().clearPage1();
                  });
            }
          });
    }
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        save();
        break;
      case "Clear":
        if (isEnabel.isFalse) {
          LoadingDialog.recordExists(
            "Unsaved data will be lost, want to continue?",
            () {
              Get.delete<AsrunVerificationController>();
              Get.find<HomeController>().clearPage1();
            },
          );
        } else {
          Get.delete<AsrunVerificationController>();
          Get.find<HomeController>().clearPage1();
        }

        break;
      case "Exit":
        print("Im in Exit");
        try {
          Get.find<HomeController>().postUserGridSetting1(listStateManager: [
            asRunDataGrid,
            finalAsRunDataGrid,
          ], tableNamesList: [
            'key1',
            'key2,'
          ]);
        } catch (e) {
          print("Exit Error ===>" + e.toString());
        }
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("As-Run Modification"),
            screenName: "As-Run Modification",
            appBarName: "As-Run Modification",
            strViewName: "vTesting",
            isAppBarReq: true,
          ),
        );
        break;
    }
  }
}
