import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/modules/CommonSearch/views/common_search_view.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../bindings/place_master_on_load_model.dart';

class PlaceMasterController extends GetxController {
  TextEditingController placeName = TextEditingController(),
      placeShortName = TextEditingController(),
      ibfBranchCode = TextEditingController(),
      sapCode = TextEditingController();

  var zoneName = RxList<DropDownValue>(),
      placeType = RxList<DropDownValue>(),
      parentPlaceName = RxList<DropDownValue>();

  DropDownValue? selectZoneName;
  DropDownValue? selectPlaceType;
  DropDownValue? selectParentPlaceName;

  FocusNode placeNameFN = FocusNode();

  PlaceMasterOnLoadModel? placeMaster;
  @override
  void onInit() {
    super.onInit();
    placeNameFN = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          // getPlaceName(placeName.text);
          getRetrieveRecord(placeName.text);
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
        api: ApiFactory.PLACE_MASTER_ON_LOAD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('placeMasterOnLoad')) {
            placeMaster =
                PlaceMasterOnLoadModel.fromJson(map as Map<String, dynamic>);
            // Zone Name
            zoneName.clear();
            var i = 0;
            placeMaster!.placeMasterOnLoad!.lstZonename!.forEach((e) {
              zoneName.add(DropDownValue(
                key: i.toString(),
                value: e.zoneName,
              ));
              ++i;
            });
            // Place Type
            placeType.clear();
            placeMaster!.placeMasterOnLoad!.lstPlaceType!.forEach((e) {
              placeType.add(DropDownValue(
                key: e.placeTypeCode,
                value: e.placeTypeName,
              ));
            });
            // Parent Place Name
            parentPlaceName.clear();
            i = 0;
            placeMaster!.placeMasterOnLoad!.lstParentPlaceName!.forEach((e) {
              parentPlaceName.add(DropDownValue(
                key: i.toString(),
                value: e.placeName,
              ));
              ++i;
            });
          }
        });
  }

  getPlaceName(String placeName) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PLACE_MASTER_PLACE_NAME(placeName),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('placeMasterOnLoad')) {}
        });
  }

  getRetrieveRecord(String placeNames) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PLACE_MASTER_RETRIEVE_RECORD("", placeNames),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('retrieveRecord')) {
            //Place Name
            placeName.text = map['retrieveRecord'][0]['placeName'];
            //Place Type
            selectPlaceType = placeType.firstWhereOrNull((e) {
              var result = e.key.toString() ==
                  map['retrieveRecord'][0]['placeTypeCode'].toString();
              return result;
            });
            //Place Short Name
            placeShortName.text = map['retrieveRecord'][0]['placeShortName'];
            //Parent Place Name
            selectParentPlaceName = parentPlaceName.firstWhereOrNull((e) {
              var result = placeMaster!.placeMasterOnLoad!
                      .lstParentPlaceName![int.parse(e.key ?? '0')].placeCode ==
                  map['retrieveRecord'][0]['placeCode'].toString();
              return result;
            });
            //Zone Name
            selectZoneName = zoneName.firstWhereOrNull((e) {
              var result = placeMaster!.placeMasterOnLoad!
                      .lstZonename![int.parse(e.key ?? '0')].zoneCode ==
                  map['retrieveRecord'][0]['zoneCode'].toString();
              return result;
            });
            //IBF Branch Code
            ibfBranchCode.text =
                map['retrieveRecord'][0]['ibfBranchCode'].toUpperCase();
            //SAP Code
            sapCode.text = map['retrieveRecord'][0]['sapCode'].toUpperCase();

            update(['placeMasterUpdate']);
          }
        });
  }

  postSave() {
    LoadingDialog.call();
    var payload = {
      "placeCode": "<string>",
      "placeName": placeName.text,
      "placeShortName": placeShortName.text,
      "placeTypeCode": selectPlaceType?.key ?? "",
      "parentPlaceCode": "<string>",
      "zoneCode": placeMaster!.placeMasterOnLoad!
          .lstZonename![int.parse(selectZoneName?.key ?? '0')].zoneCode,
      "ibfBranchCode": ibfBranchCode.text,
      "sapCode": sapCode.text,
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.PLACE_MASTER_POST_SAVE,
        json: payload,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('placeMasterOnLoad')) {}
        });
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        break;
      case "Clear":
        Get.delete<PlaceMasterController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("Place Master"),
            screenName: "Place Master",
            appBarName: "Place Master",
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
