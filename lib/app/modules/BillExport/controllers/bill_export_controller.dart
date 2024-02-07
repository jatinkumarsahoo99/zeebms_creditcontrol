import 'dart:async';
import 'dart:convert';
import 'package:bms_creditcontrol/app/modules/BillExport/ResultModel.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/pluto_grid.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../../CompanyChannelLink/ChannelLinkMasterData.dart';
import '../BillExportInitModel.dart';

class BillExportController extends GetxController {
  var locationList = <DropDownValue>[].obs,
      ChannelList = <DropDownValue>[].obs,
      agencyList = <DropDownValue>[].obs;

  DropDownValue? selectedLocation, selectedChannel, selectedAgency;

  final tecFrom = TextEditingController().obs;
  final tecTo = TextEditingController().obs;

  List<GridData> gridData = [];
  BillExportInitModel? initModel;
  PlutoGridStateManager? stateManager;
  PlutoGridStateManager? stateManager1;
  ResultModel? result;

  var canDialogShow = false.obs;
  Widget? dialogWidget;
  Rxn<int> initialOffset = Rxn<int>(null);
  Completer<bool>? completerDialog;
  List<dynamic>? modelData;

  @override
  void onInit() {
    getLoad();
    super.onInit();
  }

  getLoad() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.BILL_EXPORT_INIT,
        fun: (Map map) {
          if (map["onload"] != null) {
            initModel = BillExportInitModel.fromJson(map["onload"]);
          }
          update(["init"]);
        });
  }

  getDetails() {
    LoadingDialog.call();
    var jsonData = {
      "locationname": selectedLocation?.value ?? "",
      "channelname": selectedChannel?.value ?? "",
      "agencyname": selectedAgency?.value ?? "",
      "fromDate": tecFrom.value.text.replaceAll("-", "/"),
      "toDate": tecTo.value.text.replaceAll("-", "/")
    };

    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.BILL_EXPORT_GET_DETAILS,
        fun: (Map map) {
          Get.back();
          gridData = [];
          if (map.containsKey("details")) {
            map["details"].forEach((e) {
              gridData.add(new GridData.fromJson(e));
            });
          }
          update(["grid"]);
        },
        json: jsonData);
  }

  saveDetails() {
    LoadingDialog.call();
    var jsonData = {
      "agencycode": selectedAgency?.key ?? "",
      "agencyname": selectedAgency?.value ?? "",
      "locationname": selectedLocation?.value ?? "",
      "channelname": selectedChannel?.value ?? "",
      "fromDate": Utils.dateFormatChange(
          tecFrom.value.text, "dd-MM-yyyy", "yyyy-MM-dd"),
      "toDate":
          Utils.dateFormatChange(tecTo.value.text, "dd-MM-yyyy", "yyyy-MM-dd"),
      "billLstNumbers": stateManager?.checkedRows.map((e) {
        return {"printBillNumber": e.cells["printBillNumber"]?.value ?? ""};
      }).toList()
    };

    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.BILL_EXPORT_FILES,
        fun: (map) {
          Get.back();
          if (map is Map && map.containsKey("files") && map["files"] != null) {
            result = ResultModel.fromJson(map as Map<String, dynamic>);
            result?.files?.forEach((element) async {
              if (element.fileBytes != null && element.fileBytes != "")
                await FileSaver.instance.saveFile(
                  name: element.fileName ?? "",
                  bytes: base64Decode(element.fileBytes!),
                );
            });
          }
        },
        json: jsonData);
  }

  getDataDetails() {
    LoadingDialog.call();
    var jsonData = {
      "agencycode": selectedAgency?.key ?? "",
      "agencyname": selectedAgency?.value ?? "",
      "locationname": selectedLocation?.value ?? "",
      "channelname": selectedChannel?.value ?? "",
      "fromDate": Utils.dateFormatChange(
          tecFrom.value.text, "dd-MM-yyyy", "yyyy-MM-dd"),
      "toDate":
          Utils.dateFormatChange(tecTo.value.text, "dd-MM-yyyy", "yyyy-MM-dd")
    };

    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.BILL_VIEWS_DATA,
        fun: (map) {
          Get.back();
          modelData = null;
          if (map is Map && map.containsKey("model") && map["model"] != null) {
            modelData = map["model"];
          }
          update(["grid1"]);
        },
        json: jsonData);
  }
}
