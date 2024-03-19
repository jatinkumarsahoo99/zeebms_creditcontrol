import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/place_type_master_controller.dart';

class PlaceTypeMasterView extends GetView<PlaceTypeMasterController> {
   PlaceTypeMasterView({Key? key}) : super(key: key);

   PlaceTypeMasterController controllerX =
  Get.put<PlaceTypeMasterController>(PlaceTypeMasterController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * .55,
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text('Place Type Master'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 16,top: 8),
                    child: InputFields.formField1WidthBox(
                        hintTxt: "Place Type",
                        controller: controllerX.placeTypeMasterController,
                        // width: 0.4,
                        // titleInLeft: true,
                        // titleSizeboxWidth: 45,
                        // fieldWidth: 0.1,
                         focus: controllerX.placeTypeFocus,
                         capital: true,
                         widthRatio: 0.4),
                  ),
                ),
                SizedBox(height: 15),

                /// bottom common buttons
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,left: 8,bottom: 0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
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
                                "frmPlaceTypeMaster");
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
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      key: GlobalKey(),
    );
  }
}
