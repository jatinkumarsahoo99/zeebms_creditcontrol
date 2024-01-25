import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
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
  List<LstPayTerm>? payTermList;
  List<LstPayTerm>? lstClientAgencyMaster;

  FocusNode payRouteFS=FocusNode();

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

            // selectPayment
            // selectCredit
          } else {
            masterModel = null;
          }
          update(["main"]);
        });
  }

  formHandler(String string) {}
}
