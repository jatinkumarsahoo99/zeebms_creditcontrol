import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/station_master_controller.dart';

class StationMasterView extends GetView<StationMasterController> {
  const StationMasterView({Key? key}) : super(key: key);
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
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: 90,
                        // bottomPadding: false,
                      ),
                      // DropDownField.formDropDownSearchAPI2Expand(
                      //   GlobalKey(),
                      //   context,
                      //   title: "Related Zone",
                      //   url: "",
                      //   onchanged: (value) {},
                      //   titleInLeft: true,
                      //   textSizeboxWidth: 95,
                      // ),
                      DropDownField.formDropDown1WidthMapExpand(
                        [],
                        (value) {},
                        "Related Zone",
                        // .23,
                        // autoFocus: true,
                        titleInLeft: true,
                        titleSizeBoxWidth: 85,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Get.find<HomeController>().getCommonButton(
                        Routes.STATION_MASTER,
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
