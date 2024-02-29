import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

// import 'package:bms_programming/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/data/PermissionModel.dart';
import 'package:bms_creditcontrol/app/providers/Utils.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../data/DrawerModel.dart';
import '../data/user_data_settings_model.dart';
import '../providers/Aes.dart';
import '../providers/ApiFactory.dart';
import '../routes/app_pages.dart';
import 'ConnectorControl.dart';
import 'MainController.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  SubChild? selectChild;
  var selectChild1 = Rxn<SubChild>();
  List? buttons;

  bool isMoviePlannerPopupShown = false;

  @override
  void onInit() {
    getbuttondata();
    super.onInit();
  }

  getbuttondata() async {
    String value = await rootBundle.loadString('assets/json/buttons.json');
    buttons = json.decode(value);
    update(["buttons"]);
  }

  clearPage1() {
    String extractName = (html.window.location.href.split("?")[0])
        .split(ApiFactory.SPLIT_CLEAR_PAGE)[1];
    print("Extract name>>>>" + extractName);
    var uri = Uri.dataFromString(
        html.window.location.href); //converts string to a uri
    Map<String, String> params = uri.queryParameters;
    print("Params are>>>>" + params.toString());
    if (RoutesList.listRoutes.contains("/" + extractName)) {
      if (extractName == "frmDailyFPC") {
        html.window.location.reload();
      } else {
        String personalNo =
            Aes.encrypt(Get.find<MainController>().user?.personnelNo ?? "") ??
                "";
        String loginCode =
            (Aes.encrypt(Get.find<MainController>().user?.logincode ?? "") ??
                "");
        String formName =
            (Aes.encrypt(Get.find<MainController>().formName ?? "") ?? "");
        Get.offAndToNamed("/" + extractName, parameters: {
          "loginCode": loginCode,
          "personalNo": personalNo,
          "formName": formName
        });
      }
    }
  }

  void postUserGridSetting1(
      {required List<PlutoGridStateManager?>? listStateManager,
      List<String?>? tableNamesList}) {
    if (listStateManager == null || listStateManager.isEmpty) return;

    if (tableNamesList != null && tableNamesList.isNotEmpty) {
      tableNamesList.removeWhere((element) => element == null);
    }
    if (tableNamesList != null &&
        tableNamesList.isNotEmpty &&
        (tableNamesList.length != listStateManager.length)) return;

    List data = [];
    for (int i = 0; i < listStateManager.length; i++) {
      if (listStateManager[i] != null) {
        Map<String, dynamic> singleMap = {};
        listStateManager[i]?.columns.forEach((element) {
          singleMap[element.field] = element.width;
        });
        String? mapData = jsonEncode(singleMap);
        data.add({
          "formName":
              Get.find<MainController>().formName.replaceAll(" ", "") ?? "",
          "controlName":
              tableNamesList == null ? "${i + 1}_table" : tableNamesList[i],
          "userSettings": mapData
        });
      } else {
        continue;
      }
    }

    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.USER_SETTINGS,
        json: {"lstUserSettings": data},
        fun: (map) {});
  }

  Future<List<Map<String, Map<String, double>>>>? fetchUserSetting1() {
    Completer<List<Map<String, Map<String, double>>>> completer =
        Completer<List<Map<String, Map<String, double>>>>();
    List<Map<String, Map<String, double>>> data = [];
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api:
              "${ApiFactory.FETCH_USER_SETTING}?formName=${Get.find<MainController>().formName.replaceAll(" ", "")}",
          fun: (map) {
            if (map is Map &&
                map.containsKey("userSetting") &&
                map["userSetting"] != null) {
              map["userSetting"].forEach((e) {
                Map<String, Map<String, double>> userGridSettingMain = {};
                Map<String, double> userGridSetting = {};
                jsonDecode(e["userSettings"]).forEach((key, value) {
                  userGridSetting[key] = value;
                });
                userGridSettingMain[e["controlName"] ?? ""] = userGridSetting;
                // data.add(userGridSetting);
                data.add(userGridSettingMain);
              });
              completer.complete(data);
              // return data;
            } else {
              completer.complete(data);
              // return null;
            }
          });
    } catch (e) {
      completer.complete(data);
    }
    return completer.future;
  }

  Map<String, double> getGridWidthByKey(
      {String? key,
      required List<Map<String, Map<String, double>>>? userGridSettingList}) {
    Map<String, double> gridWidths = {};
    try {
      if (key != null && key != "") {
        if ((userGridSettingList?.length ?? 0) > 0) {
          for (int i = 0; i < (userGridSettingList?.length ?? 0); i++) {
            if (userGridSettingList?[i] != null) {
              if (((userGridSettingList?[i].keys.toList()) ?? [])
                  .contains(key ?? "")) {
                gridWidths =
                    userGridSettingList?[i][key] as Map<String, double>;
                break;
              } else {
                continue;
              }
            } else {
              continue;
            }
          }
          return gridWidths;
        } else {
          // print(">>>>>>>>>>>>>elsegridWidths" + gridWidths.toString());
          return gridWidths;
        }
      } else {
        if ((userGridSettingList?.length ?? 0) > 1) {
          for (int i = 0; i < (userGridSettingList?.length ?? 0); i++) {
            if (userGridSettingList?[i] != null) {
              if (((userGridSettingList?[i].keys.toList()) ?? [])
                  .contains("1_table")) {
                gridWidths =
                    userGridSettingList?[i]["1_table"] as Map<String, double>;
                break;
              } else {
                continue;
              }
            } else {
              continue;
            }
          }

          if (userGridSettingList?[0] != null && gridWidths.isEmpty) {
            gridWidths = (userGridSettingList?[0].values.first) ?? {};
          }
          // print(">>>>>>>>>>>>>ifgridWidths" + gridWidths.toString());
          return gridWidths;
        } else if ((userGridSettingList?.length ?? 0) == 1) {
          if (userGridSettingList?[0] != null) {
            gridWidths = (userGridSettingList?[0].values.first) ?? {};
          }
          // print(">>>>>>>>>>>>>ifgridWidths" + gridWidths.toString());
          return gridWidths;
        } else {
          return gridWidths;
        }
      }
    } catch (e) {
      print(">>>>>>>>>>>>" + e.toString());
      return gridWidths;
    }
  }

  void postUserGridSetting(
      {required List<PlutoGridStateManager> listStateManager}) {
    if (listStateManager == null || listStateManager.isEmpty) return;
    List data = [];
    for (int i = 0; i < listStateManager.length; i++) {
      Map<String, dynamic> singleMap = {};
      listStateManager[i].columns.forEach((element) {
        singleMap[element.field] = element.width;
      });
      String? mapData = jsonEncode(singleMap);
      data.add({
        "formName":
            Get.find<MainController>().formName.replaceAll(" ", "") ?? "",
        "controlName": (i + 1).toString() + "_table",
        "userSettings": mapData
      });
    }
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.USER_SETTINGS,
        json: {"lstUserSettings": data},
        fun: (map) {});
  }

  Future<List<Map<String, double>>>? fetchUserSetting() {
    List<Map<String, double>> data = [];
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.FETCH_USER_SETTING +
            "?formName=${Get.find<MainController>().formName}",
        fun: (map) {
          print("Data is>>" + jsonEncode(map));
          if (map is Map &&
              map.containsKey("userSetting") &&
              map["userSetting"] != null) {
            map["userSetting"].forEach((e) {
              Map<String, double> userGridSetting = {};
              jsonDecode(e["userSettings"]).forEach((key, value) {
                print("Data key is>>" +
                    key.toString() +
                    " value is>>>" +
                    value.toString());
                userGridSetting[key] = value;
              });
              data.add(userGridSetting);
            });
            return data;
          } else {
            return null;
          }
        });
  }

  void postUserGridSetting2(
      {required List<Map<String, PlutoGridStateManager?>> listStateManager,
        String? formName}) {
    if (listStateManager.isEmpty) return;
    var data = <Map<String, dynamic>>[];

    for (var element in listStateManager) {
      element.forEach(
            (key, value) {
          if (value != null) {
            Map<String, double> singleMap = {};
            for (var element in value.columns) {
              singleMap[element.field] = element.width;
            }
            data.add(
              UserSetting(
                formName: (formName?.replaceAll(' ', '')) ??
                    Get.find<MainController>().formName.replaceAll(" ", ""),
                controlName: key,
                userSettings: singleMap,
              ).toJson(),
            );
          }
        },
      );
    }
    if (data.isEmpty) return;
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.USER_SETTINGS,
      json: {"lstUserSettings": data},
      fun: (map) {},
    );
  }

  Future<UserDataSettings> fetchUserSetting2({String? formName}) {
    Completer<UserDataSettings> completer = Completer();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api:
      "${ApiFactory.FETCH_USER_SETTING}?formName=${(formName?.replaceAll(" ", "")) ?? Get.find<MainController>().formName.replaceAll(" ", "")}",
      fun: (map) {
        var userSettings = UserDataSettings.fromJson(map);
        return completer.complete(userSettings);
      },
    );
    return completer.future;
  }

  Widget getCommonButton<T>(
    String frmName,
    void Function(String btnName) btnName, {
    bool handleAutoClear = true,
    bool exitButtonNotUsed = true,
    List<String>? disableBtns,
    List<String>? buttonNameList,
  }) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      id: "buttons",
      builder: (controller) {
        if (frmName.contains("/")) {
          frmName = frmName.replaceAll("/", "");
        }
        PermissionModel? formPermissions =
            Get.find<MainController>().permissionList?.lastWhere(
          (element) {
            return element.appFormName == frmName;
          },
          orElse: () => PermissionModel(),
        );

        if ((controller.buttons?.length ?? 0) == 0 ||
            formPermissions?.delete == null) {
          if (controller.buttons?.isNotEmpty ?? false) {
            return const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Form Permission not found in permission list Please contact to ADMIN.",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Wrap(
            spacing: 5,
            runSpacing: 15,
            crossAxisAlignment: WrapCrossAlignment.start,
            // runAlignment: WrapAlignment.start,
            // alignment: WrapAlignment.start,
            children: [
              for (int index = 0;
                  index < (controller.buttons?.length ?? 0);
                  index++) ...{
                if (buttonNameList != null &&
                    buttonNameList.any(
                        (e) => controller.buttons![index]["name"].contains(e)))
                  ...{}
                else ...{
                  FormButtonWrapper(
                    btnText: controller.buttons?[index]["name"],
                    callback: (disableBtns != null &&
                            disableBtns
                                .contains(controller.buttons?[index]["name"]))
                        ? null
                        : Utils.btnAccessHandler2(
                                    controller.buttons?[index]['name'],
                                    controller,
                                    formPermissions!) ==
                                null
                            ? null
                            : () async {
                                btnName(controller.buttons?[index]['name']);
                                if (handleAutoClear &&
                                    controller.buttons?[index]['name'] ==
                                        "Clear") {
                                  if (RoutesList.listRoutes
                                      .contains("/" + frmName)) {
                                    try {
                                      await Get.delete<T>();
                                    } catch (e) {
                                      print(
                                          "Error while clearing a page ${e.toString()}");
                                    } finally {
                                      clearPage1();
                                    }
                                  } else {
                                    print(
                                        "Please add your route in RoutesList Class");
                                  }
                                }
                              },
                    exitButtonNotUsed: exitButtonNotUsed,
                  )
                }
              }
            ],
          ),
        );
      },
    );
  }

  Widget getCommonButtonWithSourceBtnLst<T>(
      String frmName,
      void Function(String btnName) btnName, {
        bool handleAutoClear = true,
        bool exitButtonNotUsed = true,
        List<String>? disableBtns,
        List<String>? buttonNameList,
        required List sourceButtons
      }) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      id: "buttons",
      builder: (controller) {
        if (frmName.contains("/")) {
          frmName = frmName.replaceAll("/", "");
        }
        PermissionModel? formPermissions =
        Get.find<MainController>().permissionList?.lastWhere(
              (element) {
            return element.appFormName == frmName;
          },
          orElse: () => PermissionModel(),
        );

        if ((sourceButtons?.length ?? 0) == 0 ||
            formPermissions?.delete == null) {
          if (sourceButtons?.isNotEmpty ?? false) {
            return const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Form Permission not found in permission list Please contact to ADMIN.",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Wrap(
            spacing: 5,
            runSpacing: 15,
            crossAxisAlignment: WrapCrossAlignment.start,
            // runAlignment: WrapAlignment.start,
            // alignment: WrapAlignment.start,
            children: [
              for (int index = 0;
              index < (sourceButtons?.length ?? 0);
              index++) ...{
                if (buttonNameList != null &&
                    buttonNameList.any(
                            (e) => sourceButtons![index]["name"].contains(e)))
                  ...{}
                else ...{
                  FormButtonWrapper(
                    btnText: sourceButtons?[index]["name"],
                    callback: (disableBtns != null &&
                        disableBtns
                            .contains(sourceButtons?[index]["name"]))
                        ? null
                        : Utils.btnAccessHandler2(
                        sourceButtons?[index]['name'],
                        controller,
                        formPermissions!) ==
                        null
                        ? null
                        : () async {
                      btnName(sourceButtons?[index]['name']);
                      if (handleAutoClear &&
                          sourceButtons?[index]['name'] ==
                              "Clear") {
                        if (RoutesList.listRoutes
                            .contains("/" + frmName)) {
                          try {
                            await Get.delete<T>();
                          } catch (e) {
                            print(
                                "Error while clearing a page ${e.toString()}");
                          } finally {
                            clearPage1();
                          }
                        } else {
                          print(
                              "Please add your route in RoutesList Class");
                        }
                      }
                    },
                    exitButtonNotUsed: exitButtonNotUsed,
                  )
                }
              }
            ],
          ),
        );
      },
    );
  }

}
