import 'package:bms_creditcontrol/app/providers/SizeDefine.dart';
import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextFieldExpanded.dart';
import 'package:bms_creditcontrol/widgets/LabelTextStyle.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/sized_box_widget.dart';
import '../../../../widgets/texts.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';
import '../../../routes/app_pages.dart';
import '../controllers/client_deals_controller.dart';

class ClientDealsView extends GetView<ClientDealsController> {
  ClientDealsView({Key? key}) : super(key: key);

  @override
  final controller = Get.put<ClientDealsController>(
    ClientDealsController(),
  );

  var rebuildKey = GlobalKey<ScaffoldState>();

  dragableDialogRemark() {
    controller.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.55,
          height: Get.height * 0.65,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                // color: Colors.grey[200],
                child: Stack(
                  fit: StackFit.expand,
                  // alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Remark',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.dialogWidget = null;
                          controller.canDialogShow.value = false;
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              InputFields.formField6(
                hintTxt: " ",
                controller: controller.remarkDiaController,
                // titleInLeft: true,
                // titleSizeboxWidth: 50,
                height: Get.height * 0.1,
                maxLen: 1000,
                maxLines: 10,
                contentPad: 15,
                width: 0.53,
                // bottomPadding: false,
                autoFocus: false,
              ),
              SizedBox(
                height: 4,
              ),
              FormButton1(
                btnText: "Add",
                callback: () {
                  // dragableDialogRemark();
                  controller.remarkAdd();
                },
              ),
              SizedBox(
                height: 4,
              ),
              Expanded(child: Container(
                child: Obx(() {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: (controller.remarkList != null &&
                        controller.remarkList.isNotEmpty) ? DataGridFromMap(
                      showSrNo: true,
                      hideCode: false,
                      formatDate: false,
                      columnAutoResize: true,
                      doPasccal: true,
                      colorCallback: (row) =>
                      (row.row.cells
                          .containsValue(
                          controller.remarkStateManager?.currentCell))
                          ? Colors.deepPurple.shade200
                          : Colors.white,
                      exportFileName: "Client Deals",
                      mode: PlutoGridMode.normal,
                      mapData: controller.remarkList.value,
                      // mapData: (controllerX.dataList)!,
                      widthRatio: Get.width / 9 - 1,
                      onload: (PlutoGridOnLoadedEvent load) {
                        controller.remarkStateManager =
                            load.stateManager;
                      },
                    ) : Container(),
                  );
                }),
              ))
            ],
          ),
        ),
      ),
    );
    controller.canDialogShow.value = true;
  }

  dragInfoDialog() {
    controller.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.55,
          height: Get.height * 0.65,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                // color: Colors.grey[200],
                child: Stack(
                  fit: StackFit.expand,
                  // alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Info',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.dialogWidget = null;
                          controller.canDialogShow.value = false;
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Expanded(child: Container(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: (controller.clientDealRetrieveModel != null &&
                      controller.clientDealRetrieveModel?.agencyLeaveModel !=
                          null &&
                      controller.clientDealRetrieveModel?.agencyLeaveModel
                          ?.addInfo != null &&
                      (controller.clientDealRetrieveModel?.agencyLeaveModel
                          ?.addInfo?.length ?? 0) > 0
                  ) ? DataGridFromMap(
                    showSrNo: true,
                    hideCode: false,
                    formatDate: false,
                    columnAutoResize: true,
                    doPasccal: true,
                    colorCallback: (row) =>
                    (row.row.cells
                        .containsValue(
                        controller.addInfoStateManager?.currentCell))
                        ? Colors.deepPurple.shade200
                        : Colors.white,
                    exportFileName: "Client Deals",
                    mode: PlutoGridMode.normal,
                    hideKeys: ["isrequired", "allowedvalues"],
                    mapData: controller.clientDealRetrieveModel!
                        .agencyLeaveModel!.addInfo!.
                    map((e) => e.toJson()).toList(),
                    // mapData: (controllerX.dataList)!,
                    widthRatio: Get.width / 9 - 1,
                    onload: (PlutoGridOnLoadedEvent load) {
                      controller.addInfoStateManager =
                          load.stateManager;
                    },
                  ) : Container(),
                ),
              )),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormButtonWrapper(
                    btnText: "DONE",
                    showIcon: false,
                    // isEnabled: btn['isDisabled'],
                    callback: () {
                      // controller.gridStateManagerLeft?.setFilter((element) => true);
                      // controller.gridStateManagerLeft?.notifyListeners();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    controller.canDialogShow.value = true;
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Scaffold(
              key: rebuildKey,
              floatingActionButton: Obx(() {
                return controller.canDialogShow.value
                    ? DraggableFab(
                  initPosition: controller.getOffSetValue(constraints),
                  child: controller.dialogWidget!,
                )
                    : const SizedBox();
              }),
              body: GetBuilder(
                init: controller,
                builder: (controller) {
                  print(Get.width * 0.2);
                  print(Get.width * 0.1);

                  return Padding(
                    padding:
                    const EdgeInsets.only(
                        left: 8.0, top: 3, right: 8, bottom: 2),
                    child: FocusTraversalGroup(
                      policy: OrderedTraversalPolicy(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              FocusTraversalOrder(
                                order: const NumericFocusOrder(0),
                                child: Expanded(
                                  child: Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.locationList.value ?? [],
                                          (value) {
                                        controller.selectedLocation?.value =
                                            value;
                                        controller.getChannel(
                                            locationCode: value.key ?? "");
                                      },
                                      "Location",
                                      // .20,
                                      autoFocus: true,
                                      titleInLeft: true,
                                      inkWellFocusNode: controller
                                          .locationFocus,
                                      selected: controller.selectedLocation
                                          ?.value,
                                      titleSizeBoxWidth: 45,
                                    );
                                  }),
                                ),
                              ),
                              sizedBoxWidth(10),
                              FocusTraversalOrder(
                                order: const NumericFocusOrder(1),
                                child: Expanded(
                                  child: Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                        controller.channelList.value ?? [],
                                            (data) {
                                          controller.selectedChannel?.value =
                                              data;
                                          controller.channelLeave();
                                        },
                                        "",
                                        inkWellFocusNode: controller
                                            .channelFocus,
                                        titleInLeft: true,
                                        selected: controller.selectedChannel
                                            ?.value,
                                        titleSizeBoxWidth: 50,
                                        autoFocus: false
                                      // onFocusChange: (val){
                                      //   if(val == false){
                                      //     controller.dealNoFocus.requestFocus();
                                      //   }
                                      // }
                                      // .20,
                                    );
                                  }),
                                ),
                              ),
                              sizedBoxWidth(10),
                              SizedBox(
                                width: Get.width * 0.2,
                                child: Obx(() {
                                  return Focus(
                                    skipTraversal: true,
                                    descendantsAreFocusable: false,
                                    child: DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.payMode.value ?? [],
                                          (data) {
                                        controller.selectPayMode?.value = data;
                                      },
                                      "Pay Mode",
                                      titleInLeft: true,
                                      autoFocus: false,
                                      selected: controller.selectPayMode?.value,
                                      titleSizeBoxWidth: 50,
                                      // .23,
                                    ),
                                  );
                                }),
                              ),
                              sizedBoxWidth(10),
                              SizedBox(
                                width: Get.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      // width: 50,
                                      color: Colors.grey.shade400,
                                      child: text_m_w700(
                                        "Search Deal",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FocusTraversalOrder(
                                        order: NumericFocusOrder(2),
                                        child: InputFields.formFieldExpand2(
                                          hintTxt: "Deal No",
                                          controller: controller
                                              .dealNoController,
                                          titleInLeft: true,
                                          titleSizeboxWidth: 50,
                                          focusNode: controller.dealNoFocus,
                                          bottomPadding: false,
                                          autoFocus: false,
                                        ),
                                      ),
                                    ),

                                    sizedBoxWidth(5),
                                    Expanded(
                                      child: FocusTraversalOrder(
                                        order: NumericFocusOrder(3),
                                        child: DateWithThreeTextFieldExpanded(
                                          title: "Date",
                                          mainTextController: controller
                                              .dateController,
                                          // widthRation: .135,
                                          titleInLeft: true,
                                        ),
                                      ),
                                    ),

                                    // InputFields.formField(hintTxt: hintTxt, controller: controller)
                                  ],
                                ),
                                // child: DropDownField.formDropDown1WidthMapExpand(
                                //   [],
                                //   (value) {},
                                //   "Location",
                                //   // .20,
                                //   autoFocus: true,
                                //   titleInLeft: true,
                                // ),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FocusTraversalOrder(
                                        order: const NumericFocusOrder(4),
                                        child: DateWithThreeTextFieldExpanded(
                                          title: "From",
                                          mainTextController:
                                          controller.fromDateController,
                                          // widthRation: .135,
                                          titleInLeft: true,
                                          titleInSizeBox: 50,
                                        ),
                                      ),
                                    ),

                                    sizedBoxWidth(5),
                                    Expanded(
                                      child: FocusTraversalOrder(
                                        order: const NumericFocusOrder(5),
                                        child: DateWithThreeTextFieldExpanded(
                                          title: "To",
                                          mainTextController: controller
                                              .toDateController,
                                          // widthRation: .135,
                                          titleInLeft: true,
                                          onFocusChange: (val, sta) {
                                            if (sta == false) {
                                              controller.clientFocus
                                                  .requestFocus();
                                            }
                                          },
                                        ),
                                      ),
                                    ),

                                    // InputFields.formField(hintTxt: hintTxt, controller: controller)
                                  ],
                                ),
                              ),
                              sizedBoxWidth(10),
                              SizedBox(
                                width: Get.width * 0.2,
                                child: Focus(
                                  skipTraversal: true,
                                  descendantsAreFocusable: false,
                                  child: Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.currency.value ?? [],
                                          (data) {
                                        controller.selectCurrency?.value = data;
                                      },
                                      "Currency",
                                      titleInLeft: true,
                                      autoFocus: false,
                                      selected: controller.selectCurrency
                                          ?.value,
                                      titleSizeBoxWidth: 50,
                                      // .23,
                                    );
                                  }),
                                ),
                              ),
                              sizedBoxWidth(10),
                              SizedBox(
                                width: Get.width * 0.2,
                                child: Focus(
                                  skipTraversal: true,
                                  descendantsAreFocusable: false,
                                  child: DropDownField
                                      .formDropDown1WidthMapExpand(
                                    controller.locationList2.value ?? [],
                                        (data) {
                                      controller.selectedLocation2?.value =
                                          data;
                                    },
                                    "Location",
                                    titleInLeft: true,
                                    autoFocus: false,
                                    selected: controller.selectedLocation2
                                        ?.value,
                                    titleSizeBoxWidth: 50,
                                    // .23,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Row(
                            children: [
                              Expanded(
                                child: FocusTraversalOrder(
                                  order: const NumericFocusOrder(6),
                                  child: Obx(() {
                                    return DropDownField
                                        .formDropDownSearchAPI2Expand(
                                        GlobalKey(), context,
                                        title: "Client",
                                        url:
                                        "${ApiFactory
                                            .Client_Deal_GET_CLIENTS}?locationCode=${controller
                                            .selectedLocation?.value
                                            ?.key}&channelCode=${controller
                                            .selectedChannel?.value
                                            ?.key}&clientName=",
                                        selectedValue: controller.selectedClient
                                            ?.value,
                                        onchanged: (value) {
                                          controller.selectedClient?.value =
                                              value;
                                          controller.clientsLeave();
                                        },
                                        textSizeboxWidth: 55,
                                        customInData: "clients",
                                        parseKeyForKey: "clientcode",
                                        parseKeyForValue: "clientname",
                                        titleInLeft: true,
                                        autoFocus: false,
                                        inkwellFocus: controller.clientFocus
                                    );
                                  }),
                                ),
                              ),
                              sizedBoxWidth(5),
                              Focus(
                                skipTraversal: true,
                                descendantsAreFocusable: false,
                                child: FormButton1(
                                  btnText: "@",
                                  callback: () {},
                                ),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: FocusTraversalOrder(
                                  order: NumericFocusOrder(7),
                                  child: Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                        controller.agencyList.value ?? [],
                                            (data) {
                                          controller.selectAgency?.value = data;
                                          controller.agencyLeave();
                                        },
                                        "Agency",
                                        selected: controller.selectAgency
                                            ?.value,
                                        titleInLeft: true,
                                        autoFocus: false,
                                        titleSizeBoxWidth: 50,
                                        inkWellFocusNode: controller.agencyFocus
                                      // .20,
                                    );
                                  }),
                                ),
                              ),
                              sizedBoxWidth(5),
                              Focus(
                                descendantsAreFocusable: false,
                                skipTraversal: true,
                                child: FormButton1(
                                  btnText: "@",
                                  callback: () {},
                                ),
                              ),
                              sizedBoxWidth(10),
                              SizedBox(
                                width: Get.width * 0.2,
                                child: FocusTraversalOrder(
                                  order: const NumericFocusOrder(13),
                                  child: Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.dealType.value ?? [],
                                          (data) {
                                        controller.selectDealType?.value = data;
                                      },
                                      "Deal Type",
                                      selected: controller.selectDealType
                                          ?.value,
                                      titleInLeft: true,
                                      autoFocus: false,
                                      titleSizeBoxWidth: 50,
                                      // .23,
                                    );
                                  }),
                                ),
                              ),
                              sizedBoxWidth(10),
                              SizedBox(
                                width: Get.width * 0.2,
                                child: Focus(
                                  skipTraversal: true,
                                  descendantsAreFocusable: false,
                                  child: DropDownField
                                      .formDropDown1WidthMapExpand(
                                    controller.channelList2.value ?? [],
                                        (data) {
                                      controller.selectedChannel2?.value = data;
                                      controller.getSearchClient();
                                    },
                                    "Channel",
                                    selected: controller.selectedChannel2
                                        ?.value,
                                    titleInLeft: true,
                                    autoFocus: false,
                                    titleSizeBoxWidth: 50,
                                    // .23,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FocusTraversalOrder(
                                        order: const NumericFocusOrder(8),
                                        child: InputFields.formFieldExpand2(
                                          hintTxt: "Reference",
                                          controller: controller
                                              .referenceController,
                                          titleInLeft: true,
                                          titleSizeboxWidth: 50,
                                          bottomPadding: false,
                                          autoFocus: false,
                                        ),
                                      ),
                                    ),

                                    sizedBoxWidth(5),
                                    Expanded(
                                      child: FocusTraversalOrder(
                                        order: NumericFocusOrder(9),
                                        child: DateWithThreeTextFieldExpanded(
                                          title: "Reference Date",
                                          mainTextController:
                                          controller.referenceDateController,
                                          // widthRation: .135,
                                          titleInLeft: true,
                                          titleInSizeBox: 50,
                                        ),
                                      ),
                                    ),

                                    // InputFields.formField(hintTxt: hintTxt, controller: controller)
                                  ],
                                ),
                                // child: DropDownField.formDropDown1WidthMapExpand(
                                //   [],
                                //   (value) {},
                                //   "Location",
                                //   // .20,
                                //   autoFocus: true,
                                //   titleInLeft: true,
                                // ),
                              ),
                              sizedBoxWidth(10),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FocusTraversalOrder(
                                        order: NumericFocusOrder(10),
                                        child: Obx(() {
                                          return DropDownField
                                              .formDropDown1WidthMapExpand(
                                            controller.brandList.value ?? [],
                                                (data) {
                                              controller.selectBrand?.value =
                                                  data;
                                            },
                                            "Brand",
                                            titleInLeft: true,
                                            autoFocus: false,
                                            selected: controller.selectBrand
                                                ?.value,
                                            titleSizeBoxWidth: 50,
                                            // .20,
                                          );
                                        }),
                                      ),
                                    ),
                                    sizedBoxWidth(5),
                                    Focus(
                                      skipTraversal: true,
                                      descendantsAreFocusable: false,
                                      child: FormButton1(
                                        btnText: "...",
                                        callback: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              sizedBoxWidth(10),
                              SizedBox(
                                width: Get.width * 0.2,
                                child: Focus(
                                  skipTraversal: true,
                                  descendantsAreFocusable: false,
                                  child: InputFields.numbers4(
                                    hintTxt: "Bk Dur",
                                    controller: controller.bkDurationController,
                                    titleInLeft: true,
                                    titleSizeboxWidth: 45,
                                  ),
                                ),
                              ),
                              sizedBoxWidth(10),
                              SizedBox(
                                width: Get.width * 0.2,
                                child: Focus(
                                  skipTraversal: true,
                                  descendantsAreFocusable: false,
                                  onFocusChange: (sta) {
                                    if (!sta) {
                                      print(">>>>>>clientFocusLoss");
                                    }
                                  },
                                  child: Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.clientList2.value ?? [],
                                          (data) {
                                        controller.selectedClient2?.value =
                                            data;
                                        controller.getSearchDealNumber();
                                      },
                                      "Client",
                                      titleInLeft: true,
                                      selected: controller.selectedClient2
                                          ?.value,
                                      titleSizeBoxWidth: 50,
                                      // .23,
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: FocusTraversalOrder(
                                                  order: NumericFocusOrder(11),
                                                  child: InputFields.numbers4(
                                                    hintTxt: "Max Speed",
                                                    controller:
                                                    controller
                                                        .maxSpeedController,
                                                    titleInLeft: true,
                                                    titleSizeboxWidth: 40,
                                                  ),
                                                ),
                                              ),

                                              sizedBoxWidth(5),
                                              Expanded(
                                                child: Focus(
                                                  skipTraversal: true,
                                                  descendantsAreFocusable: false,
                                                  child: InputFields.numbers4(
                                                    hintTxt: "Amount",
                                                    controller:
                                                    controller.amountController,
                                                    titleInLeft: true,
                                                    // titleSizeboxWidth: 45,
                                                  ),
                                                ),
                                              ),

                                              // InputFields.formField(hintTxt: hintTxt, controller: controller)
                                            ],
                                          ),
                                          // child: DropDownField.formDropDown1WidthMapExpand(
                                          //   [],
                                          //   (value) {},
                                          //   "Location",
                                          //   // .20,
                                          //   autoFocus: true,
                                          //   titleInLeft: true,
                                          // ),
                                        ),
                                        sizedBoxWidth(10),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Focus(
                                                  descendantsAreFocusable: false,
                                                  skipTraversal: true,
                                                  child: InputFields.numbers4(
                                                    hintTxt: "Seconds",
                                                    controller:
                                                    controller
                                                        .secondsController,
                                                    titleInLeft: true,
                                                    titleSizeboxWidth: 45,
                                                  ),
                                                ),
                                              ),

                                              sizedBoxWidth(5),
                                              Expanded(
                                                child: FocusTraversalOrder(
                                                  order: const NumericFocusOrder(
                                                      12),
                                                  child: Obx(() {
                                                    return CheckBoxWidget1(
                                                      title: "Effective Rate",
                                                      value: controller
                                                          .effectiveRate
                                                          .value,
                                                      onChanged: (val) {
                                                        controller.effectiveRate
                                                            .value = val!;
                                                        controller.effectiveRate
                                                            .refresh();
                                                      },
                                                    );
                                                  }),
                                                ),
                                              ),

                                              // InputFields.formField(hintTxt: hintTxt, controller: controller)
                                            ],
                                          ),
                                        ),
                                        sizedBoxWidth(10),
                                        SizedBox(
                                          width: Get.width * 0.2,
                                          child: Focus(
                                            skipTraversal: true,
                                            descendantsAreFocusable: false,
                                            child: InputFields.numbers4(
                                              hintTxt: "Bk Amt",
                                              controller: controller
                                                  .bkAmountController,
                                              titleInLeft: true,
                                              titleSizeboxWidth: 45,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    sizedBoxHeight(5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child:
                                                LabelText2.style(
                                                    hint: "Executive"),
                                              ),
                                              Obx(() {
                                                return text_m_w700(
                                                    controller.executive
                                                        .value ?? "");
                                              }),
                                            ],
                                          ),
                                        ),
                                        sizedBoxWidth(10),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 150,
                                                    child: LabelText2.style(
                                                        hint: "Payroute"),
                                                  ),
                                                  Obx(() {
                                                    return text_m_w700(
                                                      controller.payroute
                                                          .value ?? "",
                                                    );
                                                  }),
                                                ],
                                              ),
                                              text_m_w700(
                                                "sssssss",
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        ),
                                        sizedBoxWidth(10),
                                        SizedBox(
                                          width: Get.width * 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50),
                                            child: text_m_w700(
                                              "sssssss",
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    sizedBoxHeight(5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: LabelText2.style(
                                                    hint: "Zone"),
                                              ),
                                              Obx(() {
                                                return text_m_w700(
                                                    controller.zone.value ??
                                                        "");
                                              }),
                                            ],
                                          ),
                                        ),
                                        sizedBoxWidth(10),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 150,
                                                    child: LabelText2.style(
                                                        hint: "Agency Pan Card"),
                                                  ),
                                                  Obx(() {
                                                    return text_m_w700(
                                                      controller.agencyPanNumber
                                                          .value ?? "",
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        sizedBoxWidth(10),
                                        SizedBox(
                                          width: Get.width * 0.2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              sizedBoxWidth(10),
                              SizedBox(
                                width: Get.width * 0.2,
                                height: Get.height * 0.1,
                                child: Obx(() {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(
                                            width: 1.0, color: Colors.grey)),
                                    child: Scrollbar(
                                      controller: controller.scrollController,
                                      thumbVisibility: true,
                                      child: ListView.builder(
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.selectedDealNo
                                                    .value =
                                                    index;
                                                controller.selectedDealNo
                                                    .refresh();
                                                controller.retrieveRecord(
                                                    locationCode: controller
                                                        .selectedLocation2
                                                        ?.value
                                                        ?.key,
                                                    channelCode: controller
                                                        .selectedChannel2?.value
                                                        ?.key,
                                                    clientCode: controller
                                                        .selectedClient2?.value
                                                        ?.key,
                                                    agencyCode: controller
                                                        .selectAgency?.value
                                                        ?.key,
                                                    dealNumber: controller
                                                        .dealNoList
                                                        .value[index]
                                                    ['dealnumber']);
                                              },
                                              child: Obx(() {
                                                return Container(
                                                  color:
                                                  (controller.selectedDealNo
                                                      .value ==
                                                      index)
                                                      ? Colors.deepPurpleAccent
                                                      : Colors.white,
                                                  child: Text(
                                                      controller.dealNoList
                                                          .value[index]
                                                      ['dealnumber'] ??
                                                          "",
                                                      style: TextStyle(
                                                          color: (controller
                                                              .selectedDealNo
                                                              .value ==
                                                              index)
                                                              ? Colors.white
                                                              : Colors.black)),
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                        itemCount: controller.dealNoList.length,
                                        controller: controller.scrollController,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: text_m_w700(
                                  "GST Plant Name",
                                  color: Colors.green,
                                ),
                              ),
                              Obx(() {
                                return text_m_w700(
                                  controller.gstPlantName.value ?? "",
                                  color: Colors.green,
                                );
                              }),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: 150,
                                  child: LabelText3.style(
                                      hint: "AgencyGSTNumber")),
                              Obx(() {
                                return text_m_w700(
                                  controller.agencyGstNumber.value ?? "",
                                );
                              }),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),

                          sizedBoxHeight(2),

                          /* Row(
                      children: [
                        SizedBox(
                            width: 150,
                            child: LabelText2.style(hint: "AgencyGSTNumber")),
                        text_m_w700(
                          "Label42",
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),*/

                          Row(
                            // runSpacing: 10,
                            // spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // LabelText2.style(hint: "Type")
                              CheckBoxOnRight(
                                  title: "Type",
                                  top: 14,
                                  value: controller.type.value,
                                  onChanged: (val) {
                                    controller.type.value = val!;
                                    controller.accountEnaSta.value = val;
                                    controller.accountEnaSta.refresh();
                                  }),

                              Obx(() {
                                return DropDownField.formDropDown1WidthMap(
                                    controller.accountList.value ?? [], (data) {
                                  controller.selectAccount?.value = data;
                                }, "Account", .18,
                                    selected: controller.selectAccount?.value,
                                    isEnable: controller.accountEnaSta.value
                                  // titleInLeft: true,
                                );
                              }),
                              Obx(() {
                                return DropDownField.formDropDown1WidthMap(
                                  controller.subTypeList.value ?? [],
                                      (data) {
                                    controller.selectSubType?.value = data;
                                  },
                                  selected: controller.selectSubType?.value,
                                  isEnable: controller.accountEnaSta.value,
                                  "Sub Type",
                                  .18,
                                  // titleInLeft: true,
                                );
                              }),
                              DropDownField.formDropDown1WidthMap(
                                  controller.spotTypeList.value ?? [], (data) {
                                controller.selectSpotType?.value = data;
                              }, "Spot Type", .18,
                                  selected: controller.selectSpotType?.value
                                // titleInLeft: true,
                              ),
                              SizedBox(
                                width: Get.width * .18,
                                child: DropDownField
                                    .formDropDownSearchAPI2Expand(
                                  GlobalKey(),
                                  context,
                                  title: "Program",
                                  url: "",
                                  onchanged: (value) {},
                                  // width: Get.width * 0.3,
                                  // titleInLeft: true,
                                  textSizeboxWidth: 60,
                                ),
                              ),
                              DropDownField.formDropDown1WidthMap(
                                  controller.bandList.value ?? [], (data) {
                                controller.selectBand?.value = data;
                              }, "Band", .18,
                                  selected: controller.selectBand?.value
                                // titleInLeft: true,
                              ),
                            ],
                          ),

                          const SizedBox(height: 3),

                          Obx(() {
                            return Row(
                              // runSpacing: 5,
                              // spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // LabelText2.style(hint: "Type")

                                DropDownField.formDropDown1WidthMap(
                                    controller.addInfoList.value ?? [], (data) {
                                  controller.selectAddInfo?.value = data;
                                }, "AddInfo", .18,
                                    selected: controller.selectAddInfo?.value
                                  // titleInLeft: true,
                                ),
                                // Spacer(),

                                CheckBoxOnRight(
                                    title: "Week End",
                                    value: controller.weekEnd.value,
                                    onChanged: (val) {
                                      controller.weekEnd.value = val!;
                                      controller.weekend(val);
                                    }),
                                sizedBoxWidth(20),
                                CheckBoxOnRight(
                                    title: "Week Day",
                                    onChanged: (val) {
                                      controller.weekDay.value = val!;
                                      controller.weekDayFun(val);
                                    },
                                    value: controller.weekDay.value),
                                sizedBoxWidth(20),
                                CheckBoxOnRight(
                                    title: "Mon",
                                    value: controller.mon.value,
                                    onChanged: (val) {
                                      controller.mon.value = val!;
                                    }),
                                CheckBoxOnRight(
                                    title: "Tue",
                                    value: controller.tue.value,
                                    onChanged: (val) {
                                      controller.tue.value = val!;
                                    }),
                                CheckBoxOnRight(
                                    title: "Wed",
                                    value: controller.wed.value,
                                    onChanged: (val) {
                                      controller.wed.value = val!;
                                    }),
                                CheckBoxOnRight(
                                    title: "Thu",
                                    value: controller.thu.value,
                                    onChanged: (val) {
                                      controller.thu.value = val!;
                                    }),
                                CheckBoxOnRight(
                                    title: "Fri",
                                    value: controller.fri.value,
                                    onChanged: (val) {
                                      controller.fri.value = val!;
                                    }),
                                CheckBoxOnRight(
                                    title: "Sat",
                                    value: controller.sat.value,
                                    onChanged: (val) {
                                      controller.sat.value = val!;
                                    }),
                                CheckBoxOnRight(
                                    title: "Sun",
                                    value: controller.sun.value,
                                    onChanged: (val) {
                                      controller.sun.value = val!;
                                    }),
                                InputFields.formFieldNumberMask(
                                  hintTxt: "Start Time",
                                  controller: controller.startTime,
                                  widthRatio: 0.08,

                                  // isEnable: controllerX.isEnable,
                                  onEditComplete: (val) {
                                    // controllerX.calculateDuration();
                                  },
                                  // isTime: true,
                                  // isEnable: controller.isEnable.value,
                                  paddingLeft: 0,
                                ),

                                InputFields.formFieldNumberMask(
                                  hintTxt: "End Time",
                                  controller: controller.endTime,
                                  widthRatio: 0.08,
                                  // isEnable: controllerX.isEnable,
                                  onEditComplete: (val) {
                                    // controllerX.calculateDuration();
                                  },
                                  // isTime: true,
                                  // isEnable: controller.isEnable.value,
                                  paddingLeft: 0,
                                ),
                              ],
                            );
                          }),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(
                              //   width: Get.width * 0.15,
                              //   child: InputFields.formFieldExpand2(
                              //     hintTxt: "End time",
                              //     controller: TextEditingController(),
                              //     titleInLeft: true,
                              //     titleSizeboxWidth: 50,
                              //     bottomPadding: false,
                              //   ),
                              // ),

                              // Spacer(),

                              SizedBox(
                                width: Get.width * 0.18,
                                child: InputFields.numbers4(
                                    hintTxt: "Seconds",
                                    controller: controller.secondsController2,
                                    // titleInLeft: true,
                                    // titleSizeboxWidth: 45,
                                    fieldWidth: 0.1,
                                    padLeft: 0),
                              ),
                              SizedBox(
                                width: 5,
                              ),

                              SizedBox(
                                width: Get.width * 0.18,
                                child: InputFields.numbers4(
                                  hintTxt: "Rate per 100 seconds",
                                  controller: controller
                                      .ratePerTenSecondsController,
                                  // titleInLeft: true,
                                  // titleSizeboxWidth: 45,
                                  fieldWidth: 0.15,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: Get.width * 0.18,
                                child: InputFields.numbers4(
                                  hintTxt: "Amount",
                                  controller: controller.amountController2,
                                  // titleInLeft: true,
                                  // titleSizeboxWidth: 45,
                                  fieldWidth: 0.15,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: Get.width * 0.18,
                                child: InputFields.numbers4(
                                  hintTxt: "Val Rate",
                                  controller: controller.valueRateController,
                                  // titleInLeft: true,
                                  // titleSizeboxWidth: 45,
                                  fieldWidth: 0.15,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 5,
                            spacing: 10,
                            children: [
                              FormButton1(
                                btnText: "Add",
                                callback: () {},
                              ),
                              FormButton1(
                                btnText: "Clear",
                                callback: () {},
                              ),
                              FormButton1(
                                btnText: "Duplicate",
                                callback: () {},
                              ),
                              sizedBoxWidth(100),
                              FormButton1(
                                btnText: "Remarks",
                                callback: () {
                                  dragableDialogRemark();
                                },
                              ),
                              FormButton1(
                                btnText: "Compare",
                                callback: () {},
                              ),
                              sizedBoxWidth(100),
                              FormButton1(
                                btnText: "Import",
                                callback: () {
                                  controller.pickFile();
                                },
                              ),
                              text_m_w700("xxx", color: Colors.blue)
                            ],
                          ),

                          const SizedBox(height: 3),
                          // Obx(
                          //   () =>
                          Expanded(
                            child: GetBuilder<ClientDealsController>(
                              // assignId: true,
                              id: "grid",
                              builder: (controller) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: (controller.clientDealRetrieveModel !=
                                      null &&
                                      controller.clientDealRetrieveModel?.
                                      agencyLeaveModel != null &&
                                      controller.clientDealRetrieveModel
                                          ?.agencyLeaveModel?.newDetails !=
                                          null &&
                                      (controller.clientDealRetrieveModel
                                          ?.agencyLeaveModel?.newDetails
                                          ?.length ??
                                          0) > 0) ?
                                  DataGridFromMap(
                                    showSrNo: true,
                                    hideCode: false,
                                    formatDate: false,
                                    columnAutoResize: false,
                                    doPasccal: true,
                                    colorCallback: (row) =>
                                    (row.row.cells
                                        .containsValue(
                                        controller.stateManager?.currentCell))
                                        ? Colors.deepPurple.shade200
                                        : Colors.white,
                                    widthSpecificColumn: Get.find<
                                        HomeController>()
                                        .getGridWidthByKey(
                                        key: "tbl1",
                                        userGridSettingList:
                                        controller.userGridSetting1),
                                    exportFileName: "Client Deals",
                                    mode: PlutoGridMode.normal,
                                    mapData: (controller
                                        .clientDealRetrieveModel!
                                        .agencyLeaveModel!.newDetails!
                                        .map((e) => e.toJson())
                                        .toList()),
                                    // mapData: (controllerX.dataList)!,
                                    widthRatio: Get.width / 9 - 1,
                                    onload: (PlutoGridOnLoadedEvent load) {
                                      controller.stateManager =
                                          load.stateManager;
                                    },
                                  ) : Container(),
                                );
                              },
                            ),
                          ),

                          // ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Get.find<HomeController>()
                                    .getCommonButton(
                                  Routes.CLIENT_DEALS,
                                  // handleAutoClear: false,
                                  // disableBtns: ['Save', 'Refresh'],
                                      (btnName) {
                                    // controller.formHandler(btnName);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 4),
                                child: FormButtonWrapper(
                                  btnText: "Info",
                                  showIcon: false,
                                  // isEnabled: btn['isDisabled'],
                                  callback: () {
                                    dragInfoDialog();
                                    // controller.gridStateManagerLeft?.setFilter((element) => true);
                                    // controller.gridStateManagerLeft?.notifyListeners();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 4),
                                child: FormButtonWrapper(
                                  btnText: "Close Deal",
                                  showIcon: false,
                                  // isEnabled: btn['isDisabled'],
                                  callback: () {
                                    // controller.gridStateManagerLeft?.setFilter((element) => true);
                                    // controller.gridStateManagerLeft?.notifyListeners();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 4),
                                child: FormButtonWrapper(
                                  btnText: "View Docs",
                                  showIcon: false,
                                  // isEnabled: btn['isDisabled'],
                                  callback: () {
                                    // controller.gridStateManagerLeft?.setFilter((element) => true);
                                    // controller.gridStateManagerLeft?.notifyListeners();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
        }
    );
  }
}
