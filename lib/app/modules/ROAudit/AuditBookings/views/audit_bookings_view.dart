import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
import 'package:bms_creditcontrol/widgets/FormButton.dart';
import 'package:bms_creditcontrol/widgets/sized_box_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../../widgets/dropdown.dart';
import '../../../../../widgets/gridFromMap.dart';
import '../../../../../widgets/input_fields.dart';
import '../../../../controller/HomeController.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/audit_bookings_controller.dart';

class AuditBookingsView extends GetView<AuditBookingsController> {
  AuditBookingsView({Key? key}) : super(key: key);

  var controller = Get.put<AuditBookingsController>(AuditBookingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuditBookingsController>(
        init: controller,
        id: "update",
        builder: (controller) {
          return SizedBox(
            width: context.width,
            height: context.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Expanded(
                                //   child:
                                //       // Obx(() {
                                //       //   return
                                //       InputFields.formFieldExpand2(
                                //     hintTxt: "Voucher No",
                                //     controller: TextEditingController(),
                                //     // titleInLeft: true,
                                //     autoFocus: true,
                                //     // focusNode: controller.vocherNoFN,
                                //     // padLeft: 10,
                                //     titleSizeboxWidth: 80,
                                //   ),
                                //   // }),
                                // ),

                                Expanded(
                                  child: Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.locationList.value,
                                      (value) {
                                        controller.selectedLocation = value;
                                      },
                                      "Location",
                                      // titleInLeft: true,
                                      selected: controller.selectedLocation,
                                      titleSizeBoxWidth: 75,
                                    );
                                  }),
                                ),

                                SizedBox(
                                  width: 10,
                                ),

                                Expanded(
                                  child: Obx(() {
                                    return DropDownField
                                        .formDropDown1WidthMapExpand(
                                      controller.channelList.value,
                                      (value) {
                                        controller.selectedChannel = value;
                                      },
                                      "Channel",
                                      // titleInLeft: true,
                                      selected: controller.selectedChannel,
                                      titleSizeBoxWidth: 75,
                                    );
                                  }),
                                ),
                                // SizedBox(width: 5),
                                // Expanded(
                                //   child: Obx(() {
                                //     return DateWithThreeTextField(
                                //       title: "Voucher Date",
                                //       mainTextController:
                                //           controller.tecVocherDate.value,
                                //       expand: true,
                                //     );
                                //   }),
                                // ),
                              ],
                            ),
                            sizedBoxHeight(5),
                            Row(
                              children: [
                                Expanded(
                                  child: InputFields.formFieldExpand2(
                                      hintTxt: "Ref No",
                                      controller: controller.tecRefNo,
                                      autoFocus: true,
                                      titleSizeboxWidth: 80,
                                      bottomPadding: false),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: DateWithThreeTextField(
                                    title: "",
                                    mainTextController: TextEditingController(),
                                    isEnable: false,
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxHeight(5),

                            DropDownField.formDropDownSearchAPI2Expand(
                              GlobalKey(),
                              context,
                              title: "Client",
                              url: "",
                              onchanged: (value) {
                                controller.selectedClient = value;
                              },
                              // titleInLeft: true,
                              selectedValue: controller.selectedClient,
                              parseKeyForKey: "",
                              parseKeyForValue: "",
                              textSizeboxWidth: 85,
                            ),
                            sizedBoxHeight(5),

                            DropDownField.formDropDownSearchAPI2Expand(
                              GlobalKey(),
                              context,
                              title: "Agency",
                              url: "",
                              onchanged: (value) {
                                controller.selectedAgency = value;
                              },
                              // titleInLeft: true,
                              selectedValue: controller.selectedAgency,
                              parseKeyForKey: "",
                              parseKeyForValue: "",
                              textSizeboxWidth: 85,
                            ),
                            sizedBoxHeight(5),

                            DropDownField.formDropDownSearchAPI2Expand(
                              GlobalKey(),
                              context,
                              title: "Brand",
                              url: "",
                              onchanged: (value) {
                                controller.selectedBrand = value;
                              },
                              // titleInLeft: true,
                              selectedValue: controller.selectedBrand,
                              parseKeyForKey: "",
                              parseKeyForValue: "",
                              textSizeboxWidth: 85,
                            ),
                            sizedBoxHeight(5),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: InputFields.formFieldExpand2(
                                      hintTxt: "Executive",
                                      controller: controller.tecRefNo,
                                      autoFocus: true,
                                      titleSizeboxWidth: 80,
                                      bottomPadding: false),
                                ),

                                SizedBox(
                                  width: 10,
                                ),

                                FormButton(
                                  btnText: "Deal",
                                  showIcon: false,
                                  isEnabled: true,
                                  callback: () {},
                                ),

                                SizedBox(
                                  width: 10,
                                ),

                                FormButton(
                                  btnText: "Validation",
                                  showIcon: false,
                                  isEnabled: true,
                                  callback: () {},
                                ),

                                SizedBox(
                                  width: 10,
                                ),

                                FormButton(
                                  btnText: "Spots",
                                  showIcon: false,
                                  isEnabled: true,
                                  callback: () {},
                                ),

                                // Expanded(
                                //   child: DateWithThreeTextField(
                                //     title: "",
                                //     mainTextController: TextEditingController(),
                                //     isEnable: false,
                                //   ),
                                // ),
                              ],
                            ),

                            // SizedBox(height: 5),
                            // GetBuilder<ReturnsBlankTapesController>(
                            //     id: "updateEmp",
                            //     builder: (controller) {
                            //       return DropDownField
                            //           .formDropDownSearchAPI2Expand(
                            //         GlobalKey(),
                            //         context,
                            //         title: "Employee",
                            //         url: ApiFactory
                            //             .RETURNS_BLANK_TAPE_SEARCH_EMPLOYEE,
                            //         onchanged: (value) {
                            //           controller.selectedEmployee = value;
                            //         },
                            //         // titleInLeft: true,
                            //         selectedValue: controller.selectedEmployee,
                            //         parseKeyForKey: "Employeecode",
                            //         parseKeyForValue: "Employeename",
                            //         textSizeboxWidth: 85,
                            //       );
                            //     }),
                            // SizedBox(height: 5),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Obx(() {
                            //         return DropDownField
                            //             .formDropDown1WidthMapExpand(
                            //           controller.tapeTypeList.value,
                            //           (value) {
                            //             controller.selectedTapeType = value;
                            //           },
                            //           "Tape Type",
                            //           // titleInLeft: true,
                            //           selected: controller.selectedTapeType,
                            //           titleSizeBoxWidth: 75,
                            //         );
                            //       }),
                            //     ),
                            //     SizedBox(width: 5),
                            //     Expanded(
                            //       child: Obx(() {
                            //         return DropDownField
                            //             .formDropDown1WidthMapExpand(
                            //           controller.tapeIdList.value,
                            //           (value) {
                            //             controller.selectedTapeId = value;
                            //           },
                            //           "Tape ID",
                            //           // titleInLeft: true,
                            //           selected: controller.selectedTapeId,
                            //         );
                            //       }),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 5),
                            // Obx(() {
                            //   return InputFields.formFieldExpand2(
                            //       hintTxt: "Remarks",
                            //       // titleInLeft: true,
                            //       controller: controller.tecRemarks.value,
                            //       titleSizeboxWidth: 80);
                            // }),
                            // SizedBox(height: 10),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     SizedBox(
                            //       width: 150,
                            //       child: FormButton(
                            //         btnText: "Show",
                            //         showIcon: false,
                            //         callback: () {
                            //           controller.onShowButton();
                            //         },
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 150,
                            //       child: FormButton(
                            //         btnText: "Clear Search",
                            //         callback: () {
                            //           controller.onClearSearch();
                            //         },
                            //         showIcon: false,
                            //       ),
                            //     ),
                            //     Obx(() {
                            //       return SizedBox(
                            //         width: 150,
                            //         child: FormButton(
                            //           btnText: "Reselected Year/Branch",
                            //           showIcon: false,
                            //           callback: () {
                            //             controller.onReselectYearBranch();
                            //           },
                            //           isEnabled:
                            //               controller.reselectButtonEnable.value,
                            //         ),
                            //       );
                            //     }),
                            //   ],
                            // ),
                            // SizedBox(height: 35),
                            // Obx(() {
                            //   return Visibility(
                            //     visible: controller.isVisibleLeft.value,
                            //     child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.end,
                            //       children: [
                            //         Expanded(
                            //           child: Obx(() {
                            //             return DropDownField
                            //                 .formDropDown1WidthMapExpand(
                            //               controller.tapeNameList.value,
                            //               (value) {
                            //                 controller.selectedTapeName = value;
                            //               },
                            //               "Tape Name",
                            //               // titleInLeft: true,
                            //               selected: controller.selectedTapeName,
                            //               titleSizeBoxWidth: 75,
                            //             );
                            //           }),
                            //         ),
                            //         SizedBox(width: 5),
                            //         Expanded(
                            //           child: Obx(() {
                            //             return InputFields.formFieldExpand(
                            //               hintTxt: "QOH",
                            //               // titleInLeft: true,
                            //               controller: controller.tecQOH.value,
                            //             );
                            //           }),
                            //         ),
                            //         SizedBox(width: 5),
                            //         FormButton(
                            //           btnText: "Ok",
                            //           callback: () {
                            //             controller.onOkButton();
                            //           },
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            // }),
                            // SizedBox(height: 5),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      GetBuilder<AuditBookingsController>(
                          id: "updatePC",
                          builder: (controller) {
                            return Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DateWithThreeTextField(
                                          title: "FPC Eff Dt",
                                          mainTextController:
                                              controller.tecFpcDate,
                                          isEnable: false,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: DateWithThreeTextField(
                                          title: "Book Dt",
                                          mainTextController:
                                              controller.tecBookDate,
                                          isEnable: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBoxHeight(5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InputFields.formFieldExpand2(
                                          hintTxt: "Booking No",
                                          controller: controller.tecBookingNo,
                                          autoFocus: true,
                                          titleSizeboxWidth: 80,
                                          bottomPadding: false,
                                        ),
                                      ),
                                      sizedBoxWidth(5),
                                      SizedBox(
                                        width: 100,
                                        child: InputFields.formFieldExpand2(
                                          hintTxt: "",
                                          controller: controller.tecBlankYear,
                                          // autoFocus: true,
                                          titleSizeboxWidth: 80,
                                          bottomPadding: false,
                                        ),
                                      ),
                                      sizedBoxWidth(5),
                                      SizedBox(
                                        width: 150,
                                        child: InputFields.formFieldExpand2(
                                          hintTxt: "",
                                          controller: controller.tecRefNo,
                                          // autoFocus: true,
                                          titleSizeboxWidth: 80,
                                          bottomPadding: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Deal No",
                                    controller: controller.tecDealNo,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Pay route",
                                    controller: controller.tecPayRoute,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                  ),
                                  sizedBoxHeight(5),
                                  InputFields.formFieldExpand2(
                                    hintTxt: "Pay Mode",
                                    controller: controller.tecPayMode,
                                    titleSizeboxWidth: 80,
                                    bottomPadding: false,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                  SizedBox(height: 5),
                  CheckBoxWidget1(title: "Select All"),
                  Expanded(
                    child: Obx(() {
                      return DataGridFromMap3(
                        // colorCallback: (row) {
                        //   if (row == controller.sm?.currentRow) {
                        //     return Colors.deepPurple.shade100;
                        //   } else {
                        //     return Colors.white;
                        //   }
                        // },
                        // colorCallback: (row) => (row.row.cells
                        //         .containsValue(controller.sm?.currentCell))
                        //     ? Colors.deepPurple.shade200
                        //     : Colors.white,
                        // showSecondaryDialog: false,

                        // exportFileName: "Returns Blank Tapes",
                        mapData: controller.gridData.value,
                        // controller.gridDataTableData.value,
                        // .map((e) => e.toJson())
                        // .toList(),
                        // formatDate: false,
                        // onRowDoubleTap: (event) {
                        //   controller.sm?.setCurrentCell(event.cell,
                        //       event.rowIdx); // to give focus to selected row
                        //   controller.onRowDounleTap(event);
                        //   controller.isVisibleRight.value = true;
                        // },
                        // onload: (event) {
                        //   var smNew = event.stateManager;
                        //   controller.sm = smNew;
                        //   event.stateManager
                        //       .setSelectingMode(PlutoGridSelectingMode.row);
                        //   event.stateManager
                        //       .setCurrentCell(event.stateManager.firstCell, 0);
                        //   controller.sm = event.stateManager;
                        // },
                        // hideCode: false,
                        // mode: PlutoGridMode.normal,
                        // witdthSpecificColumn: controller.showFirstGridData.value
                        //     ? {
                        //         "vouchernumber": 120,
                        //         "description": 240,
                        //         "tapeid": 120,
                        //         "partyname": 240,
                        //         "programname": 240,
                        //         "channelname": 240,
                        //         "modifiedby": 120,
                        //         "gatepassno": 120,
                        //         "epsno": 120,
                        //         "GatePassDate": 120,
                        //         "status": 120,
                        //         "exporttapecode": 120,
                        //         "VoucherDate": 120,
                        //         "record": 120
                        //       }
                        //     : {
                        //         "voucherNumber": 120,
                        //         "description": 240,
                        //         "tapeID": 120,
                        //         "partyName": 240,
                        //         "programName": 240,
                        //         "channelName": 240,
                        //         "modifiedBy": 120,
                        //         "gatePassNo": 120,
                        //         "epsNo": 120,
                        //         "GatePassDate": 120,
                        //         "status": 120,
                        //         "exportTapeCode": 120,
                        //         "VoucherDate": 180,
                        //         "record": 120,
                        //         "yearcode": 120
                        //       },
                        // witdthSpecificColumn:
                        //     Get.find<HomeController>().getGridWidthByKey(
                        //   userGridSettingList:
                        //       controller.userGridSetting1?.value,
                        // ),
                      );
                    }),
                  ),
                  sizedBoxHeight(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // FormButton1(btnText: "OS"),

                      FormButton(
                        btnText: "OS",
                        showIcon: false,
                        isEnabled: true,
                        callback: () {},
                      ),
                      sizedBoxWidth(10),

                      FormButton(
                        btnText: "Mark As Un-Audit",
                        showIcon: false,
                        isEnabled: true,
                        callback: () {},
                      ),
                    ],
                  ),
                  Get.find<HomeController>().getCommonButton(
                    Routes.AUDIT_BOOKINGS,
                    (btnName) {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
