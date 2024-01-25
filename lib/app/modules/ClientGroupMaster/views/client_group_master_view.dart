import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextFieldExpanded.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/client_group_master_controller.dart';

class ClientGroupMasterView extends GetView<ClientGroupMasterController> {
  ClientGroupMasterView({Key? key}) : super(key: key);

  final controller =
      Get.put<ClientGroupMasterController>(ClientGroupMasterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .55,
          child: Dialog(
              backgroundColor: Colors.grey[100],
              child: GetBuilder(
                  init: controller,
                  builder: (builder) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppBar(
                          title: const Text('Client Group Master'),
                          centerTitle: true,
                          backgroundColor: Colors.deepPurple,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => InputFields.formFieldExpand2(
                                  hintTxt: "Group Name",
                                  controller: controller.tecGroupName.value,
                                  // titleInLeft: true,
                                  titleSizeboxWidth: 90,
                                  // bottomPadding: false,
                                ),
                              ),
                              Obx(
                                () => InputFields.formFieldExpand2(
                                  hintTxt: "Short Name",
                                  controller: controller.tecShortName.value,
                                  // titleInLeft: true,
                                  titleSizeboxWidth: 90,
                                  // bottomPadding: false,
                                ),
                              ),
                              DropDownField.formDropDownSearchAPI2Expand(
                                GlobalKey(),
                                context,
                                title: "Client Name",
                                url: "",
                                onchanged: (value) {
                                  controller.selectedClientName = value;
                                },
                                // titleInLeft: true,
                                textSizeboxWidth: 95,
                                selectedValue: controller.selectedClientName,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => InputFields.formFieldExpand2(
                                  hintTxt: "Creator",
                                  controller: controller.tecCreator.value,
                                  // titleInLeft: true,
                                  titleSizeboxWidth: 90,
                                  isEnable: false,
                                  // bottomPadding: false,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Expanded(
                                  //   child: Container(
                                  //     height: 250,
                                  //     decoration: BoxDecoration(
                                  //       border: Border.all(color: Colors.grey),
                                  //     ),
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: Obx(() {
                                      return SizedBox(
                                        height: Get.height * 0.35,
                                        child: DataGridFromMap3(
                                          mapData: controller.gridData.value,
                                          //     .map((e) {
                                          //   if (e["changedon"] != null) {
                                          //     e['changedon'] = DateFormat(
                                          //             'dd-MM-yyyy hh:mm a')
                                          //         .format(DateFormat(
                                          //                 'yyyy-MM-ddThh:mm:ss')
                                          //             .parse(e['changedon']));
                                          //   }
                                          //   return e;
                                          // }).toList(),
                                          // onload: (event) {
                                          //   controller.sm = event.stateManager;
                                          // },
                                          // widthSpecificColumn:
                                          //     Get.find<HomeController>()
                                          //         .getGridWidthByKey(
                                          //   userGridSettingList: controller
                                          //       .userGridSetting1?.value,
                                          // ),
                                        ),
                                      );
                                    }),
                                  ),

                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        child: FormButton(
                                          btnText: "Add",
                                          callback: () {},
                                          showIcon: false,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: FormButton(
                                          btnText: "Remove",
                                          callback: () {},
                                          showIcon: false,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Get.find<HomeController>().getCommonButton(
                                Routes.CLIENT_GROUP_MASTER,
                                (btnName) {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  })),
        ),
      ),
    );
  }
}
