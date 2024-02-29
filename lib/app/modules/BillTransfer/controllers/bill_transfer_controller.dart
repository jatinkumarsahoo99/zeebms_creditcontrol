import 'package:bms_creditcontrol/app/providers/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class BillTransferController extends GetxController {
  //TODO: Implement BillTransferController

  final count = 0.obs;

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> companyList = RxList([]);

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController totalToController = TextEditingController();
  TextEditingController totalSAPBillsController = TextEditingController();
  TextEditingController totalBillsTransferredController = TextEditingController();
  TextEditingController pendingToTransferController = TextEditingController();

  DropDownValue? selectLocation;
  DropDownValue? selectCompany;

  Rx<bool> transferBtn = Rx<bool>(false);

  fetchAllLoaderData() {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.TRANSFER_DATA_TO_SAP_ON_LOAD,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['infoLoad'] != null) {
              RxList<DropDownValue> dataList = RxList([]);
              map['infoLoad']['lstLocationMasters'].forEach((e) {
                dataList.add(DropDownValue.fromJsonDynamic(e, "locationCode", "locationName"));
              });
              locationList.addAll(dataList);
              locationList.refresh();
            }

            if (map is Map && map['infoLoad'] != null) {
              RxList<DropDownValue> dataList = RxList([]);
              map['infoLoad']['lstCompanyMasters'].forEach((e) {
                dataList.add(DropDownValue.fromJsonDynamic(e, "sapcompanycode", "companyname"));
              });
              companyList.addAll(dataList);
              companyList.refresh();
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  toDateLeave() {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "LocationCode": selectLocation?.key ?? "",
        "FromDate": Utils.toDateFormat6(fromDateController.text),
        "ToDate": Utils.toDateFormat6(toDateController.text),
        "CompanyCode": selectCompany?.key ?? "",
        "BillDate": Utils.toDateFormat6(fromDateController.text),
      };
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.TRANSFER_DATA_TO_SAP_DATE_LEAVE,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['infoDateLeave'] != null) {
              transferBtn.value = map['infoDateLeave']['btnTransfer'] ?? false;
              transferBtn.refresh();

              totalToController.text = map['infoDateLeave']['totalTO'];
              totalSAPBillsController.text = map['infoDateLeave']['totalSAPBills'];
              totalBillsTransferredController.text = map['infoDateLeave']['totalBillTranferred'];
              pendingToTransferController.text = map['infoDateLeave']['billPendingToTransfer'];
              // totalToController.text = map['infoDateLeave']['btnTransfer'];
            } else {
              transferBtn.value = false;
              transferBtn.refresh();

              totalToController.text = "0";
              totalSAPBillsController.text = "0";
              totalBillsTransferredController.text = "0";
              pendingToTransferController.text = "0";
              // totalToController.text = "0";
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  transferApiCall() {
    try {
      if (Utils.checkFromAndToDateIsCorrectOrder(
          fromDate: fromDateController.text, toDate: toDateController.text)) {
        LoadingDialog.showErrorDialog("To Date cannot be less than From Date");
      } else {
        LoadingDialog.call();
        Map<String, dynamic> postData = {
          "locationCode": selectLocation?.key ?? "",
          "fromDate": Utils.toDateFormat6(fromDateController.text),
          "toDate": Utils.toDateFormat6(toDateController.text),
          "companyCode": selectCompany?.key ?? ""
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.TRANSFER_DATA_TO_SAP_BTN_TRANSFER,
            json: postData,
            fun: (map) {
              if(map is Map){
                LoadingDialog.callDataSaved(msg: "Bill transferred successfully",callback: (){
                  clearAll();
                });
              }
            },
            failed: (map) {
              closeDialogIfOpen();
            });
      }
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  clearAll() {
    Get.delete<BillTransferController>();
    Get.find<HomeController>().clearPage1();
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    fetchAllLoaderData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
