import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../SalesExecutiveMasterModel.dart';
import '../SelectExecutiveModel.dart';

class SalesExecutiveMasterController extends GetxController {
  double widthRatio = 0.4;

  DropDownValue? selectSapName;
  DropDownValue? selectCompany;
  DropDownValue? selectLocation;
  DropDownValue? selectStation;
  DropDownValue? selectPlace;
  RxString sapCode = RxString("");
  RxString executiveName = RxString("");
  RxString department = RxString("");
  RxString designation = RxString("");
  RxString mobileno = RxString("");
  RxString email = RxString("");
  RxBool isActive = RxBool(false);
  SalesExecutiveMasterModel? masterModel;
  SelectExecutiveModel? selectExecutiveModel;

  @override
  void onInit() {
    getLoad();
    super.onInit();
  }

  getLoad() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.SALES_EXECUTIVE_MASTER_DATA,
        fun: (Map map) {
          if (map.containsKey("getload") && map["getload"] != null) {
            masterModel = SalesExecutiveMasterModel.fromJson(map["getload"]);
          }
          update(["main"]);
        });
  }

  getDetails() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.SALES_EXECUTIVE_DETAILS("", selectSapName?.key ?? ""),
        fun: (Map map) {
          // update(["listUpdate"]);
          if (map.containsKey("getRetrieve") && map["getRetrieve"] != null) {
            selectExecutiveModel =
                SelectExecutiveModel.fromJson(map["getRetrieve"][0]);
            sapCode.value = selectExecutiveModel?.personnelNo ?? "";
            executiveName.value = selectExecutiveModel?.employeeName ?? "";
            department.value = selectExecutiveModel?.department ?? "";
            designation.value = selectExecutiveModel?.designation ?? "";
            mobileno.value = selectExecutiveModel?.mobileNo ?? "";
            email.value = selectExecutiveModel?.email ?? "";
            isActive.value = selectExecutiveModel?.status == 0 ? false : true;
            if (selectExecutiveModel?.companyCode != null) {
              selectCompany = masterModel?.lstCompanyMaster1?.firstWhere(
                  (element) =>
                      element.key == (selectExecutiveModel?.companyCode ?? ""));
            } else {
              selectCompany = null;
            }
            if (selectExecutiveModel?.locationCode != null) {
              selectLocation = masterModel?.lstLocationMaster1?.firstWhere(
                  (element) =>
                      element.key ==
                      (selectExecutiveModel?.locationCode ?? ""));
            } else {
              selectLocation = null;
            }
            if (selectExecutiveModel?.stationCode != null) {
              selectStation = masterModel?.lstStationMaster1?.firstWhere(
                  (element) =>
                      element.key == (selectExecutiveModel?.stationCode ?? ""));
            } else {
              selectStation = null;
            }
            if (selectExecutiveModel?.placeCode != null) {
              selectPlace = masterModel?.lstPlaceMaster1?.firstWhere(
                  (element) =>
                      element.key == (selectExecutiveModel?.placeCode ?? ""));
            } else {
              selectPlace = null;
            }
          } else {
            selectExecutiveModel = null;
            sapCode.value = "";
            executiveName.value = "";
            department.value = "";
            designation.value = "";
            mobileno.value = "";
            email.value = "";
            isActive.value = false;
            selectCompany = null;
            selectLocation = null;
            selectStation = null;
            selectPlace = null;
          }
          update(["main"]);
        });
  }

  saveData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.SALES_EXECUTIVE_SAVE,
      json: {
        "personnelCode": selectSapName?.key ?? "",
        "userName": executiveName.value ?? "",
        "personnelName": selectExecutiveModel?.personnelName ?? "",
        "personnelShortName": selectExecutiveModel?.personnelShortName ?? "",
        "departmentCode": "<string>",
        "designationCode": "<string>",
        "locationCode": selectLocation?.key,
        "companyCode": selectCompany?.key,
        "address1": "<string>",
        "address2": "<string>",
        "placeCode": selectPlace?.key,
        "pin1": masterModel?.lstCompanyMaster![selectCompany?.selectedIndex??0].pin1,
        "phone": "<string>",
        "mobile": mobileno.value,
        "fax": "<string>",
        "email": email.value,
        "activeNonActive": isActive.value,
        "stationCode": selectStation?.key
      },
      fun: (Map map) {
        Get.back();
      },
    );
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        saveData();
        break;
      case "Clear":
        Get.delete<SalesExecutiveMasterController>();
        Get.find<HomeController>().clearPage1();
        break;
    }
  }
}
