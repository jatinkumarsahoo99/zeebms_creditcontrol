import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/modules/CommonSearch/views/common_search_view.dart';
import 'package:bms_creditcontrol/app/modules/InvoiceRevision/bindings/invoice_revision_retrieve_model.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../providers/ApiFactory.dart';

class InvoiceRevisionController extends GetxController {
  TextEditingController fromDate = TextEditingController(),
      locationTEC = TextEditingController(),
      channelTEC = TextEditingController(),
      invoice = TextEditingController(),
      billDate = TextEditingController(),
      client = TextEditingController(),
      agencyTEC = TextEditingController(),
      payRoute = TextEditingController(),
      bookingNo = TextEditingController(),
      bookingAmt = TextEditingController();

  var location = RxList<DropDownValue>();
  var channel = RxList<DropDownValue>();
  var agency = RxList<DropDownValue>();
  var payroute = RxList<DropDownValue>();
  Rxn<DropDownValue> selectLocation = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectChannel = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectNewClient = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectAgency = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectPayroute = Rxn<DropDownValue>();
  InvoiceRevisionModel? invoiceRevisionModel;
  var retrieveList = <Retrieve>[];
  PlutoGridStateManager? stateManager;
  var isEnable = true;

  FocusNode locationFN = FocusNode(),
      channelFN = FocusNode(),
      newClientFN = FocusNode(),
      agencyFN = FocusNode(),
      payrouteFN = FocusNode();

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
    onLoad();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.INVOICE_REVISION_GET_LOCATION,
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey("location") &&
              map['location'] != null) {
            location.clear();
            map['location'].forEach((e) {
              location.add(DropDownValue(
                  key: e['locationCode'], value: e['locationName']));
            });
            update(['init']);
          }
        });
  }

  getChannel(locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.INVOICE_REVISION_GET_CHANNEL(locationCode),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('channel')) {
            channel.clear();
            map['channel'].forEach((e) {
              channel.add(DropDownValue(
                key: e['channelcode'],
                value: e['channelname'],
              ));
            });
          }
        });
  }

  clientLeave() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.INVOICE_REVISION_CLIENT_LEAVE(
          selectLocation.value?.key ?? "",
          selectChannel.value?.key ?? "",
          selectNewClient.value?.key ?? "",
        ),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('newClient')) {
            if (map['newClient']['lstAGency'] != null) {
              agency.clear();
              map['newClient']['lstAGency'].forEach((e) {
                agency.add(DropDownValue(
                  key: e['agencycode'].toString(),
                  value: e['agencyname'],
                ));
              });
            }
            if (map['newClient']['lstPayout'] != null) {
              payroute.clear();
              map['newClient']['lstPayout'].forEach((e) {
                payroute.add(DropDownValue(
                  key: e['payroutecode'],
                  value: e['payroutename'],
                ));
              });
            }
          }
        });
  }

  getRetrieve() {
    if (selectLocation.value == null || selectChannel.value == null) {
      LoadingDialog.showErrorDialog('Select Loaction & Channel.');
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.INVOICE_REVISION_RETRIEVE(
            selectLocation.value?.key ?? "",
            selectChannel.value?.key ?? "",
            fromDate.text,
          ),
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('retrieve')) {
              retrieveList.clear();
              invoiceRevisionModel =
                  InvoiceRevisionModel.fromJson(map as Map<String, dynamic>);
              retrieveList = invoiceRevisionModel?.retrieve ?? [];
              isEnable = false;
              update(['init']);
            }
          });
    }
  }

  save() {
    if (selectLocation.value == null ||
        selectChannel.value == null ||
        bookingNo.text.isEmpty ||
        invoice.text.isEmpty ||
        client.text.isEmpty ||
        agencyTEC.text.isEmpty ||
        selectNewClient.value == null ||
        selectAgency.value == null ||
        selectPayroute.value == null) {
      LoadingDialog.showErrorDialog(
          'Row should be in edited and necessary selection should be done to save the record.');
    } else if (retrieveList.isEmpty) {
      LoadingDialog.showErrorDialog('No bills present for revision.');
    } else {
      var payload = {
        "locationCode": selectLocation.value?.key ?? '',
        "channelCode": selectChannel.value?.key ?? '',
        "bookingNumber": bookingNo.text,
        "billNumber": invoice.text,
        "billDate": billDate.text,
        "clientCode": selectNewClient.value?.key ?? '',
        "agencyCode": selectAgency.value?.key ?? '',
        "payrouteCode": selectPayroute.value?.key ?? '',
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.INVOICE_REVISION_SAVE,
          json: payload,
          fun: (Map map) {
            Get.back();
            if (map != null && map.containsKey('retrieve')) {
              retrieveList.clear();
              invoiceRevisionModel =
                  InvoiceRevisionModel.fromJson(map as Map<String, dynamic>);
              retrieveList = invoiceRevisionModel?.retrieve ?? [];
              update(['init']);
            }
          });
    }
  }

  fillGridData(event) {
    locationTEC.text = event.row.cells['locationName']?.value ?? "";
    channelTEC.text = event.row.cells['channelName']?.value ?? "";
    invoice.text = event.row.cells['sapInvoiceNo']?.value ?? "";
    billDate.text =
        dateConvertToddMMyyyy(event.row.cells['billDate']?.value ?? "");
    client.text = event.row.cells['clientName']?.value ?? "";
    agencyTEC.text = event.row.cells['agencyName']?.value ?? "";
    payRoute.text = event.row.cells['payrouteName']?.value ?? "";
    bookingNo.text = event.row.cells['toNumber'].value ?? "";
    bookingAmt.text = event.row.cells['bookingAmount']?.value.toString() ?? "";
    getBrand();
    update(['textFieldUpdate']);
  }

  getBrand() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.INVOICE_REVISION_BILL_DETAIL(
          selectLocation.value?.key ?? "",
          selectChannel.value?.key ?? "",
        ),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('retrieve')) {
            retrieveList.clear();
            invoiceRevisionModel =
                InvoiceRevisionModel.fromJson(map as Map<String, dynamic>);
            retrieveList = invoiceRevisionModel?.retrieve ?? [];
            update(['init']);
          }
        });
  }

  String dateConvertToddMMyyyy(String date) {
    return (DateFormat('dd-MM-yyyy')
        .format(DateFormat('dd-MMM-yyyy').parse(date)));
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        save();
        break;
      case "Clear":
        Get.delete<InvoiceRevisionController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("Invoice Revision"),
            screenName: "Invoice Revision",
            appBarName: "Invoice Revision",
            strViewName: "vTesting",
            isAppBarReq: true,
          ),
        );
        break;
      case "Exit":
        Get.find<HomeController>().postUserGridSetting1(
          listStateManager: [
            stateManager,
          ],
        );
        break;
    }
  }
}
