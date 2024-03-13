part of 'client_deals_controller.dart';


extension ImportExcelController2 on ClientDealsController {



  btnImportClickWithCondition({List<Map<String, dynamic>>? excelDataNew}) async {
    checkImport = false;
    importGridListNew?.clear();
    if (dealNoController.text.trim() == "") {
      LoadingDialog.showErrorDialog("Deal Number Can't be blank");
      return;
    }
    if (excelDataNew != null && excelDataNew.isNotEmpty) {
      for (int i = 0; i < (excelDataNew.length); i++) {
        if (excelDataNew[i]['SponsorTypeName'].toString().trim() == "") {
          bool sta = await ignoreBlankRow();
          if (sta == false) {
            return;
          }
          // continue;
        }
        if (excelDataNew[i]['Rate'] == 0 &&
            excelDataNew[i]['Seconds'] == 0 &&
            excelDataNew[i]['Amount'] == 0 &&
            excelDataNew[i]['ValuationRate'] == 0) {
          return;
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
        }

        if ((newDetails.programName).toString().trim() != "") {
          if ((newDetails.programCode).toString().trim() == "") {
            checkImport = true;
          }
        }

        if (newDetails.primaryEventCode.toString().trim() == "1") {
          newDetails.accountname = excelDataNew[i]['Accountname'];
          newDetails.accountCode = allCode['accountCode'];
          if ((newDetails.accountCode).toString().trim() == "") {
            checkImport = true;
          }
          newDetails.eventname = excelDataNew[i]['Eventname'];
          newDetails.eventcode = allCode['eventcode'];
          if ((newDetails.eventcode).toString().trim() == "") {
            checkImport = true;
          }
        } else {
          newDetails.accountname = "";
          newDetails.accountCode = "";
          newDetails.eventcode = "";
          newDetails.eventname = "";
        }
        importGridListNew?.add(newDetails);
      }
    }
  }

  Future<bool> ignoreBlankRow() async {
    Completer<bool> completer = Completer<bool>();
    if (checkImport) {
      // Goto DataNotAdded
      completer.complete(false);
      return completer.future;
    }
    // importGridList
    for (int i = 0; i < (importGridListNew?.length ?? 0); i++) {
      for (int k = 0; k < (importGridList?.length ?? 0); k++) {
        if ((importGridList?.length ?? 0) > 0) {
          if ((importGridListNew?[i].primaryEventCode == importGridList?[k].primaryEventCode) &&
              (importGridListNew?[i].sponsorTypeCode == importGridList?[k].sponsorTypeCode) &&
              (importGridListNew?[i].programCode == importGridList?[k].programCode) &&
              (importGridListNew?[i].starttime == importGridList?[k].starttime) &&
              (importGridListNew?[i].endTime == importGridList?[k].endTime) &&
              (importGridListNew?[i].rate == importGridList?[k].rate) &&
              (importGridListNew?[i].valuationRate == importGridList?[k].valuationRate) &&
              (importGridListNew?[i].sun == importGridList?[k].sun) &&
              (importGridListNew?[i].mon == importGridList?[k].mon) &&
              (importGridListNew?[i].tue == importGridList?[k].tue) &&
              (importGridListNew?[i].wed == importGridList?[k].wed) &&
              (importGridListNew?[i].thu == importGridList?[k].thu) &&
              (importGridListNew?[i].fri == importGridList?[k].fri) &&
              (importGridListNew?[i].sat == importGridList?[k].sat) &&
              (importGridListNew?[i].accountCode == importGridList?[k].accountCode) &&
              (importGridListNew?[i].eventcode == importGridList?[k].eventcode)) {
            bool sta = await LoadingDialog.modifyWithAsync(
                "Similar entry already exists!\nDo you want to modify it?",
                cancelTitle: "Yes",
                deleteTitle: "No");
            if (sta) {
              bool reSta = await editRows(selectedOldIndex: 0, selectNewIndex: 0);
            } else {
              continue;
            }
          }
        }
      }
    }
    completer.complete(true);
    return completer.future;
  }

  addEdit(int index,{bool isNew = false}) {
    if(isNew){
      importGridList.add(NewDetails());
      index =(importGridList.isEmpty)?0: ((importGridList.length??1) -1);
    }
    importGridList[index].recordnumber = txtDRecordNumber.value;
    importGridList[index].sponsorTypeCode = selectSpotType?.value?.key ?? "";
    importGridList[index].sponsorTypeName = selectSpotType?.value?.value ?? "";

    // print(">>>>>>>>>>>>>sponsorTypeCode${selectSpotType?.value?.key}");



    importGridList[index].programCode = selectProgram?.value?.key ?? "";
    importGridList[index].programName = selectProgram?.value?.value ?? "";
    importGridList[index].starttime = startTime.text ?? "";
    importGridList[index].endTime = endTime.text ?? "";
    importGridList[index].seconds = secondsController2.text ?? "";
    importGridList[index].rate = ratePerTenSecondsController.text ?? "";
    importGridList[index].amount = amountController2.text ?? "";
    importGridList[index].bandCode = selectBand?.value?.key ?? "";
    importGridList[index].timeBand = selectBand?.value?.value ?? "";
    importGridList[index].valuationRate = valueRateController.text ?? "";
    importGridList[index].netCode = selectAddInfo?.value?.key ?? "";
    importGridList[index].netWorkName = selectAddInfo?.value?.value ?? "";
    importGridList[index].sun = getOneZero(sta: sun.value);
    importGridList[index].mon = getOneZero(sta: mon.value);
    importGridList[index].tue = getOneZero(sta: tue.value);
    importGridList[index].wed = getOneZero(sta: wed.value);
    importGridList[index].thu = getOneZero(sta: thu.value);
    importGridList[index].fri = getOneZero(sta: fri.value);
    importGridList[index].sat = getOneZero(sta: sat.value);
    importGridList[index].primaryEventCode = getOneZero(sta: type.value);
    if (type.value == true) {
      importGridList[index].accountCode = selectAccount?.value?.key ?? "";
      importGridList[index].accountname = selectAccount?.value?.value ?? "";
      importGridList[index].eventcode = selectSubType?.value?.key ?? "";
      importGridList[index].eventname = selectSubType?.value?.value ?? "";
    }
    btnClearClick();
    btnDoubleClick == false;
    update(['grid']);


  }


