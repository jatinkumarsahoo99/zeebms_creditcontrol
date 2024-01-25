import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/station_master_controller.dart';

class StationMasterView extends GetView<StationMasterController> {
  StationMasterView({Key? key}) : super(key: key);

  StationMasterController controller =
      Get.put<StationMasterController>(StationMasterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .55,
          child: Dialog(
            backgroundColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: const Text('Station Master'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputFields.formFieldExpand2(
                        hintTxt: "Station",
                        controller: controller.stationName,
                        titleSizeboxWidth: 90,
                        autoFocus: true,
                        focusNode: controller.stationNameFN,
                      ),
                      Obx(
                        () => DropDownField.formDropDown1WidthMapExpand(
                          controller.relatedZone.value,
                          (value) {
                            controller.selectRelatedZone.value = value;
                          },
                          "Related Zone",
                          titleSizeBoxWidth: 85,
                          selected: controller.selectRelatedZone.value,
                          inkWellFocusNode: controller.relatedZoneFN,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Get.find<HomeController>().getCommonButton(
                        Routes.STATION_MASTER,
                        (btnName) {
                          controller.formHandler(btnName);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
