import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../providers/ApiFactory.dart';

class PayrouteCategoryMasterController extends GetxController {
  //TODO: Implement PayrouteCategoryMasterController

  // final count = 0.obs;

  final tecPayRouteCategory = TextEditingController().obs;
  var checkBoxSelected = false.obs;
  FocusNode payRouteFocus = FocusNode();
  var checkBoxStringValue = "";
  var payrouteCategoryCode = "";

  @override
  void onInit() {
    payRouteFocus.addListener(() {
      if (!payRouteFocus.hasFocus) {
        if (tecPayRouteCategory.value.text.isNotEmpty) {
          getRecord();
        }
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // getRecord(){
  //   LoadingDialog.call();
  //   Get.co
  // }

  getRecord() {
    tecPayRouteCategory.value.text =
        tecPayRouteCategory.value.text.toUpperCase();
    payrouteCategoryCode = "";
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.PAYROUTE_CATEGORY_MASTER_GET_RECORD(
        tecPayRouteCategory.value.text,
      ),
      fun: (resp) {
        Get.back();
        if (resp != null &&
            resp is Map<String, dynamic> &&
            resp.containsKey("retrieve")) {
          // tecPayRouteCategory.value.text =
          //     resp["retrieve"][0]["payrouteCategoryName"];
          payrouteCategoryCode = resp["retrieve"][0]["payrouteCategoryCode"];
          checkBoxStringValue = resp["retrieve"][0]["r4_YN"];
          if (checkBoxStringValue == "N") {
            checkBoxSelected.value = false;
          } else if (checkBoxStringValue == "Y") {
            checkBoxSelected.value = true;
          }
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

  saveRecord() {
    print("Save button tapped");
    if (tecPayRouteCategory.value.text.isEmpty) {
      LoadingDialog.showErrorDialog("Pay Route Category Name cannot be empty.");
    } else if (payrouteCategoryCode != "") {
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
    print("calling save record");
    var model = {
      "payrouteCategoryCode": payrouteCategoryCode,
      "payrouteCategoryName": tecPayRouteCategory.value.text,
      "r4_YN": checkBoxSelected.value
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.PAYROUTE_CATEGORY_MASTER_SAVE_RECORD,
      json: model,
      fun: (resp) {
        Get.back();
        if (resp != null &&
            resp is Map<String, dynamic> &&
            resp.toString().contains("successfully")) {
          LoadingDialog.callDataSaved(msg: resp["message"]);
        }
      },
    );
  }

  formHandler(btn) {
    switch (btn) {
      case "Clear":
        break;
      case "Save":
        // UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        saveRecord();
        break;
      case "Delete":
        break;
      case "Refresh":
        break;
      case "Exit":
        break;
      case "Docs":
        break;
    }
  }

  // void increment() => count.value++;
}
