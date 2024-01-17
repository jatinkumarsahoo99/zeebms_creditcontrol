import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/g_s_t_plant_info_controller.dart';

class GSTPlantInfoView extends GetView<GSTPlantInfoController> {
  GSTPlantInfoView({Key? key}) : super(key: key);

  GSTPlantInfoController controllerX =
      Get.put<GSTPlantInfoController>(GSTPlantInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<GSTPlantInfoController>(
                id: "grid",
                builder: (controllerX) {
                  return Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: (controllerX.gstPlantInfoModel != null &&
                            controllerX.gstPlantInfoModel?.load != null &&
                            (controllerX.gstPlantInfoModel?.load?.length ?? 0) >
                                0)
                        ? DataGridFromMap(
                            showSrNo: true,
                            hideCode: false,
                            formatDate: false,
                            columnAutoResize: false,
                            doPasccal: true,editKeys: const ["plantCode","plantName","plantName2","coCode",
                      "companyName","houseNumberAndStreet","postalCode","city","countryKey","countryName","region","regionDescription"],
                            colorCallback: (row) => (row.row.cells
                                    .containsValue(
                                        controllerX.stateManager?.currentCell))
                                ? Colors.deepPurple.shade200
                                : Colors.white,
                            widthSpecificColumn: Get.find<HomeController>()
                                .getGridWidthByKey(
                                    key: "tbl1",
                                    userGridSettingList:
                                        controllerX.userGridSetting1),
                            exportFileName: "GST Plant Info",
                            mode: PlutoGridMode.normal,
                            mapData: (controllerX.gstPlantInfoModel!.load!
                                .map((e) => e.toJson())
                                .toList()),
                            // mapData: (controllerX.dataList)!,
                            widthRatio: Get.width / 9 - 1,
                            onload: (PlutoGridOnLoadedEvent load) {
                              controllerX.stateManager = load.stateManager;
                            },
                          )
                        : Container(),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0, left: 10, right: 0),
                  child: FormButtonWrapper(
                    btnText: "Add",
                    callback: () {
                      // controllerX.showApiCall();
                    },
                    showIcon: true,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0, left: 10, right: 0),
                  child: FormButtonWrapper(
                    btnText: "Remove",
                    callback: () {
                      // controllerX.showApiCall();
                    },
                    showIcon: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 9,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GetBuilder<HomeController>(
                  id: "buttons",
                  init: Get.find<HomeController>(),
                  builder: (controller) {
                    try {
                      PermissionModel formPermissions =
                          Get.find<MainController>().permissionList!.lastWhere(
                              (element) =>
                                  element.appFormName == "frmGstPlantInfo");
                      if (controller.buttons != null) {
                        return Wrap(
                          spacing: 5,
                          runSpacing: 15,
                          alignment: WrapAlignment.center,
                          children: [
                            for (var btn in controller.buttons!)
                              FormButtonWrapper(
                                btnText: btn["name"],
                                callback: Utils.btnAccessHandler2(btn['name'],
                                            controller, formPermissions) ==
                                        null
                                    ? null
                                    : () => controllerX.formHandler(
                                          btn['name'],
                                        ),
                              )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    } catch (e) {
                      return const Text("No Access");
                    }
                  }),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
