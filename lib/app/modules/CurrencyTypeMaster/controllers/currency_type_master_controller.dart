import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/controller/MainController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/modules/CommonSearch/views/common_search_view.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/app/providers/Utils.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CurrencyTypeMasterController extends GetxController {
  TextEditingController currencyName = TextEditingController(),
      shortName = TextEditingController(),
      currencyCode = TextEditingController(),
      lowerCurrencyName = TextEditingController(),
      currency = TextEditingController();

  FocusNode shortNameFN = FocusNode(),
      currencyCodeFN = FocusNode(),
      lowerCurrencyCodeFN = FocusNode(),
      currencyFN = FocusNode(),
      currencyNameFN = FocusNode(),
      locationFN = FocusNode();

  var isDefultCurrency = false.obs;
  var strCode = "";
  var isCurrencyCode = true.obs;

  var location = RxList<DropDownValue>();
  Rxn<DropDownValue> selectLocation = Rxn<DropDownValue>();

  @override
  void onInit() {
    super.onInit();
    focusListner();
  }

  @override
  void onReady() {
    super.onReady();
    getFormLoad();
  }

  @override
  void onClose() {
    super.onClose();
  }

  focusListner() {
    currencyNameFN = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          if (currencyName.text.isNotEmpty) {
            featchCurrency(currencyName.text);
          }
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
    shortNameFN = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          if (shortName.text.isNotEmpty) {
            shortName.text = shortName.text.toUpperCase();
          }

          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
    currencyCodeFN = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          if (currencyCode.text.isNotEmpty) {
            currencyCode.text = currencyCode.text.toUpperCase();
            leaveCurrencyName(currencyCode.text);
          }

          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
    lowerCurrencyCodeFN = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          if (lowerCurrencyName.text.isNotEmpty) {
            lowerCurrencyName.text =
                Utils.capitalizeWords(lowerCurrencyName.text);
          }

          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
    currencyFN = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          if (currency.text.isNotEmpty) {
            currency.text = currency.text.toUpperCase();
          }
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
  }

  getFormLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CURRENCY_TYPE_MASTER_INITIAL_LOAD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('onload')) {
            location.clear();
            map['onload'].forEach((e) {
              location.add(DropDownValue(
                  key: e['locationCode'], value: e['locationName']));
            });
          }
        });
  }

  leaveCurrencyName(currencyName) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CURRENCY_TYPE_MASTER_LEAVE_CURRENCY_NAME(currencyName),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('currencyData')) {
            LoadingDialog.showErrorDialog(map['currencyData']['message'],
                callback: () {
              currencyCode.clear();
              currencyCodeFN.requestFocus();
            });
          }
        });
  }

  featchCurrency(currencyNamee) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CURRENCY_TYPE_MASTER_FEATCH_CURRENCY(currencyNamee),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('currencyData')) {
            if (map['currencyData']['currencyName'].isNotEmpty &&
                map['currencyData']['shortName'].isNotEmpty &&
                map['currencyData']['locationCode'].isNotEmpty) {
              strCode = map['currencyData']['strCode'] ?? "";
              //Currency Name
              currencyName.text = map['currencyData']['currencyName'] ?? "";
              //Short Name
              shortName.text = map['currencyData']['shortName'] ?? "";
              //Currency Code
              currencyCode.text = map['currencyData']['currencyType'] ?? "";
              isCurrencyCode.value = false;
              //Lower Currency Name
              lowerCurrencyName.text =
                  map['currencyData']['lowerCurrencyName'] ?? "";
              //Currency
              currency.text = map['currencyData']['currency'] ?? "";
              //Location
              selectLocation.value = location.firstWhereOrNull((e) {
                var result = e.key == map['currencyData']['locationCode'];

                return result;
              });
              //Defult Currency
              isDefultCurrency.value =
                  map['currencyData']['defaultCurrency'] == "Y" ? true : false;
            }
          }
        });
  }

  saveData() {
    if (currencyName.text.isEmpty) {
      LoadingDialog.showErrorDialog("Currency cannot be empty.", callback: () {
        currencyNameFN.requestFocus();
      });
    } else if (shortName.text.isEmpty) {
      LoadingDialog.showErrorDialog("Short Name cannot be empty.",
          callback: () {
        shortNameFN.requestFocus();
      });
    } else if (currencyCode.text.isEmpty) {
      LoadingDialog.showErrorDialog("Currency Type cannot be empty.",
          callback: () {
        currencyCodeFN.requestFocus();
      });
    } else if (currency.text.isEmpty) {
      LoadingDialog.showErrorDialog("Currency cannot be empty.", callback: () {
        currencyFN.requestFocus();
      });
    } else if (selectLocation.value == null) {
      LoadingDialog.showErrorDialog("Location cannot be empty.", callback: () {
        locationFN.requestFocus();
      });
    } else {
      if (strCode.isNotEmpty) {
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
    var payLoad = {
      "strCode": strCode,
      "currencyName": currencyName.text,
      "shortName": shortName.text,
      "locationCode": selectLocation.value?.key ?? "",
      "currencyType": currencyCode.text,
      "defaultCurrency": isDefultCurrency.isTrue ? "Y" : "N",
      "lowerCurrencyName": lowerCurrencyName.text,
      "currency": currency.text,
      "loggedUser": Get.find<MainController>().user?.logincode ?? "",
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.CURRENCY_TYPE_MASTER_SAVE_DATA,
        json: payLoad,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('saveInfo')) {
            LoadingDialog.callDataSaved(
                msg: map['saveInfo'],
                callback: () {
                  Get.delete<CurrencyTypeMasterController>();
                  Get.find<HomeController>().clearPage1();
                });
          }
        });
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        saveData();
        break;
      case "Clear":
        Get.delete<CurrencyTypeMasterController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("Place Master"),
            screenName: "Place Master",
            appBarName: "Place Master",
            strViewName: "vTesting",
            isAppBarReq: true,
          ),
        );
        break;
      case "Exit":
        break;
    }
  }
}
