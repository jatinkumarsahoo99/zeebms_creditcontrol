part of 'client_deals_controller.dart';

extension ImportExcelController on ClientDealsController {
  // exe backup file ImportExcelController 2


  pickFile() async {
    LoadingDialog.call();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['xlsx', 'xls'],
      type: FileType.custom,
    );
    closeDialogIfOpen();
    if (result != null && result.files.single != null) {
      // print(">>>>>>filename"+(result.files[0].name.toString()));
      // pathController.text = result.files[0].name.toString();

      loadBtn(result);
    } else {
      LoadingDialog.showErrorDialog("Please try again");
      // User canceled the pic5ker
      print(">>>>dataCancel");
    }
  }

  loadBtn(FilePickerResult result) {
    LoadingDialog.call();
    var jsonData = <String, dynamic>{};
    try {
      Uint8List? fileBytes = result.files.first.bytes;
      var excel = Excel.decodeBytes(result.files.first.bytes as List<int>);
      List<dynamic> headers = [];
      int sheet = 0;
      var excelDataList = <Map<String, dynamic>>[];
      for (var table in excel.tables.keys) {
        var tableData = <Map<String, dynamic>>[];
        sheet = sheet + 1;
        // Extract headers from the first row
        headers = excel.tables[table]!.row(0).map((cell) => cell?.value.toString()).toList();

        print(">>>>>" + headers.toString());

        for (var rowIdx = 1; rowIdx <= excel.tables[table]!.maxRows; rowIdx++) {
          var rowData = <String, dynamic>{};
          var row = excel.tables[table]!.row(rowIdx);
          for (var colIdx = 0; colIdx < row.length; colIdx++) {
            var header = headers[colIdx];
            var cellValue = row[colIdx]?.value.toString();
            rowData[header ?? ""] = cellValue;
          }
          if (rowData.isNotEmpty) {
            tableData.add(rowData);
          }
        }
        jsonData['S${sheet}'] = tableData;
        excelDataList = tableData;
        print(">>>>jsonData $jsonData");
        closeDialogIfOpen();
      }
      List<String> sourceList = [
        "PrimaryEventCode",
        "Recordnumber",
        "SponsorTypeCode",
        "SponsorTypeName",
        "ProgramCode",
        "ProgramName",
        "ProgramCategoryCode",
        "Starttime",
        "EndTime",
        "Seconds",
        "Rate",
        "Amount",
        "ValuationRate",
        "BookedSeconds",
        "BalanceSeconds",
        "BalanceAmount",
        "BandCode",
        "TimeBand",
        "NetCode",
        "NetWorkName",
        "Sun",
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat",
        "Revflag",
        "AccountCode",
        "Accountname",
        "Eventcode",
        "Eventname",
        "Spots",
        "Paymentmodecaption",
        "RevenueTypeCode",
        "RevenueTypeName",
        "SubRevenueTypeName",
        "SubRevenueTypeCode",
        "CountBased",
        "BaseDuration"
      ];
      // List<String> list2 = [ "ku","jks"];
      List<dynamic> sta = Utils.listCompare(sourceList: sourceList, compareLst: headers);
      print(">>>>>>>>>sta$sta");
      if (!sta[0]) {
        LoadingDialog.showErrorDialog(sta[1] ?? "");
      } else {
        callValidationFun(excelData: excelDataList);
      }
    } catch (e) {
      print(">>>>" + e.toString());
      // gridData = RateCardFromDealWorkFlowModel(export: []);
      closeDialogIfOpen();
      update(['grid']);
      LoadingDialog.showErrorDialog(e.toString());
    }
  }

  Future<Map<String, dynamic>> getAllCode(
      {String? sponsorTypeName,
      String? programName,
      String? timeBandName,
      String? networkName,
      String? accountName,
      String? eventName}) {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    LoadingDialog.call();
    try {
      Map<String, dynamic> postData = {
        "sponsorTypeName": sponsorTypeName,
        "programName": programName,
        "timeBand": timeBandName,
        "netWorkName": networkName,
        "accountname": accountName,
        "eventname": eventName
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.Client_Deal_GET_EACH_VALUE_IMPORT,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['model'] != null) {
              completer.complete(map as FutureOr<Map<String, dynamic>>?);
            } else {
              completer.complete({
                "sponsorTypeCode": "",
                "programCode": "",
                "bandCode": "",
                "netCode": "",
                "accountCode": "",
                "eventcode": ""
              });
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            completer.complete({
              "sponsorTypeCode": "",
              "programCode": "",
              "bandCode": "",
              "netCode": "",
              "accountCode": "",
              "eventcode": ""
            });
          });
    } catch (e) {
      closeDialogIfOpen();
      completer.complete({
        "sponsorTypeCode": "",
        "programCode": "",
        "bandCode": "",
        "netCode": "",
        "accountCode": "",
        "eventcode": ""
      });
    }
    return completer.future;
  }


  Future<bool> btnImportClickWithConditionBmsWeb({List<Map<String, dynamic>>? excelDataNew}) async {
    Completer<bool> completer = Completer<bool>();
    try {
      checkImport = false;
      importGridListNew?.clear();
      if (dealNoController.text.trim() == "") {
        LoadingDialog.showErrorDialog("Deal Number Can't be blank");
        completer.complete(true);
        return completer.future;
      }
      if (excelDataNew != null && excelDataNew.isNotEmpty) {
        for (int i = 0; i < (excelDataNew.length); i++) {
          if (excelDataNew[i]['Rate'] == 0 &&
              excelDataNew[i]['Seconds'] == 0 &&
              excelDataNew[i]['Amount'] == 0 &&
              excelDataNew[i]['ValuationRate'] == 0) {
            completer.complete(true);
            return completer.future;
          }

          Map<String, dynamic> allCode = await getAllCode(
              programName: excelDataNew[i]['ProgramName'],
              accountName: excelDataNew[i]['Accountname'],
              eventName: excelDataNew[i]['Eventname'],
              networkName: excelDataNew[i]['NetWorkName'],
              sponsorTypeName: excelDataNew[i]['SponsorTypeName'],
              timeBandName: excelDataNew[i]['TimeBand']);

          NewDetails newDetails = NewDetails(
            primaryEventCode: (excelDataNew[i]['Amount'] != "") ? "1" : "0",
            recordnumber: "",
            sponsorTypeName: excelDataNew[i]['SponsorTypeName'],
            programName: excelDataNew[i]['ProgramName'],
            programCategoryCode: "",
            starttime: "we need to check",
            endTime: "we need to check",
            seconds: excelDataNew[i]['Seconds'],
            rate: excelDataNew[i]['Rate'],
            amount: excelDataNew[i]['Amount'],
            valuationRate: excelDataNew[i]['ValuationRate'],
            bookedSeconds: excelDataNew[i]['BookedSeconds'],
            programCode: allCode['programCode'],
            sponsorTypeCode: allCode['sponsorTypeCode'],
            balanceSeconds: excelDataNew[i]['BalanceSeconds'],
            balanceAmount: excelDataNew[i]['BalanceAmount'],
            timeBand: excelDataNew[i]['TimeBand'],
            bandCode: allCode['bandCode'],
            netWorkName: excelDataNew[i]['NetWorkName'],
            sun: excelDataNew[i]['Sun'],
            mon: excelDataNew[i]['Mon'],
            tue: excelDataNew[i]['Tue'],
            wed: excelDataNew[i]['Wed'],
            thu: excelDataNew[i]['Thu'],
            fri: excelDataNew[i]['Fri'],
            sat: excelDataNew[i]['Sat'],
            revflag: "",
            spots: excelDataNew[i]['Spots'],
            paymentmodecaption: excelDataNew[i]['Paymentmodecaption'],
            revenueTypeCode: "",
            revenueTypeName: excelDataNew[i]['RevenueTypeName'],
            subRevenueTypeName: excelDataNew[i]['SubRevenueTypeName'],
            subRevenueTypeCode: "",
            countBased: excelDataNew[i]['CountBased'],
            baseDuration: excelDataNew[i]['BaseDuration'],
          );

          if ((newDetails.sponsorTypeCode).toString().trim() == "") {
            checkImport = true;
            continue;
          }

          if ((newDetails.programName).toString().trim() != "") {
            if ((newDetails.programCode).toString().trim() == "") {
              checkImport = true;
              continue;
            }
          }

          if (newDetails.primaryEventCode.toString().trim() == "1") {
            newDetails.accountname = excelDataNew[i]['Accountname'];
            newDetails.accountCode = allCode['accountCode'];
            if ((newDetails.accountCode).toString().trim() == "") {
              checkImport = true;
              continue;
            }
            newDetails.eventname = excelDataNew[i]['Eventname'];
            newDetails.eventcode = allCode['eventcode'];
            if ((newDetails.eventcode).toString().trim() == "") {
              checkImport = true;
              continue;
            }
          } else {
            newDetails.accountname = "";
            newDetails.accountCode = "";
            newDetails.eventcode = "";
            newDetails.eventname = "";
          }

          importGridListNew?.add(newDetails);
        }
        completer.complete(true);
        return completer.future;
      } else {
        importGridListNew?.clear();
        completer.complete(true);
        return completer.future;
      }
    } catch (e) {
      importGridListNew?.clear();
      completer.complete(true);
      return completer.future;
    }
  }

  newImportedDataListCheckingSimilarity({List<Map<String, dynamic>>? excelDataN}) {
    // importGridList
    btnImportClickWithConditionBmsWeb(excelDataNew: excelDataN).then((value) async {
      try {
        if ((importGridListNew?.length ?? 0) > 0) {
          if (importGridList.isNotEmpty) {
            bool isLast = true;
            for (int i = 0; i < (importGridListNew?.length ?? 0); i++) {
              for (int k = 0; k < importGridList.length; k++) {
                if ((importGridListNew?[i].primaryEventCode ==
                        importGridList[k].primaryEventCode) &&
                    (importGridListNew?[i].sponsorTypeCode == importGridList[k].sponsorTypeCode) &&
                    (importGridListNew?[i].programCode == importGridList[k].programCode) &&
                    (importGridListNew?[i].starttime == importGridList[k].starttime) &&
                    (importGridListNew?[i].endTime == importGridList[k].endTime) &&
                    (importGridListNew?[i].rate == importGridList[k].rate) &&
                    (importGridListNew?[i].valuationRate == importGridList[k].valuationRate) &&
                    (importGridListNew?[i].sun == importGridList[k].sun) &&
                    (importGridListNew?[i].mon == importGridList[k].mon) &&
                    (importGridListNew?[i].tue == importGridList[k].tue) &&
                    (importGridListNew?[i].wed == importGridList[k].wed) &&
                    (importGridListNew?[i].thu == importGridList[k].thu) &&
                    (importGridListNew?[i].fri == importGridList[k].fri) &&
                    (importGridListNew?[i].sat == importGridList[k].sat) &&
                    (importGridListNew?[i].accountCode == importGridList[k].accountCode) &&
                    (importGridListNew?[i].eventcode == importGridList[k].eventcode)) {
                  isLast = false;
                  bool sta = await LoadingDialog.modifyWithAsync(
                      "Similar entry already exists!\nDo you want to modify it?",
                      cancelTitle: "Yes",
                      deleteTitle: "No");
                  if (sta) {
                    NewDetails data = importGridList[k];
                    importGridList[k] = importGridListNew?[i] ?? data;
                    importGridListNew?.removeAt(i);
                    break;
                  } else {
                    continue;
                  }
                }
                else if ((k == importGridList.length - 1) && isLast == true) {
                  importGridList.add(importGridListNew![i]);
                  importGridListNew?.removeAt(i);
                }
                else {
                  continue;
                }
              }
            }
          } else {
            importGridList = importGridListNew ?? [];
          }
        } else {
          LoadingDialog.showErrorDialog("Invalid Data found in excel file please check");
        }
      } catch (e) {
        LoadingDialog.showErrorDialog("Invalid Data found in excel file please check");
      }
    });
  }

}
