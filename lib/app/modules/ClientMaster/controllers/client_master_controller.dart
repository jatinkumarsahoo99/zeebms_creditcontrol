import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';
import '../ClientMasterModel.dart';
import '../ClientRetriveDataModel.dart';

class ClientMasterController extends GetxController {
  //TODO: Implement ClientMasterController

  final count = 0.obs;
  double fixedWidth = 0.53;
  double fixedWidth1 = 0.23;
  double fixedWidth2 = 0.18;
  double fixedWidth3 = 0.427999;
  bool? isEnable = false;
  DropDownValue? selectClientName;
  DropDownValue? selectCity;
  DropDownValue? selectCountry;
  DropDownValue? selectPayment;
  DropDownValue? selectCredit;
  Rxn<DropDownValue>? selectLocation = Rxn<DropDownValue>();
  Rxn<DropDownValue>? selectChannel = Rxn<DropDownValue>();

  // DropDownValue? selectChannel;
  DropDownValue? selectAgency;
  DropDownValue? selectExecutive;
  DropDownValue? selectPayroute;
  DropDownValue? selectPlant;
  DropDownValue? selectPayMode;
  DropDownValue? selectAgency1;
  TextEditingController shortName_ = TextEditingController();
  TextEditingController address1_ = TextEditingController();
  TextEditingController address2_ = TextEditingController();
  TextEditingController pin_ = TextEditingController();
  TextEditingController ibfCode_ = TextEditingController();
  TextEditingController phone_ = TextEditingController();
  TextEditingController mob_ = TextEditingController();
  TextEditingController fax_ = TextEditingController();
  TextEditingController email_ = TextEditingController();
  TextEditingController contact_ = TextEditingController();
  TextEditingController sapClie_ = TextEditingController();
  TextEditingController sector_ = TextEditingController();
  TextEditingController industry_ = TextEditingController();
  TextEditingController creditDays_ = TextEditingController();
  TextEditingController creditLimit_ = TextEditingController();
  TextEditingController name1_ = TextEditingController();
  TextEditingController name2_ = TextEditingController();
  TextEditingController name3_ = TextEditingController();
  TextEditingController ibfRemark_ = TextEditingController();
  TextEditingController effective_ = TextEditingController();
  TextEditingController ibfRemark1_ = TextEditingController();

  ClientMasterModel? masterModel;
  ClientRetriveDataModel? retrieveData;

  // List<DropDownValue>? plantList;
  RxList<DropDownValue>? channelList = RxList([]);
  RxList<DropDownValue>? plantList = RxList([]);
  RxList<DropDownValue>? agencyList1 = RxList([]);
  List<LstPayTerm>? payTermList;
  List<ClientAgencyMaster>? lstClientAgencyMaster;

  FocusNode payRouteFS = FocusNode();
  PlutoGridStateManager? payTermManager;
  PlutoGridStateManager? clientMasterManager;

  @override
  void onInit() {
    getLoad();
    super.onInit();
  }

