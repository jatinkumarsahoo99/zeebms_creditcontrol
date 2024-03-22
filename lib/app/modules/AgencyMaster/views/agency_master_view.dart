import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/helper/pluto_move_direction.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../AgencyMasterRetrieveModel.dart';
import '../InfoDataList.dart';
import '../controllers/agency_master_controller.dart';

class AgencyMasterView extends StatelessWidget {
  AgencyMasterView({Key? key}) : super(key: key);

  AgencyMasterController controllerX =
  Get.put<AgencyMasterController>(AgencyMasterController());

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
                          if(controllerX.agencyMasterRetrieveModel != null &&
                              controllerX.agencyMasterRetrieveModel?.retrieve != null &&
                              controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo != null){
                            List<Map<String, dynamic>> data = controllerX.getDataFromGrid2(
                                controllerX.addInfoStateManager);
                            controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo?.clear();
                            for (var element in data) {
                              controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo?.add(
                                  TblAddInfo.fromJson(element));
                            }
                          }

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
              Expanded(child: Container(
                child: GetBuilder<AgencyMasterController>(
                    id: "all",
                    builder: (controller) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: (controller.infoDataList != null &&
                            controller.infoDataList?.data != null  &&
                            (controller.infoDataList?.data?.length??0) > 0
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
                          onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {
                            List<String>? data = (event.cell.row.cells['allowedValues']?.value ??
                                "").toString().split("~").toList();
                            // List<String>? data =  dataLst.getRange(1, dataLst.length-1).toList();
                            // print(">>>>>>>>dataList${data}");
                            if (data != null && data.length > 0) {
                              if (int.parse(
                                  (event.cell.row.cells['selectIndex']?.value ?? "0").toString()) <
                                  (data.length - 1)) {
                                event.cell.row.cells['selectIndex']?.value = (int.parse(
                                    (event.cell.row.cells['selectIndex']?.value ?? "0")
                                        .toString()) + 1).toString();
                              } else {
                                event.cell.row.cells['selectIndex']?.value = "0";
                              }

                              if (data.length == 1) {
                                event.cell.row.cells['infoValue']?.value = data[0];
                              } else {
                                event.cell.row.cells['infoValue']?.value = data[int.parse(
                                    (event.cell.row.cells['selectIndex']?.value ?? "0")
                                        .toString())];
                              }
                              controller.addInfoStateManager?.notifyListeners();
                            }
                          },
                          hideKeys: ["isRequired", "allowedValues", "selectIndex", "lstData"],
                          editKeys: ['infoValue'],
                          onEdit: (PlutoGridOnChangedEvent event){
                            controller.addInfoStateManager?.notifyListeners();
                          },
                          mapData: controller.infoDataList!.data!.map((e) => e.toJson()).toList(),
                          // mapData: (controllerX.dataList)!,
                          widthRatio: Get.width / 9 - 1,
                          onload: (PlutoGridOnLoadedEvent load) {
                            controller.addInfoStateManager =
                                load.stateManager;
                          },
                        ) : Container(),
                      );
                    }),
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
                      try{
                        LoadingDialog.call();
                        controllerX.addInfoStateManager?.moveCurrentCell(PlutoMoveDirection.left,force: true);
                        Future.delayed(const Duration(seconds: 1),() {
                          if(controllerX.agencyMasterRetrieveModel != null &&
                              controllerX.agencyMasterRetrieveModel?.retrieve != null &&
                              controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo != null){
                            List<Map<String, dynamic>> data = controllerX.getDataFromGrid2(
                                controllerX.addInfoStateManager);
                            controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo?.clear();
                            for (var element in data) {
                              controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo?.add(
                                  TblAddInfo.fromJson(element));
                            }
                          }
                          if (Get.isDialogOpen ?? false) {
                            Get.back();
                          }
                        },);
                      }catch(e){
                        if (Get.isDialogOpen ?? false) {
                          Get.back();
                        }
                      }
                      controllerX.dialogWidget = null;
                      controllerX.canDialogShow.value = false;
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          key: rebuildKey,
          floatingActionButton: Obx(() {
            return controllerX.canDialogShow.value
                ? DraggableFab(
              initPosition: controllerX.getOffSetValue(constraints),
              child: controllerX.dialogWidget!,
              dragStartCall: (){
                print(">>>>>>>>>>start call");
                controllerX.addInfoStateManager?.moveCurrentCell(PlutoMoveDirection.left,force: true);
              },
              dragEndCall: () {
                LoadingDialog.call();
                Future.delayed(Duration(seconds: 1),() {
                  if(controllerX.infoDataList != null){
                    List<Map<String, dynamic>> data = controllerX.getDataFromGrid2(
                        controllerX.addInfoStateManager);
                    // controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo?.clear();
                    controllerX.infoDataList = InfoDataList(data: []);
                    for (var element in data) {
                      print(">>>>>element ${element}\n");
                      // controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo?.add(TblAddInfo.fromJson(element));

                      controllerX.infoDataList?.data?.add(DataLst.fromJson(element));
                    }
                   /* controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo?.forEach((element) {
                      controllerX.infoDataList?.data?.add(DataLst.fromJson(element.toJson()));
                    });*/

                  }
                  if (Get.isDialogOpen ?? false) {
                    Get.back();
                  }
                  controllerX.update(['all']);

                });


              },
            )
                : const SizedBox();
          }),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  // flex: 15,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0, bottom: 4),
                              child: SizedBox(
                                height: Get.height * 0.77,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 2,
                                      ),
                                      DropDownField.formDropDownSearchAPI2(
                                          GlobalKey(), context,
                                          title: "Agency Name",
                                          autoFocus: false,
                                          // customInData: "empList",
                                          url: ApiFactory.AGENCY_MASTER_GET_AGENCY_NAME ?? "",
                                          // inkwellFocus: controllerX.employeeFocus,
                                          // parseKeyForTitle: "programName",
                                          parseKeyForKey: "agencycode",
                                          parseKeyForValue: "Agencyname",
                                          selectedValue: controllerX.selectedAgencyName.value,
                                          // selectedValue: controllerX.selectedEmployee.value,
                                          onchanged: (data) {
                                            controllerX.selectedAgencyName.value = data;
                                            controllerX.getRetrieveRecord();
                                          },
                                          dialogHeight: 200,
                                          width: (Get.width * controllerX.fixedWidth)),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      SizedBox(
                                        width: Get.width * controllerX.fixedWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "Group Name",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.groupNameController,
                                              width: controllerX.fixedWidth1,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              isEnable: controllerX.disable.value,
                                              // focusNode: controllerX.productLevel1Focus
                                              // autoFocus: true,
                                            ),

                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "Contact Person",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.contactPersonController,
                                              width: controllerX.fixedWidth1,
                                              isEnable: controllerX.disable.value,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus
                                              // autoFocus: true,
                                            ),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),

                                      SizedBox(
                                        width: Get.width * controllerX.fixedWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "Address",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.addressController,
                                              width: controllerX.fixedWidth1,
                                              isEnable: controllerX.disable.value,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.addressController1,
                                              width: controllerX.fixedWidth1,
                                              isEnable: controllerX.disable.value,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),

                                      SizedBox(
                                        width: Get.width * controllerX.fixedWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(() {
                                              return DropDownField.formDropDown1WidthMap(
                                                controllerX.cityLst.value ?? [],
                                                    (value) {
                                                  // controllerX.selectedCensorShipType = value;
                                                },
                                                "City",
                                                controllerX.fixedWidth1,
                                                selected: controllerX.selectedCity.value,
                                                // isEnable: controllerX.isEnable,
                                                autoFocus: false,
                                              );
                                            }),
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "Pin",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.pinController,
                                              width: controllerX.fixedWidth1,
                                              isEnable: controllerX.disable.value,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      SizedBox(
                                        width: Get.width * controllerX.fixedWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "Tel",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.telController,
                                              isEnable: controllerX.disable.value,
                                              width: controllerX.fixedWidth1,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "Email",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.emailController,
                                              width: controllerX.fixedWidth1,
                                              isEnable: controllerX.disable.value,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      SizedBox(
                                        width: Get.width * controllerX.fixedWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "SAP Code",
                                              labelColor: Colors.black,
                                              isEnable: controllerX.disable.value,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.sapCodeController,
                                              width: controllerX.fixedWidth1,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "Cust Grp",
                                              labelColor: Colors.black,
                                              isEnable: controllerX.disable.value,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.custGrpController,
                                              width: controllerX.fixedWidth1,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      SizedBox(
                                        width: Get.width * controllerX.fixedWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "Mobile",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.mobileController,
                                              width: controllerX.fixedWidth1,
                                              isEnable: controllerX.disable.value,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "IBF Desc",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.IBFDescController,
                                              width: controllerX.fixedWidth1,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              isEnable: controllerX.disable.value,
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      SizedBox(
                                        width: Get.width * controllerX.fixedWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "Print Name",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.printNameController,
                                              width: controllerX.fixedWidth1,
                                              isEnable: controllerX.disable.value,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "Name 3",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.name3Controller,
                                              isEnable: controllerX.disable.value,
                                              width: controllerX.fixedWidth1,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 3,
                                      ),

                                      SizedBox(
                                        width: Get.width * controllerX.fixedWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "PAN No.",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.panNoController,
                                              width: controllerX.fixedWidth1,
                                              isEnable: controllerX.disable.value,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                            InputFields.formField1WithCustomColor(
                                              hintTxt: "GST No.",
                                              labelColor: Colors.black,
                                              // autoFocus: true,
                                              // controller: controllerX.productLevel1Controller,
                                              controller: controllerX.gstNoController,
                                              width: controllerX.fixedWidth1,
                                              isEnable: controllerX.disable.value,
                                              // isEnable: controllerX.isEnable,
                                              onchanged: (value) {},
                                              autoFocus: false,
                                              // focusNode: controllerX.productLevel1Focus

                                              // autoFocus: true,
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 9,
                          child: GetBuilder<AgencyMasterController>(
                              id: "grid",
                              builder: (controllerX) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  child: (controllerX.agencyMasterRetrieveModel != null &&
                                      controllerX.agencyMasterRetrieveModel?.retrieve != null &&
                                      controllerX.agencyMasterRetrieveModel?.retrieve
                                          ?.lstClientAgency != null &&
                                      (controllerX.agencyMasterRetrieveModel?.retrieve
                                          ?.lstClientAgency?.length ?? 0) > 0
                                  ) ? DataGridFromMap3(
                                    showSrNo: true,
                                    hideCode: false,
                                    formatDate: false,
                                    columnAutoResize: true,
                                    doPasccal: true,
                                    colorCallback: (row) =>
                                    (row.row.cells
                                        .containsValue(
                                        controllerX.stateManager?.currentCell))
                                        ? Colors.deepPurple.shade200
                                        : Colors.white,
                                    exportFileName: "Agency Master",
                                    hideKeys: const ["locationCode","channelCode",
                                      "agencyCode","clientCode","executiveCode",
                                      "payroutecode","agencyName","personnelName",
                                      "payroutename","effectiveFrom","plantid"],
                                    mode: PlutoGridMode.normal,
                                    mapData: (controllerX
                                        .agencyMasterRetrieveModel!.retrieve!.lstClientAgency!
                                        .map((e) => e.toJson())
                                        .toList()),
                                    // mapData: (controllerX.dataList)!,
                                    widthRatio: Get.width / 9 - 1,
                                    onload: (PlutoGridOnLoadedEvent? load) {
                                      controllerX.stateManager =
                                          load?.stateManager;
                                    },
                                  ) : Container(),
                                );
                              }))
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    InputFields.formField1(
                        hintTxt: "Email To",
                        // autoFocus: true,
                        // controller: controllerX.productLevel1Controller,
                        controller: controllerX.emailToController,
                        width: 0.94,
                        // isEnable: controllerX.isEnable,
                        onchanged: (value) {},
                        autoFocus: false,
                        titleInLeft: true
                      // focusNode: controllerX.productLevel1Focus

                      // autoFocus: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    InputFields.formField1(
                      hintTxt: "Email CC",
                      // autoFocus: true,
                      // controller: controllerX.productLevel1Controller,
                      controller: controllerX.emailCCController,
                      width: 0.94,
                      // isEnable: controllerX.isEnable,
                      onchanged: (value) {},
                      autoFocus: false,
                      titleInLeft: true,

                      // focusNode: controllerX.productLevel1Focus

                      // autoFocus: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                          child: FormButtonWrapper(
                            btnText: "Block Agency",
                            callback: () {
                              controllerX.postBlockAgency();
                            },
                            showIcon: true,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 8.0, left: 10, right: 0),
                          child: FormButtonWrapper(
                            btnText: "Un-Block Agency",
                            callback: () {
                              controllerX.postUnBlockAgency();
                            },
                            showIcon: true,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    /* Align(
                            alignment: Alignment.topLeft,
                            child: GetBuilder<HomeController>(
                                id: "buttons",
                                init: Get.find<HomeController>(),
                                builder: (controller) {
                                  PermissionModel formPermissions = Get
                                      .find<MainController>()
                                      .permissionList!
                                      .lastWhere((element) =>
                                  element.appFormName == "frmAgencyMaster");
                                  if (controller.buttons != null) {
                                    return ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      // buttonPadding: EdgeInsets.only(left: 0,right: 5,top: 4,bottom: 4),
                                      children: [
                                        for (var btn in controller.buttons!)
                                          FormButtonWrapper(
                                            btnText: btn["name"],
                                            callback: Utils.btnAccessHandler2(btn['name'],
                                                controller, formPermissions) ==
                                                null
                                                ? null
                                                : () =>
                                                controllerX.formHandler(
                                                  btn['name'],
                                                ),
                                          )
                                      ],
                                    );
                                  }
                                  return Container();
                                }),
                          ),*/
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Get.find<HomeController>()
                          .getCommonButton(
                        Routes.AGENCY_MASTER,
                        // handleAutoClear: false,
                        // disableBtns: ['Save', 'Refresh'],
                            (btnName) {
                          controllerX.formHandler(btnName);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 4),
                      child: FormButtonWrapper(
                        btnText: "Info",
                        callback: () {
                          if(controllerX.agencyMasterRetrieveModel != null &&
                              controllerX.agencyMasterRetrieveModel?.retrieve != null &&
                              controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo != null &&
                              (controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo?.length??0) > 0){
                            controllerX.infoDataList = InfoDataList(data: []);
                            controllerX.agencyMasterRetrieveModel?.retrieve?.tblAddInfo?.forEach((element) {
                              controllerX.infoDataList?.data?.add(DataLst.fromJson(element.toJson()));
                            });
                            dragInfoDialog();

                          }else{
                            controllerX.getInfoData().then((value){
                              dragInfoDialog();
                            });
                          }
                        },
                        showIcon: true,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
