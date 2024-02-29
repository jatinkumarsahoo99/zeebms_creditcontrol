import 'dart:convert';

import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/modules/ReadytoBills/bindings/billing_status_model.dart';
import 'package:bms_creditcontrol/app/modules/ReadytoBills/bindings/billings_value_model.dart';
import 'package:bms_creditcontrol/app/modules/ReadytoBills/bindings/verify_model.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/app/providers/ExportData.dart';
import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/pluto_grid.dart';
import 'package:bms_creditcontrol/widgets/gridFromMap.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReadytoBillsController extends GetxController {
  TextEditingController fromDate = TextEditingController(),
      toDate = TextEditingController();

  List extraButtonName = ['Verify', 'Billing Value', 'Export', 'Clear', 'Exit'];
  var isR4 = false.obs;
  var isSelectecRows = false.obs;
  var isFiltter = false.obs;
  int lastSelectedIdx = 0;
  var isTrueFalseFiltter = true.obs;

  PlutoGridStateManager? billingGrid;
  PlutoGridStateManager? verifyGrid;
  PlutoGridStateManager? billingValueGrid;

  BillingStatusModel? billingStatusModel;
  VerifyModel? verifyModel;
  BillingsValueModel? billingsValueModel;

  var billingsList = <Billing>[].obs;
  var billingsList2 = <Billing>[].obs;
  var verifyList = <Verify>[].obs;
  var billingValueList = <Billings>[].obs;

  var location = RxList<DropDownValue>();
  var channel = RxList<DropDownValue>();

  Rxn<DropDownValue> selectLocation = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectChannel = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectAgency = Rxn<DropDownValue>();

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
        api: ApiFactory.READY_TO_BILLS_ON_LOAD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('onload')) {
            location.clear();
            map['onload'].forEach((e) {
              location.add(DropDownValue(
                key: e['locationCode'],
                value: e['locationName'],
              ));
            });
          }
        });
  }

  getChannel(locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.READY_TO_BILLS_GET_CHANNEL(locationCode),
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

  getBillingStatus() {
    if (selectLocation.value == null || selectChannel.value == null) {
      LoadingDialog.showErrorDialog("Please select channel & loaction.",
          callback: () {
        Get.back();
      });
    } else {
      var payload = {
        "channelCode": selectChannel.value?.key ?? "",
        "locationCode": selectLocation.value?.key ?? "",
        "fromDate": dateConvertToyyyyMMdd(fromDate.text),
        "toDate": dateConvertToyyyyMMdd(toDate.text),
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          json: payload,
          api: ApiFactory.READY_TO_BILLS_GET_BILLING_STATUS,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('billing')) {
              billingStatusModel =
                  BillingStatusModel.fromJson(map as Map<String, dynamic>);
              billingsList.clear();
              billingsList2.clear();
              billingsList.value = billingStatusModel?.billing ?? [];
              billingsList2.value = billingStatusModel?.billing ?? [];
            }
          });
    }
  }

  mark() {
    if (selectLocation.value == null || selectChannel.value == null) {
      LoadingDialog.showErrorDialog("Please select channel & loaction.",
          callback: () {
        Get.back();
      });
    } else {
      var payload = {
        "channelCode": selectChannel.value?.key ?? "",
        "locationCode": selectLocation.value?.key ?? "",
        "fromDate": dateConvertToyyyyMMdd(fromDate.text),
        "toDate": dateConvertToyyyyMMdd(toDate.text),
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          json: payload,
          api: ApiFactory.READY_TO_BILLS_MARK,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('mark')) {
              LoadingDialog.callInfoMessage(
                map['mark'],
              );
            }
          });
    }
  }

  duplicateCheck() {
    if (selectLocation.value == null || selectChannel.value == null) {
      LoadingDialog.showErrorDialog("Please select channel & loaction.",
          callback: () {
        Get.back();
      });
    } else {
      var payload = {
        "channelCode": selectChannel.value?.key ?? "",
        "locationCode": selectLocation.value?.key ?? "",
        "fromDate": dateConvertToyyyyMMdd(fromDate.text),
        "toDate": dateConvertToyyyyMMdd(toDate.text),
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          json: payload,
          api: ApiFactory.READY_TO_BILLS_CHECK_DUPLICATE,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('duplicate')) {}
          });
    }
  }

  verify() {
    isFiltter.value = false;
    if (selectLocation.value == null || selectChannel.value == null) {
      LoadingDialog.showErrorDialog("Please select channel & loaction.",
          callback: () {
        Get.back();
      });
    } else {
      var payload = {
        "channelCode": selectChannel.value?.key ?? "",
        "locationCode": selectLocation.value?.key ?? "",
        "fromDate": dateConvertToyyyyMMdd(fromDate.text),
        "toDate": dateConvertToyyyyMMdd(toDate.text),
        "chkR4": isR4.value,
        "agencycode": selectAgency.value?.key ?? "",
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          json: payload,
          api: ApiFactory.READY_TO_BILLS_VERIFY,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('verify')) {
              verifyModel = VerifyModel.fromJson(map as Map<String, dynamic>);
              verifyList.clear();
              verifyList.value = verifyModel?.verify ?? [];
              verifyDilogBox();
            }
          });
    }
  }

  billingValue() {
    isFiltter.value = true;
    if (selectLocation.value == null || selectChannel.value == null) {
      LoadingDialog.showErrorDialog("Please select channel & loaction.",
          callback: () {
        Get.back();
      });
    } else {
      var payload = {
        "channelCode": selectChannel.value?.key ?? "",
        "locationCode": selectLocation.value?.key ?? "",
        "fromDate": dateConvertToyyyyMMdd(fromDate.text),
        "toDate": dateConvertToyyyyMMdd(toDate.text),
        "chkR4": isR4.value,
        "agencycode": selectAgency.value?.key ?? null,
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          json: payload,
          api: ApiFactory.READY_TO_BILLS_BILLING_VALUE,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('billings')) {
              billingsValueModel =
                  BillingsValueModel.fromJson(map as Map<String, dynamic>);
              billingValueList.clear();
              billingValueList.value = billingsValueModel?.billings ?? [];
              verifyDilogBox();
            }
          });
    }
  }

  sendToSap() {
    var payload = {};
    if (isFiltter.isFalse) {
      // Verify
      var sapBookingLIst = [];
      for (var item in verifyList) {
        if (item.bookingNumber!.isNotEmpty) {
          sapBookingLIst.add({
            "bookingNumber": item.bookingNumber,
            "channelCode": selectChannel.value?.key ?? "",
            "locationCode": selectLocation.value?.key ?? "",
          });
        }
      }
      payload = {
        "channelCode": selectChannel.value?.key ?? "",
        "locationCode": selectLocation.value?.key ?? "",
        "fromDate": dateConvertToyyyyMMdd(fromDate.text),
        "toDate": dateConvertToyyyyMMdd(toDate.text),
        "chkR4": isR4.value,
        "agencycode": selectAgency.value?.key ?? null,
        "sapBookingLst": sapBookingLIst,
      };
    } else {
      // Billing VAlue
      var sapBookingLIst = [];
      for (var item in billingValueList) {
        if (item.checked == true) {
          sapBookingLIst.add({
            "bookingNumber":
                item.bookingnumber!.isNotEmpty ? item.bookingnumber : "",
            "channelCode": selectChannel.value?.key ?? "",
            "locationCode": selectLocation.value?.key ?? "",
          });
        }
      }
      payload = {
        "channelCode": selectChannel.value?.key ?? "",
        "locationCode": selectLocation.value?.key ?? "",
        "fromDate": dateConvertToyyyyMMdd(fromDate.text),
        "toDate": dateConvertToyyyyMMdd(toDate.text),
        "chkR4": isR4.value,
        "agencycode": selectAgency.value?.key ?? null,
        "sapBookingLst": sapBookingLIst,
      };
    }

    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
        json: payload,
        api: ApiFactory.READY_TO_BILLS_SEND_TO_SAP,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('sendToSAP')) {
            LoadingDialog.callDataSaved(
                msg: map['sendToSAP'],
                callback: () {
                  export();
                  Get.delete<ReadytoBillsController>();
                  Get.find<HomeController>().clearPage1();
                });
          }
        });
  }

  resendToSap() {
    var payload = {
      "channelCode": selectChannel.value?.key ?? "",
      "locationCode": selectLocation.value?.key ?? "",
      "fromDate": dateConvertToyyyyMMdd(fromDate.text),
      "toDate": dateConvertToyyyyMMdd(toDate.text),
      "chkR4": isR4.value,
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
        json: payload,
        api: ApiFactory.READY_TO_BILLS_RESEND_TO_SAP,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('resendToSAP')) {
            LoadingDialog.callDataSaved(
                msg: map['resendToSAP'],
                callback: () {
                  Get.delete<ReadytoBillsController>();
                  Get.find<HomeController>().clearPage1();
                });
          }
        });
  }

  export() {
    if (selectLocation.value == null || selectChannel.value == null) {
      LoadingDialog.showErrorDialog("Please select channel & loaction.",
          callback: () {
        Get.back();
      });
    } else {
      var payload = {
        "channelCode": selectChannel.value?.key ?? "",
        "locationCode": selectLocation.value?.key ?? "",
        "channelName": selectChannel.value?.value ?? "",
        "locationName": selectLocation.value?.value ?? "",
        "fromDate": dateConvertToyyyyMMdd(fromDate.text),
        "toDate": dateConvertToyyyyMMdd(toDate.text),
        "chkR4": isR4.value,
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          json: payload,
          api: ApiFactory.READY_TO_BILLS_EXPORT,
          fun: (Map map) async {
            Get.back();
            if (map != null && map.containsKey('export')) {
              await FileSaver.instance.saveFile(
                name: (map['export']['fileName'] + ".xlsx"),
                bytes: base64Decode(map['export']['fileInBytes']),
              );
            }
          });
    }
  }

  save() {
    if (selectLocation.value == null || selectChannel.value == null) {
      LoadingDialog.showErrorDialog("Please select channel & loaction.",
          callback: () {
        Get.back();
      });
    } else {
      var saveList = [];
      for (var i = 0; i < billingsList.length; i++) {
        print(billingsList[i].remark!.isNotEmpty);
        if (billingsList[i].remark!.isNotEmpty) {
          saveList.add({
            "channelCode": selectChannel.value?.key ?? "",
            "locationCode": selectLocation.value?.key ?? "",
            "telecastDate":
                dateConvertToyyyyMMdd1(billingsList[i].telecastDate!),
            "remark": billingsList[i].remark ?? "",
          });
        }
      }
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          json: {
            "saveData": saveList,
          },
          api: ApiFactory.READY_TO_BILLS_SAVE,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('save')) {
              LoadingDialog.callDataSaved(
                  msg: map['save'],
                  callback: () {
                    Get.delete<ReadytoBillsController>();
                    Get.find<HomeController>().clearPage1();
                  });
            }
          });
    }
  }

  String dateConvertToyyyyMMdd(String date) {
    return (DateFormat('yyyy-MM-dd')
        .format(DateFormat('dd-MM-yyyy').parse(date)));
  }

  String dateConvertToyyyyMMdd1(String date) {
    return (DateFormat('yyyy-MM-dd')
        .format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(date)));
  }

  verifyDilogBox() {
    showDialog(
      context: Get.context!,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: Get.width * .80,
            height: Get.height * .7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  isFiltter.isFalse
                      ? Obx(
                          () => Expanded(
                            child: verifyList.isEmpty
                                ? Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                  )
                                : DataGridFromMap3(
                                    mapData: verifyList.value
                                            .map((e) => e.toJson())
                                            .toList() ??
                                        [],
                                    onload: (value) {
                                      verifyGrid = value.stateManager;
                                    },
                                    exportFileName: "Ready to Bills",
                                    hideCode: false,
                                    hideKeys: const [
                                      'v_wbs',
                                      'clcode',
                                      'agcode'
                                    ],
                                    columnAutoResize: false,
                                    widthSpecificColumn:
                                        Get.find<HomeController>()
                                            .getGridWidthByKey(
                                                userGridSettingList:
                                                    userGridSetting1?.value,
                                                key: 'key2'),
                                  ),
                          ),
                        )
                      : Obx(
                          () => Expanded(
                            child: billingValueList.isEmpty
                                ? Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                  )
                                : DataGridFromMap3(
                                    mapData: billingValueList.value
                                            .map((e) => e.toJson())
                                            .toList() ??
                                        [],
                                    hideCode: false,
                                    onload: (value) {
                                      billingValueGrid = value.stateManager;
                                    },
                                    exportFileName: "Ready to Bills",
                                    checkBoxColumnKey: const [
                                      'checked',
                                    ],
                                    checkBoxStrComparison: "true",
                                    uncheckCheckBoxStr: "false",
                                    actionIconKey: const [
                                      'checked',
                                    ],
                                    actionOnPress: (position, isSpaceCalled) {
                                      lastSelectedIdx = billingValueGrid
                                              ?.refRows[position.rowIdx ?? 0]
                                              .sortIdx ??
                                          0;
                                      if (isSpaceCalled) {
                                        if (billingValueGrid != null) {
                                          billingValueGrid?.changeCellValue(
                                            billingValueGrid!.currentCell!,
                                            billingValueGrid!
                                                        .currentCell!.value ==
                                                    "true"
                                                ? "false"
                                                : "true",
                                            force: true,
                                            callOnChangedEvent: true,
                                            notify: true,
                                          );
                                        }
                                      }
                                    },
                                    onEdit: (event) {
                                      lastSelectedIdx = billingValueGrid
                                              ?.refRows[event.rowIdx ?? 0]
                                              .sortIdx ??
                                          0;
                                      if (event.columnIdx == 1) {
                                        billingValueList[lastSelectedIdx]
                                            .checked = (event.value == "true");
                                      }
                                    },
                                    columnAutoResize: false,
                                    widthSpecificColumn:
                                        Get.find<HomeController>()
                                            .getGridWidthByKey(
                                                userGridSettingList:
                                                    userGridSetting1?.value,
                                                key: 'key3'),
                                  ),
                          ),
                        ),
                  Row(
                    children: [
                      Obx(() {
                        return CheckBoxWidget1(
                          title: "Set all selected Rows",
                          value: isSelectecRows.value,
                          onChanged: (val) {
                            isSelectecRows.value = !(isSelectecRows.value);
                          },
                        );
                      }),
                      const Expanded(child: SizedBox()),
                      FormButtonWrapper(
                        btnText: "Send To SAP",
                        callback: () {
                          sendToSap();
                        },
                        showIcon: false,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      FormButtonWrapper(
                        btnText: "Back",
                        callback: () {
                          Get.back();
                        },
                        showIcon: false,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      FormButtonWrapper(
                        btnText: "Resend To SAP",
                        callback: () {
                          LoadingDialog.recordExists(
                            'Want to resend data to SAP.',
                            () {
                              resendToSap();
                            },
                          );
                        },
                        showIcon: false,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  filterList() {
    if (isTrueFalseFiltter.isTrue) {
      isTrueFalseFiltter.value = false;
      billingsList.sort((a, b) {
        if (a.remark!.isEmpty != b.remark!.isEmpty) {
          return a.remark!.isEmpty ? -1 : 1; // empty remarks first
        } else if (a.asRunImport != b.asRunImport) {
          return a.asRunImport! ? 1 : -1; // false first
        } else {
          return a.telecastDate!.compareTo(
              b.telecastDate!); // Sort by date if val and remarks are the same
        }
      });
    } else {
      isTrueFalseFiltter.value = true;
      billingsList.sort((a, b) {
        if (a.remark!.isEmpty != b.remark!.isEmpty) {
          return a.remark!.isEmpty ? 1 : -1; // empty remarks first
        } else if (a.asRunImport != b.asRunImport) {
          return a.asRunImport! ? -1 : 1; // false first
        } else {
          return a.telecastDate!.compareTo(
              b.telecastDate!); // Sort by date if val and remarks are the same
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
        Get.delete<ReadytoBillsController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Verify":
        verify();
        break;
      case "Billing Value":
        billingValue();
        break;
      case "Export":
        export();
        break;
      case "Exit":
        Get.find<HomeController>().postUserGridSetting1(listStateManager: [
          billingGrid,
          verifyGrid,
          billingValueGrid,
        ], tableNamesList: [
          'key1',
          'key2',
          'key3',
        ]);
        break;
    }
  }
}