  getLoad() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CLIENT_MASTER_MAIN_DATA,
        fun: (Map map) {
          if (map.containsKey("cmLoad")) {
            masterModel = ClientMasterModel.fromJson(map["cmLoad"]);
            effective_.text =
                (masterModel?.maxEffectiveDate ?? '').replaceAll("-", "/");
          } else {
            masterModel = null;
          }
          update(["main"]);
        });
  }

  getChannel() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CLIENT_MASTER_CHANNEL_LEAVE +
            (selectLocation?.value?.key ?? ""),
        fun: (Map map) {
          if (map.containsKey("cmChannels") && map["cmChannels"] != null) {
            channelList?.clear();
            map["cmChannels"].forEach((e) {
              channelList?.value.add(DropDownValue(
                  key: e["channelCode"], value: e["channelName"]));
            });
          }
        });
  }

  getPlantList() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CLIENT_MASTER_GET_PAYROUTE_CODE(
            selectLocation?.value?.key ?? "",
            selectChannel?.value?.key ?? "",
            selectPayroute?.key ?? ""),
        fun: (Map map) {
          Get.back();
          // map.
          map["cMplants"].forEach((e) {
            plantList?.value.add(DropDownValue(
                key: e["plantid"].toString(), value: e["PlantName"]));
          });
          payRouteFS.requestFocus();
          // update(["main"]);
        });
  }

  postUnblockClient() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.CLIENT_MASTER_UNBLOCK_CLIENT,
        fun: (map) {
          Get.back();
          // map.
          if (map is Map && map.containsKey("message")) {
            LoadingDialog.callDataSaved(msg: map["message"]);
          } else {
            LoadingDialog.callErrorMessage1(msg: map.toString());
          }
        },
        json: {"clientcode": selectClientName?.key ?? ""});
  }

  postBlockClient() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.CLIENT_MASTER_BLOCK_CLIENT,
        fun: (map) {
          Get.back();
          // map.
          if (map is Map && map.containsKey("message")) {
            LoadingDialog.callDataSaved(msg: map["message"]);
          } else {
            LoadingDialog.callErrorMessage1(msg: map.toString());
          }
        },
        json: {"clientcode": selectClientName?.key ?? ""});
  }

  getRetriveData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CLIENT_MASTER_RETRIVE_DATA(
            selectClientName?.key ?? "", selectClientName?.value ?? ""),
        fun: (Map map) {
          Get.back();
          if (map.containsKey("cmRecord")) {
            retrieveData = ClientRetriveDataModel.fromJson(map["cmRecord"]);
            shortName_.text =
                retrieveData?.lstRecords![0].clientShortName ?? "";
            address1_.text = retrieveData?.lstRecords![0].address1 ?? "";
            address2_.text = retrieveData?.lstRecords![0].address2 ?? "";
            pin_.text = retrieveData?.lstRecords![0].pin ?? "";
            ibfCode_.text = retrieveData?.lstRecords![0].ibfcode ?? "";
            phone_.text = retrieveData?.lstRecords![0].phone ?? "";
            mob_.text = retrieveData?.lstRecords![0].mobile ?? "";
            fax_.text = retrieveData?.lstRecords![0].fax ?? "";
            email_.text = retrieveData?.lstRecords![0].email ?? "";
            contact_.text = retrieveData?.lstRecords![0].contactPerson ?? "";
            sapClie_.text = retrieveData?.lstRecords![0].sapClinetCode ?? "";
            sector_.text = retrieveData?.lstRecords![0].groupFlag ?? "";
            industry_.text = retrieveData?.lstRecords![0].psuFlag ?? "";
            creditDays_.text =
                retrieveData?.lstRecords![0].creditdays.toString() ?? "";
            creditLimit_.text =
                retrieveData?.lstRecords![0].osAmount.toString() ?? "";
            name1_.text = retrieveData?.lstRecords![0].name1 ?? "";
            name2_.text = retrieveData?.lstRecords![0].name2 ?? "";
            name3_.text = retrieveData?.lstRecords![0].name3 ?? "";
            ibfRemark_.text = retrieveData?.lstRecords![0].ibfremark ?? "";
            if (retrieveData?.lstRecords![0].city != null) {
              selectCity = masterModel?.lstCitys?.firstWhere((element) =>
                  element.key == retrieveData?.lstRecords![0].city);
            }

            if (retrieveData?.lstRecords![0].countrycode != null) {
              selectCountry = masterModel?.lstCountryCodes?.firstWhere(
                  (element) =>
                      element.key == retrieveData?.lstRecords![0].countrycode);
            }
            if (retrieveData?.lstRecords![0].paymentmodecode != null) {
              selectPayment = masterModel?.lstPaymentModes?.firstWhere(
                  (element) =>
                      element.key ==
                      retrieveData?.lstRecords![0].paymentmodecode);
            }
            if (retrieveData?.lstRecords![0].creditRateCode != null) {
              selectCredit = masterModel?.lstCreditRates?.firstWhere(
                  (element) =>
                      element.key ==
                      retrieveData?.lstRecords![0].creditRateCode);
            }
            payTermList = retrieveData?.lstPayTerm ?? [];

            // selectPayment
            // selectCredit
          } else {
            masterModel = null;
          }
          update(["main", "payTerm"]);
        });
  }

  formHandler(name) {
    switch (name) {
      case "Save":
        save();
        break;
      case "Clear":
        Get.delete<ClientMasterController>();
        Get.find<HomeController>().clearPage1();
        break;
    }
  }

  void addToClientMaster() {
    if (lstClientAgencyMaster == null) {
      lstClientAgencyMaster = [];
    }
    ClientAgencyMaster data = ClientAgencyMaster();
    data.locationCode = selectLocation?.value?.key ?? "";
    data.locationName = selectLocation?.value?.value ?? "";
    data.channelCode = selectChannel?.value?.key ?? "";
    data.channelName = selectChannel?.value?.value ?? "";
    data.agencyCode = selectAgency?.key ?? "";
    data.agencyName = selectAgency?.value ?? "";
    data.payroutecode = selectPayroute?.key ?? "";
    data.payrouteName = selectPayroute?.value ?? "";
    data.plantid = selectPlant?.key ?? "";
    data.plantName = selectPlant?.value ?? "";
    data.clientName = selectClientName?.value ?? "";
    data.effectiveFrom = effective_.text;
    data.executiveName = selectExecutive?.value ?? "";
    data.executiveCode = selectExecutive?.key ?? "";
    lstClientAgencyMaster?.add(data);
    update(["clientData"]);
  }

  postSave() {
    var jsonData = {
      "clientCode": selectClientName?.key ?? "",
      "clientName": selectClientName?.value ?? "",
      "clientShortName": retrieveData?.lstRecords![0].clientShortName ?? "",
      "address1": retrieveData?.lstRecords![0].address1 ?? "",
      "address2": retrieveData?.lstRecords![0].address2 ?? "",
      "city": retrieveData?.lstRecords![0].city ?? "",
      "phone": retrieveData?.lstRecords![0].phone ?? "",
      "fax": retrieveData?.lstRecords![0].fax ?? "",
      "mobile": retrieveData?.lstRecords![0].mobile ?? "",
      "email": retrieveData?.lstRecords![0].email ?? "",
      "contactPerson": retrieveData?.lstRecords![0].contactPerson ?? "",
      "creditRateCode": retrieveData?.lstRecords![0].creditRateCode ?? "",
      "modifiedBy": retrieveData?.lstRecords![0].modifiedBy ?? "",
      "pin": retrieveData?.lstRecords![0].pin ?? "",
      "countrycode": retrieveData?.lstRecords![0].countrycode ?? "",
      "ibf": retrieveData?.lstRecords![0].ibfcode != "" ? "Y" : "N",
      "ibfcode": retrieveData?.lstRecords![0].ibfcode ?? "",
      "sapClinetCode": retrieveData?.lstRecords![0].sapClinetCode ?? "",
      "name1": retrieveData?.lstRecords![0].name1 ?? "",
      "name2": retrieveData?.lstRecords![0].name2 ?? "",
      "name3": retrieveData?.lstRecords![0].name3 ?? "",
      "paymentmodecode": retrieveData?.lstRecords![0].paymentmodecode ?? "",
      "ibfremark": retrieveData?.lstRecords![0].ibfremark ?? "",
      "groupFlag": retrieveData?.lstRecords![0].groupFlag ?? "",
      "contractual": retrieveData?.lstRecords![0].chkContractual ?? false,
      "psuFlag": retrieveData?.lstRecords![0].psuFlag ?? "",
      "brandFlag": false,
      "surrogateflag": false,
      "slotsaleflag": false,
      "exposureflag": false,
      "pdc": false,
      "creditdays":
          retrieveData?.lstRecords![0].clientShortName.toString() ?? "",
      "osAmount": retrieveData?.lstRecords![0].osAmount.toString() ?? "",
      "lstClientAgencyMaster":
          lstClientAgencyMaster?.map((e) => e.toJson1()).toList(),
      "lstPayTerm": payTermList?.map((e) => e.toJson()).toList()
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.CLIENT_MASTER_POST_SAVE,
        fun: (map) {
          Get.back();
          // map.
          if (map is Map && map.containsKey("message")) {
            LoadingDialog.callDataSaved(msg: map["message"]);
          } else {
            LoadingDialog.callErrorMessage1(msg: map.toString());
          }
        },
        json: jsonData);
  }

  save() {
    // LoadingDialog.call();
    postSave();
  }

  void getAgencyFromList() {
    if (lstClientAgencyMaster != null &&
        (lstClientAgencyMaster?.isNotEmpty ?? false)) {
      lstClientAgencyMaster?.forEach((e) {
        agencyList1?.add(DropDownValue(key: e.agencyCode, value: e.agencyName));
      });
    }
  }

  void addPayTerm() {
    if (payTermList == null) {
      payTermList = [];
    }
    LstPayTerm data = LstPayTerm();
    data.clientcode = selectClientName?.key??"";
    data.clientName = selectClientName?.value??"";
    data.paymentmodecode = selectPayMode?.key??"";
    data.paymentMode = selectPayMode?.value??"";
    data.ibfRemark = ibfRemark1_.text;
    data.agencyCode = selectAgency1?.key ?? "";
    data.agencyName = selectAgency1?.value ?? "";
    data.clientName = selectClientName?.value ?? "";
    payTermList?.add(data);
    update(["payTerm"]);
  }
}
