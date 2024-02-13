import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/modules/AgencyEmbargo/bindings/on_load_model.dart';
import 'package:bms_creditcontrol/app/modules/CommonSearch/views/common_search_view.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/pluto_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AgencyEmbargoController extends GetxController {
  TextEditingController date = TextEditingController(),
      embargoNo = TextEditingController(),
      reason = TextEditingController();

  var selectedTab = "Embargo List".obs;
  List<String> mainTabs = [
    "Embargo List", //0
    "Agency History", //1
  ];
  FocusNode reasonFN = FocusNode();
  PageController pageController = PageController(initialPage: 0);
  AgencyEmbargoOnLoadModel? agencyEmbargoOnLoadModel;
  var embargoList = <Onload>[].obs;
  var agencyHistoryList = [].obs;
  PlutoGridStateManager? embargoGrid;
  PlutoGridStateManager? agencyHistoryGrid;

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
        api: ApiFactory.AGENCY_EMBARGO_ON_LOAD,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('onload')) {
            agencyEmbargoOnLoadModel =
                AgencyEmbargoOnLoadModel.fromJson(map as Map<String, dynamic>);
            embargoList.clear();
            embargoList.value = agencyEmbargoOnLoadModel?.onload ?? [];
          }
        });
  }

  getAgencyHistory(agencyCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.AGENCY_EMBARGO_GET_AGENCY_HISTORY(agencyCode),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('history')) {
            agencyHistoryList.value = map['history'];
          }
        });
  }

  save() {
    if (selectAgency.value == null) {
      LoadingDialog.showErrorDialog("Agency Name cannot be empty.");
    } else if (reason.text.isEmpty) {
      LoadingDialog.showErrorDialog("Please enter reason.");
    } else {
      var payload = {
        "agencyCode": selectAgency.value?.key ?? "",
        "embargoNo": embargoNo.text,
        "fromdate": dateConvertToyyyyMMdd(date.text),
        "reason": reason.text,
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AGENCY_EMBARGO_SAVE,
          json: payload,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('save')) {
              LoadingDialog.callDataSaved(
                  msg: map['save'],
                  callback: () {
                    Get.delete<AgencyEmbargoController>();
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

  formHandler(btn) {
    switch (btn) {
      case "Save":
        save();
        break;
      case "Clear":
        Get.delete<AgencyEmbargoController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Exit":
        print("Im in Exit");
        try {
          Get.find<HomeController>().postUserGridSetting1(
            listStateManager: [
              embargoGrid,
              agencyHistoryGrid,
            ],
            tableNamesList: [
              'key1',
              'key2',
            ],
          );
        } catch (e) {
          print("Exit Error ===>" + e.toString());
        }
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("Agency Embargo"),
            screenName: "Agency Embargo",
            appBarName: "Agency Embargo",
            strViewName: "vAGencyembargo",
            isAppBarReq: true,
          ),
        );
        break;
    }
  }
}
