import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonSearch/views/common_search_view.dart';

class CreditRateMasterController extends GetxController {
  //TODO: Implement CreditRateMasterController

  // final count = 0.obs;
  final tecDescription = TextEditingController().obs;
  final tecGradeInShort = TextEditingController().obs;
  final tecLowerLimit = TextEditingController().obs;
  final tecUpperLimit = TextEditingController().obs;

  FocusNode descriptionFocus = FocusNode();
  var creditRateCode = "";
  // FocusNode descriptionFocus = FocusNode();

  @override
  void onInit() {
    super.onInit();
    descriptionFocus.addListener(() {
      if (!descriptionFocus.hasFocus) {
        if (tecDescription.value.text.isNotEmpty) {
          retrieveRecord();
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  retrieveRecord() {
    // tecDescription.value.text =
    //     tecPayRouteCategory.value.text.toUpperCase();
    creditRateCode = "";
    tecGradeInShort.value.clear();
    tecLowerLimit.value.clear();
    tecUpperLimit.value.clear();
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.CREDIT_RATE_MASTER_RETRIEVE_RECORD(
        tecDescription.value.text,
      ),
      fun: (resp) {
        Get.back();
        if (resp != null &&
            resp is Map<String, dynamic> &&
            resp.containsKey("crRecord") &&
            resp["crRecord"].isNotEmpty) {
          creditRateCode = resp["crRecord"][0]["creditRateCode"];
          tecGradeInShort.value.text =
              resp["crRecord"][0]["creditRateShortName"];
          tecLowerLimit.value.text =
              resp["crRecord"][0]["creditLowerLimit"].toString();
          tecUpperLimit.value.text =
              resp["crRecord"][0]["creditUpperLimit"].toString();
        }
      },
      failed: (resp) {
        Get.back();
        LoadingDialog.showErrorDialog(resp.toString());
      },
    );
  }

  onSaveClick() {
    // print("Save button tapped");
    // print(" code" + payrouteCategoryCode);
    if (tecDescription.value.text.isEmpty) {
      LoadingDialog.showErrorDialog("Description cannot be empty.");
    } else if (tecGradeInShort.value.text.isEmpty) {
      LoadingDialog.showErrorDialog("Grade In Short cannot be empty.");
    } else if (creditRateCode != "") {
      // LoadingDialog.recordExists(
      //     "Record Already exist! \n Do you want to modify it", callback: () {
      //   // callSaveRecord();
      // });
      LoadingDialog.recordExists(
        "Record Already exist! \n Do you want to modify it",
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
    if (tecLowerLimit.value.text.isEmpty) {
      tecLowerLimit.value.text = "0";
    }
    if (tecUpperLimit.value.text.isEmpty) {
      tecUpperLimit.value.text = "0";
    }
    var model = {
      "creditRateCode": creditRateCode,
      "creditRateName": tecDescription.value.text,
      "creditRateShortName": tecGradeInShort.value.text,
      "creditLowerLimit": double.tryParse(tecLowerLimit.value.text) ?? 0.0,
      "creditUpperLimit": double.tryParse(tecUpperLimit.value.text) ?? 0.0,
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.CREDIT_RATE_MASTER_SAVE_RECORD,
      json: model,
      fun: (resp) {
        Get.back();
        if (resp != null &&
            resp is Map<String, dynamic> &&
            resp.toString().contains("successfully")) {
          LoadingDialog.callDataSaved(
            msg: resp["save"],
            callback: () {
              callClear();
            },
          );
        }
      },
    );
  }

  callClear() {
    Get.delete<CreditRateMasterController>();
    Get.find<HomeController>().clearPage1();
  }

  formHandler(btn) {
    switch (btn) {
      case "Clear":
        callClear();

        break;
      case "Save":
        onSaveClick();
        // payRouteFocus.unfocus();
        // UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        // saveRecord();
        break;
      case "Delete":
        break;
      case "Refresh":
        break;
      case "Exit":
        break;
      case "Docs":
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("Credit Rate Master"),
            screenName: "Credit Rate Master",
            appBarName: "Credit Rate Master",
            strViewName: "vTesting",
            isAppBarReq: true,
          ),
        );
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void increment() => count.value++;
}
