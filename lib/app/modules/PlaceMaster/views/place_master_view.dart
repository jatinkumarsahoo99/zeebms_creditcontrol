import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/place_master_controller.dart';

class PlaceMasterView extends GetView<PlaceMasterController> {
  PlaceMasterView({Key? key}) : super(key: key);

  PlaceMasterController controller =
      Get.put<PlaceMasterController>(PlaceMasterController());
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
                  title: const Text('Place Master'),
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
                        hintTxt: "Place Name",
                        controller: controller.placeName,
                        titleInLeft: true,
                        titleSizeboxWidth: 100,
                        autoFocus: true,
                      ),
                      DropDownField.formDropDown1WidthMapExpand(
                        [],
                        (value) {},
                        "Place type",
                        titleInLeft: true,
                        titleSizeBoxWidth: 95,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputFields.formFieldExpand2(
                        hintTxt: "Place Short Name",
                        controller: controller.placeShortName,
                        titleInLeft: true,
                        titleSizeboxWidth: 100,
                      ),
                      DropDownField.formDropDown1WidthMapExpand(
                        [],
                        (value) {},
                        "Parent Place Name",
                        titleInLeft: true,
                        titleSizeBoxWidth: 95,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropDownField.formDropDown1WidthMapExpand(
                        [],
                        (value) {},
                        "Zone Name",
                        titleInLeft: true,
                        titleSizeBoxWidth: 95,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputFields.formFieldExpand2(
                        hintTxt: "IBF Branch Code",
                        controller: controller.ibfBranchCode,
                        titleInLeft: true,
                        titleSizeboxWidth: 100,
                        // bottomPadding: false,
                      ),
                      InputFields.formFieldExpand2(
                        hintTxt: "SAP Code",
                        controller: controller.sapCode,
                        titleInLeft: true,
                        titleSizeboxWidth: 100,
                        // bottomPadding: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Get.find<HomeController>().getCommonButton(
                        Routes.PLACE_MASTER,
                        (btnName) {},
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
