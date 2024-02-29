import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../providers/ApiFactory.dart';
import '../views/email_bill_details_view.dart';

class EmailBillDetailsController extends GetxController {
  double widthRatio = 0.24;
  double widthRatio1 = 0.53;
  double widthOfTab = 100;

  Rx<Mode> calendarView = Rx<Mode>(Mode.bills);
  Rx<String> selectRadio = Rx<String>("Summary");

  RxBool sendTest = RxBool(false);
  RxBool all1 = RxBool(false);
  RxBool all2 = RxBool(false);

  var companyList = <DropDownValue>[].obs;
  var gridData = [].obs;

  DropDownValue? selectedCompany;

  TextEditingController counter1_ = TextEditingController(text: "0");
  TextEditingController counter2_ = TextEditingController(text: "0");

  TextEditingController testTo_ = TextEditingController();
  TextEditingController tecDate = TextEditingController();

  TextEditingController path_ = TextEditingController();
  TextEditingController body_ = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    onLoad();
  }

  onLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.EMAIL_BILL_DETAILS_ONLOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          closeDialogIfOpen();
          if (map is Map &&
              map.containsKey("onload") &&
              map['onload'] != null &&
              map['onload'].isNotEmpty) {
            map['onload'].forEach((e) {
              companyList.add(DropDownValue(
                  key: e["sapCompanycode"], value: e["companyname"]));
              // cityList.add(
              //     DropDownValue(key: e["placecode"], value: e["placename"]));
            });
          }
        },
        failed: (map) {
          LoadingDialog.showErrorDialog(map);
        });
  }

  onGenerate() {
    var model = {
      "companyCode": selectedCompany!.key ?? "",
      "billdate": (DateFormat('yyyy-MM-dd')
          .format(DateFormat('dd-MM-yyyy').parse(tecDate.text)))
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.EMAIL_BILL_DETAILS_GENERATE,
      json: model,
      fun: (resp) {
        closeDialogIfOpen();
        if (resp is Map<String, dynamic> &&
            resp.toString().contains("generate") &&
            resp["generate"] != null &&
            resp["generate"].isNotEmpty) {
          gridData.value = resp["generate"];
        }
      },
      failed: (resp) {
        closeDialogIfOpen();
        LoadingDialog.showErrorDialog(resp);
      },
    );
  }

  onBills() {
    var model = {
      "companyCode": "<string>",
      "companyName": "<string>",
      "billdate": "<dateTime>",
      "details": [
        {
          "rowNo": "<integer>",
          "locationcode": "<string>",
          "channelcode": "<string>",
          "clientcode": "<string>",
          "clientName": "<string>",
          "agencycode": "<string>",
          "agencyName": "<string>",
          "mailTo": "<string>"
        },
        {
          "rowNo": "<integer>",
          "locationcode": "<string>",
          "channelcode": "<string>",
          "clientcode": "<string>",
          "clientName": "<string>",
          "agencycode": "<string>",
          "agencyName": "<string>",
          "mailTo": "<string>"
        }
      ],
      "testMailFrom": "<string>",
      "testMailTo": "<string>",
      "testMailBody": "<string>"
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.EMAIL_BILL_DETAILS_BILLS,
      json: model,
      fun: (resp) {
        closeDialogIfOpen();
        // if (resp != null &&
        //     resp is Map<String, dynamic> &&
        //     resp.toString().contains("successfully")) {
        //   LoadingDialog.callDataSaved(
        //     msg: resp["message"],
        //     callback: () {
        //       callClear();
        //     },
        //   );
        // }
      },
      failed: (resp) {
        closeDialogIfOpen();

        LoadingDialog.showErrorDialog(resp);
      },
    );
  }

  getBillFiles() {
    var model = {
      "companyCode": "<string>",
      "companyName": "<string>",
      "billdate": "<dateTime>",
      "details": [
        {
          "rowNo": "<integer>",
          "locationcode": "<string>",
          "channelcode": "<string>",
          "clientcode": "<string>",
          "clientName": "<string>",
          "agencycode": "<string>",
          "agencyName": "<string>",
          "mailTo": "<string>"
        },
        {
          "rowNo": "<integer>",
          "locationcode": "<string>",
          "channelcode": "<string>",
          "clientcode": "<string>",
          "clientName": "<string>",
          "agencycode": "<string>",
          "agencyName": "<string>",
          "mailTo": "<string>"
        }
      ],
      "testMailFrom": "<string>",
      "testMailTo": "<string>",
      "testMailBody": "<string>"
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.EMAIL_BILL_DETAILS_BILLS,
      json: model,
      fun: (resp) {
        closeDialogIfOpen();
        // if (resp != null &&
        //     resp is Map<String, dynamic> &&
        //     resp.toString().contains("successfully")) {
        //   LoadingDialog.callDataSaved(
        //     msg: resp["message"],
        //     callback: () {
        //       callClear();
        //     },
        //   );
        // }
      },
      failed: (resp) {
        closeDialogIfOpen();

        LoadingDialog.showErrorDialog(resp);
      },
    );
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  formHandler(btn) {}
}