  Future<bool> editRows({required int selectedOldIndex, required int selectNewIndex}) {
    Completer<bool> completer = Completer<bool>();
    try {
      importGridList[selectedOldIndex].primaryEventCode =
          importGridListNew?[selectNewIndex].primaryEventCode;
      importGridList[selectedOldIndex].recordnumber = "${selectedOldIndex + 1}";
      importGridList[selectedOldIndex].sponsorTypeCode =
          importGridListNew?[selectNewIndex].sponsorTypeCode;
      importGridList[selectedOldIndex].sponsorTypeName =
          importGridListNew?[selectNewIndex].sponsorTypeName;
      importGridList[selectedOldIndex].programCode =
          importGridListNew?[selectNewIndex].programCode;
      importGridList[selectedOldIndex].programName =
          importGridListNew?[selectNewIndex].programName;
      importGridList[selectedOldIndex].programCategoryCode =
          importGridListNew?[selectNewIndex].programCategoryCode;
      importGridList[selectedOldIndex].starttime = importGridListNew?[selectNewIndex].starttime;
      importGridList[selectedOldIndex].endTime = importGridListNew?[selectNewIndex].endTime;
      importGridList[selectedOldIndex].seconds = importGridListNew?[selectNewIndex].seconds;
      importGridList[selectedOldIndex].rate = importGridListNew?[selectNewIndex].rate;
      importGridList[selectedOldIndex].amount = importGridListNew?[selectNewIndex].amount;
      importGridList[selectedOldIndex].valuationRate =
          importGridListNew?[selectNewIndex].valuationRate;
      importGridList[selectedOldIndex].bookedSeconds =
          importGridListNew?[selectNewIndex].bookedSeconds;
      importGridList[selectedOldIndex].balanceSeconds =
          importGridListNew?[selectNewIndex].balanceSeconds;
      importGridList[selectedOldIndex].balanceAmount =
          importGridListNew?[selectNewIndex].balanceAmount;
      importGridList[selectedOldIndex].bandCode = importGridListNew?[selectNewIndex].bandCode;
      importGridList[selectedOldIndex].timeBand = importGridListNew?[selectNewIndex].timeBand;
      importGridList[selectedOldIndex].netCode = importGridListNew?[selectNewIndex].netCode;
      importGridList[selectedOldIndex].netWorkName =
          importGridListNew?[selectNewIndex].netWorkName;
      importGridList[selectedOldIndex].sun = importGridListNew?[selectNewIndex].sun;
      importGridList[selectedOldIndex].mon = importGridListNew?[selectNewIndex].mon;
      importGridList[selectedOldIndex].tue = importGridListNew?[selectNewIndex].tue;
      importGridList[selectedOldIndex].wed = importGridListNew?[selectNewIndex].wed;
      importGridList[selectedOldIndex].thu = importGridListNew?[selectNewIndex].thu;
      importGridList[selectedOldIndex].fri = importGridListNew?[selectNewIndex].fri;
      importGridList[selectedOldIndex].sat = importGridListNew?[selectNewIndex].sat;
      importGridList[selectedOldIndex].revflag = importGridListNew?[selectNewIndex].revflag;
      importGridList[selectedOldIndex].accountCode =
          importGridListNew?[selectNewIndex].accountCode;
      importGridList[selectedOldIndex].accountname =
          importGridListNew?[selectNewIndex].accountname;
      importGridList[selectedOldIndex].eventcode = importGridListNew?[selectNewIndex].eventcode;
      importGridList[selectedOldIndex].eventname = importGridListNew?[selectNewIndex].eventname;
      importGridList[selectedOldIndex].spots = importGridListNew?[selectNewIndex].spots;
      importGridList[selectedOldIndex].paymentmodecaption =
          importGridListNew?[selectNewIndex].paymentmodecaption;
      importGridList[selectedOldIndex].revenueTypeName =
          importGridListNew?[selectNewIndex].revenueTypeName;
      importGridList[selectedOldIndex].revenueTypeCode =
          importGridListNew?[selectNewIndex].revenueTypeCode;
      importGridList[selectedOldIndex].subRevenueTypeCode =
          importGridListNew?[selectNewIndex].subRevenueTypeCode;
      importGridList[selectedOldIndex].subRevenueTypeName =
          importGridListNew?[selectNewIndex].subRevenueTypeName;
      importGridList[selectedOldIndex].countBased = importGridListNew?[selectNewIndex].countBased;
      importGridList[selectedOldIndex].baseDuration =
          importGridListNew?[selectNewIndex].baseDuration;

      secondsController.text = colTotal("seconds");
      amountController.text = colTotal("amount");

      if (double.parse(amountController.text ?? "0") > 0) {
        maxSpeedController.text = amountController.text;
      }

      completer.complete(true);
    } catch (e) {
      completer.complete(false);
    }
    return completer.future;
  }

}