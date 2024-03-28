import 'dart:async';

import 'package:bms_creditcontrol/app/modules/GSTPlantInfo/GSTPlantInfoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonDocs/controllers/common_docs_controller.dart';
import '../../CommonDocs/views/common_docs_view.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../AgencyMasterRetrieveModel.dart';
import '../InfoDataList.dart';
import 'dart:html' as html;

class AgencyMasterController extends GetxController {
  //TODO: Implement AgencyMasterController

  final count = 0.obs;
  double fixedWidth = 0.49;
  double fixedWidth1 = 0.23;
  double fixedWidth2 = 0.43;
  Widget? dialogWidget;
  var canDialogShow = false.obs;
  Rxn<int> initialOffset = Rxn<int>(null);
  Completer<bool>? completerDialog;
  ScrollController scrollController = ScrollController();

  Rx<bool> disable = Rx<bool>(false);
  Rx<bool> enable = Rx<bool>(true);

  RxList<DropDownValue> cityLst = RxList([]);

  Rxn<DropDownValue> selectedCity = Rxn<DropDownValue>(null);
  Rxn<DropDownValue> selectedAgencyName = Rxn<DropDownValue>(null);

  TextEditingController groupNameController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressController1 = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sapCodeController = TextEditingController();
  TextEditingController custGrpController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController IBFDescController = TextEditingController();
  TextEditingController printNameController = TextEditingController();
  TextEditingController name3Controller = TextEditingController();
  TextEditingController panNoController = TextEditingController();
  TextEditingController gstNoController = TextEditingController();
  TextEditingController emailToController = TextEditingController();
  TextEditingController emailCCController = TextEditingController();

  AgencyMasterRetrieveModel? agencyMasterRetrieveModel;

  PlutoGridStateManager? stateManager;
  PlutoGridStateManager? addInfoStateManager;

  String agencyCode = "";
  String strShortName = "";
  String strCreditRateCode = "";

