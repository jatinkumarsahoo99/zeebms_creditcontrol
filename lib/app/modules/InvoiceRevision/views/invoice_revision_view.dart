import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/invoice_revision_controller.dart';

class InvoiceRevisionView extends GetView<InvoiceRevisionController> {
  InvoiceRevisionView({Key? key}) : super(key: key);

  InvoiceRevisionController controller =
      Get.put<InvoiceRevisionController>(InvoiceRevisionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
      id: "init",
      init: controller,
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                runSpacing: 5,
                spacing: 5,
                children: [
                  DropDownField.formDropDown1WidthMap(
                    controller.location,
                    (value) {
                      controller.selectLocation.value = value;
                      controller.getChannel(value.key);
                    },
                    "Location",
                    .23,
                    selected: controller.selectLocation.value,
                    autoFocus: true,
                    inkWellFocusNode: controller.locationFN,
                    isEnable: controller.isEnable,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Obx(
                    () => DropDownField.formDropDown1WidthMap(
                      controller.channel,
                      (data) {
                        controller.selectChannel.value = data;
                      },
                      "Channel",
                      .23,
                      selected: controller.selectChannel.value,
                      inkWellFocusNode: controller.channelFN,
                      isEnable: controller.isEnable,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  DateWithThreeTextField(
                    title: "From Date",
                    mainTextController: controller.fromDate,
                    widthRation: .135,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FormButtonWrapper(
                    btnText: "Retrieve",
                    callback: () {
                      controller.getRetrieve();
                    },
                    showIcon: false,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: controller.retrieveList.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                      )
                    : DataGridFromMap3(
                        mapData: controller.retrieveList
                            .map((e) => e.toJson())
                            .toList(),
                        hideKeys: const ['currencytype'],
                        onload: (value) {
                          controller.stateManager = value.stateManager;
                        },
                        colorCallback: (colorEvent) {
                          if (colorEvent.row.cells.containsValue(
                              controller.stateManager?.currentCell)) {
                            return Colors.deepPurple.shade100;
                          }
                          return Colors.white;
                        },
                        onRowDoubleTap: (event) {
                          controller.stateManager
                              ?.setCurrentCell(event.cell, event.rowIdx);
                          controller.fillGridData(event);
                        },
                        exportFileName: "Invoice Revision",
                        widthSpecificColumn: Get.find<HomeController>()
                            .getGridWidthByKey(
                                userGridSettingList:
                                    controller.userGridSetting1?.value),
                      ),
              ),

              const SizedBox(
                // width: 40,
                height: 10,
              ),

              GetBuilder(
                  id: "textFieldUpdate",
                  init: controller,
                  builder: (controller) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "Location",
                                      controller: controller.locationTEC,
                                      isEnable: false,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "Channel",
                                      controller: controller.channelTEC,
                                      isEnable: false,
                                      titleSizeboxWidth: 55,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "SAP Invoice No",
                                      controller: controller.invoice,
                                      isEnable: false,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: DateWithThreeTextField(
                                      title: "Bill Date",
                                      mainTextController: controller.billDate,
                                      widthRation: .135,
                                      isEnable: false,
                                    ),
                                  ),
                                ],
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Client",
                                controller: controller.client,
                                isEnable: false,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Agency",
                                controller: controller.agencyTEC,
                                isEnable: false,
                              ),
                              InputFields.formFieldExpand2(
                                hintTxt: "Pay Route",
                                controller: controller.payRoute,
                                isEnable: false,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "Booking No",
                                      controller: controller.bookingNo,
                                      isEnable: false,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: InputFields.formFieldExpand2(
                                      hintTxt: "Booking Amt",
                                      controller: controller.bookingAmt,
                                      isEnable: false,
                                      titleSizeboxWidth: 55,
                                    ),
                                  ),
                                ],
                              ),
                              DropDownField.formDropDown1WidthMapExpand(
                                [],
                                (value) {},
                                "Brand",
                                autoFocus: true,
                                titleSizeBoxWidth: 75,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(
                                () =>
                                    DropDownField.formDropDownSearchAPI2Expand(
                                  GlobalKey(),
                                  context,
                                  title: "New Client",
                                  parseKeyForKey: "ClientCode",
                                  parseKeyForValue: "ClientName",
                                  url:
                                      ApiFactory.INVOICE_REVISION_SEARCH_CLIENT,
                                  onchanged: (value) {
                                    controller.selectNewClient.value = value;
                                    controller.clientLeave();
                                  },
                                  textSizeboxWidth: 85,
                                  selectedValue:
                                      controller.selectNewClient.value,
                                  dialogHeight: 200,
                                  inkwellFocus: controller.newClientFN,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(
                                () => DropDownField.formDropDown1WidthMapExpand(
                                  controller.agency,
                                  (value) {
                                    controller.selectAgency.value = value;
                                  },
                                  "New Agency",
                                  autoFocus: true,
                                  titleSizeBoxWidth: 75,
                                  selected: controller.selectAgency.value,
                                  inkWellFocusNode: controller.agencyFN,
                                  dialogHeight: 200,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(
                                () => DropDownField.formDropDown1WidthMapExpand(
                                  controller.payroute,
                                  (value) {
                                    controller.selectPayroute.value = value;
                                  },
                                  "New Payroute",
                                  autoFocus: true,
                                  titleSizeBoxWidth: 75,
                                  selected: controller.selectPayroute.value,
                                  inkWellFocusNode: controller.payrouteFN,
                                  dialogHeight: 200,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),

              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Get.find<HomeController>().getCommonButton(
                  Routes.INVOICE_REVISION,
                  handleAutoClear: false,
                  (btnName) {
                    controller.formHandler(btnName);
                  },
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
