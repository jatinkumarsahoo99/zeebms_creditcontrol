import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/modules/AsrunImportSecondaryEvents/bindings/asrun_import_model.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;

class AsrunImportSecondaryEventsController extends GetxController {
  TextEditingController logDate = TextEditingController();

  var location = RxList<DropDownValue>();
  var channel = RxList<DropDownValue>();
  var isEnabel = true.obs;

  FocusNode locationFN = FocusNode(), channelFN = FocusNode();

  Rxn<DropDownValue> selectLocation = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectChannel = Rxn<DropDownValue>();

  AsrunImportModel? asrunImportModel;
  var asrunImportList = <AsRunDetails>[].obs;

  PlutoGridStateManager? asrunGrid;

  Rxn<List<Map<String, Map<String, double>>>>? userGridSetting1 = Rxn([]);
  fetchUserSetting1() async {
    userGridSetting1?.value =
        await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserSetting1();
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoad();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getOnLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ASRUN_SECONDARY_EVENT_GET_LOCATION,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('location')) {
            location.clear();
            map['location'].forEach((e) {
              location.add(DropDownValue(
                key: e['locationcode'],
                value: e['locationname'],
              ));
            });
          }
        });
  }

  getChannel(locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ASRUN_SECONDARY_EVENT_GET_CHANNEL(locationCode),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('channel')) {
            channel.clear();
            map['channel'].forEach((e) {
              channel.add(DropDownValue(
                key: e['channelcode'],
                value: e['channelName'],
              ));
            });
          }
        });
  }

  pickFile() async {
    if (selectLocation.value == null) {
      LoadingDialog.showErrorDialog("Please select loaction.", callback: () {
        Get.back();
      });
    } else if (selectChannel.value == null) {
      LoadingDialog.showErrorDialog("Please select channel.", callback: () {
        Get.back();
      });
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single != null) {
        importfile(result.files[0]);
      } else {
        // User canceled the pic5ker
      }
    }
  }

  importfile(PlatformFile? file) async {
    LoadingDialog.call();
    dio.FormData formData = dio.FormData.fromMap(
      {
        "location": selectLocation.value?.key ?? "",
        "channel": selectChannel.value?.key ?? "",
        "TelecastDate": dateConvertToyyyyMMdd(logDate.text),
        'formfile': dio.MultipartFile.fromBytes(
          file!.bytes!.toList(),
          filename: file.name,
        ),
      },
    );

    Get.find<ConnectorControl>().POSTMETHOD_FORMDATA(
        api: ApiFactory.ASRUN_SECONDARY_EVENT_IMPORT,
        json: formData,
        fun: (map) {
          Get.back();
          if (map != null && map.toString().contains("model")) {
            asrunImportModel =
                AsrunImportModel.fromJson(map as Map<String, dynamic>);
            asrunImportList.clear();
            asrunImportList.value = asrunImportModel?.model?.asRunDetails ?? [];
          }
        });
  }

  // getBillingStatus() {
  //   var payload = {
  //     "location": selectLocation.value?.key ?? "",
  //     "channel": selectChannel.value?.key ?? "",
  //     "TelecastDate": dateConvertToyyyyMMdd(logDate.text),
  //     "formfile": '',
  //   };
  //   LoadingDialog.call();
  //   Get.find<ConnectorControl>().POSTMETHOD(
  //       json: payload,
  //       api: ApiFactory.READY_TO_BILLS_GET_BILLING_STATUS,
  //       fun: (Map map) {
  //         Get.back();
  //         if (map != null && map.containsKey('billing')) {}
  //       });
  // }

  String dateConvertToyyyyMMdd(String date) {
    return (DateFormat('yyyy-MM-dd')
        .format(DateFormat('dd-MM-yyyy').parse(date)));
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        break;
      case "Clear":
        Get.delete<AsrunImportSecondaryEventsController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Verify":
        break;
      case "Billing Value":
        break;
      case "Export":
        break;
      case "Exit":
        Get.find<HomeController>().postUserGridSetting1(
          listStateManager: [
            asrunGrid,
          ],
        );
        break;
    }
  }
}
