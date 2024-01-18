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
  RxList<DropDownValue> brandList2 = RxList([]);
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
  RxList<dynamic> dealNoList = RxList([]);

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

  FocusNode channelFocus = FocusNode();
  FocusNode dealNoFocus = FocusNode();
  FocusNode dateFocus = FocusNode();
  FocusNode fromFocus = FocusNode();
  FocusNode toFocus = FocusNode();
  FocusNode clientFocus = FocusNode();
  FocusNode agencyFocus = FocusNode();

  ScrollController scrollController = ScrollController();
  Rx<int> selectedDealNo = Rx<int>(0);
  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1 = [];

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

  clientsLeave() {
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
            } else {}
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
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
  ClientDealRetrieveModel ?clientDealRetrieveModel;
  retrieveRecord({String? locationCode,String ? channelCode,String ?
  dealNumber,String ? clientCode,String ? agencyCode}) {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "locationCode": locationCode??"",
        "channelCode": channelCode??"",
        "dealNumber": dealNumber??"",
        "clientcode": clientCode,
        "agencyCode": agencyCode
      };
      Get.find<ConnectorControl>().POSTMETHOD(api: ApiFactory.Client_Deal_RETRIVE_RECORD,
          json: postData,
          fun: (map){
            closeDialogIfOpen();
            if(map is Map){
              clientDealRetrieveModel = ClientDealRetrieveModel.fromJson(map as Map<String,dynamic>);
              if(clientDealRetrieveModel != null && clientDealRetrieveModel?.agencyLeaveModel != null
                   ){
                if(clientDealRetrieveModel?.agencyLeaveModel?.retrieve != null && (clientDealRetrieveModel?.agencyLeaveModel?.retrieve?.length??0) >0){
                  for (var element in locationList) {
                    if(element.key.toString().trim() == clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].locationcode.toString().trim()){
                      selectedLocation?.value = DropDownValue(value:element.value ,key:element.key ) ;
                      selectedLocation?.refresh();
                      break;
                    }
                  }
                  for (var element in channelList) {
                    if(element.key.toString().trim() == clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].channelCode.toString().trim()){
                      selectedChannel?.value = DropDownValue(value:element.value ,key:element.key ) ;
                      selectedChannel?.refresh();
                      break;
                    }
                  }
                }

                dealNoController.text = clientDealRetrieveModel?.agencyLeaveModel?.retrieve?[0].dealNumber??"";

              }

              update(["grid"]);
            }else{
              clientDealRetrieveModel = null;
            }
          });

    }catch(e){
      closeDialogIfOpen();
    }
  }

  @override
  void onInit() {
     dealNoFocus = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          if(dealNoController.text != ""){
            retrieveRecord(dealNumber: dealNoController.text,agencyCode: selectAgency?.value?.key,
                clientCode: selectedClient?.value?.key,channelCode: selectedChannel?.value?.key,locationCode: selectedLocation?.value?.key);
          }

          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
     fetchUserSetting1();
    super.onInit();
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
