import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/routes/app_pages.dart';
import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/dropdown.dart';
import 'package:bms_creditcontrol/widgets/gridFromMap.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controllers/payment_route_master_controller.dart';

class PaymentRouteMasterView extends GetView<PaymentRouteMasterController> {
  PaymentRouteMasterView({Key? key}) : super(key: key);

  PaymentRouteMasterController controller =
      Get.put<PaymentRouteMasterController>(PaymentRouteMasterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        id: 'routeUpdate',
        init: controller,
        builder: (controller) {
          return Center(
              child: SizedBox(
            width: Get.width * .50,
            child: Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    title: const Text('Payment Route Master'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      runSpacing: 5,
                      spacing: Get.width * 0.01,
                      children: [
                        InputFields.formField1(
                          hintTxt: "Pay Route Name",
                          controller: controller.payRouteName,
                          width: .34,
                          titleInLeft: true,
                          padLeft: 35,
                          inputformatters: [
                            UpperCaseTextFormatter(),
                          ],
                          focusNode: controller.payRouteNameFN,
                          autoFocus: true,
                        ),
                        InputFields.formField1(
                          hintTxt: "Short Name",
                          controller: controller.shortName,
                          width: .143,
                          titleInLeft: true,
                          padLeft: 58,
                          inputformatters: [
                            UpperCaseTextFormatter(),
                          ],
                        ),
                        DropDownField.formDropDown1WidthMap(
                          controller.currency,
                          (data) {
                            controller.selectCurrency = data;
                          },
                          "Currency",
                          .147,
                          titleInLeft: true,
                          selected: controller.selectCurrency,
                          dialogHeight: 300,
                          inkWellFocusNode: controller.currencyFN,
                        ),
                        DropDownField.formDropDown1WidthMap(
                          controller.loactions,
                          (data) {
                            controller.selectLocation = data;
                            controller.locationLeave(data.key.toString());
                          },
                          "Location Name",
                          .34,
                          titleInLeft: true,
                          padLeft: 42,
                          selected: controller.selectLocation,
                          dialogHeight: 280,
                          inkWellFocusNode: controller.locationFN,
                        ),
                        DropDownField.formDropDown1WidthMap(
                          controller.channel,
                          (data) {
                            controller.selectChannel = data;
                            controller.channelLeave(
                                controller.selectLocation?.key.toString() ?? "",
                                data.key.toString());
                          },
                          "Channel Name",
                          .34,
                          titleInLeft: true,
                          padLeft: 45,
                          selected: controller.selectChannel,
                          dialogHeight: 280,
                          inkWellFocusNode: controller.channelFN,
                        ),
                        InputFields.formField1(
                          hintTxt: "Main Company Share",
                          controller: controller.mainCompanyShare,
                          width: .34,
                          titleInLeft: true,
                          maxLen: 200,
                          padLeft: 12,
                          inputformatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        InputFields.formField1(
                          hintTxt: "Collection Agent Share",
                          controller: controller.collectionAgentShare,
                          width: .34,
                          titleInLeft: true,
                          maxLen: 200,
                          inputformatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        InputFields.formField1(
                          hintTxt: "Agency Share",
                          controller: controller.agencyShare,
                          width: .34,
                          titleInLeft: true,
                          padLeft: 50,
                          maxLen: 200,
                          inputformatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        DropDownField.formDropDown1WidthMap(
                          controller.sapCustGrp,
                          (data) {
                            controller.selectSapCustGrp = data;
                          },
                          "SAP Cust Grp",
                          .34,
                          titleInLeft: true,
                          padLeft: 51,
                          selected: controller.selectSapCustGrp,
                          dialogHeight: 280,
                          inkWellFocusNode: controller.sapCustGrpFN,
                        ),
                        DropDownField.formDropDown1WidthMap(
                          controller.billingPayRoute,
                          (data) {
                            controller.selectBillingPayRoute = data;
                          },
                          "Billing Pay Route",
                          .34,
                          titleInLeft: true,
                          padLeft: 35,
                          dialogHeight: 280,
                          selected: controller.selectBillingPayRoute,
                          inkWellFocusNode: controller.billingPayRouteFN,
                        ),
                        DropDownField.formDropDown1WidthMap(
                          controller.payRouteCategory,
                          (data) {
                            controller.selectPayRouteCategory = data;
                          },
                          "Pay Route Category",
                          .34,
                          titleInLeft: true,
                          padLeft: 21,
                          selected: controller.selectPayRouteCategory,
                          dialogHeight: 280,
                          inkWellFocusNode: controller.payRouteCategoryFN,
                        ),
                        const SizedBox(
                          width: 150,
                        ),
                        Obx(() {
                          return CheckBoxWidget1(
                            title: "To be billed",
                            value: controller.isToBeBilled.value,
                            onChanged: (val) {
                              controller.isToBeBilled.value =
                                  !(controller.isToBeBilled.value);
                            },
                          );
                        }),
                        Obx(() {
                          return CheckBoxWidget1(
                            title: "Active",
                            value: controller.isActive.value,
                            onChanged: (val) {
                              controller.isActive.value =
                                  !(controller.isActive.value);
                            },
                          );
                        }),
                        FormButtonWrapper(
                          btnText: "Service Tax",
                          callback: () {
                            serviceTaxDilogBox();
                          },
                          showIcon: false,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Get.find<HomeController>().getCommonButton(
                      Routes.PAYMENT_ROUTE_MASTER,
                      handleAutoClear: false,
                      (btnName) {
                        controller.formHandler(btnName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  serviceTaxDilogBox() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (_) {
        return Dialog(
          child: SizedBox(
              width: Get.width * 0.45,
              height: Get.height * 0.7,
              child: GetBuilder(
                init: controller,
                id: "serviceUpdate",
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        title: const Text('Service Tax'),
                        centerTitle: true,
                        backgroundColor: Colors.deepPurple,
                        automaticallyImplyLeading: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          runSpacing: 5,
                          spacing: Get.width * 0.01,
                          children: [
                            DropDownField.formDropDown1WidthMap(
                              controller.serviceLocation,
                              (data) {
                                controller.selectServiceLocation = data;
                                controller
                                    .getServiceChannel(data.key.toString());
                              },
                              "Location",
                              .39,
                              titleInLeft: true,
                              padLeft: 10,
                              selected: controller.selectServiceLocation,
                              autoFocus: true,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            DropDownField.formDropDown1WidthMap(
                              controller.serviceChannel,
                              (data) {
                                controller.selectServiceChannel = data;
                                controller.getServiceRetrieve(
                                    controller.selectServiceLocation?.value
                                            .toString() ??
                                        "",
                                    data.value.toString());
                              },
                              "Channel",
                              .39,
                              titleInLeft: true,
                              padLeft: 13,
                              selected: controller.selectServiceChannel,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => Expanded(
                          child: controller.serviceList.isEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: DataGridFromMap3(
                                    mapData: controller.serviceList,
                                    onload: (value) {
                                      controller.serviceGrid =
                                          value.stateManager;
                                    },
                                    exportFileName: "Payment Route Master",
                                    hideCode: false,
                                    widthSpecificColumn:
                                        Get.find<HomeController>()
                                            .getGridWidthByKey(
                                                userGridSettingList: controller
                                                    .userGridSetting1?.value),
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Get.find<HomeController>().getCommonButton(
                          Routes.PAYMENT_ROUTE_MASTER,
                          handleAutoClear: false,
                          disableBtns: ['Save', 'Delete'],
                          exitButtonNotUsed: false,
                          (btnName) {
                            controller.serviceTaxFormHandler(btnName);
                          },
                        ),
                      ),
                    ],
                  );
                },
              )),
        );
      },
    );
  }
}
