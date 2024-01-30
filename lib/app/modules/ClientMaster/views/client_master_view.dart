import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/client_master_controller.dart';

class ClientMasterView extends GetView<ClientMasterController> {
  ClientMasterView({Key? key}) : super(key: key);

  ClientMasterController controllerX =
      Get.put<ClientMasterController>(ClientMasterController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GetBuilder<ClientMasterController>(
                init: controllerX,
                id: "main",
                builder: (logic) {
                  return Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 11,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: SingleChildScrollView(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 7,
                                  ),
                                  DropDownField.formDropDownSearchAPI2(
                                      GlobalKey(), context,
                                      title: "Name",
                                      autoFocus: true,
                                      url: ApiFactory
                                          .CLIENT_MASTER_SEARCH_CLIENT,
                                      // inkwellFocus: controllerX.employeeFocus,
                                      // parseKeyForTitle: "programName",
                                      parseKeyForKey: "ClientCode",
                                      parseKeyForValue: "ClientName",
                                      selectedValue: controllerX
                                          .selectClientName, onchanged: (data) {
                                    controllerX.selectClientName = data;
                                    controllerX.getRetriveData();
                                  },
                                      width:
                                          (Get.width * controllerX.fixedWidth)),
                                  InputFields.formField1(
                                    hintTxt: "Short Name",
                                    // autoFocus: true,
                                    // controller: controllerX.productLevel1Controller,
                                    controller: controllerX.shortName_,
                                    width: controllerX.fixedWidth,
                                    isEnable: controllerX.isEnable,
                                    onchanged: (value) {},
                                    autoFocus: false,
                                    // focusNode: controllerX.productLevel1Focus
                                    // autoFocus: true,
                                  ),
                                  InputFields.formField1(
                                    hintTxt: "Address",
                                    // autoFocus: true,
                                    // controller: controllerX.productLevel1Controller,
                                    controller: controllerX.address1_,
                                    width: controllerX.fixedWidth,
                                    isEnable: controllerX.isEnable,
                                    onchanged: (value) {},
                                    autoFocus: false,
                                    // focusNode: controllerX.productLevel1Focus
                                    // autoFocus: true,
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  InputFields.formField1(
                                    hintTxt: "",
                                    // autoFocus: true,
                                    showTitle: false,
                                    // controller: controllerX.productLevel1Controller,
                                    controller: controllerX.address2_,
                                    width: controllerX.fixedWidth,
                                    isEnable: controllerX.isEnable,
                                    onchanged: (value) {},
                                    autoFocus: false,

                                    // focusNode: controllerX.productLevel1Focus
                                    // autoFocus: true,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.005,
                                      ),
                                      DropDownField.formDropDown1WidthMap(
                                        controllerX.masterModel?.lstCitys ?? [],
                                        (value) {
                                          controllerX.selectCity = value;
                                          // controllerX.selectedCensorShipType = value;
                                        },
                                        "City",
                                        controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        selected: controllerX.selectCity,
                                        autoFocus: false,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.035,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.034,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Pin",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.pin_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                                    ],
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.005,
                                      ),
                                      DropDownField.formDropDown1WidthMap(
                                        controllerX
                                                .masterModel?.lstCountryCodes ??
                                            [],
                                        (value) {
                                          controllerX.selectCountry = value;
                                        },
                                        "Country",
                                        controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        selected: controllerX.selectCountry,
                                        autoFocus: false,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.035,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.034,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "IBF Code",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.ibfCode_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                                    ],
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.005,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Phone",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.phone_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.035,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.034,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Mobile",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.mob_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                                    ],
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.005,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Fax",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.fax_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.035,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.034,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Email",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.email_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                                    ],
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.005,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Contact",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.contact_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.035,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.034,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "SAP Client",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.sapClie_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                                    ],
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.005,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Sector",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.sector_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.035,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.034,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Industry",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.industry_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                                    ],
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.005,
                                      ),
                                      DropDownField.formDropDown1WidthMap(
                                        controllerX
                                                .masterModel?.lstPaymentModes ??
                                            [],
                                        (value) {
                                          controllerX.selectPayment = value;
                                        },
                                        "Payment",
                                        controllerX.fixedWidth1,
                                        selected: controllerX.selectPayment,
                                        isEnable: controllerX.isEnable,
                                        autoFocus: false,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.035,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.034,
                                      ),
                                      DropDownField.formDropDown1WidthMap(
                                        controllerX
                                                .masterModel?.lstCreditRates ??
                                            [],
                                        (value) {
                                          controllerX.selectCredit = value;
                                        },
                                        "Credit",
                                        controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        selected: controllerX.selectCredit,
                                        autoFocus: false,
                                      ),
                                      /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                                    ],
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.005,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Credit Days",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.creditDays_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.035,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.034,
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "Credit Limit",
                                        // autoFocus: true,
                                        // controller: controllerX.productLevel1Controller,
                                        controller: controllerX.creditLimit_,
                                        width: controllerX.fixedWidth1,
                                        isEnable: controllerX.isEnable,
                                        onchanged: (value) {},
                                        autoFocus: false,
                                        // focusNode: controllerX.productLevel1Focus
                                        // autoFocus: true,
                                      ),
                                      /* SizedBox(
                                  width: Get.width*0.01,
                                ),*/
                                    ],
                                  ),
                                  InputFields.formField1(
                                    hintTxt: "Name 1",
                                    // autoFocus: true,
                                    // controller: controllerX.productLevel1Controller,
                                    controller: controllerX.name1_,
                                    width: controllerX.fixedWidth,
                                    isEnable: controllerX.isEnable,
                                    onchanged: (value) {},
                                    autoFocus: false,
                                    // focusNode: controllerX.productLevel1Focus
                                    // autoFocus: true,
                                  ),
                                  InputFields.formField1(
                                    hintTxt: "Name 2",
                                    // autoFocus: true,
                                    // controller: controllerX.productLevel1Controller,
                                    controller: controllerX.name2_,
                                    width: controllerX.fixedWidth,
                                    isEnable: controllerX.isEnable,
                                    onchanged: (value) {},
                                    autoFocus: false,
                                    // focusNode: controllerX.productLevel1Focus
                                    // autoFocus: true,
                                  ),
                                  InputFields.formField1(
                                    hintTxt: "Name 3",
                                    // autoFocus: true,
                                    // controller: controllerX.productLevel1Controller,
                                    controller: controllerX.name3_,
                                    width: controllerX.fixedWidth,
                                    isEnable: controllerX.isEnable,
                                    onchanged: (value) {},
                                    autoFocus: false,
                                    // focusNode: controllerX.productLevel1Focus
                                    // autoFocus: true,
                                  ),
                                  InputFields.formField1(
                                    hintTxt: "IBF Remarks",
                                    // autoFocus: true,
                                    // controller: controllerX.productLevel1Controller,
                                    controller: controllerX.ibfRemark_,
                                    width: controllerX.fixedWidth,
                                    isEnable: controllerX.isEnable,
                                    onchanged: (value) {},
                                    autoFocus: false,
                                    // focusNode: controllerX.productLevel1Focus
                                    // autoFocus: true,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 10, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Block Client",
                                          callback: () {
                                            controllerX.postBlockClient();
                                          },
                                          showIcon: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 10, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Un-Block Client",
                                          callback: () {
                                            controllerX.postUnblockClient();
                                          },
                                          showIcon: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 9,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                /*SizedBox(
                                            width: Get.width*0.005,
                                          ),*/
                                                DropDownField
                                                    .formDropDown1WidthMap(
                                                  controllerX.masterModel
                                                          ?.lstlocations ??
                                                      [],
                                                  (value) {
                                                    // controllerX.selectedCensorShipType = value;
                                                    controllerX.selectLocation
                                                        ?.value = value;
                                                    controllerX.getChannel();
                                                  },
                                                  "Location",
                                                  controllerX.fixedWidth2,
                                                  selected: controllerX
                                                      .selectLocation?.value,
                                                  // isEnable: controllerX.isEnable,
                                                  autoFocus: false,
                                                ),
                                                /*SizedBox(
                                            width: Get.width*0.035,
                                          ),
                                          SizedBox(
                                            width: Get.width*0.034,
                                          ),*/
                                                Obx(() {
                                                  return DropDownField
                                                      .formDropDown1WidthMap(
                                                    controllerX.channelList
                                                            ?.value ??
                                                        [],
                                                    (value) {
                                                      controllerX.selectChannel
                                                          ?.value = value;
                                                    },
                                                    "Channel",
                                                    controllerX.fixedWidth2,
                                                    selected: controllerX
                                                        .selectChannel?.value,
                                                    // isEnable: controllerX.isEnable,
                                                    autoFocus: false,
                                                  );
                                                }),
                                                /* SizedBox(
                                              width: Get.width*0.01,
                                            ),*/
                                              ],
                                            ),
                                            DropDownField.formDropDownSearchAPI2(
                                                GlobalKey(), context,
                                                title: "Agency",
                                                autoFocus: false,
                                                // customInData: "empList",
                                                url: ApiFactory
                                                    .CLIENT_MASTER_SEARCH_AGENCY,
                                                // inkwellFocus: controllerX.employeeFocus,
                                                // parseKeyForTitle: "programName",
                                                parseKeyForKey: "agencycode",
                                                parseKeyForValue: "agencyname",
                                                // selectedValue: controllerX.selectedEmployee.value,
                                                onchanged: (data) {
                                              controllerX.selectAgency = data;
                                            },
                                                width: (Get.width *
                                                    controllerX.fixedWidth3)),
                                            DropDownField.formDropDownSearchAPI2(
                                                GlobalKey(), context,
                                                title: "Executive",
                                                autoFocus: false,
                                                // customInData: "empList",
                                                url: ApiFactory
                                                    .CLIENT_MASTER_SEARCH_EXECUTIVE,
                                                // inkwellFocus: controllerX.employeeFocus,
                                                // parseKeyForTitle: "programName",
                                                parseKeyForKey: "Personnelcode",
                                                parseKeyForValue:
                                                    "Personnelname",
                                                // selectedValue: controllerX.selectedEmployee.value,
                                                onchanged: (data) {
                                              controllerX.selectExecutive =
                                                  data;
                                            },
                                                width: (Get.width *
                                                    controllerX.fixedWidth3)),
                                            Obx(() {
                                              return DropDownField.formDropDownSearchAPI2(
                                                  GlobalKey(), context,
                                                  title: "Payroute",
                                                  autoFocus: false,
                                                  // customInData: "empList",
                                                  url: ApiFactory
                                                      .CLIENT_MASTER_SEARCH_PAYROUTE(
                                                          controllerX
                                                                  .selectLocation
                                                                  ?.value
                                                                  ?.key ??
                                                              "",
                                                          controllerX
                                                                  .selectChannel
                                                                  ?.value
                                                                  ?.key ??
                                                              ""),
                                                  // inkwellFocus: controllerX.employeeFocus,
                                                  // parseKeyForTitle: "programName",
                                                  parseKeyForKey:
                                                      "PayrouteCode",
                                                  parseKeyForValue:
                                                      "PayrouteName",
                                                  selectedValue:
                                                      controllerX.selectPayroute,
                                                  onchanged: (data) {
                                                controllerX.selectPayroute =
                                                    data;
                                                controllerX.getPlantList();
                                              },
                                                  width: (Get.width *
                                                      controllerX.fixedWidth3),
                                                  inkwellFocus: controllerX.payRouteFS);
                                            }),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: DateWithThreeTextField(
                                                    title: "Effective",
                                                    mainTextController:
                                                        controllerX.effective_,
                                                    widthRation:
                                                        controllerX.fixedWidth2,
                                                    // isEnable: controllerX.isEnable.value,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.005,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Obx(() => DropDownField
                                                    .formDropDown1WidthMap(
                                                  controllerX
                                                          .plantList?.value ??
                                                      [],
                                                  (value) {
                                                    controllerX.selectPlant =
                                                        value;
                                                  },
                                                  "Plant",
                                                  0.413,
                                                  selected:
                                                      controllerX.selectPlant,
                                                  // isEnable: controllerX.isEnable,
                                                  autoFocus: false,
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0,
                                                          left: 10,
                                                          right: 1),
                                                  child: FormButtonWrapper(
                                                    btnText: "Add",
                                                    callback: () {
                                                      // controllerX.showApiCall();
                                                    },
                                                    showIcon: true,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Container(
                                              width: Get.width *
                                                  controllerX.fixedWidth3,
                                              height: Get.height * 0.23,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                /*SizedBox(
                                            width: Get.width*0.005,
                                          ),*/
                                                DropDownField
                                                    .formDropDown1WidthMap(
                                                  [],
                                                  (value) {
                                                    // controllerX.selectedCensorShipType = value;
                                                  },
                                                  "Agency",
                                                  0.3,
                                                  // isEnable: controllerX.isEnable,
                                                  autoFocus: false,
                                                ),
                                                /*SizedBox(
                                            width: Get.width*0.035,
                                          ),
                                          SizedBox(
                                            width: Get.width*0.034,
                                          ),*/
                                                InkWell(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 14.0,
                                                            left: 10,
                                                            right: 1),
                                                    child: Container(
                                                      width: Get.width * 0.0502,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey)),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: Center(
                                                            child: Text("...")),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                /* SizedBox(
                                              width: Get.width*0.01,
                                            ),*/
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                DropDownField
                                                    .formDropDown1WidthMap(
                                                  controllerX.retrieveData
                                                          ?.lstPaymentMaster ??
                                                      [],
                                                  (value) {
                                                    controllerX.selectAgency1 =
                                                        value;
                                                  },
                                                  "Pay Mode",
                                                  0.3,
                                                  selected:
                                                      controllerX.selectAgency1,
                                                  // isEnable: controllerX.isEnable,
                                                  autoFocus: false,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.035,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InputFields.formField1(
                                                  hintTxt: "IBF Remark",
                                                  // autoFocus: true,
                                                  // controller: controllerX.productLevel1Controller,
                                                  controller:
                                                      controllerX.ibfRemark1_,
                                                  width: 0.3,
                                                  autoFocus: false,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0,
                                                          left: 10,
                                                          right: 1),
                                                  child: FormButtonWrapper(
                                                    btnText: "Add",
                                                    callback: () {
                                                      // controllerX.showApiCall();
                                                    },
                                                    showIcon: true,
                                                  ),
                                                ),

                                                /* SizedBox(
                                          width: Get.width*0.01,
                                        ),*/
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: Get.width *
                                                  controllerX.fixedWidth3,
                                              height: Get.height * 0.12,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
            SizedBox(height: 5),
            // const SizedBox(height: 8),
            Align(
              alignment: Alignment.topLeft,
              child: GetBuilder<HomeController>(
                  id: "buttons",
                  init: Get.find<HomeController>(),
                  builder: (controller) {
                    PermissionModel formPermissions = Get.find<MainController>()
                        .permissionList!
                        .lastWhere((element) =>
                            element.appFormName == "frmAuditStatus");
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
      key: GlobalKey(),
    );
  }
}
