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
        body: GetBuilder(
          init: controller,
          id: "placeMasterUpdate",
          builder: (controller) {
            return Center(
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
                              focusNode: controller.placeNameFN,
                              inputformatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                            DropDownField.formDropDown1WidthMapExpand(
                              controller.placeType.value,
                              (value) {
                                controller.selectPlaceType = value;
                              },
                              "Place type",
                              titleInLeft: true,
                              titleSizeBoxWidth: 95,
                              selected: controller.selectPlaceType,
                              dialogHeight: 290,
                              inkWellFocusNode: controller.placeTypeFN,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputFields.formFieldExpand2(
                              hintTxt: "Place Short Name",
                              controller: controller.placeShortName,
                              titleInLeft: true,
                              titleSizeboxWidth: 100,
                              inputformatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                            DropDownField.formDropDown1WidthMapExpand(
                              controller.parentPlaceName,
                              (value) {
                                controller.selectParentPlaceName = value;
                                print("==============");
                                print(controller.selectParentPlaceName?.key ??
                                    '0');
                                print(controller
                                    .placeMaster!
                                    .placeMasterOnLoad!
                                    .lstParentPlaceName![int.parse(
                                        controller.selectParentPlaceName?.key ??
                                            '0')]
                                    .parentPlaceCode);
                              },
                              "Parent Place Name",
                              titleInLeft: true,
                              titleSizeBoxWidth: 95,
                              selected: controller.selectParentPlaceName,
                              dialogHeight: 290,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropDownField.formDropDown1WidthMapExpand(
                              controller.zoneName,
                              (value) {
                                controller.selectZoneName = value;
                              },
                              "Zone Name",
                              titleInLeft: true,
                              titleSizeBoxWidth: 95,
                              selected: controller.selectZoneName,
                              dialogHeight: 290,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputFields.formFieldExpand2(
                              hintTxt: "IBF Branch Code",
                              controller: controller.ibfBranchCode,
                              titleInLeft: true,
                              titleSizeboxWidth: 100,
                              inputformatters: [
                                UpperCaseTextFormatter(),
                              ],
                              maxLen: 3,
                              // bottomPadding: false,
                            ),
                            InputFields.formFieldExpand2(
                              hintTxt: "SAP Code",
                              controller: controller.sapCode,
                              titleInLeft: true,
                              titleSizeboxWidth: 100,
                              inputformatters: [
                                UpperCaseTextFormatter(),
                              ],
                              maxLen: 2,

                              // bottomPadding: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Get.find<HomeController>().getCommonButton(
                              Routes.PLACE_MASTER,
                              handleAutoClear: false,
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
            );
          },
        ));
  }
}
