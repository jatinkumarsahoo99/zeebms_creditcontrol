import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../models/retrive_data_model.dart';

class CompanyMasterController extends GetxController {
  //TODO: Implement CompanyMasterController

  // final count = 0.obs;
  var cityList = <DropDownValue>[].obs;

  DropDownValue? selectedCity;

  final tecCompanyName = TextEditingController().obs;
  final tecShortName = TextEditingController().obs;
  final tecCorpAddress = TextEditingController().obs;
  final tecCorpAddress2 = TextEditingController();
  final tecPin = TextEditingController().obs;
  final tecTelephone = TextEditingController().obs;
  final tecFax = TextEditingController().obs;
  final tecRegdAddress = TextEditingController().obs;
  final tecRegdAddress2 = TextEditingController().obs;

  final tecPanCardNo = TextEditingController().obs;
  final tecSTC_No = TextEditingController().obs;
  final tecFormerCompany = TextEditingController().obs;
  final tecEmailAdreess = TextEditingController().obs;
  final tecWebSite = TextEditingController().obs;
  final tecCIN_Number = TextEditingController().obs;
  final tecLogoFile = TextEditingController().obs;
  final tecSAP_Code = TextEditingController().obs;
  final tecRemarks = TextEditingController().obs;
  final tecBlank1 = TextEditingController().obs;
  final tecBlank2 = TextEditingController().obs;

  FocusNode companyNameFN = FocusNode();

  String? companyCode;

  // var <RetriveDataModel>retriveData;
  // RetriveDataModel? retriveData;

  @override
  void onInit() {
    super.onInit();
    companyNameFN.addListener(() {
      if (!companyNameFN.hasFocus) {
        if (tecCompanyName.value.text.isNotEmpty) {
          callRetriveData();
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    onLoad();
  }

  onLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMPANY_MASTER_GETLOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          closeDialogIfOpen();
          if (map is Map &&
              map.containsKey("cmLoad") &&
              map['cmLoad']["lstCMPlace"] != null &&
              map['cmLoad']["lstCMPlace"].isNotEmpty) {
            map['cmLoad']["lstCMPlace"].forEach((e) {
              cityList.add(
                  DropDownValue(key: e["placecode"], value: e["placename"]));
            });
          }
        },
        failed: (map) {
          LoadingDialog.showErrorDialog(map);
        });
  }

  callRetriveData() {
    tecCompanyName.value.text = tecCompanyName.value.text.toUpperCase();
    // payrouteCategoryCode = "";
    companyCode = null;
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.COMPANY_MASTER_GET_GET_RETRIVE(
        companyCode: "",
        companyName: tecCompanyName.value.text,
      ),
      fun: (resp) {
        Get.back();
        if (resp != null &&
            resp is Map<String, dynamic> &&
            resp.containsKey("cmLoad") &&
            resp["cmLoad"]["lstCompanyM"] != null &&
            resp["cmLoad"]["lstCompanyM"].isNotEmpty) {
          RetriveDataModel? retriveData;

          retriveData = RetriveDataModel.fromJson(resp);
          var listData = retriveData.cmLoad!.lstCompanyM!.first;
          companyCode = listData.companyCode;
          tecShortName.value.text = listData.companyShortName ?? "";
          tecCorpAddress.value.text = listData.address1 ?? "";
          tecCorpAddress2.text = listData.address2 ?? "";
          tecTelephone.value.text = listData.phone ?? "";
          tecFax.value.text = listData.fax ?? "";
          tecEmailAdreess.value.text = listData.email ?? "";
          tecLogoFile.value.text = listData.logoFileName ?? "";
          tecPin.value.text = listData.pin ?? "";
          tecRegdAddress.value.text = listData.regdAddress1 ?? "";
          tecRegdAddress2.value.text = listData.regdAddress2 ?? "";

          tecPanCardNo.value.text = listData.panNumber ?? "";
          tecSTC_No.value.text = listData.stNumber ?? "";
          tecRemarks.value.text = listData.remark ?? "";

          tecSAP_Code.value.text = listData.sapCompanyCode ?? "";
          tecFormerCompany.value.text = listData.formerCompanyName ?? "";

          tecCIN_Number.value.text = listData.cinNumber ?? "";

          tecWebSite.value.text = listData.companyWebSitename ?? "";

          cityList.forEach((e) {
            if (e.key == listData.placeCode) {
              selectedCity = e;
              // update(["city"]);
              cityList.refresh();
              return;
            }
          });
          // tecCIN_Number.value.text = listData.cinNumber ?? "";
          // tecCIN_Number.value.text = listData.cinNumber ?? "";

          // tecPayRouteCategory.value.text =
          //     resp["retrieve"][0]["payrouteCategoryName"];
          // payrouteCategoryCode = resp["retrieve"][0]["payrouteCategoryCode"];
          // checkBoxStringValue = resp["retrieve"][0]["r4_YN"];
          // if (checkBoxStringValue == "N") {
          //   checkBoxSelected.value = false;
          // } else if (checkBoxStringValue == "Y") {
          //   checkBoxSelected.value = true;
          // }
          // dataTableList.addAll((resp['loadData'] as List<dynamic>)
          //     .map((e) => BlankTapeMasterModel.fromJson(e))
          //     .toList());
        }
      },
      failed: (resp) {
        Get.back();
        LoadingDialog.showErrorDialog(resp.toString());
      },
    );
  }

