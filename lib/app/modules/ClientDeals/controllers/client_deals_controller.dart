import 'dart:async';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';
import '../AgencyLeaveModel.dart';
import '../ClientDealRetrieveModel.dart';

class ClientDealsController extends GetxController {
  //TODO: Implement ClientDealsController

  final count = 0.obs;
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  Rx<TextEditingController> duration = TextEditingController().obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> clientList = RxList([]);
  RxList<DropDownValue> agencyList = RxList([]);
  RxList<DropDownValue> brandList = RxList([]);
  RxList<DropDownValue> bandList = RxList([]);
  // RxList<DropDownValue> brandList2 = RxList([]);
  RxList<DropDownValue> accountList = RxList([]);
  RxList<DropDownValue> subTypeList = RxList([]);
  RxList<DropDownValue> spotTypeList = RxList([]);
  RxList<DropDownValue> programList = RxList([]);
  RxList<DropDownValue> addInfoList = RxList([]);
  RxList<DropDownValue> clientList2 = RxList([]);
  RxList<DropDownValue> payMode = RxList([]);
  RxList<DropDownValue> currency = RxList([]);
  RxList<DropDownValue> locationList2 = RxList([]);
  RxList<DropDownValue> dealType = RxList([]);
  RxList<DropDownValue> channelList2 = RxList([]);
  RxList<AddInfo> infoDiaLogList = RxList([]);
  RxList<dynamic> dealNoList = RxList([]);
  RxList<dynamic> remarkList = RxList([]);

  Rxn<DropDownValue>? selectedLocation = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedLocation2 = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedChannel = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedChannel2 = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedClient = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedClient2 = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectPayMode = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectCurrency = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectBrand = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectBand = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectBrand2 = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectAgency = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectDealType = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectAccount = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectSubType = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectSpotType = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectProgram = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectAddInfo = Rxn<DropDownValue>(null);

  TextEditingController dealNoController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController referenceDateController = TextEditingController();
  TextEditingController maxSpeedController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController secondsController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController bkDurationController = TextEditingController();
  TextEditingController bkAmountController = TextEditingController();
  TextEditingController textFormFieldController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController secondsController2 = TextEditingController();
  TextEditingController ratePerTenSecondsController = TextEditingController();
  TextEditingController amountController2 = TextEditingController();
  TextEditingController valueRateController = TextEditingController();
  TextEditingController remarkDiaController = TextEditingController();

  Rx<bool> effectiveRate = Rx<bool>(false);
  Rx<bool> type = Rx<bool>(false);
  Rx<bool> weekDay = Rx<bool>(false);
  Rx<bool> weekEnd = Rx<bool>(false);
  Rx<bool> mon = Rx<bool>(false);
  Rx<bool> tue = Rx<bool>(false);
  Rx<bool> wed = Rx<bool>(false);
  Rx<bool> thu = Rx<bool>(false);
  Rx<bool> fri = Rx<bool>(false);
  Rx<bool> sat = Rx<bool>(false);
  Rx<bool> sun = Rx<bool>(false);

  Rx<bool> accountEnaSta = Rx<bool>(false);

  FocusNode channelFocus = FocusNode();
  FocusNode locationFocus = FocusNode();
  FocusNode dealNoFocus = FocusNode();
  FocusNode dateFocus = FocusNode();
  FocusNode fromFocus = FocusNode();
  FocusNode toFocus = FocusNode();
  FocusNode clientFocus = FocusNode();
  FocusNode agencyFocus = FocusNode();

  ScrollController scrollController = ScrollController();
  Rx<int> selectedDealNo = Rx<int>(0);
  PlutoGridStateManager? stateManager;
  PlutoGridStateManager? remarkStateManager;
  PlutoGridStateManager? addInfoStateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1 = [];
  Rx<String> agencyGstNumber = Rx<String>("");
  Rx<String> agencyPanNumber = Rx<String>("");
  Rx<String> clientEmbargo = Rx<String>("");
  Rx<String> executive = Rx<String>("");
  Rx<String> payroute = Rx<String>("");
  Rx<String> zone = Rx<String>("");
  Rx<String> gstPlantName = Rx<String>("");

