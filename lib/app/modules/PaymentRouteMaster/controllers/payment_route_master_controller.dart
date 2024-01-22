import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/modules/PaymentRouteMaster/bindings/combo_box_model.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../CommonSearch/views/common_search_view.dart';

class PaymentRouteMasterController extends GetxController {
  TextEditingController payRouteName = TextEditingController(),
      shortName = TextEditingController(),
      collectionAgentShare = TextEditingController(),
      mainCompanyShare = TextEditingController(),
      agencyShare = TextEditingController();

  var isToBeBilled = true.obs, isActive = true.obs;

  var payRouteCode = "";

  FocusNode payRouteNameFN = FocusNode(),
      locationFN = FocusNode(),
      currencyFN = FocusNode(),
      sapCustGrpFN = FocusNode(),
      billingPayRouteFN = FocusNode(),
      payRouteCategoryFN = FocusNode(),
      channelFN = FocusNode();

  var loactions = RxList<DropDownValue>(),
      currency = RxList<DropDownValue>(),
      payRouteCategory = RxList<DropDownValue>(),
      sapCustGrp = RxList<DropDownValue>(),
      channel = RxList<DropDownValue>(),
      billingPayRoute = RxList<DropDownValue>(),
      serviceLocation = RxList<DropDownValue>(),
      serviceChannel = RxList<DropDownValue>();

  DropDownValue? selectLocation;
  DropDownValue? selectCurrency;
  DropDownValue? selectPayRouteCategory;
  DropDownValue? selectSapCustGrp;
  DropDownValue? selectChannel;
  DropDownValue? selectBillingPayRoute;
  DropDownValue? selectServiceLocation;
  DropDownValue? selectServiceChannel;

  var serviceList = [].obs;
  PlutoGridStateManager? serviceGrid;

