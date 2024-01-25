import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/modules/CommonSearch/views/common_search_view.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StationMasterController extends GetxController {
  TextEditingController stationName = TextEditingController();
  var relatedZone = RxList<DropDownValue>();

  Rxn<DropDownValue> selectRelatedZone = Rxn<DropDownValue>();
  FocusNode stationNameFN = FocusNode(), relatedZoneFN = FocusNode();

  var stationCode = "";

  @override
  void onInit() {
    super.onInit();
    stationNameFN = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          stationName.text = stationName.text.toUpperCase();
          getRetrieveRecord(stationName.text);
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
  }

  @override
  void onClose() {
    super.onClose();
  }

  getFormLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.STATION_MASTER_ON_LOAD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('stationMasterOnLoad')) {
            // Related Zone
            relatedZone.clear();
            map['stationMasterOnLoad'].forEach((e) {
              relatedZone.add(DropDownValue(
                key: e['zoneCode'],
                value: e['zoneName'],
              ));
            });
          }
        });
  }

  getRetrieveRecord(String placeNames) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.STATION_MASTER_RETRIEVE_RECORD("", placeNames),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('retrieveRecord')) {
            //Station Name
            stationName.text = map['retrieveRecord'][0]['stationName'];
            //Station Code
            stationCode = map['retrieveRecord'][0]['stationCode'];
            //Related Zone
            selectRelatedZone.value = relatedZone.firstWhereOrNull((e) {
              var result = e.key == map['retrieveRecord'][0]['zoneCode'];
              return result;
            });
          }
        });
  }

  postSave() {
    if (stationName.text.isEmpty) {
      LoadingDialog.showErrorDialog("Station Name cannot be empty.");
    } else if (selectRelatedZone.value == null) {
      LoadingDialog.showErrorDialog("Related Zone is compulsory.");
    } else {
      if (stationCode.isNotEmpty) {
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
    var payload = {
      "stationCode": stationCode,
      "stationName": stationName.text,
      "zoneCode": selectRelatedZone.value?.key ?? "",
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.STATION_MASTER_POST_SAVE,
        json: payload,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('save')) {
            LoadingDialog.callDataSaved(
                msg: map['save'],
                callback: () {
                  Get.delete<StationMasterController>();
                  Get.find<HomeController>().clearPage1();
                });
          }
        });
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        postSave();
        break;
      case "Clear":
        Get.delete<StationMasterController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("Station Master"),
            screenName: "Station Master",
            appBarName: "Station Master",
            strViewName: "Bms_view_payroutemaster",
            isAppBarReq: true,
          ),
        );
        break;

      case "Exit":
        break;
    }
  }
}
