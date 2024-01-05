import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
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
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey))
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 14.0, left: 10, right: 0),
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
                  padding:
                  const EdgeInsets.only(top: 14.0, left: 10, right: 0),
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
                    try{
                      PermissionModel formPermissions =
                      Get.find<MainController>()
                          .permissionList!
                          .lastWhere((element) =>
                      element.appFormName ==
                          "frmGstPlantInfo");
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
                      }else{
                        return Container();
                      }
                    }catch(e){
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
