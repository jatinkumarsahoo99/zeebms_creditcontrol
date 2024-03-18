import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../CommonDocs/controllers/common_docs_controller.dart';
import '../../CommonDocs/views/common_docs_view.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../ClientEmbargoHistoryModel.dart';
import '../ClientEmbargoModel.dart';

class ClientEmbargoController extends GetxController {
  //TODO: Implement ClientEmbargoController

  final count = 0.obs;
  var selectedTab = 0.obs;
  double fixedWidth = 0.52;
  ClientEmbargoModel? clientEmbargoModel;
  PlutoGridStateManager? stateManager;
  PlutoGridStateManager? stateManagerHistory;
  TextEditingController dateController = TextEditingController();
  TextEditingController embargoNoController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  Rxn<DropDownValue> selectedClient = Rxn<DropDownValue>(null);

  ClientEmbargoHistoryModel? clientEmbargoHistoryModel;

  getAllLoadData() {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.CLIENT_EMBARGO_ON_LOAD,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (kDebugMode) {
              print(">>>>>>>>>>mapData$map");
            }
            if (map is Map &&
                map['ceLoad'] != null &&
                map['ceLoad']['lstclientEmbs'] != null &&
                map['ceLoad']['lstclientEmbs'].length > 0) {
              clientEmbargoModel = ClientEmbargoModel.fromJson(map as Map<String, dynamic>);
              /*Future.delayed(Duration(seconds: 2),() {
                dateController.text = Utils.getMMDDYYYYFromDDMMYYYYInString3(
                    clientEmbargoModel?.ceLoad?.minfromDate ?? "");
              },);*/

              if (kDebugMode) {
                print(">>>>>>>>>>>>>>>>>>data${clientEmbargoModel?.toJson()}");
              }
              update(['grid1']);
            } else {
              clientEmbargoModel = null;
              update(['grid1']);
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  getClientNameClick({String? clientCode}) {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.CLIENT_EMBARGO_GET_CLIENT_NAME_CLICK + (clientCode ?? ""),
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map &&
                map['clientNameClick'] != null &&
                map['clientNameClick']['lstClient'] != null &&
                map['clientNameClick']['lstClient'].length > 0) {
              clientEmbargoHistoryModel =
                  ClientEmbargoHistoryModel.fromJson(map as Map<String, dynamic>);
              update(['grid2']);
            } else {
              clientEmbargoHistoryModel = null;
              update(['grid2']);
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  saveApiCall() {
    if (selectedClient.value == null) {
      LoadingDialog.showErrorDialog("Client Name cannot be empty.");
    } else if (reasonController.text.trim() == "") {
      LoadingDialog.showErrorDialog("Please enter reason.");
    } else {
      try {
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "clientcode": selectedClient.value?.key ?? "",
          "embargoNo": embargoNoController.text ?? "",
          "fromdate": (dateController.text) ?? "",
          "todate": (dateController.text) ?? "",
          "reason": reasonController.text ?? "",
          "strCode": "0"
        };
        if (kDebugMode) {
          print(">>>>>>>>>>postData$postData");
        }
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.CLIENT_EMBARGO_POST,
            json: postData,
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map && map['message'] != null) {
                LoadingDialog.callDataSaved(
                    msg: map['message'] ?? "Something went wrong",
                    callback: () {
                      clearAll();
                    });
              } else {
                LoadingDialog.showErrorDialog((map ?? "Something went wrong").toString());
              }
            },
            failed: (map) {
              closeDialogIfOpen();
              LoadingDialog.showErrorDialog((map ?? "Something went wrong").toString());
            });
      } catch (e) {
        closeDialogIfOpen();
        LoadingDialog.showErrorDialog("Something went wrong");
      }
    }
  }

  saveApiCallForClearEmbg({String? clientCode, String? embargoNo}) {
    if (clientCode == null || clientCode == "") {
      LoadingDialog.showErrorDialog("Client Name cannot be empty.");
    } else if (embargoNo == null || embargoNo == "") {
      LoadingDialog.showErrorDialog("Embargo no can not be empty.");
    } else {
      try {
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "clientcode": clientCode ?? "",
          "embargoNo": embargoNo ?? "",
          "fromdate": (dateController.text) ?? "",
          "todate": (dateController.text) ?? "",
          "reason": reasonController.text ?? "",
          "strCode": "0"
        };
        if (kDebugMode) {
          print(">>>>>>>>>>postData$postData");
        }
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.CLIENT_EMBARGO_POST,
            json: postData,
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map && map['message'] != null) {
                LoadingDialog.callDataSaved(
                    msg: map['message'] ?? "Something went wrong",
                    callback: () {
                      clearAll();
                    });
              } else {
                LoadingDialog.showErrorDialog((map ?? "Something went wrong").toString());
              }
            },
            failed: (map) {
              closeDialogIfOpen();
              LoadingDialog.showErrorDialog((map ?? "Something went wrong").toString());
            });
      } catch (e) {
        closeDialogIfOpen();
        LoadingDialog.showErrorDialog("Something went wrong");
      }
    }
  }

  btnClearEmbargo() {
    LoadingDialog.modify4("Want to clear embargo?", () {
      saveApiCallForClearEmbg(
          clientCode: stateManager
                  ?.rows[stateManager?.currentRowIdx ?? 0].cells['clientcode']?.value ??
              "",
          embargoNo: stateManager
                  ?.rows[stateManager?.currentRowIdx ?? 0].cells['embargoNo']?.value ??
              "");
    }, () {}, confirmTitle: "No", deleteTitle: "Yes");
  }

  clearAll() {
    Get.delete<ClientEmbargoController>();
    Get.find<HomeController>().clearPage1();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getAllLoadData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  String? strEmbargoNo = "";

  docs() async {
    String documentKey = "";
    if (embargoNoController.text == "") {
      documentKey = "";
    } else {
      documentKey = "ClientEmbargo ${embargoNoController.text}";
    }
    if (documentKey == "") {
      return;
    }
    Get.defaultDialog(
      title: "Documents",
      content: CommonDocsView(documentKey: documentKey),
    ).then((value) {
      Get.delete<CommonDocsController>(tag: "commonDocs");
    });
  }

  formHandler(String sta) {
    if (sta == "Clear") {
      clearAll();
    } else if (sta == "Save") {
      saveApiCall();
    } else if (sta == "Search") {
      Get.to(
        const SearchPage(
          key: Key("Client Embargo"),
          screenName: "Client Embargo",
          appBarName: "Client Embargo",
          strViewName: "VClientEmbargo",
          isAppBarReq: true,
        ),
      );
    } else if (sta == "Docs") {
      docs();
    }
  }
}
