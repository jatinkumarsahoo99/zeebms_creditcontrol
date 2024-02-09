import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/secondary_asrun_modification_controller.dart';

class SecondaryAsrunModificationView extends StatelessWidget {
  SecondaryAsrunModificationView({Key? key}) : super(key: key);

  SecondaryAsrunModificationController controllerX =
      Get.put<SecondaryAsrunModificationController>(SecondaryAsrunModificationController());

  var rebuildKey = GlobalKey<ScaffoldState>();

  dragInfoDialog() {
    controllerX.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controllerX.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.7,
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
                          controllerX.dialogWidget = null;
                          controllerX.canDialogShow.value = false;
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
              Expanded(
                  child: Container(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Container(),
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
    controllerX.canDialogShow.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
        key: rebuildKey,
        floatingActionButton: Obx(() {
          return controllerX.canDialogShow.value
              ? DraggableFab(
                  initPosition: controllerX.getOffSetValue(constraints),
                  child: controllerX.dialogWidget!,
                )
              : const SizedBox();
        }),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDownField.formDropDown1WidthMap(
                    controllerX.locationList.value ?? [],
                    (value) {
                      controllerX.selectedLocation = value;
                      controllerX.getChannels(locationCode: value.key ?? "");
                      // controllerX.getChannel(value.key??"");
                    },
                    "Location",
                    .3,
                    selected: controllerX.selectedLocation,
                    // isEnable: controllerX.isEnable.value,
                    // selected: controllerX.selectedLocation,
                    // dialogHeight: Get.height * .15,
                    autoFocus: true,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    controllerX.channelList.value ?? [],
                    (value) {
                      controllerX.selectedChannel = value;
                      // controllerX.getChannel(value.key??"");
                    },
                    "Channel",
                    .3,
                    selected: controllerX.selectedChannel,
                    // isEnable: controllerX.isEnable.value,
                    // selected: controllerX.selectedLocation,
                    // dialogHeight: Get.height * .15,
                    autoFocus: true,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DateWithThreeTextField(
                    title: "Log Date",
                    mainTextController: controllerX.logDateController,
                    widthRation: .1,
                    // isEnable: controllerX.isEnable.value,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    child: FormButtonWrapper(
                      btnText: "Retrieve Data",
                      callback: () {
                        // controllerX.showApiCall();
                        controllerX.getBindData();
                      },
                      showIcon: true,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    child: FormButtonWrapper(
                      btnText: "Clear Mismatch",
                      callback: () {
                        // controllerX.showApiCall();
                      },
                      showIcon: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Expanded(
                  child: GetBuilder<SecondaryAsrunModificationController>(
                      id: "grid",
                      builder: (controllerX) {
                        return Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                          child: (controllerX.secondaryAsrunGridModel != null &&
                                  controllerX.secondaryAsrunGridModel?.bindGrid != null &&
                                  controllerX.secondaryAsrunGridModel?.bindGrid
                                          ?.lstAsRunBookingDetails !=
                                      null &&
                                  (controllerX.secondaryAsrunGridModel?.bindGrid
                                              ?.lstAsRunBookingDetails?.length ??
                                          0) >
                                      0)
                              ? DataGridFromMap6(
                                  showSrNo: true,
                                  hideCode: false,
                                  formatDate: false,
                                  columnAutoResize: true,
                                  doPasccal: true,
                                  colorCallback: (row) => (row.row.cells
                                          .containsValue(controllerX.stateManager?.currentCell))
                                      ? Colors.deepPurple.shade200
                                      : Colors.white,
                                  exportFileName: "Secondary Asrun Modification",
                                  mode: PlutoGridMode.normal,
                                  onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {
                                    print(
                                        ">>>>>>>>>>>onRowDoubleTapColField${event.cell.column.field ?? ""}");
                                    print(
                                        ">>>>>>>>>>>onRowDoubleTapColField${event.cell.row.cells['spotStatus']?.value ?? ""}");
                                    // spotStatus
                                    if ((event.cell.column.field ?? "").toString().trim() ==
                                        "spotStatus") {
                                      if ((event.cell.row.cells['spotStatus']?.value ?? "")
                                              .toString()
                                              .toLowerCase()
                                              .trim() ==
                                          "telecasted") {
                                        LoadingDialog.modify3(
                                            "Want to change the status to NOT TELECASTED", () {
                                          controllerX
                                              .stateManager
                                              ?.rows[controllerX.stateManager?.currentRowIdx ?? 0]
                                              .cells['spotStatus']
                                              ?.value = "NOT TELECASTED";
                                          controllerX.stateManager?.notifyListeners();
                                        }, () {}, cancelTitle: "No", confirmTitle: "Yes");
                                      } else {
                                        dragInfoDialog();
                                      }
                                    }
                                  },
                                  hideKeys: const [
                                    "clearBySys",
                                    "spotPositionShortName",
                                    "telecastProgramcode",
                                    "telprogname",
                                    "telpos",
                                    "bookingDetailCode1",
                                    "dealno",
                                    "packagecode",
                                    "recordnumber",
                                    "modifyStatus",
                                    "locationCode",
                                    "channelCode",
                                    ""
                                  ],
                                  mapData: controllerX
                                      .secondaryAsrunGridModel!.bindGrid!.lstAsRunBookingDetails!
                                      .map((e) => e.toJson())
                                      .toList(),
                                  // mapData: (controllerX.dataList)!,
                                  widthRatio: Get.width / 9 - 1,
                                  onload: (PlutoGridOnLoadedEvent load) {
                                    controllerX.stateManager = load.stateManager;
                                  },
                                )
                              : Container(),
                        );
                      })),
              SizedBox(
                height: 4,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: GetBuilder<HomeController>(
                    id: "buttons",
                    init: Get.find<HomeController>(),
                    builder: (controller) {
                      PermissionModel formPermissions = Get.find<MainController>()
                          .permissionList!
                          .lastWhere(
                              (element) => element.appFormName == "frmSecondaryAsRunModification");
                      if (controller.buttons != null) {
                        return ButtonBar(
                          alignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          // buttonPadding: EdgeInsets.only(left: 0,right: 5,top: 4,bottom: 4),
                          children: [
                            for (var btn in controller.buttons!)
                              FormButtonWrapper(
                                btnText: btn["name"],
                                callback: Utils.btnAccessHandler2(
                                            btn['name'], controller, formPermissions) ==
                                        null
                                    ? null
                                    : () => controllerX.formHandler(
                                          btn['name'],
                                        ),
                              )
                          ],
                        );
                      }
                      return Container();
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