  PaymentRouteMasterComboBoxes? paymentRouteMasterComboBoxes;

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
    payRouteNameFN = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          getRetrieveRecord(payRouteName.text);
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    getFormLoad();
    getServiceLocation();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getFormLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_FORM_LOAD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('getload')) {
            sapCustGrp.clear();
            map["getload"].forEach((e) {
              sapCustGrp.add(
                  DropDownValue(key: e['groupcode'], value: e['groupname']));
            });
            getComboBox();
          }
        });
  }

  getComboBox() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_COMBO_BOXES,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('lstcombobox')) {
            paymentRouteMasterComboBoxes =
                PaymentRouteMasterComboBoxes.fromJson(
                    map as Map<String, dynamic>);
            loactions.clear();
            paymentRouteMasterComboBoxes!.lstcombobox!.lstLocation!
                .forEach((e) {
              loactions.add(
                  DropDownValue(key: e.locationCode, value: e.locationName));
            });
            currency.clear();
            var i = 0;
            paymentRouteMasterComboBoxes!.lstcombobox!.lstCurrency!
                .forEach((e) {
              currency.add(
                  DropDownValue(key: i.toString(), value: e.currencyTypeName));
              ++i;
            });
            payRouteCategory.clear();
            var a = 0;
            paymentRouteMasterComboBoxes!.lstcombobox!.lstPayRouteCategory!
                .forEach((e) {
              payRouteCategory.add(DropDownValue(
                  key: a.toString(), value: e.payrouteCategoryName));
              ++a;
            });
          }
        });
  }

  Future<void> locationLeave(String locationCode) async {
    LoadingDialog.call();
    await Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_LOCATION_LEAVE(locationCode),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('result')) {
            channel.clear();
            map["result"]['lstchannel'].forEach((e) {
              channel.add(DropDownValue(
                  key: e['channelcode'], value: e['channelName']));
            });
            update(['routeUpdate']);
          }
        });
  }

  Future<void> channelLeave(String locationCode, String channelCode) async {
    LoadingDialog.call();
    await Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_CHANNEL_LEAVE(
            locationCode, channelCode),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('result')) {
            billingPayRoute.clear();
            map["result"].forEach((e) {
              billingPayRoute.add(DropDownValue(
                  key: e['payRouteCode'], value: e['payRouteName']));
            });
            update(['routeUpdate']);
          }
        });
  }

  getRetrieveRecord(String routeName) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_GET_RETRIEVE_RECORD("", routeName),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('retrieve')) {
            var retrieve = map['retrieve'];
            ////
            payRouteCode = retrieve['lstRouteMaster'][0]['payRouteCode'];
            ////
            payRouteName.text = retrieve['lstRouteMaster'][0]['payRouteName'];
            ////
            shortName.text = retrieve['lstRouteMaster'][0]['payRouteShortName'];
            // Location
            selectLocation = loactions.firstWhereOrNull((e) {
              var result = e.key.toString() ==
                  retrieve['lstRouteMaster'][0]['locationCode'];
              return result;
            });
            // Channel
            locationLeave(retrieve['lstRouteMaster'][0]['locationCode'] ?? "")
                .then((value) {
              selectChannel = channel.firstWhereOrNull((e) {
                var result = e.key.toString() ==
                    retrieve['lstRouteMaster'][0]['channelCode'];
                return result;
              });
            });
            // Currency
            selectCurrency = currency.firstWhereOrNull((e) {
              var result = paymentRouteMasterComboBoxes!.lstcombobox!
                      .lstCurrency![int.parse(e.key.toString())].currencyType ==
                  retrieve['lstRouteMaster'][0]['currencyType'];
              return result;
            });
            /////
            mainCompanyShare.text = retrieve['lstRouteMaster'][0]
                    ['mainCompanyShare']
                .toStringAsFixed(2);
            collectionAgentShare.text = retrieve['lstRouteMaster'][0]
                    ['collectionAgentShare']
                .toStringAsFixed(2);
            agencyShare.text =
                retrieve['lstRouteMaster'][0]['agencyShare'].toStringAsFixed(2);
            // Sap Cust Grp
            selectSapCustGrp = sapCustGrp.firstWhereOrNull((e) {
              var result = e.key!.toString() ==
                  retrieve['lstRouteMaster'][0]['servicetax'].toString();
              return result;
            });

            // Billing Pay Route
            channelLeave(retrieve['lstRouteMaster'][0]['locationCode'] ?? "",
                    retrieve['lstRouteMaster'][0]['channelCode'] ?? "")
                .then((value) {
              selectBillingPayRoute = billingPayRoute.firstWhereOrNull((e) {
                var result = e.key.toString() ==
                    retrieve['lstRouteMaster'][0]['billingPayRouteCode'];
                return result;
              });
            });

            // Pay Route Category
            selectPayRouteCategory = payRouteCategory.firstWhereOrNull((e) {
              var result = paymentRouteMasterComboBoxes!
                      .lstcombobox!
                      .lstPayRouteCategory![int.parse(e.key.toString())]
                      .payrouteCategoryCode
                      .toString() ==
                  retrieve['lstRouteMaster'][0]['payrouteCategoryCode']
                      .toString();
              return result;
            });
            // To Be Billed
            isToBeBilled.value =
                retrieve['lstRouteMaster'][0]['billingStatus'] == "N"
                    ? false
                    : true;
            isActive.value =
                retrieve['lstRouteMaster'][0]['active'] == 0 ? false : true;

            update(['routeUpdate']);
          }
        });
  }

  postSaveRecord() {
    if (payRouteName.text.isEmpty) {
      LoadingDialog.showErrorDialog("Pay Route Name cannot be empty.");
    } else if (shortName.text.isEmpty) {
      LoadingDialog.showErrorDialog("Short Name cannot be empty.");
    } else if (selectCurrency == null) {
      LoadingDialog.showErrorDialog("Please select Currency.");
    } else if (selectLocation == null) {
      LoadingDialog.showErrorDialog("Please select Loaction Name.");
    } else if (selectChannel == null) {
      LoadingDialog.showErrorDialog("Please select Channel Name.");
    } else if (selectPayRouteCategory == null) {
      LoadingDialog.showErrorDialog("Please select Pay Route Category.");
    } else if (mainCompanyShare.text.isEmpty ||
        collectionAgentShare.text.isEmpty ||
        agencyShare.text.isEmpty) {
      LoadingDialog.showErrorDialog(
          "Error converting data type navarchar to numeric.");
    } else {
      if (payRouteCode.isNotEmpty) {
        LoadingDialog.modify("Record Already exist!\nDo you want to modify it?",
            () {
          // yes
          save();
        }, () {
          //no
          Get.back();
        }, cancelTitle: "No", deleteTitle: "Yes");
      } else {
        save();
      }
    }
  }

  save() {
    LoadingDialog.call();
    var payLoad = {
      "payRouteCode": payRouteCode,
      "payRouteName": payRouteName.text,
      "payRouteShortName": shortName.text,
      "channelCode": selectChannel?.key ?? "",
      "locationCode": selectLocation?.key ?? "",
      "currencyTypeCode": paymentRouteMasterComboBoxes!.lstcombobox!
          .lstCurrency![int.parse(selectCurrency?.key ?? '0')].currencyTypeCode,
      "mainCompanyShare": mainCompanyShare.text,
      "collectionAgentShare": collectionAgentShare.text,
      "agencyShare": agencyShare.text,
      "billingPayRouteCode": selectBillingPayRoute?.key ?? '',
      "payrouteCategoryCode": paymentRouteMasterComboBoxes!
          .lstcombobox!
          .lstPayRouteCategory![int.parse(selectPayRouteCategory?.key ?? '0')]
          .payrouteCategoryCode,
      "billingStatus": isToBeBilled.value,
      "servicetax": selectSapCustGrp?.key ?? '',
      "active": isActive.value,
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_POST_SAVE_RECORD,
        json: payLoad,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('message')) {
            LoadingDialog.callDataSaved(
                msg: map['message'],
                callback: () {
                  clear();
                });
          }
        });
  }

  getServiceLocation() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_GET_SERVICE_LOCATION,
        fun: (Map map) {
          // Get.back();
          if (map != null && map.containsKey('location2')) {
            serviceLocation.clear();
            map['location2']["result"].forEach((e) {
              serviceLocation.add(DropDownValue(
                  key: e['locationCode'], value: e['locationName']));
            });
          }
        });
  }

  getServiceChannel(String locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_SERVICE_CHANNEL(locationCode),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('channel2')) {
            serviceChannel.clear();
            map["channel2"]['result'].forEach((e) {
              serviceChannel.add(DropDownValue(
                  key: e['channelCode'], value: e['channelName']));
            });
          }
        });
  }

  getServiceRetrieve(String locationName, String channelName) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_GET_SERVICE_RETRIEVE(
            locationName, channelName),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('serviceRetrieve')) {
            serviceList.clear();
            serviceList.value = map['serviceRetrieve'];
          }
        });
  }

  clear() {
    payRouteCode = "";
    payRouteName.clear();
    shortName.clear();
    selectCurrency = null;
    selectLocation = null;
    selectChannel = null;
    mainCompanyShare.clear();
    collectionAgentShare.clear();
    agencyShare.clear();
    selectSapCustGrp = null;
    selectBillingPayRoute = null;
    selectPayRouteCategory = null;
    isToBeBilled.value = false;
    isActive.value = false;
    update(['routeUpdate']);
    payRouteNameFN.requestFocus();
  }

  serviceClear() {
    selectServiceLocation = null;
    selectServiceChannel = null;
    serviceList.clear();
    update(['serviceUpdate']);
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        postSaveRecord();
        break;
      case "Clear":
        clear();
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("Payment Route Master"),
            screenName: "Payment Route Master",
            appBarName: "Payment Route Master",
            strViewName: "Bms_view_payroutemaster",
            isAppBarReq: true,
          ),
        );
        break;

      case "Exit":
        break;
    }
  }

  serviceTaxFormHandler(btn) {
    switch (btn) {
      case "Save":
        break;
      case "Clear":
        serviceClear();
        break;
      case "Exit":
        LoadingDialog.callExitForm(() {
          serviceClear();
          Get.back();
          Get.back();
        });
        Get.find<HomeController>().postUserGridSetting1(listStateManager: [
          serviceGrid,
        ]);
        break;
    }
  }
}
