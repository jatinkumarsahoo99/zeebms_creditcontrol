import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/providers/SizeDefine.dart';
import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/DateTime/DateWithThreeTextFieldExpanded.dart';
import 'package:bms_creditcontrol/widgets/LabelTextStyle.dart';
import 'package:bms_creditcontrol/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/sized_box_widget.dart';
import '../../../../widgets/texts.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
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
                        controller.remarkList.isNotEmpty) ?
                    DataGridFromMap(
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
                      mode: PlutoGridMode.selectWithOneTap,
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

  dragInfoDialogLinkDeal() {
    controller.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.88,
          height: Get.height * 0.85,
          child: LayoutBuilder(
              builder: (context, child) {
                return GetBuilder<ClientDealsController>
                  (id: "all",
                    builder: (controller) {
                  return Column(
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
                                'Link Deal',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width*0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InputFields.numbers(
                                    hintTxt: "Group No",
                                    controller: controller.dialogGroupNoController,
                                    width: 0.15,
                                    padLeft: 0,
                                    isEnabled: false

                                  // titleInLeft: true,
                                  // titleSizeboxWidth: 45,

                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                DateWithThreeTextField(
                                  title: "Date",
                                  mainTextController: controller.dialogDateController,
                                  widthRation: .15,
                                  isEnable: false,
                                  // isEnable: controllerX.isEnable.value,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                CheckBoxOnRight(
                                  title: "Show Selected",
                                  value: controller.showSelected.value,
                                  onChanged: (val) {
                                    controller.showSelected.value = val!;
                                    // controller.weekend(val);
                                  },
                                  // fn: controller.weekEndFocus,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width * .4,
                            child: DropDownField
                                .formDropDownSearchAPI2Expand(
                              GlobalKey(),
                              context,
                              title: "Client",
                              url: "",
                              isEnable: false,
                              onchanged: (data) {
                                controller.selectedDialogClient?.value = data;
                              },
                              selectedValue: controller.selectedDialogClient?.value,
                              // width: Get.width * 0.3,
                              // titleInLeft: true,
                              textSizeboxWidth: 60,
                              // inkwellFocus: controller.programFocus
                            ),
                          ),
                          DropDownField.formDropDown1WidthMap(
                               [], (data) {
                            controller.selectedDialogAgency?.value = data;
                          }, "Agency", .4,
                              selected: controller.selectedDialogAgency?.value,
                              // inkWellFocusNode: controller.addInfoFocus
                            // titleInLeft: true,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child:(controller.linkDealRetrieveModel != null &&
                            controller.linkDealRetrieveModel?.model != null &&
                            controller.linkDealRetrieveModel?.model?.deals != null &&
                            (controller.linkDealRetrieveModel?.model?.deals?.length??0) > 0)?
                        DataGridFromMap3(
                          showSrNo: true,
                          hideCode: false,
                          formatDate: false,
                          columnAutoResize: true,
                          doPasccal: true,
                          colorCallback: (row) =>
                          (row.row.cells
                              .containsValue(
                              controller.dealStateManager?.currentCell))
                              ? Colors.deepPurple.shade200
                              : Colors.white,
                          exportFileName: "Client Deals",
                          mode: PlutoGridMode.normal,
                          noEditcheckBoxColumnKey: ["selected"],
                          checkBoxStrComparison: true,
                          uncheckCheckBoxStr: false,
                          checkBoxColumnKey: const ["selected"],
                          onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event){
                           controller.linkDealDialogFirstGridDoubleClick(event);
                          },
                          // checkRow: true,
                          // checkRowKey: "selected",
                          // checkRowKey: "selected",
                          // checkRow: true,


                          // hideKeys: ["isrequired", "allowedvalues"],
                          mapData: controller.linkDealRetrieveModel!.model!.deals!.
                          map((e) => e.toJson()).toList(),
                          // mapData: (controllerX.dataList)!,
                          widthRatio: Get.width / 9 - 1,
                          onload: (PlutoGridOnLoadedEvent load) {
                            controller.dealStateManager =
                                load.stateManager;
                          },
                        ):Container(),
                      )),
                      SizedBox(
                        height: 3,
                      ),
                      Expanded(child: Container(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child:(controller.linkDealRetrieveModel != null &&
                              controller.linkDealRetrieveModel?.model != null &&
                              controller.linkDealRetrieveModel?.model?.linkedDeal != null &&
                              (controller.linkDealRetrieveModel?.model?.linkedDeal?.length??0) > 0)?
                          DataGridFromMap3(
                            showSrNo: true,
                            hideCode: false,
                            formatDate: false,
                            columnAutoResize: true,
                            doPasccal: true,
                            colorCallback: (row) =>
                            (row.row.cells
                                .containsValue(
                                controller.linkDealStateManager?.currentCell))
                                ? Colors.deepPurple.shade200
                                : Colors.white,
                            exportFileName: "Client Deals",
                            mode: PlutoGridMode.normal,
                            hideKeys: const ["locationname","channelName","dealCode",
                              "dealDetailCode","primaryEventCode","locationcode",
                              "channelcode","sponsorTypeCode","programCode",
                              "programCategoryCode","bandcode","timeband","netcode","networkname",
                              "sun","mun","tue","wed","thu","fri","sat","revflag","accountCode",
                              "accountname","eventcode","eventname","spots"],
                            // noEditcheckBoxColumnKey: ["selected"],
                            // checkBoxStrComparison: true,
                            // uncheckCheckBoxStr: false,
                            // checkBoxColumnKey: ["selected"],
                            // checkRow: true,
                            // checkRowKey: "selected",
                            // checkRowKey: "selected",
                            // checkRow: true,


                            // hideKeys: ["isrequired", "allowedvalues"],
                            mapData: controller.linkDealRetrieveModel!.model!.linkedDeal!.
                            map((e) => e.toJson()).toList(),
                            onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event){

                            },
                            // mapData: (controllerX.dataList)!,
                            widthRatio: Get.width / 9 - 1,
                            onload: (PlutoGridOnLoadedEvent load) {
                              controller.linkDealStateManager =
                                  load.stateManager;
                            },
                          ):Container(),
                        ),
                      )),
                      SizedBox(
                        height: 3,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0,bottom: 3),
                          child: Get.find<HomeController>()
                              .getCommonButton(
                            Routes.CLIENT_DEALS,
                            // handleAutoClear: false,
                            // disableBtns: ['Save', 'Refresh'],
                                (btnName) {
                              controller.dialogFormHandler(btnName);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                });
              }
          ),
        ),
      ),
    );
    controller.canDialogShow.value = true;
  }

  dragInfoCompareDialog() {
    controller.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.88,
          height: Get.height * 0.55,
          child: LayoutBuilder(
              builder: (context, child) {
                return GetBuilder<ClientDealsController>
                  (id: "all",
                    builder: (controller) {
                      return Column(
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
                                    'Compare',
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
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child:(controller.compareModelList != null &&
                                controller.compareModelList?.model != null &&
                                (controller.compareModelList?.model?.length??0) > 0)?
                            DataGridFromMap3(
                              showSrNo: true,
                              hideCode: false,
                              formatDate: false,
                              columnAutoResize: true,
                              doPasccal: true,
                              colorCallback: (row) =>
                              (row.row.cells
                                  .containsValue(
                                  controller.compareStateManager?.currentCell))
                                  ? Colors.deepPurple.shade200
                                  : Colors.white,
                              exportFileName: "Client Deals",
                              mode: PlutoGridMode.normal,
                              noEditcheckBoxColumnKey: ["selected"],
                              checkBoxStrComparison: true,
                              uncheckCheckBoxStr: false,
                              checkBoxColumnKey: const ["selected"],
                              onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event){
                                controller.linkDealDialogFirstGridDoubleClick(event);
                              },
                              // checkRow: true,
                              // checkRowKey: "selected",
                              // checkRowKey: "selected",
                              // checkRow: true,


                              // hideKeys: ["isrequired", "allowedvalues"],
                              mapData: controller.compareModelList!.model!.
                              map((e) => e.toJson()).toList(),
                              // mapData: (controllerX.dataList)!,
                              widthRatio: Get.width / 9 - 1,
                              onload: (PlutoGridOnLoadedEvent load) {
                                controller.compareStateManager =
                                    load.stateManager;
                              },
                            ):Container(),
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
                                  controller.dialogWidget = null;
                                  controller.canDialogShow.value = false;
                                  // controller.gridStateManagerLeft?.setFilter((element) => true);
                                  // controller.gridStateManagerLeft?.notifyListeners();
                                },
                              )
                            ],
                          )
                        ],
                      );
                    });
              }
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
                  dragEndCall: (){
                    controller.update(['all']);
                  },
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
                                  callback: () {
                                    controller.getClientAddress(
                                        code: controller.selectedClient?.value?.key ?? "");
                                  },
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
                                  callback: () {
                                    controller.getAgencyAddress(
                                        code: controller.selectAgency?.value?.key ?? "");
                                  },
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
                                        callback: () {
                                          controller.selectBrand?.value = null;
                                          controller.selectBrand?.refresh();
                                        },
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
                                                    hintTxt: "Max Spend",
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
                                                return Container(
                                                  width: Get.width * 0.16,
                                                  child: text_m_w700(
                                                      controller.executive
                                                          .value ?? ""),
                                                );
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
                                              Obx(() {
                                                return Container(
                                                  child: text_m_w700(
                                                    controller.clientEmb.value ?? "",
                                                    color: Colors.red,
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                        sizedBoxWidth(10),
                                        SizedBox(
                                          width: Get.width * 0.17,
                                          child: InkWell(
                                            onTap: () {
                                              controller.getLinkDealRetriveApiCall(groupNumber:controller.linkedDealNumber.value ).then((value) {
                                                if(value == true && controller.linkDealRetrieveModel != null &&
                                                    controller.linkDealRetrieveModel?.model != null ){
                                                  controller.dialogGroupNoController.text = (controller.linkDealRetrieveModel?.model?.dealcode??"").toString() ;
                                                  controller.dialogDateController.text =Utils.toDateFormat4( (controller.linkDealRetrieveModel?.model?.groupdate??"").toString()) ;
                                                  controller.selectedDialogClient?.value = DropDownValue(value:controller.linkDealRetrieveModel?.model?.clientName??"" ,
                                                      key:controller.linkDealRetrieveModel?.model?.clientCode??"" );
                                                  controller.selectedDialogAgency?.value = DropDownValue(value:controller.linkDealRetrieveModel?.model?.agencyName??"" ,
                                                      key:controller.linkDealRetrieveModel?.model?.agencyCode??"" );
                                                  dragInfoDialogLinkDeal();
                                                }else{
                                                  LoadingDialog.showErrorDialog("Data not found");
                                                }

                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50),
                                              child: Obx(() {
                                                return Container(
                                                  child: text_m_w700(
                                                    controller.linkedDealNumberWithText.value ?? "",
                                                    color: Colors.blue,
                                                  ),
                                                );
                                              }),
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

                          GetBuilder<ClientDealsController>(
                              id: "middle",
                              builder: (controller) {
                                return Column(
                                  children: [
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
                                            controller.getSubType(
                                                accountCode: controller.selectAccount?.value?.key ??
                                                    "");
                                          }, "Account", .18,
                                              selected: controller.selectAccount?.value,
                                              isEnable: controller.accountEnaSta.value,
                                              inkWellFocusNode: controller.accountFocus
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
                                              inkWellFocusNode: controller.subTypeFocus
                                            // titleInLeft: true,
                                          );
                                        }),
                                        DropDownField.formDropDown1WidthMap(
                                          controller.spotTypeList.value ?? [], (data) {
                                          controller.selectSpotType?.value = data;
                                        }, "Spot Type", .18,
                                          selected: controller.selectSpotType?.value,
                                          inkWellFocusNode: controller.spotTypeFocus,

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
                                              onchanged: (data) {
                                                controller.selectProgram?.value = data;
                                              },
                                              selectedValue: controller.selectProgram?.value,
                                              // width: Get.width * 0.3,
                                              // titleInLeft: true,
                                              textSizeboxWidth: 60,
                                              inkwellFocus: controller.programFocus
                                          ),
                                        ),
                                        DropDownField.formDropDown1WidthMap(
                                            controller.bandList.value ?? [], (data) {
                                          controller.selectBand?.value = data;
                                        }, "Band", .18,
                                            selected: controller.selectBand?.value,
                                            inkWellFocusNode: controller.bandFocus
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
                                              selected: controller.selectAddInfo?.value,
                                              inkWellFocusNode: controller.addInfoFocus
                                            // titleInLeft: true,
                                          ),
                                          // Spacer(),

                                          CheckBoxOnRight(
                                            title: "Week End",
                                            value: controller.weekEnd.value,
                                            onChanged: (val) {
                                              controller.weekEnd.value = val!;
                                              controller.weekend(val);
                                            },
                                            fn: controller.weekEndFocus,
                                          ),
                                          sizedBoxWidth(20),
                                          CheckBoxOnRight(
                                              title: "Week Day",
                                              onChanged: (val) {
                                                controller.weekDay.value = val!;
                                                controller.weekDayFun(val);
                                              },
                                              fn: controller.weekDayFocus,
                                              value: controller.weekDay.value),
                                          sizedBoxWidth(20),
                                          CheckBoxOnRight(
                                              title: "Mon",
                                              value: controller.mon.value,
                                              onChanged: (val) {
                                                controller.mon.value = val!;
                                              }, fn: controller.monDayFocus),
                                          CheckBoxOnRight(
                                              title: "Tue",
                                              value: controller.tue.value,
                                              onChanged: (val) {
                                                controller.tue.value = val!;
                                              }, fn: controller.tueDayFocus),
                                          CheckBoxOnRight(
                                              title: "Wed",
                                              value: controller.wed.value,
                                              onChanged: (val) {
                                                controller.wed.value = val!;
                                              }, fn: controller.wedDayFocus),
                                          CheckBoxOnRight(
                                              title: "Thu",
                                              value: controller.thu.value,
                                              onChanged: (val) {
                                                controller.thu.value = val!;
                                              }, fn: controller.thuDayFocus),
                                          CheckBoxOnRight(
                                              title: "Fri",
                                              value: controller.fri.value,
                                              onChanged: (val) {
                                                controller.fri.value = val!;
                                              }, fn: controller.friDayFocus),
                                          CheckBoxOnRight(
                                              title: "Sat",
                                              value: controller.sat.value,
                                              onChanged: (val) {
                                                controller.sat.value = val!;
                                              }, fn: controller.satDayFocus),
                                          CheckBoxOnRight(
                                              title: "Sun",
                                              value: controller.sun.value,
                                              onChanged: (val) {
                                                controller.sun.value = val!;
                                              }, fn: controller.sunDayFocus),
                                          InputFields.formFieldNumberMask(
                                            hintTxt: "Start Time",
                                            controller: controller.startTime,
                                            widthRatio: 0.08,

                                            // isEnable: controllerX.isEnable,
                                            onEditComplete: (val) {
                                              // controllerX.calculateDuration();
                                            },
                                            textFieldFN: controller.startTimeFocus,
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
                                            textFieldFN: controller.endTimeFocus,
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
                                  ],
                                );
                              }),


                          const SizedBox(height: 5),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 5,
                            spacing: 10,
                            children: [
                              FormButton1(
                                btnText: "Add",
                                callback: () {
                                  controller.addBtn();
                                },
                              ),
                              FormButton1(
                                btnText: "Clear",
                                callback: () {
                                  controller.btnClearClick();
                                },
                              ),
                              FormButton1(
                                btnText: "Duplicate",
                                callback: () {
                                  controller.btnDuplicateClick(
                                      selectedInd: controller.stateManager?.currentRowIdx ?? -1);
                                },
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
                                callback: () {
                                  controller.getCompareListFromApi().then((value) {
                                    dragInfoCompareDialog();
                                  });
                                },
                              ),
                              sizedBoxWidth(100),
                              FormButton1(
                                btnText: "Import",
                                callback: () async {
                                  // controller.pickFile();
                                  /*int siz = 6;
                                  for(int i=0;i<siz;i++){
                                    if(i == 2 || i== 4){
                                     bool sta =  await LoadingDialog.modifyWithAsync(
                                          "Similar entry already exists!\nDo you want to modify it?",
                                          cancelTitle: "Yes", deleteTitle: "No");
                                    }else{

                                    }

                                  }*/
                                },
                              ),
                              Obx(() {
                                return text_m_w700(
                                    controller.address.value ?? "xxx", color: Colors.blue);
                              })
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
                                  child: (controller.importGridList !=
                                      null &&
                                      (controller.importGridList.length ??
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
                                    onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent? event) {
                                      print(">>>>>doubletapClick");
                                      controller.doubleTap(selectedIndex: event?.rowIdx ?? -1);
                                    },
                                    hideKeys: const [
                                      "primaryEventCode",
                                      "sponsorTypeCode",
                                      "programCode",
                                      "programCategoryCode",
                                      "bandCode",
                                      "revflag",
                                      "subRevenueTypeCode"
                                    ],

                                    mapData: (controller
                                        .importGridList
                                        .map((e) => e.toJson())
                                        .toList()),
                                    // mapData: (controllerX.dataList)!,
                                    widthRatio: Get.width / 9 - 1,
                                    onload: (PlutoGridOnLoadedEvent? load) {
                                      controller.stateManager =
                                          load?.stateManager;
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
                                    controller.formHandler(btnName);
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
