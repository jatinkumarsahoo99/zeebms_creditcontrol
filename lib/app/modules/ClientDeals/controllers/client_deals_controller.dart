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
              if (map['onload']['location'] != null &&
                  map['onload']['location'].length > 0) {
                locationList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['location'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "locationCode", "locationName"));
                });
                locationList.addAll(dataList);
                locationList.refresh();
              }

              if (map['onload']['dealTypeMaster'] != null &&
                  map['onload']['dealTypeMaster'].length > 0) {
                dealType.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['dealTypeMaster'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "dealtypecode", "dealtypename"));
                });
                dealType.addAll(dataList);
                dealType.refresh();
              }

              if (map['onload']['currencyTypeMaster'] != null &&
                  map['onload']['currencyTypeMaster'].length > 0) {
                currency.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['currencyTypeMaster'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "currencyTypeCode", "currencyTypeName"));
                });
                currency.addAll(dataList);
                currency.refresh();
              }

              if (map['onload']['searchLocation'] != null &&
                  map['onload']['searchLocation'].length > 0) {
                locationList2.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['searchLocation'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "locationcode", "locationname"));
                });
                locationList2.addAll(dataList);
                locationList2.refresh();
              }

              if (map['onload']['searchChannel'] != null &&
                  map['onload']['searchChannel'].length > 0) {
                channelList2.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['searchChannel'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "channelcode", "channelname"));
                });
                channelList2.addAll(dataList);
                channelList2.refresh();
              }

              if (map['onload']['sponsorTypeMaster'] != null &&
                  map['onload']['sponsorTypeMaster'].length > 0) {
                spotTypeList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['sponsorTypeMaster'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "sponsorTypeCode", "sponsorTypeName"));
                });
                spotTypeList.addAll(dataList);
                spotTypeList.refresh();
              }

              if (map['onload']['accountDetails'] != null &&
                  map['onload']['accountDetails'].length > 0) {
                accountList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['onload']['accountDetails'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "accountcode", "accountname"));
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
              if (map is Map &&
                  map['channel'] != null &&
                  map['channel'].length > 0) {
                channelList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['channel'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "channelcode", "channelName"));
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

  Future<String>clientsLeave() {
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
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "agencycode", "agencyName"));
                });
                agencyList.addAll(dataList);
                agencyList.refresh();
              }
              if (map['clientLeaveModel'] != null &&
                  map['clientLeaveModel']['brand'] != null &&
                  map['clientLeaveModel']['brand'].length > 0) {
                brandList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['clientLeaveModel']['brand'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "brandcode", "brandname"));
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

  Future <String> agencyLeave() {
    Completer<String> completer = Completer<String>();
    try {
      if(selectAgency?.value?.key != null && selectAgency?.value?.key != ""){
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "clientCode": selectedClient?.value?.key ?? "",
          "locationCode": selectedLocation?.value?.key ?? "",
          "channelCode": selectedChannel?.value?.key ?? "",
          "dealNumber":dealNoController.text?? "",
          "agencyCode":selectAgency?.value?.key?? "",
          "intNewEntry": (  clientDealRetrieveModel?.agencyLeaveModel != null &&
              clientDealRetrieveModel?.agencyLeaveModel?.retrieve != null
          )?"1":"0",
          "currencyTypeCode": selectCurrency?.value?.key??""
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.Client_Deal_GET_AGENCY_LEAVE,
            json: postData,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map && map['agencyLeaveModel'] != null) {
                agencyLeaveDataModel = AgencyLeaveDataModel.fromJson(map as Map<String,dynamic>);
                if(map['agencyLeaveModel']['paymentModels'] != null &&
                    map['agencyLeaveModel']['paymentModels'].length >0){
                  RxList<DropDownValue> dataList = RxList([]);
                  payMode.clear();
                  map['agencyLeaveModel']['paymentModels'].forEach((e){
                    dataList.add(DropDownValue.fromJsonDynamic(
                        e, "paymentmodecode", "paymentmodecaption"));
                  });
                  payMode.addAll(dataList);
                  if(payMode.length >0){
                    selectPayMode?.value = DropDownValue(key:payMode[0].key ,value:payMode[0].value);
                  }
                  payMode.refresh();
                }
                executive.value = agencyLeaveDataModel?.agencyLeaveModel?.personnelname??"";
                zone.value = agencyLeaveDataModel?.agencyLeaveModel?.zonename??"";
                payroute.value = agencyLeaveDataModel?.agencyLeaveModel?.payroutename??"";
                gstPlantName.value =  agencyLeaveDataModel?.agencyLeaveModel?.plantname??"";
                agencyGstNumber.value = agencyLeaveDataModel?.agencyLeaveModel?.gst??"";
                agencyPanNumber.value = agencyLeaveDataModel?.agencyLeaveModel?.pan??"";
                for(int i=0;i<currency.length;i++){
                  if(currency[i].key.toString().trim() ==
                      agencyLeaveDataModel?.agencyLeaveModel?.currencyTypeCode.toString().trim()){
                    selectCurrency?.value = DropDownValue(value: currency[i].value,key: currency[i].key);
                    selectCurrency?.refresh();
                    break;
                  }
                }

                if(agencyLeaveDataModel?.agencyLeaveModel?.remark != null &&
                    agencyLeaveDataModel?.agencyLeaveModel?.remark != ""){
                  remarkList.clear();
                  remarkList.add({"remark":agencyLeaveDataModel?.agencyLeaveModel?.remark??""});
                  remarkList.refresh();
                }

              }
              else {
                agencyLeaveDataModel = null;
              }
              completer.complete("");
            },
            failed: (map) {
              closeDialogIfOpen();
              completer.complete("");
            });
      }
      else{
        completer.complete("");
      }

    } catch (e) {
      closeDialogIfOpen();
      completer.complete("");
    }
    return  completer.future;
  }

  channelLeave() {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "dealDate":
            Utils.getMMDDYYYYFromDDMMYYYYInString(dateController.text ?? ""),
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
                dealNoController.text =
                    map['channelLeaveModel']['dealNumber'] ?? "";
              }
              if (map['channelLeaveModel'] != null &&
                  map['channelLeaveModel']['timeBand'] != null &&
                  map['channelLeaveModel']['timeBand'].length > 0) {
                bandList.clear();
                RxList<DropDownValue> dataList = RxList([]);
                map['channelLeaveModel']['timeBand'].forEach((e) {
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "timeband", "description"));
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
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "netcode", "networkname"));
                });
                addInfoList.addAll(dataList);
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
        "dealdate":
            Utils.getMMDDYYYYFromDDMMYYYYInString(dateController.text ?? ""),
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

  remarkAdd(){
    remarkList.add({"remark":remarkDiaController.text});
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
                  dataList.add(DropDownValue.fromJsonDynamic(
                      e, "clientcode", "clientname"));
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
              if (clientDealRetrieveModel != null &&
                  clientDealRetrieveModel?.agencyLeaveModel != null) {
                try {
                  if (clientDealRetrieveModel?.agencyLeaveModel?.retrieve !=
                          null &&
                      (clientDealRetrieveModel
                                  ?.agencyLeaveModel?.retrieve?.length ??
                              0) >
                          0) {
                    for (var element in locationList) {
                      if (element.key.toString().trim() ==
                          clientDealRetrieveModel
                              ?.agencyLeaveModel?.retrieve?[0].locationcode
                              .toString()
                              .trim()) {
                        selectedLocation?.value = DropDownValue(
                            value: element.value, key: element.key);
                        selectedLocation?.refresh();
                        break;
                      }
                    }

                    if (channelList.length > 0) {
                      for (var element in channelList.value) {
                        if (element.key.toString().trim() ==
                            clientDealRetrieveModel
                                ?.agencyLeaveModel?.retrieve?[0].channelCode
                                .toString()
                                .trim()) {
                          selectedChannel?.value = DropDownValue(
                              value: element.value, key: element.key);
                          selectedChannel?.refresh();
                          break;
                        }
                      }
                    }
                    else {
                      selectedChannel?.value = DropDownValue(
                          value: selectedChannel2?.value?.value ?? "",
                          key: selectedChannel2?.value?.key ?? "");
                      selectedChannel?.refresh();
                    }

                    for (var element in currency) {
                      if (element.key.toString().trim() ==
                          clientDealRetrieveModel
                              ?.agencyLeaveModel?.retrieve?[0].currencytypecode
                              .toString()
                              .trim()) {
                        selectCurrency?.value = DropDownValue(
                            value: element.value, key: element.key);
                        selectCurrency?.refresh();
                        break;
                      }
                    }
                    for (var element in dealType) {
                      if (element.key.toString().trim() ==
                          clientDealRetrieveModel
                              ?.agencyLeaveModel?.retrieve?[0].dealTypeCode
                              .toString()
                              .trim()) {
                        selectDealType?.value = DropDownValue(
                            value: element.value, key: element.key);
                        selectDealType?.refresh();
                        break;
                      }
                    }
                    selectedClient = selectedClient2;
                    selectedClient?.refresh();

                    clientsLeave().then((value) {
                      agencyGstNumber.value = (clientDealRetrieveModel
                          ?.agencyLeaveModel?.retrieve?[0].gstNumber ??
                          "")
                          .toString();
                      agencyPanNumber.value = (clientDealRetrieveModel
                          ?.agencyLeaveModel
                          ?.retrieve?[0]
                          .agencyshortname ??
                          "")
                          .toString();
                      if (agencyList.length > 0) {
                        for (var element in agencyList) {
                          if (element.key.toString().trim() ==
                              clientDealRetrieveModel
                                  ?.agencyLeaveModel?.retrieve?[0].agencyCode
                                  .toString()
                                  .trim()) {
                            selectAgency?.value = DropDownValue(
                                value: element.value, key: element.key);
                            selectAgency?.refresh();
                            break;
                          }
                        }
                      }
                      else {
                        selectAgency?.value = DropDownValue(
                            key: clientDealRetrieveModel
                                ?.agencyLeaveModel?.retrieve?[0].agencyCode,
                            value: clientDealRetrieveModel
                                ?.agencyLeaveModel?.retrieve?[0].agencyName);
                        selectAgency?.refresh();
                      }

                      agencyLeave().then((value) {

                        dealNoController.text = clientDealRetrieveModel
                            ?.agencyLeaveModel?.retrieve?[0].dealNumber ??
                            "";
                        dateController.text = Utils.toDateFormat4(
                            clientDealRetrieveModel
                                ?.agencyLeaveModel?.retrieve?[0].dealDate);
                        referenceController.text = clientDealRetrieveModel
                            ?.agencyLeaveModel?.retrieve?[0].referenceNumber ??
                            "";
                        referenceDateController.text = Utils.toDateFormat4(
                            clientDealRetrieveModel
                                ?.agencyLeaveModel?.retrieve?[0].referenceDate);
                        fromDateController.text = Utils.toDateFormat4(
                            clientDealRetrieveModel
                                ?.agencyLeaveModel?.retrieve?[0].fromDate);
                        toDateController.text = Utils.toDateFormat4(
                            clientDealRetrieveModel
                                ?.agencyLeaveModel?.retrieve?[0].todate);
                        secondsController.text = (clientDealRetrieveModel
                            ?.agencyLeaveModel?.retrieve?[0].seconds ??
                            "0")
                            .toString();
                        amountController.text = (clientDealRetrieveModel
                            ?.agencyLeaveModel?.retrieve?[0].dealAmount ??
                            "0")
                            .toString();
                        maxSpeedController.text = (clientDealRetrieveModel
                            ?.agencyLeaveModel?.retrieve?[0].maxspend ??
                            "0")
                            .toString();

                        agencyPanNumber.refresh();
                        agencyGstNumber.refresh();


                        if (brandList.length > 0) {
                          for (var element in brandList) {
                            if (element.key.toString().trim() ==
                                clientDealRetrieveModel
                                    ?.agencyLeaveModel?.retrieve?[0].brandCode
                                    .toString()
                                    .trim()) {
                              selectBrand?.value = DropDownValue(
                                  value: element.value, key: element.key);
                              selectBrand?.refresh();
                              break;
                            }
                          }
                        }
                        else {
                          selectBrand?.value = DropDownValue(
                              key: clientDealRetrieveModel
                                  ?.agencyLeaveModel?.retrieve?[0].brandCode,
                              value: "");
                          selectBrand?.refresh();
                        }


                        effectiveRate.value = (clientDealRetrieveModel
                            ?.agencyLeaveModel
                            ?.retrieve?[0]
                            .effectiveRateYN ==
                            1)
                            ? true
                            : false;
                        effectiveRate.refresh();

                      });

                    });

                  }
                } catch (e) {}
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
        return Offset(
            (constraints.maxWidth / 3) + 30, constraints.maxHeight / 3);
      case 2:
        return Offset(Get.width * 0.09, Get.height * 0.12);
      case 3:
        return const Offset(20, 20);
      default:
        return null;
    }
  }

  remarkDialog(){

  }

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

      int sheet = 0;
      for (var table in excel.tables.keys) {
        var tableData = <Map<String, dynamic>>[];
        sheet = sheet + 1;
        // Extract headers from the first row
        var headers = excel.tables[table]!
            .row(0)
            .map((cell) => cell?.value.toString())
            .toList();

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
        print(">>>>jsonData " + jsonData.toString());
        closeDialogIfOpen();
      }
      List<String> sourceList = ["jks", "ku"];
      // List<String> list2 = [ "ku","jks"];


    } catch (e) {
      print(">>>>" + e.toString());
      // gridData = RateCardFromDealWorkFlowModel(export: []);
      closeDialogIfOpen();
      update(['grid']);
      LoadingDialog.showErrorDialog(e.toString());
    }
  }

  listCompare({required List<dynamic> sourceList,required List<dynamic> compareList}){
    bool sta = false;
    if(sourceList.isNotEmpty && compareList.isNotEmpty){
      if(sourceList.length > compareList.length){
        return !sta;
      }

      for(int i=0;i<sourceList.length;i++){
        if(sta){
          break;
        }
        for(int j=0;j<compareList.length;j++){
          if(sourceList[i].toString().toLowerCase().trim() == compareList[j].toString().toLowerCase().trim()){
            break;
          }else if((j == compareList.length-1) && (sourceList[i].toString().toLowerCase().trim() !=
              compareList[j].toString().toLowerCase().trim())){
            sta = true;
            break;
          }else{
            continue;
          }
        }
      }
      return !sta;
    }else{
      return !sta;
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
