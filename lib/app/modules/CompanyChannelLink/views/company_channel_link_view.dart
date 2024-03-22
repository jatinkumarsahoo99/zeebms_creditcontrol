import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/sized_box_widget.dart';
import '../../../controller/HomeController.dart';
import '../../../data/user_data_settings_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/company_channel_link_controller.dart';

class CompanyChannelLinkView extends GetView<CompanyChannelLinkController> {
  CompanyChannelLinkView({Key? key}) : super(key: key);

  CompanyChannelLinkController controller =
      Get.put<CompanyChannelLinkController>(
    CompanyChannelLinkController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<CompanyChannelLinkController>(
                  id: "init",
                  init: controller,
                  builder: (logic) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: FocusTraversalOrder(
                                      order: NumericFocusOrder(1),
                                      child: DropDownField
                                          .formDropDown1WidthMapExpand(
                                        controller.initData?.lstLocations ?? [],
                                        (value) {
                                          controller.selectLocation = value;
                                          controller.getChannel();
                                        },
                                        "Location Name",
                                        autoFocus: true,
                                        selected: controller.selectLocation,
                                      ),
                                    ),
                                  ),
                                  sizedBoxWidth(10),
                                  Expanded(
                                    child: Obx(() {
                                      return FocusTraversalOrder(
                                        order: NumericFocusOrder(2),
                                        child: DropDownField
                                            .formDropDown1WidthMapExpand(
                                          controller.channelList?.value ?? [],
                                          (value) {
                                            controller.selectChannel = value;
                                          },
                                          "Channel Name",
                                          // .23,
                                          // autoFocus: true,
                                          selected: controller.selectChannel,
                                          // titleInLeft: true,
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(5),
                              FocusTraversalOrder(
                                order: NumericFocusOrder(3),
                                child:
                                    DropDownField.formDropDown1WidthMapExpand(
                                        controller.initData?.lstfillComboRes
                                                ?.lstCollectionAgent ??
                                            [], (value) {
                                  controller.selectCollAgent = value;
                                }, "Collection Agent",
                                        // .23,
                                        // autoFocus: true,
                                        selected: controller.selectCollAgent
                                        // titleInLeft: true,
                                        ),
                              ),
                              sizedBoxHeight(5),
                              FocusTraversalOrder(
                                order: NumericFocusOrder(4),
                                child:
                                    DropDownField.formDropDown1WidthMapExpand(
                                        controller.initData?.lstfillComboRes
                                                ?.lstParents ??
                                            [], (value) {
                                  controller.selectParentCompany = value;
                                  controller.getSapProfile();
                                }, "Parent Company",
                                        // .23,
                                        // autoFocus: true,
                                        selected: controller.selectParentCompany
                                        // titleInLeft: true,
                                        ),
                              ),
                              sizedBoxHeight(5),
                              Obx(() {
                                return FocusTraversalOrder(
                                  order: NumericFocusOrder(7),
                                  child:
                                      DropDownField.formDropDown1WidthMapExpand(
                                          controller.sapProfileList?.value ??
                                              [], (value) {
                                    controller.selectSapProfCen = value;
                                  }, "Sap Profit Center",
                                          // .23,
                                          autoFocus: true,
                                          selected: controller.selectSapProfCen
                                          // titleInLeft: true,
                                          ),
                                );
                              }),
                            ],
                          ),
                        ),
                        sizedBoxWidth(10),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              FocusTraversalOrder(
                                order: NumericFocusOrder(5),
                                child:
                                    DropDownField.formDropDown1WidthMapExpand(
                                        controller.initData?.lstfillComboRes
                                                ?.lstPayRouteCategories ??
                                            [], (value) {
                                  controller.selectPayrouteCat = value;
                                }, "Payroute Category",
                                        // .23,
                                        // autoFocus: true,
                                        selected: controller.selectPayrouteCat
                                        // titleInLeft: true,
                                        ),
                              ),
                              sizedBoxHeight(5),
                              FocusTraversalOrder(
                                order: NumericFocusOrder(6),
                                child: DropDownField()
                                    .formDropDownCheckBoxMapExpanded(
                                  controller.initData?.lstfillComboRes
                                          ?.lstCurrencies ??
                                      [],
                                  (value) {
                                    // controller.selectCurrency = value;
                                  },
                                  "Currency",
                                  // 0.16,
                                  onChanged: (index, selectValue) {
                                    // controller.locations[index].isSelected = selectValue;
                                    controller
                                        .initData
                                        ?.lstfillComboRes
                                        ?.lstCurrencies![index]
                                        .isSelected = selectValue;
                                  },
                                  // showData:
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
              const SizedBox(height: 10),
              // Obx(
              //   () =>
              GetBuilder<CompanyChannelLinkController>(
                init: controller,
                id: "grid",
                builder: (logic) {
                  return Expanded(
                    child: (controller.initData != null &&
                            controller.initData?.companyChannelLinkDatas !=
                                null)
                        ? FocusTraversalOrder(
                            order: NumericFocusOrder(8),
                            child: DataGridFromMap(
                              showSrNo: true,
                              exportFileName: "Client Channel Link",
                              mode: PlutoGridMode.normal,
                              mapData: (controller
                                  .initData?.companyChannelLinkDatas
                                  ?.map((e) => e.toJson())
                                  .toList())!,

                              // mapData: (controllerX.dataList)!,
                              widthRatio: Get.width / 9 - 1,
                              onload: (PlutoGridOnLoadedEvent load) {
                                controller.gridManager = load.stateManager;
                              },
                              widthSpecificColumn: (controller
                                  .userDataSettings?.userSetting
                                  ?.firstWhere(
                                      (element) =>
                                          element.controlName == "gridManager",
                                      orElse: () => UserSetting())
                                  .userSettings),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                          ),
                  );
                },
              ),

              SizedBox(
                // width: 40,
                height: 10,
              ),
              FocusTraversalOrder(
                order: NumericFocusOrder(9),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Get.find<HomeController>().getCommonButton(
                    Routes.COMPANY_CHANNEL_LINK,
                    (btnName) {
                      controller.formHandler(btnName);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
