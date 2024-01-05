import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
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
                  title: Text('Client Embargo'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        DropDownField.formDropDownSearchAPI2(
                            GlobalKey(), context,
                            title: "Place Type",
                            autoFocus: false,
                            customInData: "empList",
                            url: "",
                            // inkwellFocus: controllerX.employeeFocus,
                            // parseKeyForTitle: "programName",
                            parseKeyForKey: "employeecode",
                            parseKeyForValue: "employeename",
                            // selectedValue: controllerX.selectedEmployee.value,
                            onchanged: (data) {},
                            width: (Get.width * 0.4)),
                      ]
                  ),
                ),
                SizedBox(height: 6),

                /// bottom common buttons
                Align(
                  alignment: Alignment.topCenter,
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
