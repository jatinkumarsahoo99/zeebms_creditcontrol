import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextFieldExpanded.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/client_group_master_controller.dart';

class ClientGroupMasterView extends GetView<ClientGroupMasterController> {
  const ClientGroupMasterView({Key? key}) : super(key: key);
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
                      InputFields.formFieldExpand2(
                        hintTxt: "Group Name",
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: 90,
                        // bottomPadding: false,
                      ),
                      InputFields.formFieldExpand2(
                        hintTxt: "Short Name",
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: 90,
                        // bottomPadding: false,
                      ),
                      DropDownField.formDropDownSearchAPI2Expand(
                        GlobalKey(),
                        context,
                        title: "Client Name",
                        url: "",
                        onchanged: (value) {},
                        titleInLeft: true,
                        textSizeboxWidth: 95,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputFields.formFieldExpand2(
                        hintTxt: "Creator",
                        controller: TextEditingController(),
                        titleInLeft: true,
                        titleSizeboxWidth: 90,
                        isEnable: false,
                        // bottomPadding: false,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                            ),
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
            ),
          ),
        ),
      ),
    );
  }
}