  var canDialogShow = false.obs;
  Widget? dialogWidget;
  Rxn<int> initialOffset = Rxn<int>(null);
  Completer<bool>? completerDialog;
  AgencyLeaveDataModel? agencyLeaveDataModel;

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  getAllLoadData() {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.Client_Deal_GET_LOAD,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['onload'] != null) {
              if (map['onload']['location'] != null && map['onload']['location'].length > 0) {
                locationList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['location'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "locationCode", "locationName"));
                });
                locationList.addAll(dataList);
                locationList.refresh();
              }

              if (map['onload']['dealTypeMaster'] != null &&
                  map['onload']['dealTypeMaster'].length > 0) {
                dealType.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['dealTypeMaster'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "dealtypecode", "dealtypename"));
                });
                dealType.addAll(dataList);
                dealType.refresh();
              }

              if (map['onload']['currencyTypeMaster'] != null &&
                  map['onload']['currencyTypeMaster'].length > 0) {
                currency.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['currencyTypeMaster'].forEach((e) {
                  dataList.add(
                      DropDownValue.fromJsonDynamic(e, "currencyTypeCode", "currencyTypeName"));
                });
                currency.addAll(dataList);
                currency.refresh();
              }

              if (map['onload']['searchLocation'] != null &&
                  map['onload']['searchLocation'].length > 0) {
                locationList2.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['searchLocation'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "locationcode", "locationname"));
                });
                locationList2.addAll(dataList);
                locationList2.refresh();
              }

              if (map['onload']['searchChannel'] != null &&
                  map['onload']['searchChannel'].length > 0) {
                channelList2.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['searchChannel'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "channelcode", "channelname"));
                });
                channelList2.addAll(dataList);
                channelList2.refresh();
              }

              if (map['onload']['sponsorTypeMaster'] != null &&
                  map['onload']['sponsorTypeMaster'].length > 0) {
                spotTypeList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['sponsorTypeMaster'].forEach((e) {
                  dataList
                      .add(DropDownValue.fromJsonDynamic(e, "sponsorTypeCode", "sponsorTypeName"));
                });
                spotTypeList.addAll(dataList);
                spotTypeList.refresh();
              }

              if (map['onload']['accountDetails'] != null &&
                  map['onload']['accountDetails'].length > 0) {
                accountList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['accountDetails'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "accountcode", "accountname"));
                });
                accountList.addAll(dataList);
                accountList.refresh();
              }
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  getChannel({String? locationCode}) {
    print(">>>>locationCode" + locationCode.toString());
    if (locationCode != null && locationCode != "") {
      try {
        LoadingDialog.call();
        // Map<String,dynamic> postData = {};
        Get.find<ConnectorControl>().GETMETHODCALL(
            api: ApiFactory.Client_Deal_GET_CHANNEL + locationCode,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map && map['channel'] != null && map['channel'].length > 0) {
                channelList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['channel'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "channelcode", "channelName"));
                });
                channelList.addAll(dataList);
                channelList.refresh();
              } else {
                channelList.clear();
              }
            },
            failed: (map) {
              closeDialogIfOpen();
            });
      } catch (e) {
        closeDialogIfOpen();
      }
    }
  }

  getSubType({String? accountCode}) {
    if (accountCode != null && accountCode != "") {
      try {
        LoadingDialog.call();
        // Map<String,dynamic> postData = {};
        Get.find<ConnectorControl>().GETMETHODCALL(
            api: ApiFactory.Client_Deal_GET_SUBTYPE + accountCode,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map && map['subType'] != null && map['subType'].length > 0) {
                subTypeList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['subType'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "eventcode", "eventname"));
                });
                subTypeList.addAll(dataList);
                subTypeList.refresh();
              } else {
                subTypeList.clear();
              }
            },
            failed: (map) {
              closeDialogIfOpen();
            });
      } catch (e) {
        closeDialogIfOpen();
      }
    }
  }

  Future<String> clientsLeave() {
    Completer<String> completer = Completer<String>();
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "clientCode": selectedClient?.value?.key ?? "",
        "locationCode": selectedLocation?.value?.key ?? "",
        "channelCode": selectedChannel?.value?.key ?? ""
      };
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.Client_Deal_GET_CLIENTS_LEAVE,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map) {
              if (map['clientLeaveModel'] != null &&
                  map['clientLeaveModel']['agency'] != null &&
                  map['clientLeaveModel']['agency'].length > 0) {
                agencyList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['clientLeaveModel']['agency'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "agencycode", "agencyName"));
                });
                selectAgency?.value = null;
                agencyList.addAll(dataList);
                agencyList.refresh();
                selectAgency?.refresh();
              }
              if (map['clientLeaveModel'] != null &&
                  map['clientLeaveModel']['brand'] != null &&
                  map['clientLeaveModel']['brand'].length > 0) {
                brandList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['clientLeaveModel']['brand'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "brandcode", "brandname"));
                });
                brandList.addAll(dataList);
                brandList.refresh();
              }
              clientEmbargo.value = map['clientLeaveModel']['clientEmbargo'];
            } else {}
            completer.complete("");
          },
          failed: (map) {
            closeDialogIfOpen();
            completer.complete("");
          });
    } catch (e) {
      closeDialogIfOpen();
      completer.complete("");
    }
    return completer.future;
  }

  Future<String> agencyLeave() {
    Completer<String> completer = Completer<String>();
    try {
      if (selectAgency?.value?.key != null && selectAgency?.value?.key != "") {
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "clientCode": selectedClient?.value?.key ?? "",
          "locationCode": selectedLocation?.value?.key ?? "",
          "channelCode": selectedChannel?.value?.key ?? "",
          "dealNumber": dealNoController.text ?? "",
          "agencyCode": selectAgency?.value?.key ?? "",
          "intNewEntry": (clientDealRetrieveModel?.agencyLeaveModel != null &&
                  clientDealRetrieveModel?.agencyLeaveModel?.retrieve != null)
              ? "1"
              : "0",
          "currencyTypeCode": selectCurrency?.value?.key ?? ""
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.Client_Deal_GET_AGENCY_LEAVE,
            json: postData,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map && map['agencyLeaveModel'] != null) {
                agencyLeaveDataModel = AgencyLeaveDataModel.fromJson(map as Map<String, dynamic>);
                if (map['agencyLeaveModel']['paymentModels'] != null &&
                    map['agencyLeaveModel']['paymentModels'].length > 0) {
                  RxList<DropDownValue> dataList = RxList([]);
                  payMode.clear();
                  map['agencyLeaveModel']['paymentModels'].forEach((e) {
                    dataList.add(
                        DropDownValue.fromJsonDynamic(e, "paymentmodecode", "paymentmodecaption"));
                  });
                  payMode.addAll(dataList);
                  if (payMode.length > 0) {
                    selectPayMode?.value =
                        DropDownValue(key: payMode[0].key, value: payMode[0].value);
                  }
                  payMode.refresh();
                }
                executive.value = agencyLeaveDataModel?.agencyLeaveModel?.personnelname ?? "";
                zone.value = agencyLeaveDataModel?.agencyLeaveModel?.zonename ?? "";
                payroute.value = agencyLeaveDataModel?.agencyLeaveModel?.payroutename ?? "";
                gstPlantName.value = agencyLeaveDataModel?.agencyLeaveModel?.plantname ?? "";
                agencyGstNumber.value = agencyLeaveDataModel?.agencyLeaveModel?.gst ?? "";
                agencyPanNumber.value = agencyLeaveDataModel?.agencyLeaveModel?.pan ?? "";
                for (int i = 0; i < currency.length; i++) {
                  if (currency[i].key.toString().trim() ==
                      agencyLeaveDataModel?.agencyLeaveModel?.currencyTypeCode.toString().trim()) {
                    selectCurrency?.value =
                        DropDownValue(value: currency[i].value, key: currency[i].key);
                    selectCurrency?.refresh();
                    break;
                  }
                }

                if (agencyLeaveDataModel?.agencyLeaveModel?.remark != null &&
                    agencyLeaveDataModel?.agencyLeaveModel?.remark != "") {
                  remarkList.clear();
                  remarkList.add({"remark": agencyLeaveDataModel?.agencyLeaveModel?.remark ?? ""});
                  remarkList.refresh();
                }
              } else {
                agencyLeaveDataModel = null;
              }
              completer.complete("");
            },
            failed: (map) {
              closeDialogIfOpen();
              completer.complete("");
            });
      } else {
        completer.complete("");
      }
    } catch (e) {
      closeDialogIfOpen();
      completer.complete("");
    }
    return completer.future;
  }

  channelLeave({String? netCode}) {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "dealDate": Utils.getMMDDYYYYFromDDMMYYYYInString(dateController.text ?? ""),
        "locationCode": selectedLocation?.value?.key ?? "",
        "channelCode": selectedChannel?.value?.key ?? ""
      };
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.Client_Deal_GET_CHANNEL_LEAVE,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map) {
              if (map['channelLeaveModel'] != null &&
                  map['channelLeaveModel']['dealNumber'] != null &&
                  map['channelLeaveModel']['dealNumber'] != "") {
                dealNoController.text = map['channelLeaveModel']['dealNumber'] ?? "";
              }
              if (map['channelLeaveModel'] != null &&
                  map['channelLeaveModel']['timeBand'] != null &&
                  map['channelLeaveModel']['timeBand'].length > 0) {
                bandList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['channelLeaveModel']['timeBand'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "timeband", "description"));
                });
                bandList.addAll(dataList);
                bandList.refresh();
              }
              if (map['channelLeaveModel'] != null &&
                  map['channelLeaveModel']['addinfo'] != null &&
                  map['channelLeaveModel']['addinfo'].length > 0) {
                addInfoList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['channelLeaveModel']['addinfo'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "netcode", "networkname"));
                });
                addInfoList.addAll(dataList);
                if (netCode != "") {
                  for (var element in addInfoList) {
                    if (element.key.toString().trim() == netCode.toString().trim()) {
                      selectAddInfo?.value = DropDownValue(key: element.key, value: element.value);
                      selectAddInfo?.refresh();
                      break;
                    }
                  }
                }
                addInfoList.refresh();
              }
            } else {}
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  dealDateLeave() {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "dealdate": Utils.getMMDDYYYYFromDDMMYYYYInString(dateController.text ?? ""),
        "locationCode": selectedLocation?.value?.key ?? "",
        "channelCode": selectedChannel?.value?.key ?? ""
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.Client_Deal_GET_DEAL_DATE_LEAVE,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map) {}
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  remarkAdd() {
    remarkList.add({"remark": remarkDiaController.text});
    remarkDiaController.text = "";
    remarkList.refresh();
  }

  weekend(bool sta) {
    sat.value = sta;
    sun.value = sta;
    sat.refresh();
    sun.refresh();
  }

  weekDayFun(bool sta) {
    mon.value = sta;
    tue.value = sta;
    wed.value = sta;
    thu.value = sta;
    fri.value = sta;
    fri.refresh();
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  getSearchClient() {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "locationCode": selectedLocation2?.value?.key ?? "",
        "channelCode": selectedChannel2?.value?.key ?? ""
      };
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.Client_Deal_GET_SEARCH_CLIENT,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map) {
              if (map['model'] != null && map['model'].length > 0) {
                clientList2.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['model'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(e, "clientcode", "clientname"));
                });
                clientList2.addAll(dataList);
                clientList2.refresh();
              }
            } else {}
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  getSearchDealNumber() {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "locationCode": selectedLocation2?.value?.key ?? "",
        "channelCode": selectedChannel2?.value?.key ?? "",
        "clientCode": selectedClient2?.value?.key ?? ""
      };
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.Client_Deal_GET_SEARCH_DEAL_NUMBERS,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map) {
              if (map['model'] != null && map['model'].length > 0) {
                dealNoList.clear();
                RxList<dynamic> dataList = RxList([]);
                map['model'].forEach((e) {
                  dataList.add(e);
                });
                dealNoList.addAll(dataList);
                dealNoList.refresh();
              } else {
                dealNoList.clear();
                dealNoList.refresh();
              }
            } else {
              dealNoList.clear();
              dealNoList.refresh();
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  ClientDealRetrieveModel? clientDealRetrieveModel;
  Rx<String> linkedDealNumber = Rx<String>("sssssss");
  Rx<String> clientEmb = Rx<String>("sssssss");
  retrieveRecord(
      {String? locationCode,
      String? channelCode,
      String? dealNumber,
      String? clientCode,
      String? agencyCode}) {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "locationCode": locationCode ?? "",
        "channelCode": channelCode ?? "",
        "dealNumber": dealNumber ?? "",
        "clientcode": clientCode,
        "agencyCode": agencyCode
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.Client_Deal_RETRIVE_RECORD,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map) {
              clientDealRetrieveModel =
                  ClientDealRetrieveModel.fromJson(map as Map<String, dynamic>);
              importGridList?.clear();
              if (clientDealRetrieveModel != null &&
                  clientDealRetrieveModel?.agencyLeaveModel != null &&
                  clientDealRetrieveModel?.agencyLeaveModel?.newDetails != null &&
                  (clientDealRetrieveModel?.agencyLeaveModel?.newDetails?.length ?? 0) > 0) {
                importGridList = clientDealRetrieveModel?.agencyLeaveModel?.newDetails;
              }
              // linkedDealNumber

              if (clientDealRetrieveModel != null &&
                  clientDealRetrieveModel?.agencyLeaveModel != null) {
                try {
                  if (clientDealRetrieveModel?.agencyLeaveModel?.retrieve != null &&
                      (clientDealRetrieveModel?.agencyLeaveModel?.retrieve?.length ?? 0) > 0) {
                    for (var element in locationList) {
                      if (element.key.toString().trim() ==
                          clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].locationcode
                              .toString()
                              .trim()) {
                        selectedLocation?.value =
                            DropDownValue(value: element.value, key: element.key);
                        selectedLocation?.refresh();
                        break;
                      }
                    }

                    if (channelList.length > 0) {
                      for (var element in channelList.value) {
                        if (element.key.toString().trim() ==
                            clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].channelCode
                                .toString()
                                .trim()) {
                          selectedChannel?.value =
                              DropDownValue(value: element.value, key: element.key);
                          selectedChannel?.refresh();
                          break;
                        }
                      }
                    } else {
                      selectedChannel?.value = DropDownValue(
                          value: selectedChannel2?.value?.value ?? "",
                          key: selectedChannel2?.value?.key ?? "");
                      selectedChannel?.refresh();
                    }

                    for (var element in currency) {
                      if (element.key.toString().trim() ==
                          clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].currencytypecode
                              .toString()
                              .trim()) {
                        selectCurrency?.value =
                            DropDownValue(value: element.value, key: element.key);
                        selectCurrency?.refresh();
                        break;
                      }
                    }
                    for (var element in dealType) {
                      if (element.key.toString().trim() ==
                          clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].dealTypeCode
                              .toString()
                              .trim()) {
                        selectDealType?.value =
                            DropDownValue(value: element.value, key: element.key);
                        selectDealType?.refresh();
                        break;
                      }
                    }
                    selectedClient = selectedClient2;
                    selectedClient?.refresh();

                    clientsLeave().then((value) {
                      agencyGstNumber.value =
                          (clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].gstNumber ?? "")
                              .toString();
                      agencyPanNumber.value = (clientDealRetrieveModel
                                  ?.agencyLeaveModel?.retrieve?[0].agencyshortname ??
                              "")
                          .toString();
                      if (agencyList.length > 0) {
                        for (var element in agencyList) {
                          if (element.key.toString().trim() ==
                              clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].agencyCode
                                  .toString()
                                  .trim()) {
                            selectAgency?.value =
                                DropDownValue(value: element.value, key: element.key);
                            selectAgency?.refresh();
                            break;
                          }
                        }
                      } else {
                        selectAgency?.value = DropDownValue(
                            key: clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].agencyCode,
                            value:
                                clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].agencyName);
                        selectAgency?.refresh();
                      }

                      agencyLeave().then((value) {
                        dealNoController.text =
                            clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].dealNumber ??
                                "";
                        dateController.text = Utils.toDateFormat4(
                            clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].dealDate);
                        referenceController.text = clientDealRetrieveModel
                                ?.agencyLeaveModel?.retrieve?[0].referenceNumber ??
                            "";
                        referenceDateController.text = Utils.toDateFormat4(
                            clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].referenceDate);
                        fromDateController.text = Utils.toDateFormat4(
                            clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].fromDate);
                        toDateController.text = Utils.toDateFormat4(
                            clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].todate);
                        secondsController.text =
                            (clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].seconds ?? "0")
                                .toString();
                        amountController.text =
                            (clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].dealAmount ??
                                    "0")
                                .toString();
                        maxSpeedController.text =
                            (clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].maxspend ??
                                    "0")
                                .toString();

                        agencyPanNumber.refresh();
                        agencyGstNumber.refresh();

                        if (brandList.length > 0) {
                          for (var element in brandList) {
                            if (element.key.toString().trim() ==
                                clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].brandCode
                                    .toString()
                                    .trim()) {
                              selectBrand?.value =
                                  DropDownValue(value: element.value, key: element.key);
                              selectBrand?.refresh();
                              break;
                            }
                          }
                        } else {
                          selectBrand?.value = DropDownValue(
                              key:
                                  clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].brandCode,
                              value: "");
                          selectBrand?.refresh();
                        }

                        effectiveRate.value = (clientDealRetrieveModel
                                    ?.agencyLeaveModel?.retrieve?[0].effectiveRateYN ==
                                1)
                            ? true
                            : false;
                        effectiveRate.refresh();
                      });
                    });
                  }
                } catch (e) {}
              }

              if (clientDealRetrieveModel?.agencyLeaveModel?.linkedDealNumber != null &&
                  clientDealRetrieveModel?.agencyLeaveModel?.linkedDealNumber != "") {
                linkedDealNumber.value =
                    "Linked Deal Number  ${clientDealRetrieveModel?.agencyLeaveModel?.linkedDealNumber}";
                clientEmb.value = "Client Emb";
                clientEmb.refresh();
                linkedDealNumber.refresh();
              } else {
                linkedDealNumber.value = "sssssss";
                clientEmb.value = "sssssss";
                clientEmb.refresh();
                linkedDealNumber.refresh();
              }

              update(["grid"]);
            } else {
              clientDealRetrieveModel = null;
            }
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  Offset? getOffSetValue(BoxConstraints constraints) {
    switch (initialOffset.value) {
      case 1:
        return Offset((constraints.maxWidth / 3) + 30, constraints.maxHeight / 3);
      case 2:
        return Offset(Get.width * 0.09, Get.height * 0.12);
      case 3:
        return const Offset(20, 20);
      default:
        return null;
    }
  }

  remarkDialog() {}

  @override
  void onInit() {
    dealNoFocus = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          if (dealNoController.text != "") {
            retrieveRecord(
                dealNumber: dealNoController.text,
                agencyCode: selectAgency?.value?.key,
                clientCode: selectedClient?.value?.key,
                channelCode: selectedChannel?.value?.key,
                locationCode: selectedLocation?.value?.key);
          }

          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
    fetchUserSetting1();
    super.onInit();
  }

  Rx<String> address = Rx<String>("");

  getAgencyAddress({String? code}) {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: "${ApiFactory.Client_Deal_GET_AGENCY_ADDRESS}?AgencyCode=$code",
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['model'] != null) {
              address.value = map['model'];
              address.refresh();
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  getClientAddress({String? code}) {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: "${ApiFactory.Client_Deal_GET_CLIENT_ADDRESS}?clientCode=$code",
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['model'] != null) {
              address.value = map['model'];
              address.refresh();
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  pickFile() async {
    LoadingDialog.call();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['xlsx', 'xls'],
      type: FileType.custom,
    );
    closeDialogIfOpen();
    if (result != null && result.files.single != null) {
      // print(">>>>>>filename"+(result.files[0].name.toString()));
      // pathController.text = result.files[0].name.toString();

      loadBtn(result);
    } else {
      LoadingDialog.showErrorDialog("Please try again");
      // User canceled the pic5ker
      print(">>>>dataCancel");
    }
  }

  loadBtn(FilePickerResult result) {
    LoadingDialog.call();
    var jsonData = <String, dynamic>{};
    try {
      Uint8List? fileBytes = result.files.first.bytes;
      var excel = Excel.decodeBytes(result.files.first.bytes as List<int>);
      List<dynamic> headers = [];
      int sheet = 0;
      var excelDataList = <Map<String, dynamic>>[];
      for (var table in excel.tables.keys) {
        var tableData = <Map<String, dynamic>>[];
        sheet = sheet + 1;
        // Extract headers from the first row
        headers = excel.tables[table]!.row(0).map((cell) => cell?.value.toString()).toList();

        print(">>>>>" + headers.toString());

        for (var rowIdx = 1; rowIdx <= excel.tables[table]!.maxRows; rowIdx++) {
          var rowData = <String, dynamic>{};
          var row = excel.tables[table]!.row(rowIdx);
          for (var colIdx = 0; colIdx < row.length; colIdx++) {
            var header = headers[colIdx];
            var cellValue = row[colIdx]?.value.toString();
            rowData[header ?? ""] = cellValue;
          }
          if (rowData.isNotEmpty) {
            tableData.add(rowData);
          }
        }
        jsonData['S${sheet}'] = tableData;
        excelDataList = tableData;
        print(">>>>jsonData $jsonData");
        closeDialogIfOpen();
      }
      List<String> sourceList = [
        "Recordnumber",
        "SponsorTypeName",
        "ProgramName",
        "Starttime",
        "EndTime",
        "Seconds",
        "Rate",
        "Amount",
        "ValuationRate",
        "BookedSeconds",
        "BalanceSeconds",
        "BalanceAmount",
        "TimeBand",
        "NetWorkName",
        "Sun",
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat",
        "Accountname",
        "Eventname",
        "Spots",
        "Paymentmodecaption",
        "RevenueTypeName",
        "SubRevenueTypeName",
        "CountBased",
        "BaseDuration"
      ];
      // List<String> list2 = [ "ku","jks"];
      List<dynamic> sta = Utils.listCompare(sourceList: sourceList, compareLst: headers);
      print(">>>>>>>>>sta$sta");
      if (!sta[0]) {
        LoadingDialog.showErrorDialog(sta[1] ?? "");
      } else {
        callValidationFun(excelData: excelDataList);
      }
    } catch (e) {
      print(">>>>" + e.toString());
      // gridData = RateCardFromDealWorkFlowModel(export: []);
      closeDialogIfOpen();
      update(['grid']);
      LoadingDialog.showErrorDialog(e.toString());
    }
  }

  bool checkImport = false;
  List<NewDetails>? importGridList = [];

  callValidationFun({List<Map<String, dynamic>>? excelData}) {
    LoadingDialog.modify("Do you wish to import file ?", () {}, () {
      btnImportClickWithCondition(excelDataNew: excelData);
    }, cancelTitle: "Yes", deleteTitle: "No");
  }

  Future<Map<String, dynamic>> getAllCode(
      {String? sponsorTypeName,
      String? programName,
      String? timeBandName,
      String? networkName,
      String? accountName,
      String? eventName}) {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    LoadingDialog.call();
    try {
      Map<String, dynamic> postData = {
        "sponsorTypeName": sponsorTypeName,
        "programName": programName,
        "timeBand": timeBandName,
        "netWorkName": networkName,
        "accountname": accountName,
        "eventname": eventName
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.Client_Deal_GET_EACH_VALUE_IMPORT,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['model'] != null) {
              completer.complete(map as FutureOr<Map<String, dynamic>>?);
            } else {
              completer.complete({
                "sponsorTypeCode": "",
                "programCode": "",
                "bandCode": "",
                "netCode": "",
                "accountCode": "",
                "eventcode": ""
              });
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            completer.complete({
              "sponsorTypeCode": "",
              "programCode": "",
              "bandCode": "",
              "netCode": "",
              "accountCode": "",
              "eventcode": ""
            });
          });
    } catch (e) {
      closeDialogIfOpen();
      completer.complete({
        "sponsorTypeCode": "",
        "programCode": "",
        "bandCode": "",
        "netCode": "",
        "accountCode": "",
        "eventcode": ""
      });
    }
    return completer.future;
  }

  List<NewDetails>? importGridListNew = [];
  btnImportClickWithCondition({List<Map<String, dynamic>>? excelDataNew}) async {
    checkImport = false;
    importGridListNew?.clear();
    if (dealNoController.text.trim() == "") {
      LoadingDialog.showErrorDialog("Deal Number Can't be blank");
      return;
    }
    if (excelDataNew != null && excelDataNew.isNotEmpty) {
      for (int i = 0; i < (excelDataNew.length); i++) {
        if (excelDataNew[i]['SponsorTypeName'].toString().trim() == "") {
          bool sta = await ignoreBlankRow();
          if (sta == false) {
            return;
          }
          // continue;
        }
        if (excelDataNew[i]['Rate'] == 0 &&
            excelDataNew[i]['Seconds'] == 0 &&
            excelDataNew[i]['Amount'] == 0 &&
            excelDataNew[i]['ValuationRate'] == 0) {
          return;
        }

        Map<String, dynamic> allCode = await getAllCode(
            programName: excelDataNew[i]['ProgramName'],
            accountName: excelDataNew[i]['Accountname'],
            eventName: excelDataNew[i]['Eventname'],
            networkName: excelDataNew[i]['NetWorkName'],
            sponsorTypeName: excelDataNew[i]['SponsorTypeName'],
            timeBandName: excelDataNew[i]['TimeBand']);

        NewDetails newDetails = NewDetails(
          primaryEventCode: (excelDataNew[i]['Amount'] != "") ? "1" : "0",
          recordnumber: "",
          sponsorTypeName: excelDataNew[i]['SponsorTypeName'],
          programName: excelDataNew[i]['ProgramName'],
          programCategoryCode: "",
          starttime: "we need to check",
          endTime: "we need to check",
          seconds: excelDataNew[i]['Seconds'],
          rate: excelDataNew[i]['Rate'],
          amount: excelDataNew[i]['Amount'],
          valuationRate: excelDataNew[i]['ValuationRate'],
          bookedSeconds: excelDataNew[i]['BookedSeconds'],
          programCode: allCode['programCode'],
          sponsorTypeCode: allCode['sponsorTypeCode'],
          balanceSeconds: excelDataNew[i]['BalanceSeconds'],
          balanceAmount: excelDataNew[i]['BalanceAmount'],
          timeBand: excelDataNew[i]['TimeBand'],
          bandCode: allCode['bandCode'],
          netWorkName: excelDataNew[i]['NetWorkName'],
          sun: excelDataNew[i]['Sun'],
          mon: excelDataNew[i]['Mon'],
          tue: excelDataNew[i]['Tue'],
          wed: excelDataNew[i]['Wed'],
          thu: excelDataNew[i]['Thu'],
          fri: excelDataNew[i]['Fri'],
          sat: excelDataNew[i]['Sat'],
          revflag: "",
          spots: excelDataNew[i]['Spots'],
          paymentmodecaption: excelDataNew[i]['Paymentmodecaption'],
          revenueTypeCode: "",
          revenueTypeName: excelDataNew[i]['RevenueTypeName'],
          subRevenueTypeName: excelDataNew[i]['SubRevenueTypeName'],
          subRevenueTypeCode: "",
          countBased: excelDataNew[i]['CountBased'],
          baseDuration: excelDataNew[i]['BaseDuration'],
        );

        if ((newDetails.sponsorTypeCode).toString().trim() == "") {
          checkImport = true;
        }

        if ((newDetails.programName).toString().trim() != "") {
          if ((newDetails.programCode).toString().trim() == "") {
            checkImport = true;
          }
        }

        if (newDetails.primaryEventCode.toString().trim() == "1") {
          newDetails.accountname = excelDataNew[i]['Accountname'];
          newDetails.accountCode = allCode['accountCode'];
          if ((newDetails.accountCode).toString().trim() == "") {
            checkImport = true;
          }
          newDetails.eventname = excelDataNew[i]['Eventname'];
          newDetails.eventcode = allCode['eventcode'];
          if ((newDetails.eventcode).toString().trim() == "") {
            checkImport = true;
          }
        } else {
          newDetails.accountname = "";
          newDetails.accountCode = "";
          newDetails.eventcode = "";
          newDetails.eventname = "";
        }
        importGridListNew?.add(newDetails);
      }
    }
  }

  Future<bool> ignoreBlankRow() async {
    Completer<bool> completer = Completer<bool>();
    if (checkImport) {
      // Goto DataNotAdded
      completer.complete(false);
      return completer.future;
    }
    // importGridList
    for (int i = 0; i < (importGridListNew?.length ?? 0); i++) {
      for (int k = 0; k < (importGridList?.length ?? 0); k++) {
        if ((importGridList?.length ?? 0) > 0) {
          if ((importGridListNew?[i].primaryEventCode == importGridList?[k].primaryEventCode) &&
              (importGridListNew?[i].sponsorTypeCode == importGridList?[k].sponsorTypeCode) &&
              (importGridListNew?[i].programCode == importGridList?[k].programCode) &&
              (importGridListNew?[i].starttime == importGridList?[k].starttime) &&
              (importGridListNew?[i].endTime == importGridList?[k].endTime) &&
              (importGridListNew?[i].rate == importGridList?[k].rate) &&
              (importGridListNew?[i].valuationRate == importGridList?[k].valuationRate) &&
              (importGridListNew?[i].sun == importGridList?[k].sun) &&
              (importGridListNew?[i].mon == importGridList?[k].mon) &&
              (importGridListNew?[i].tue == importGridList?[k].tue) &&
              (importGridListNew?[i].wed == importGridList?[k].wed) &&
              (importGridListNew?[i].thu == importGridList?[k].thu) &&
              (importGridListNew?[i].fri == importGridList?[k].fri) &&
              (importGridListNew?[i].sat == importGridList?[k].sat) &&
              (importGridListNew?[i].accountCode == importGridList?[k].accountCode) &&
              (importGridListNew?[i].eventcode == importGridList?[k].eventcode)) {
            bool sta = await LoadingDialog.modifyWithAsync(
                "Similar entry already exists!\nDo you want to modify it?",
                cancelTitle: "Yes",
                deleteTitle: "No");
            if (sta) {
              bool reSta = await editRows(selectedOldIndex: 0, selectNewIndex: 0);
            } else {
              continue;
            }
          }
        }
      }
    }
    completer.complete(true);
    return completer.future;
  }

  Future<bool> editRows({required int selectedOldIndex, required int selectNewIndex}) {
    Completer<bool> completer = Completer<bool>();
    try {
      importGridList?[selectedOldIndex].primaryEventCode =
          importGridListNew?[selectNewIndex].primaryEventCode;
      importGridList?[selectedOldIndex].recordnumber = "${selectedOldIndex + 1}";
      importGridList?[selectedOldIndex].sponsorTypeCode =
          importGridListNew?[selectNewIndex].sponsorTypeCode;
      importGridList?[selectedOldIndex].sponsorTypeName =
          importGridListNew?[selectNewIndex].sponsorTypeName;
      importGridList?[selectedOldIndex].programCode =
          importGridListNew?[selectNewIndex].programCode;
      importGridList?[selectedOldIndex].programName =
          importGridListNew?[selectNewIndex].programName;
      importGridList?[selectedOldIndex].programCategoryCode =
          importGridListNew?[selectNewIndex].programCategoryCode;
      importGridList?[selectedOldIndex].starttime = importGridListNew?[selectNewIndex].starttime;
      importGridList?[selectedOldIndex].endTime = importGridListNew?[selectNewIndex].endTime;
      importGridList?[selectedOldIndex].seconds = importGridListNew?[selectNewIndex].seconds;
      importGridList?[selectedOldIndex].rate = importGridListNew?[selectNewIndex].rate;
      importGridList?[selectedOldIndex].amount = importGridListNew?[selectNewIndex].amount;
      importGridList?[selectedOldIndex].valuationRate =
          importGridListNew?[selectNewIndex].valuationRate;
      importGridList?[selectedOldIndex].bookedSeconds =
          importGridListNew?[selectNewIndex].bookedSeconds;
      importGridList?[selectedOldIndex].balanceSeconds =
          importGridListNew?[selectNewIndex].balanceSeconds;
      importGridList?[selectedOldIndex].balanceAmount =
          importGridListNew?[selectNewIndex].balanceAmount;
      importGridList?[selectedOldIndex].bandCode = importGridListNew?[selectNewIndex].bandCode;
      importGridList?[selectedOldIndex].timeBand = importGridListNew?[selectNewIndex].timeBand;
      importGridList?[selectedOldIndex].netCode = importGridListNew?[selectNewIndex].netCode;
      importGridList?[selectedOldIndex].netWorkName =
          importGridListNew?[selectNewIndex].netWorkName;
      importGridList?[selectedOldIndex].sun = importGridListNew?[selectNewIndex].sun;
      importGridList?[selectedOldIndex].mon = importGridListNew?[selectNewIndex].mon;
      importGridList?[selectedOldIndex].tue = importGridListNew?[selectNewIndex].tue;
      importGridList?[selectedOldIndex].wed = importGridListNew?[selectNewIndex].wed;
      importGridList?[selectedOldIndex].thu = importGridListNew?[selectNewIndex].thu;
      importGridList?[selectedOldIndex].fri = importGridListNew?[selectNewIndex].fri;
      importGridList?[selectedOldIndex].sat = importGridListNew?[selectNewIndex].sat;
      importGridList?[selectedOldIndex].revflag = importGridListNew?[selectNewIndex].revflag;
      importGridList?[selectedOldIndex].accountCode =
          importGridListNew?[selectNewIndex].accountCode;
      importGridList?[selectedOldIndex].accountname =
          importGridListNew?[selectNewIndex].accountname;
      importGridList?[selectedOldIndex].eventcode = importGridListNew?[selectNewIndex].eventcode;
      importGridList?[selectedOldIndex].eventname = importGridListNew?[selectNewIndex].eventname;
      importGridList?[selectedOldIndex].spots = importGridListNew?[selectNewIndex].spots;
      importGridList?[selectedOldIndex].paymentmodecaption =
          importGridListNew?[selectNewIndex].paymentmodecaption;
      importGridList?[selectedOldIndex].revenueTypeName =
          importGridListNew?[selectNewIndex].revenueTypeName;
      importGridList?[selectedOldIndex].revenueTypeCode =
          importGridListNew?[selectNewIndex].revenueTypeCode;
      importGridList?[selectedOldIndex].subRevenueTypeCode =
          importGridListNew?[selectNewIndex].subRevenueTypeCode;
      importGridList?[selectedOldIndex].subRevenueTypeName =
          importGridListNew?[selectNewIndex].subRevenueTypeName;
      importGridList?[selectedOldIndex].countBased = importGridListNew?[selectNewIndex].countBased;
      importGridList?[selectedOldIndex].baseDuration =
          importGridListNew?[selectNewIndex].baseDuration;

      secondsController.text = colTotal("seconds");
      amountController.text = colTotal("amount");

      if (double.parse(amountController.text ?? "0") > 0) {
        maxSpeedController.text = amountController.text;
      }

      completer.complete(true);
    } catch (e) {
      completer.complete(false);
    }
    return completer.future;
  }

  String colTotal(String col) {
    double amt = 0;
    try {
      if (col == "amount") {
        for (int i = 0; i < (importGridList?.length ?? 0); i++) {
          amt = amt + double.parse(importGridList?[i].amount ?? "0");
        }
      } else {
        for (int i = 0; i < (importGridList?.length ?? 0); i++) {
          amt = amt + double.parse(importGridList?[i].seconds ?? "0");
        }
      }

      return amt.toStringAsFixed(3);
    } catch (e) {
      return amt.toStringAsFixed(3);
    }
  }

  primarySecondaryEvent(bool sta) {
    if (sta == true) {
      accountEnaSta.value = true;
      accountEnaSta.refresh();
    } else {
      accountEnaSta.value = false;
      selectAccount?.value = null;
      selectSubType?.value = null;
      accountEnaSta.refresh();
    }
  }

  String? sponsorTypeCode = "";

  Future<String> doubleTap({required int selectedIndex}) {
    Completer<String> completer = Completer<String>();

    if (stateManager != null && selectedIndex != -1) {
      if (stateManager?.rows[selectedIndex].cells['accountCode']?.value == "" ||
          stateManager?.rows[selectedIndex].cells['accountCode']?.value == null) {
        if (stateManager?.rows[selectedIndex].cells['seconds']?.value.toString() != "0") {
          type.value = false;
          type.refresh();
          secondsController2.text =
              (stateManager?.rows[selectedIndex].cells['bookedSeconds']?.value ?? "").toString();
          primarySecondaryEvent(type.value);
          // secondsController2
        }
        // cboDbandcode.Enabled = True
        // cboDnetcode.Enabled = True
      } else {
        if (stateManager?.rows[selectedIndex].cells['seconds']?.value.toString() != "0") {
          type.value = true;
          type.refresh();
          secondsController2.text =
              (stateManager?.rows[selectedIndex].cells['seconds']?.value ?? "").toString();
          primarySecondaryEvent(type.value);
        }
      }

      print("I am from controller");
      channelLeave(netCode: stateManager?.rows[selectedIndex].cells['netCode']?.value ?? "");

      txtDRecordNumber.value =
          (stateManager?.rows[selectedIndex].cells['recordnumber']?.value ?? "").toString();

      sponsorTypeCode =
          (stateManager?.rows[selectedIndex].cells['SponsorTypeCode']?.value ?? "").toString();

      selectSpotType?.value = DropDownValue(
          key: (stateManager?.rows[selectedIndex].cells['SponsorTypeCode']?.value ?? "").toString(),
          value:
              (stateManager?.rows[selectedIndex].cells['sponsorTypeName']?.value ?? "").toString());

      selectProgram?.value = DropDownValue(
          key: (stateManager?.rows[selectedIndex].cells['programCode']?.value ?? "").toString(),
          value: (stateManager?.rows[selectedIndex].cells['programName']?.value ?? "").toString());

      startTime.text =
          (stateManager?.rows[selectedIndex].cells['starttime']?.value ?? "").toString();
      endTime.text = (stateManager?.rows[selectedIndex].cells['endTime']?.value ?? "").toString();

      ratePerTenSecondsController.text =
          (stateManager?.rows[selectedIndex].cells['rate']?.value ?? "").toString();
      valueRateController.text =
          (stateManager?.rows[selectedIndex].cells['valuationRate']?.value ?? "").toString();
      amountController2.text =
          (stateManager?.rows[selectedIndex].cells['amount']?.value ?? "").toString();
      selectBand?.value = DropDownValue(
          value: (stateManager?.rows[selectedIndex].cells['timeBand']?.value ?? "").toString(),
          key: (stateManager?.rows[selectedIndex].cells['bandcode']?.value ?? "").toString());

      print(">>>>>>>>>>>>>>sat${stateManager?.rows[selectedIndex].cells['sun']?.value ?? ""}");
      print(">>>>>>>>>>>>>>amt${stateManager?.rows[selectedIndex].cells['Amount']?.value ?? ""}");

      sun.value = getBoolean(
          staData: (stateManager?.rows[selectedIndex].cells['sun']?.value ?? "").toString());
      mon.value = getBoolean(
          staData: (stateManager?.rows[selectedIndex].cells['mon']?.value ?? "").toString());
      tue.value = getBoolean(
          staData: (stateManager?.rows[selectedIndex].cells['tue']?.value ?? "").toString());
      wed.value = getBoolean(
          staData: (stateManager?.rows[selectedIndex].cells['wed']?.value ?? "").toString());
      thu.value = getBoolean(
          staData: (stateManager?.rows[selectedIndex].cells['thu']?.value ?? "").toString());
      fri.value = getBoolean(
          staData: (stateManager?.rows[selectedIndex].cells['fri']?.value ?? "").toString());
      sat.value = getBoolean(
          staData: (stateManager?.rows[selectedIndex].cells['sat']?.value ?? "").toString());

      type.value =
          ((stateManager?.rows[selectedIndex].cells['primaryEventCode']?.value ?? "").toString() ==
                  "1")
              ? true
              : false;
      type.refresh();

      if ((stateManager?.rows[selectedIndex].cells['primaryEventCode']?.value ?? "").toString() ==
          "1") {
        selectAccount?.value = DropDownValue(
            value: stateManager?.rows[selectedIndex].cells['accountname']?.value ?? "",
            key: stateManager?.rows[selectedIndex].cells['accountCode']?.value ?? "");
        getSubType(accountCode: selectAccount?.value?.key ?? "");

        selectSubType?.value = DropDownValue(
            value: stateManager?.rows[selectedIndex].cells['eventname']?.value ?? "",
            key: stateManager?.rows[selectedIndex].cells['eventcode']?.value ?? "");

        selectSubType?.refresh();
        selectAccount?.refresh();
      }

      update(['middle']);
      completer.complete("");
      return completer.future;
    } else {
      completer.complete("");
      return completer.future;
    }
  }

  btnClearClick() {
    type.value = false;
    accountEnaSta.value = false;
    selectAccount?.value = null;
    selectSubType?.value = null;
    selectSpotType?.value = null;
    selectProgram?.value = null;
    selectBrand?.value = null;
    selectAddInfo?.value = null;
    weekDay.value = false;
    weekEnd.value = false;
    mon.value = false;
    tue.value = false;
    wed.value = false;
    thu.value = false;
    fri.value = false;
    sat.value = false;
    sun.value = false;
    startTime.text = "00:00:00:00";
    endTime.text = "00:00:00:00";
    secondsController2.text = "0";
    ratePerTenSecondsController.text = "0";
    amountController2.text = "0";
    valueRateController.text = "0";
    txtDRecordNumber.value = "0";
    type.refresh();
    update(['middle']);
  }

  btnDuplicateClick({required int selectedInd}) {
    if (stateManager == null || (stateManager?.rows.length ?? 0) <= 0) {
      return;
    }
    doubleTap(selectedIndex: selectedInd).then((value) {
      txtDRecordNumber.value = "0";
    });
  }

  bool getBoolean({String? staData}) {
    print(">>>>>>>>>>>>>>sat$staData");
    if (staData != null && staData.toString().trim() == "1") {
      return true;
    } else {
      return false;
    }
  }

  Rx<String> txtDRecordNumber = Rx<String>("0");

  addBtn() async {
    if (valueRateController.text.trim() == "0" &&
        secondsController2.text.trim() == "0" &&
        amountController2.text.trim() == "0") {
      return;
    }

    if (selectAddInfo?.value == null) {
      return;
    }

    if (type.value == true) {
      if (selectAccount == null ||
          selectSubType == null ||
          selectAccount?.value == null ||
          selectSubType?.value == null) {
        LoadingDialog.showErrorDialog1(
            "Please select the accountcode and eventtype for secondary events!",
            callback: () {});
        return;
      }
    }

    if ((txtDRecordNumber.value ?? "").toString().trim() != "0") {
      LoadingDialog.modify2("This Record Already exists!\nDo you want to modify it?", () {
        for (int i = 0; i < (importGridList?.length ?? 0); i++) {
          if (importGridList?[i].recordnumber.toString().toLowerCase().trim() ==
              (txtDRecordNumber.value ?? "0").toString().toLowerCase().trim()) {
            addEdit(i);
            break;
          }
        }
      }, () {
        return;
      }, deleteTitle: "Yes", cancelTitle: "No");
    } else {
      for (int i = 0; i < (importGridList?.length ?? 0); i++) {
        if ((getOneZero(sta: type.value) == importGridList?[i].primaryEventCode) &&
            ((selectSpotType?.value?.key ?? "").toString().trim() ==
                (importGridList?[i].sponsorTypeCode ?? "").toString().trim()) &&
            ((selectProgram?.value?.key ?? "").toString().trim() ==
                (importGridList?[i].programCode ?? "").toString().trim()) &&
            (startTime.text == (importGridList?[i].starttime ?? "").toString().trim()) &&
            (endTime.text == (importGridList?[i].endTime ?? "").toString().trim()) &&
            (ratePerTenSecondsController.text.toString().trim() ==
                (importGridList?[i].rate ?? "").toString().trim()) &&
            (valueRateController.text.toString().trim() ==
                (importGridList?[i].valuationRate ?? "").toString().trim()) &&
            (getOneZero(sta: sun.value) == (importGridList?[i].sun ?? "").toString().trim()) &&
            (getOneZero(sta: mon.value) == (importGridList?[i].mon ?? "").toString().trim()) &&
            (getOneZero(sta: tue.value) == (importGridList?[i].tue ?? "").toString().trim()) &&
            (getOneZero(sta: wed.value) == (importGridList?[i].wed ?? "").toString().trim()) &&
            (getOneZero(sta: thu.value) == (importGridList?[i].fri ?? "").toString().trim()) &&
            (getOneZero(sta: sat.value) == (importGridList?[i].sat ?? "").toString().trim()) &&
            ((selectAccount?.value?.key).toString().trim() ==
                (importGridList?[i].accountCode ?? "").toString().trim()) &&
            ((selectSubType?.value?.key ?? "").toString().trim() ==
                (importGridList?[i].eventcode ?? "").toString().trim())) {
          bool sta = await LoadingDialog.modifyWithAsync(
              "Similar entry already exists!\nDo you want to modify it?",
              deleteTitle: "Yes",
              cancelTitle: "No");
          if (sta) {
            // addEdit(i);
            continue;
          } else {
            bool sta1 = await LoadingDialog.modifyWithAsync("Do you want to duplicate this row?",
                deleteTitle: "Yes", cancelTitle: "No");
            if (sta1) {
              return;
            } else {
              // addEdit(i);
              continue;
            }
          }
          break;
        }


      }
    }
  }

  addEdit(int index) {
    importGridList?[index].recordnumber = txtDRecordNumber.value;
    importGridList?[index].sponsorTypeCode = selectSpotType?.value?.key ?? "";
    importGridList?[index].sponsorTypeName = selectSpotType?.value?.value ?? "";
    importGridList?[index].programCode = selectProgram?.value?.key ?? "";
    importGridList?[index].programName = selectProgram?.value?.value ?? "";
    importGridList?[index].starttime = startTime.text ?? "";
    importGridList?[index].endTime = endTime.text ?? "";
    importGridList?[index].seconds = secondsController2.text ?? "";
    importGridList?[index].rate = ratePerTenSecondsController.text ?? "";
    importGridList?[index].amount = amountController2.text ?? "";
    importGridList?[index].bandCode = selectBand?.value?.key ?? "";
    importGridList?[index].timeBand = selectBand?.value?.value ?? "";
    importGridList?[index].valuationRate = valueRateController.text ?? "";
    importGridList?[index].netCode = selectAddInfo?.value?.key ?? "";
    importGridList?[index].netWorkName = selectAddInfo?.value?.key ?? "";
    importGridList?[index].sun = getOneZero(sta: sun.value);
    importGridList?[index].mon = getOneZero(sta: mon.value);
    importGridList?[index].tue = getOneZero(sta: tue.value);
    importGridList?[index].wed = getOneZero(sta: wed.value);
    importGridList?[index].thu = getOneZero(sta: thu.value);
    importGridList?[index].fri = getOneZero(sta: fri.value);
    importGridList?[index].sat = getOneZero(sta: sat.value);
    importGridList?[index].primaryEventCode = getOneZero(sta: type.value);
    if (type.value == true) {
      importGridList?[index].accountCode = selectAccount?.value?.key ?? "";
      importGridList?[index].accountname = selectAccount?.value?.value ?? "";
      importGridList?[index].eventcode = selectAccount?.value?.key ?? "";
      importGridList?[index].eventname = selectAccount?.value?.value ?? "";
    }
    btnClearClick();
  }

  getOneZero({bool? sta}) {
    if (sta ?? false) {
      return "1";
    } else {
      return "0";
    }
  }

  @override
  void onReady() {
    getAllLoadData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
