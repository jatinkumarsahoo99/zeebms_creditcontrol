import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/modules/PaymentRouteMaster/bindings/service_retrieve.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentRouteMasterController extends GetxController {
  TextEditingController payRouteName = TextEditingController(),
      shortName = TextEditingController(),
      collectionAgentShare = TextEditingController(),
      mainCompanyShare = TextEditingController(),
      agencyShare = TextEditingController();

  var isToBeBilled = true.obs, isActive = true.obs;

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

  ServiceListModel? serviceInit;
  var serviceList = [].obs;
  PlutoGridStateManager? serviceGrid;

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
            loactions.clear();
            map["lstcombobox"]['lstLocation'].forEach((e) {
              loactions.add(DropDownValue(
                  key: e['locationCode'], value: e['locationName']));
            });
            currency.clear();
            map["lstcombobox"]['lstCurrency'].forEach((e) {
              currency.add(DropDownValue(
                  key: e['currencyTypeCode'], value: e['currencyTypeName']));
            });
            payRouteCategory.clear();
            map["lstcombobox"]['lstPayRouteCategory'].forEach((e) {
              payRouteCategory.add(DropDownValue(
                  key: e['payrouteCategoryCode'].toString(),
                  value: e['payrouteCategoryName']));
            });
          }
        });
  }

  locationLeave(String locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_LOCATION_LEAVE(locationCode),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('result')) {
            channel.clear();
            map["result"]['lstchannel'].forEach((e) {
              channel.add(DropDownValue(
                  key: e['channelcode'], value: e['channelName']));
            });
          }
        });
  }

  channelLeave(String locationCode, String channelCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
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
          }
        });
  }

  postSaveRecord(String locationCode, String channelCode) {
    LoadingDialog.call();
    var payLoad = {
      "payRouteCode": "<string>",
      "payRouteName": "<string>",
      "payRouteShortName": "<string>",
      "channelCode": "<string>",
      "locationCode": "<string>",
      "currencyTypeCode": "<string>",
      "mainCompanyShare": "<string>",
      "collectionAgentShare": "<string>",
      "agencyShare": "<string>",
      "billingPayRouteCode": "<string>",
      "payrouteCategoryCode": "<string>",
      "billingStatus": "<boolean>",
      "servicetax": "<string>",
      "active": "<boolean>"
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.PAYMENT_ROUTE_MASTER_POST_SAVE_RECORD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('result')) {
            billingPayRoute.clear();
            map["result"].forEach((e) {
              billingPayRoute.add(DropDownValue(
                  key: e['payRouteCode'], value: e['payRouteName']));
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
            // serviceInit = ServiceListModel.fromJson(map['serviceRetrieve']);
            // serviceList.clear();
            // print(serviceInit!.serviceRetrieve);
            serviceList.value = map['serviceRetrieve'];
          }
        });
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        break;
      case "Clear":
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
        break;
      case "Exit":
        // Get.back();
        Get.find<HomeController>().postUserGridSetting1(listStateManager: [
          serviceGrid,
        ]);
        break;
    }
  }
}
