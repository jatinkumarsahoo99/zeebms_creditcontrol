import 'dart:convert';
import 'dart:html' as html;

// import 'package:bms_programming/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/app/data/PermissionModel.dart';
import 'package:bms_creditcontrol/app/providers/Utils.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../data/DrawerModel.dart';
import '../providers/Aes.dart';
import '../providers/ApiFactory.dart';
import '../routes/app_pages.dart';
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
    if (Routes.listRoutes.contains("/" + extractName)) {
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

  Widget getCommonButton<T>(
    String frmName,
    void Function(String btnName) btnName, {
    bool handleAutoClear = true,
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