  Offset? getOffSetValue(BoxConstraints constraints) {
    switch (initialOffset.value) {
      case 1:
        return Offset((constraints.maxWidth / 3) + 30, constraints.maxHeight / 3);
      case 2:
        return Offset(Get.width * 0.09, Get.height * 0.12);
      case 3:
        return const Offset(20, 20);
      default:
        return null;
    }
  }
  getAllLoadData() {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.AGENCY_MASTER_ON_LOAD,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            // print(">>>>>>>>>>mapData$map");
            if (map is Map && map['city'] != null && map['city'].length > 0) {
              RxList<DropDownValue> dataList = RxList([]);
              cityLst.clear();
              map['city'].forEach((e) {
                dataList.add(DropDownValue.fromJsonDynamic(e, "placeCode", "placeName"));
              });
              cityLst.addAll(dataList);
              cityLst.refresh();
            } else {}
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  getRetrieveRecord() {
    LoadingDialog.call();
    try {
      Map<String, dynamic> postData = {
        "agencycode": selectedAgencyName.value?.key ?? "",
        "agencyname": selectedAgencyName.value?.value ?? ""
      };
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.AGENCY_MASTER_GET_RETRIEVE_RECORD,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['retrieve'] != null) {
              agencyMasterRetrieveModel =
                  AgencyMasterRetrieveModel.fromJson(map as Map<String, dynamic>);
              assignVal(agencyMasterRetrieveModel);
              update(['grid']);
            } else {
              agencyMasterRetrieveModel = null;
              assignVal(agencyMasterRetrieveModel);
              update(['grid']);
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  assignVal(AgencyMasterRetrieveModel? agencyDetail) {
    if (agencyDetail != null) {
      groupNameController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].groupName ?? "";
      contactPersonController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].contactPerson ?? "";
      addressController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].address1 ?? "";
      addressController1.text = agencyDetail.retrieve?.lstAGencyMaster?[0].address2 ?? "";

      for (DropDownValue e in cityLst) {
        if (e.key.toString().trim() ==
            agencyDetail.retrieve?.lstAGencyMaster?[0].city.toString().trim()) {
          selectedCity.value = DropDownValue(value: e.value ?? "", key: e.key ?? "");
          break;
        }
      }
      selectedCity.refresh();

      pinController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].pin ?? "";
      telController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].phone ?? "";
      emailController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].email ?? "";
      sapCodeController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].sapAgencyCode ?? "";
      custGrpController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].custGroupCode ?? "";
      mobileController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].mobile ?? "";
      IBFDescController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].ibfcode ?? "";
      printNameController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].name2 ?? "";
      name3Controller.text = agencyDetail.retrieve?.lstAGencyMaster?[0].name3 ?? "";
      panNoController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].agencyShortName??"";
      gstNoController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].agencyGSTNumber ?? "";
      emailToController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].mailto ?? "";
      emailCCController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].mailcc ?? "";

      agencyCode = agencyDetail.retrieve?.lstAGencyMaster?[0].agencyCode ?? "";
      strShortName = agencyDetail.retrieve?.lstAGencyMaster?[0].agencyShortName ?? "";
      strCreditRateCode = agencyDetail.retrieve?.lstAGencyMaster?[0].creditRateCode ?? "";

    } else {
      groupNameController.text = "";
      agencyCode = "";
      strShortName = "";
      strCreditRateCode = "";

      contactPersonController.text = "";
      addressController.text = "";
      addressController1.text = "";
      selectedCity.value = null;

      pinController.text = "";
      telController.text = "";
      emailController.text = "";
      sapCodeController.text = "";
      custGrpController.text = "";
      mobileController.text = "";
      IBFDescController.text = "";
      printNameController.text = "";
      name3Controller.text = "";
      // panNoController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].pa??"";
      gstNoController.text = "";
      emailToController.text = "";
      emailToController.text = "";
    }
  }

  postBlockAgency() {
    LoadingDialog.call();
    try {
      Map<String, dynamic> postData = {
        "changeAgencyCode": selectedAgencyName.value?.key ?? "",
        "agencyCode": selectedAgencyName.value?.key ?? ""
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AGENCY_MASTER_POST_BLOCK_AGENCY,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            print(">>>>>>>>>>>>map" + map.toString());
            // {"blockMessage":"Agency Blocked"}
            if(map is Map && map['blockMessage'] != null){
              LoadingDialog.callDataSaved(msg:map['blockMessage']??"");
            }else{
              LoadingDialog.showErrorDialog((map??"Something went wrong").toString());
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            LoadingDialog.showErrorDialog((map??"Something went wrong").toString());
          });
    } catch (e) {
      closeDialogIfOpen();
      LoadingDialog.showErrorDialog(("Something went wrong"));
    }
  }

  postUnBlockAgency() {
    LoadingDialog.call();
    try {
      Map<String, dynamic> postData = {"agencyCode": selectedAgencyName.value?.key ?? ""};
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AGENCY_MASTER_POST_UN_BLOCK_AGENCY,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            print(">>>>>>>>>>>>map" + map.toString());
            // {"blockMessage":"Agency Blocked"}
            if(map is Map && map['unblockMessage'] != null){
              LoadingDialog.callDataSaved(msg:map['unblockMessage']??"");
            }else{
              LoadingDialog.showErrorDialog((map??"Something went wrong").toString());
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            LoadingDialog.showErrorDialog((map??"Something went wrong").toString());
          });
    } catch (e) {
      closeDialogIfOpen();
      LoadingDialog.showErrorDialog(("Something went wrong"));
    }
  }

  saveFunCall() {
    print(">>>>>>>agencyCode$agencyCode");
    if (agencyCode != "") {
      LoadingDialog.modify("Record Already exist!\nDo you want to modify it?", () {
        saveApiCall();
      }, () {

      },
          cancelTitle: "No", deleteTitle: "Yes");
    }
  }

  saveApiCall() {
    try{
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "agencyCode": selectedAgencyName.value?.key??"",
        "agencyName": selectedAgencyName.value?.value??"",
        "agencyShortName": strShortName??"",
        "address1": addressController.text??"",
        "address2": addressController1.text??"",
        "city": selectedCity.value?.key??"",
        "phone": telController.text??"",
        "mobile": mobileController.text??"",
        "email": emailController.text??"",
        "contactPerson": contactPersonController.text??"",
        "creditRateCode": strCreditRateCode??"",
        "pin": pinController.text??"",
        "sapAgencyCode": sapCodeController.text??"",
        "cust_group_code": custGrpController.text??"",
        "name2": printNameController.text??"",
        "name3": name3Controller.text??"",
        "mailto": emailToController.text??"",
        "mailcc": emailCCController.text??"",
        "tblAddInfo": getJson(agencyMasterRetrieveModel) ?? []
      };

      Get.find<ConnectorControl>().POSTMETHOD(
          api:  ApiFactory.AGENCY_MASTER_POST,
          json: postData,
          fun: (map){
            closeDialogIfOpen();
            if(map is Map && map['save'] != null){
              LoadingDialog.callDataSaved(msg:map['save']??"",callback: (){
                clearAll();
              });
            }else{
              LoadingDialog.showErrorDialog("Something went wrong");
            }
      },failed: (map){
            closeDialogIfOpen();
            LoadingDialog.showErrorDialog("Something went wrong");
      });

    }catch(e){
      closeDialogIfOpen();
      print(">>>>>>exception"+e.toString());
      LoadingDialog.showErrorDialog("Something went wrong");
    }

  }

  getJson(AgencyMasterRetrieveModel? agencyMod){
    if(agencyMod != null && agencyMod.retrieve != null && agencyMod.retrieve?.tblAddInfo != null
        && (agencyMod.retrieve?.tblAddInfo?.length??0) >0 ){
      return agencyMod.retrieve?.tblAddInfo?.map((e) => e.toJson()).toList();
    }else{
      return [];
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  clearAll() {
    // Get.delete<AgencyMasterController>();
    // Get.find<HomeController>().clearPage1();
    html.window.location.reload();
  }


  docs() async {
    String documentKey = "";
    if (agencyCode == "" ) {
      documentKey = "";
    } else {
      documentKey = "Agencymaster $agencyCode";
    }
    if (documentKey == "") {
      return;
    }
    Get.defaultDialog(
      title: "Documents",
      content: CommonDocsView(documentKey: documentKey),
    ).then((value) {
      Get.delete<CommonDocsController>(tag: "commonDocs");
    });
  }

  formHandler(String str) {
    if(str == "Clear"){
      clearAll();
    }else if(str == "Save"){
      saveFunCall();
    }else if(str == "Search"){
      Get.to(
        const SearchPage(
          key: Key("Agency Master"),
          screenName: "Agency Master",
          appBarName: "Agency Master",
          strViewName: "BMS_vAgencyMaster",
          isAppBarReq: true,
        ),
      );
    }else if(str == "Docs"){
      docs();
    }
  }

  List<Map<String, dynamic>> getDataFromGrid2(PlutoGridStateManager? statemanager,{String? gridName}) {
    if (statemanager != null) {
      statemanager.setFilter((element) => true);
      statemanager.notifyListeners();
      List<Map<String, dynamic>> mapList = [];
      for (var row in statemanager.rows) {
        Map<String, dynamic> rowMap = {};
        for (var key in row.cells.keys) {
          if ((key.toString().trim() == "isRequired")) {
            if(row.cells[key]?.value != null && row.cells[key]?.value != ""){
              try{
                rowMap[key] = int.parse( row.cells[key]?.value ?? "0");
              }catch(e){
                rowMap[key] = double.parse( row.cells[key]?.value ?? "0");
              }
            }else{
              rowMap[key] =  0;
            }

          } else {
            rowMap[key] = row.cells[key]?.value ?? "";
          }

        }
        mapList.add(rowMap);
      }
      return mapList;
    }
    else {
      return [];
    }
  }

  InfoDataList ? infoDataList;
  Future<String>getInfoData(){
    Completer<String> completer = Completer<String>();
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.COMMON_ADD_INFO("frmAgencyMaster"),
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map != null && map.length >0){
              infoDataList = InfoDataList.fromJson({
                "data":map
              });
            }
            completer.complete("");
            // print(">>>>>>>>>>mapData$map");
          },
          failed: (map) {
            closeDialogIfOpen();
            completer.complete("");
          });
    } catch (e) {
      closeDialogIfOpen();
      completer.complete("");
    }
    return completer.future;
  }



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getAllLoadData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
