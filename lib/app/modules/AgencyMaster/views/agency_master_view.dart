import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../controllers/agency_master_controller.dart';

class AgencyMasterView extends StatelessWidget {
  AgencyMasterView({Key? key}) : super(key: key);

  AgencyMasterController controllerX =
  Get.put<AgencyMasterController>(AgencyMasterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
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
                                        InputFields.formField1(
                                          hintTxt: "Group Name",
                                          // autoFocus: true,
                                          // controller: controllerX.productLevel1Controller,
                                          controller: controllerX.groupNameController,
                                          width: controllerX.fixedWidth,
                                          // isEnable: controllerX.isEnable,
                                          onchanged: (value) {},
                                          autoFocus: false,
                                          isEnable: controllerX.disable.value,
                                          // focusNode: controllerX.productLevel1Focus
                                          // autoFocus: true,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "Contact Person",
                                          // autoFocus: true,
                                          // controller: controllerX.productLevel1Controller,
                                          controller: controllerX.contactPersonController,
                                          width: controllerX.fixedWidth,
                                          isEnable: controllerX.disable.value,
                                          // isEnable: controllerX.isEnable,
                                          onchanged: (value) {},
                                          autoFocus: false,
                                          // focusNode: controllerX.productLevel1Focus
                                          // autoFocus: true,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "Address",
                                          // autoFocus: true,
                                          // controller: controllerX.productLevel1Controller,
                                          controller: controllerX.addressController,
                                          width: controllerX.fixedWidth,
                                          isEnable: controllerX.disable.value,
                                          // isEnable: controllerX.isEnable,
                                          onchanged: (value) {},
                                          autoFocus: false,
                                          // focusNode: controllerX.productLevel1Focus

                                          // autoFocus: true,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "",
                                          // autoFocus: true,
                                          // controller: controllerX.productLevel1Controller,
                                          controller: controllerX.addressController1,
                                          width: controllerX.fixedWidth,
                                          isEnable: controllerX.disable.value,
                                          // isEnable: controllerX.isEnable,
                                          onchanged: (value) {},
                                          autoFocus: false,
                                          // focusNode: controllerX.productLevel1Focus

                                          // autoFocus: true,
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
                                              InputFields.formField1(
                                                hintTxt: "Pin",
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
                                          width: Get.width * controllerX.fixedWidth,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InputFields.formField1(
                                                hintTxt: "Tel",
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
                                              InputFields.formField1(
                                                hintTxt: "Email",
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
                                          width: Get.width * controllerX.fixedWidth,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InputFields.formField1(
                                                hintTxt: "SAP Code",
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
                                              InputFields.formField1(
                                                hintTxt: "Cust Grp",
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
                                          width: Get.width * controllerX.fixedWidth,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InputFields.formField1(
                                                hintTxt: "Mobile",
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
                                              InputFields.formField1(
                                                hintTxt: "IBF Desc",
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
                                        InputFields.formField1(
                                          hintTxt: "Print Name",
                                          // autoFocus: true,
                                          // controller: controllerX.productLevel1Controller,
                                          controller: controllerX.printNameController,
                                          width: controllerX.fixedWidth,
                                          isEnable: controllerX.disable.value,
                                          // isEnable: controllerX.isEnable,
                                          onchanged: (value) {},
                                          autoFocus: false,
                                          // focusNode: controllerX.productLevel1Focus

                                          // autoFocus: true,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "Name 3",
                                          // autoFocus: true,
                                          // controller: controllerX.productLevel1Controller,
                                          controller: controllerX.name3Controller,
                                          isEnable: controllerX.disable.value,
                                          width: controllerX.fixedWidth,
                                          // isEnable: controllerX.isEnable,
                                          onchanged: (value) {},
                                          autoFocus: false,
                                          // focusNode: controllerX.productLevel1Focus

                                          // autoFocus: true,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "PAN No.",
                                          // autoFocus: true,
                                          // controller: controllerX.productLevel1Controller,
                                          controller: controllerX.panNoController,
                                          width: controllerX.fixedWidth,
                                          isEnable: controllerX.disable.value,
                                          // isEnable: controllerX.isEnable,
                                          onchanged: (value) {},
                                          autoFocus: false,
                                          // focusNode: controllerX.productLevel1Focus

                                          // autoFocus: true,
                                        ),
                                        InputFields.formField1(
                                          hintTxt: "GST No.",
                                          // autoFocus: true,
                                          // controller: controllerX.productLevel1Controller,
                                          controller: controllerX.gstNoController,
                                          width: controllerX.fixedWidth,
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
                                    ) ? DataGridFromMap(
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
                      InputFields.formField1(
                        hintTxt: "Email To",
                        // autoFocus: true,
                        // controller: controllerX.productLevel1Controller,
                        controller: controllerX.emailToController,
                        width: 0.95,
                        // isEnable: controllerX.isEnable,
                        onchanged: (value) {},
                        autoFocus: false,
                        // focusNode: controllerX.productLevel1Focus

                        // autoFocus: true,
                      ),
                      InputFields.formField1(
                        hintTxt: "Email CC",
                        // autoFocus: true,
                        // controller: controllerX.productLevel1Controller,
                        controller: controllerX.emailCCController,
                        width: 0.95,
                        // isEnable: controllerX.isEnable,
                        onchanged: (value) {},
                        autoFocus: false,
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
                  Align(
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
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}