  onSaveRecord() {
    // print("Save button taspped");
    // print(" code" + payrouteCategoryCode);

    if (tecCompanyName.value.text.isEmpty) {
      LoadingDialog.showErrorDialog("Company Name cannot be empty");
    } else if (tecShortName.value.text.isEmpty) {
      LoadingDialog.showErrorDialog("Company Short Name cannot be empty.");
    } else if (tecShortName.value.text.isEmpty) {
      LoadingDialog.showErrorDialog("Corp Address cannot be empty.");
    } else if (selectedCity == null) {
      LoadingDialog.showErrorDialog("Please select a City");
    } else if (companyCode != null) {
      LoadingDialog.recordExists(
        "Record Already exist! \n Do you want to modify it?",
        () {
          callSaveRecord();
        },
      );
    } else {
      callSaveRecord();
    }
  }

  callSaveRecord() {
    // print("calling save record");
    var model = {
      "companyCode": companyCode ?? "",
      "companyName": tecCompanyName.value.text,
      "companyShortName": tecShortName.value.text,
      "address1": tecCorpAddress.value.text,
      "address2": tecCorpAddress2.value.text,
      "placeCode": selectedCity?.key ?? "",
      "phone": tecTelephone.value.text,
      "fax": tecFax.value.text,
      "email": tecEmailAdreess.value.text,
      "logoFileName": tecLogoFile.value.text,
      "pin": tecPin.value.text,
      "regdAddress1": tecRegdAddress.value.text,
      "regdAddress2": tecRegdAddress2.value.text,
      "panNumber": tecPanCardNo.value.text,
      "stNumber": tecSTC_No.value.text,
      "remark": tecRemarks.value.text,
      "sapCompanyCode": tecSAP_Code.value.text,
      "formerCompanyName": tecFormerCompany.value.text,
      "cinNumber": tecCIN_Number.value.text,
      "companyWebSitename": tecWebSite.value.text
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.COMPANY_MASTER_ONSAVE,
      json: model,
      fun: (resp) {
        Get.back();
        if (resp != null &&
            resp is Map<String, dynamic> &&
            resp.toString().contains("successfully")) {
          LoadingDialog.callDataSaved(
            msg: resp["message"],
            callback: () {
              callClear();
            },
          );
        }
      },
    );
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  callClear() {
    Get.delete<CompanyMasterController>();
    Get.find<HomeController>().clearPage1();
  }

  @override
  void onClose() {
    super.onClose();
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        onSaveRecord();
        break;
      case "Clear":
        // Get.delete<CompanyMasterController>();
        // Get.find<HomeController>().clearPage1();
        callClear();
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("Company Master"),
            screenName: "Company Master",
            appBarName: "Company Master",
            strViewName: "vTesting",
            isAppBarReq: true,
          ),
        );
        break;
      case "Exit":
        // print("Im in Exit");
        // try {
        //   Get.find<HomeController>().postUserGridSetting1(listStateManager: [
        //     loadInwardGrid,
        //   ]);
        // } catch (e) {
        //   print("Exit Error ===>" + e.toString());
        // }
        break;
    }
  }

  // void increment() => count.value++;
}
