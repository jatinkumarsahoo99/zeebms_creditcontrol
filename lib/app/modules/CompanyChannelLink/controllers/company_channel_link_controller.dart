import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/controller/MainController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/widgets/CheckBox/multi_check_box.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:get/get.dart';

import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/user_data_settings_model.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../ChannelLinkMasterData.dart';

class CompanyChannelLinkController extends GetxController {
  DropDownValue? selectLocation;
  DropDownValue? selectChannel;
  DropDownValue? selectPayrouteCat;
  DropDownValue? selectCollAgent;
  DropDownValue? selectCurrency;
  DropDownValue? selectParentCompany;
  DropDownValue? selectSapProfCen;

  ChannelLinkMasterData? initData;
  List<DropDownValue>? channelList = [];
  RxList<DropDownValue>? sapProfileList = RxList([]);
  PlutoGridStateManager? gridManager;

  UserDataSettings? userDataSettings;

  int strCode = -1;

  @override
  void onInit() {
    fetchUserGridSetting();
    getLoad();
    super.onInit();
  }

  fetchUserGridSetting() async {
    userDataSettings = await Get.find<HomeController>()
        .fetchUserSetting2(formName: "frmCompanyChannelLink");
  }

  getLoad() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CHANNEL_LINK_INIT,
        fun: (Map map) {
          if (map.containsKey("loadData") && map["loadData"] != null) {
            initData = ChannelLinkMasterData.fromJson(map["loadData"]);
          } else {
            initData = null;
          }
          update(["init", "grid"]);
        });
  }

  getChannel() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CHANNEL_LINK_LOCATION + (selectLocation?.key ?? ""),
        fun: (Map map) {
          if (map.containsKey("infoChannelList") &&
              map["infoChannelList"] != null) {
            channelList = [];
            map["infoChannelList"].forEach((e) {
              channelList?.add(DropDownValue(
                  key: e["channelCode"], value: e["channelName"]));
            });
          }
          update(["init"]);
        });
  }

  getSapProfile() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CHANNEL_LINK_SAP_PROFIT_CENTER +
            (selectParentCompany?.key ?? ""),
        fun: (Map map) {
          if (map.containsKey("infoSapProfitCenter") &&
              map["infoSapProfitCenter"] != null) {
            sapProfileList?.value.clear();
            map["infoSapProfitCenter"].forEach((e) {
              sapProfileList?.value.add(DropDownValue(
                  key: e["profitCentreCode"], value: e["profitcentername"]));
            });
          }
          // update(["init"]);
        });
  }

  validateData() {
    if (selectLocation == null) {
      LoadingDialog.callInfoMessage("Location Name cannot be empty.");
    } else if (selectChannel == null) {
      LoadingDialog.callInfoMessage("Channel Name cannot be empty.");
    } else if (selectPayrouteCat == null) {
      LoadingDialog.callInfoMessage("Payroute category Name cannot be empty.");
    } else {
      List<MultiCheckBoxModel>? selectedList = initData
          ?.lstfillComboRes?.lstCurrencies
          ?.where((element) => element.isSelected ?? false)
          .toList();
      if (selectedList != null) {
        if (strCode != -1) {
          LoadingDialog.modify(
              "Record Already Exist!\nDo you want to modify it?", () {
            saveData();
          }, () {});
        } else {
          saveData();
        }
      } else {
        LoadingDialog.callInfoMessage("Select Currency name.");
      }
    }
  }

  clearData() {
    selectLocation = null;
    selectChannel = null;
    selectPayrouteCat = null;
    selectCollAgent = null;
    selectCurrency = null;
    selectParentCompany = null;
    selectSapProfCen = null;
    update(["init"]);
  }

  saveData() {
    LoadingDialog.call();
    var jsonData = {
      "strCode": strCode,
      "lstSelectedCurrencies": initData?.lstfillComboRes?.lstCurrencies
          ?.where((element) => element.isSelected ?? false)
          .map((e) =>
              e.val?.toJsonCustom("currencyTypeCode", "currencyTypeName"))
          .toList(),
      "companyChannelData":
          initData?.companyChannelLinkDatas?.map((e) => e.toJson()).toList(),
      "locationName": selectLocation?.value ?? "",
      "locationCode": selectLocation?.key ?? "",
      "channelName": selectChannel?.value ?? "",
      "channelCode": selectChannel?.key ?? "",
      "payrouteCategoryName": selectPayrouteCat?.value ?? "",
      "payrouteCategoryCode": selectPayrouteCat?.key ?? "",
      "collectionAgentCode": selectCollAgent?.key ?? "",
      "loggedUser": Get.find<MainController>().user?.logincode ?? "",
      "parentsCode": selectParentCompany?.key ?? "",
      "sapprofitCode": selectSapProfCen?.key ?? ""
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.CHANNEL_LINK_SAVE,
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey("infoSave") &&
              map["infoSave"] != null) {
            LoadingDialog.callDataSaved(
                msg: map["infoSave"],
                callback: () {
                  clearData();
                  getLoad();
                });
          } else {
            LoadingDialog.callErrorMessage1(msg: map.toString());
          }
          // update(["init"]);
        },
        json: jsonData);
  }

  void formHandler(String btnName) {
    switch (btnName) {
      case "Save":
        // saveData();
        validateData();
        break;
      case "Clear":
        Get.delete<CompanyChannelLinkController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Exit":
        Get.find<HomeController>().postUserGridSetting2(listStateManager: [
          {"gridManager": gridManager},
        ], formName: "frmCompanyChannelLink");
        break;
      case "Search":
        Get.to(SearchPage(
            screenName: "Company Channel Link",
            isAppBarReq: true,
            isPopup: true,
            appBarName: "Company Channel Link",
            strViewName: "vTesting"));
        break;
    }
  }
}
