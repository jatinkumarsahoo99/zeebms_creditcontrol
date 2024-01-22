import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/CheckBox/multi_check_box.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExportBillingFPCController extends GetxController {
  TextEditingController fromDate = TextEditingController(),
      toDate = TextEditingController();
  var locations = RxList<MultiCheckBoxModel>();
  var channels = RxList<MultiCheckBoxModel>();
  var programType = RxList<MultiCheckBoxModel>();
  var orignalRepeat = RxList<MultiCheckBoxModel>();
  var listOfProgram = RxList<MultiCheckBoxModel>();

  List<DropDownValue> selectLocation = [];
  List<DropDownValue> selectChannel = [];
  List<DropDownValue> selectProgramType = [];
  List<DropDownValue> selectOrignalRepeat = [];
  List<DropDownValue> selectListOfProgram = [];

  PlutoGridStateManager? exportBillingGrid;

  var exportBillingList = [].obs;

  var loactionFN = FocusNode(), toDateFN = FocusNode();

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
    getLoadData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getLoadData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.START_EXPORT_BILLING_FORM_LOAD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('pageload')) {
            locations.clear();
            channels.clear();
            var i = 0;
            map["pageload"]["lstLocation"].forEach((e) {
              locations.add(MultiCheckBoxModel(
                  DropDownValue(
                      key: e["locationCode"], value: e["locationName"]),
                  false,
                  i));
              i++;
            });
            i = 0;
            map["pageload"]["lstChannel"].forEach((e) {
              channels.add(MultiCheckBoxModel(
                  DropDownValue(key: e["channelCode"], value: e["channelName"]),
                  false,
                  i));
              i++;
            });
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        });
  }

  dateLeave() {
    selectLocation.clear();
    selectChannel.clear();

    for (var element in locations) {
      if (element.isSelected ?? false) {
        selectLocation.add(element.val!);
      }
    }
    for (var element in channels) {
      if (element.isSelected ?? false) {
        selectChannel.add(element.val!);
      }
    }
    LoadingDialog.call();
    var startDate = DateFormat("dd-MM-yyyy").parse(fromDate.text);
    var endDate = DateFormat("dd-MM-yyyy").parse(toDate.text);
    var payload = {
      "lstLocations": selectLocation
          .map(
            (e) => {
              "locationCode": e.key,
              "locationName": e.value,
            },
          )
          .toList(),
      "lstchannels": selectChannel
          .map((e) => {
                "channelcode": e.key,
                "channelname": e.value,
              })
          .toList(),
      "fromDate": DateFormat("yyyy-MM-dd").format(startDate),
      "toDate": DateFormat("yyyy-MM-dd").format(endDate),
    };
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.START_EXPORT_BILLING_DATE_LEAVE,
      json: payload,
      fun: (map) {
        Get.back();
        print(map);
        if (map != null && map['result'] != null && map.containsKey('result')) {
          programType.clear();
          orignalRepeat.clear();
          listOfProgram.clear();

          // Program Type
          var i = 0;
          if (map["result"]["lstprogramtypemaster"] != null) {
            map["result"]["lstprogramtypemaster"].forEach((e) {
              programType.add(MultiCheckBoxModel(
                  DropDownValue(
                      key: e["programtypeCode"], value: e["programtypeName"]),
                  false,
                  i));
              i++;
            });
          }

          //Original Repeat
          i = 0;
          if (map["result"]["lstFPCOriginalRepeat"] != null) {
            map["result"]["lstFPCOriginalRepeat"].forEach((e) {
              orignalRepeat.add(MultiCheckBoxModel(
                  DropDownValue(
                      key: e["originalRepeatCode"],
                      value: e["originalRepeatName"]),
                  false,
                  i));
              i++;
            });
          }

          // List of Program
          i = 0;
          if (map["result"]["lstprogramgroup"] != null) {
            map["result"]["lstprogramgroup"].forEach((e) {
              listOfProgram.add(MultiCheckBoxModel(
                  DropDownValue(
                      key: e["programcode"].toString(),
                      value: e["programname"]),
                  false,
                  i));
              i++;
            });
          }
        }

        update(['update']);
        toDateFN.requestFocus();
      },
    );
  }

  generate() {
    selectProgramType.clear();
    selectOrignalRepeat.clear();
    selectListOfProgram.clear();

    for (var element in programType) {
      if (element.isSelected ?? false) {
        selectProgramType.add(element.val!);
      }
    }
    for (var element in orignalRepeat) {
      if (element.isSelected ?? false) {
        selectOrignalRepeat.add(element.val!);
      }
    }
    for (var element in listOfProgram) {
      if (element.isSelected ?? false) {
        selectListOfProgram.add(element.val!);
      }
    }
    LoadingDialog.call();
    var startDate = DateFormat("dd-MM-yyyy").parse(fromDate.text);
    var endDate = DateFormat("dd-MM-yyyy").parse(toDate.text);
    var payload = {
      "lstprogramgroup": selectListOfProgram
          .map(
            (e) => {
              "programcode": e.key,
              "programname": e.value,
            },
          )
          .toList(),
      "lstprogramtypemaster": selectProgramType
          .map((e) => {
                "programtypeCode": e.key,
                "programtypeName": e.value,
              })
          .toList(),
      "lstFPCOriginalRepeat": selectOrignalRepeat
          .map((e) => {
                "originalRepeatCode": e.key,
                "originalRepeatName": e.value,
              })
          .toList(),
      "fromDate": DateFormat("yyyy-MM-dd").format(startDate),
      "toDate": DateFormat("yyyy-MM-dd").format(endDate),
    };
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.START_EXPORT_BILLING_GET_GENERATE,
      json: payload,
      fun: (map) {
        Get.back();
        print(map);
        if (map != null &&
            map['generate'] != null &&
            map.containsKey('generate')) {
          exportBillingList.clear();
          exportBillingList.value = map['generate'];
        }
      },
    );
  }
}
