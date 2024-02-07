import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../AgencyMasterRetrieveModel.dart';

class AgencyMasterController extends GetxController {
  //TODO: Implement AgencyMasterController

  final count = 0.obs;
  double fixedWidth = 0.49;
  double fixedWidth1 = 0.23;
  double fixedWidth2 = 0.43;
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

  AgencyMasterRetrieveModel ?agencyMasterRetrieveModel;

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
            if(map is Map && map['retrieve'] != null ){
              agencyMasterRetrieveModel = AgencyMasterRetrieveModel.fromJson(map as Map<String,dynamic>);
              assignVal(agencyMasterRetrieveModel);
            }else{
              agencyMasterRetrieveModel = null;
              assignVal(agencyMasterRetrieveModel);
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  assignVal(AgencyMasterRetrieveModel? agencyDetail){
    if(agencyDetail != null){
      groupNameController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].groupName??"" ;
      contactPersonController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].contactPerson??"";
      addressController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].address1??"";
      addressController1.text = agencyDetail.retrieve?.lstAGencyMaster?[0].address2??"";


      for (DropDownValue e in cityLst) {
        if(e.key.toString().trim() ==agencyDetail.retrieve?.lstAGencyMaster?[0].city.toString().trim() ){
          selectedCity.value = DropDownValue(value:e.value??"" ,key:e.key??"" );
          break;
        }
      }

      pinController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].pin??"";
      telController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].phone??"";
      emailController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].email??"";
      sapCodeController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].sapAgencyCode??"";
      custGrpController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].custGroupCode??"";
      mobileController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].mobile??"";
      IBFDescController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].ibfcode??"";
      printNameController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].name2??"";
      name3Controller.text = agencyDetail.retrieve?.lstAGencyMaster?[0].name3??"";
      // panNoController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].pa??"";
      gstNoController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].agencyGSTNumber??"";
      emailToController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].mailto??"";
      emailToController.text = agencyDetail.retrieve?.lstAGencyMaster?[0].mailcc??"";



    }else{
      groupNameController.text = "";

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

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  formHandler(String string) {}

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
