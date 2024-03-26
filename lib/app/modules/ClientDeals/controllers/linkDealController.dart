part of 'client_deals_controller.dart';

extension LinkDealController on ClientDealsController {
  linkDealDialogFirstGridDoubleClick(PlutoGridOnRowDoubleTapEvent event) {
    String? locationCode = event.cell.row.cells['locationcode']?.value ?? "";
    String? channelCode = event.cell.row.cells['channelcode']?.value ?? "";
    String? dealNumber = event.cell.row.cells['dealnumber']?.value ?? "";

    if ((event.cell.row.cells['selected']?.value ?? "").toString().trim() == "true") {
      callLinkDealDoubleClickApi(locationCode, channelCode, dealNumber).then((value) {
        if (value == true &&
            linkDealDoubleClickModel != null &&
            linkDealDoubleClickModel?.model != null &&
            (linkDealDoubleClickModel?.model?.length ?? 0) > 0) {
          if (linkDealStateManager != null) {
            int i = 0;
            linkDealDoubleClickModel?.model?.forEach((element) {
              int index = ((linkDealStateManager?.rows.length ?? 0));
              linkDealStateManager
                  ?.insertRows(index, [PlutoRow(cells: element.toJson1(index + 1))]);
              i = i + 1;
            });
            linkDealStateManager?.notifyListeners();
          } else {
            linkDealRetrieveModel = LinkDealRetrieveModel(model: ld.Model(linkedDeal: []));
            linkDealDoubleClickModel?.model?.forEach((element) {
              linkDealRetrieveModel?.model?.linkedDeal?.add(LinkedDeal.fromJson(element.toJson()));
            });
            update(['all']);
          }
        } else {
          LoadingDialog.showErrorDialog("Something went wrong");
        }
      });
    } else {}
  }

  Future<bool> callLinkDealDoubleClickApi(String? locCode, String? chCode, String? dealNo) {
    Completer<bool> completer = Completer<bool>();
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "locationcode": locCode,
        "channelcode": chCode,
        "dealnumber": dealNo
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.Client_Deal_LINK_DEAL_DOUBLE_CLICK,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['model'] != null) {
              linkDealDoubleClickModel =
                  LinkDealDoubleClickModel.fromJson(map as Map<String, dynamic>);
              completer.complete(true);
            } else {
              linkDealDoubleClickModel = null;
              completer.complete(true);
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            linkDealDoubleClickModel = null;
            completer.complete(false);
          });
    } catch (e) {
      closeDialogIfOpen();
      linkDealDoubleClickModel = null;

      completer.complete(false);
    }

    return completer.future;
  }

  Future<bool> getLinkDealRetriveApiCall({String? groupNumber}) {
    Completer<bool> completer = Completer<bool>();
    if (groupNumber != null && groupNumber != "" && groupNumber != "0") {
      try {
        LoadingDialog.call();
        // Map<String,dynamic> postData = {};
        Get.find<ConnectorControl>().GETMETHODCALL(
            api: ApiFactory.Client_Deal_GET_LINK_DEAL_RETRIVE + groupNumber,
            // "https://jsonkeeper.com/b/D537"
            fun: (map) {
              closeDialogIfOpen();
              if (map is Map && map['model'] != null) {
                linkDealRetrieveModel = LinkDealRetrieveModel.fromJson(map as Map<String, dynamic>);
                dealCode = (linkDealRetrieveModel?.model?.dealcode ?? "0").toString();
                completer.complete(true);
              } else {
                linkDealRetrieveModel = null;
                dealCode = "0";
                completer.complete(false);
              }
            },
            failed: (map) {
              linkDealRetrieveModel = null;
              dealCode = "0";
              closeDialogIfOpen();
              completer.complete(false);
            });
      } catch (e) {
        linkDealRetrieveModel = null;
        dealCode = "0";
        closeDialogIfOpen();
        completer.complete(false);
      }
    } else {
      linkDealRetrieveModel = null;
      dealCode = "0";
      completer.complete(false);
    }

    return completer.future;
  }

  dialogFormHandler(String text) {
    if (text == "Clear") {
      clearAll();
    }
    if (text == "Search") {
     /* Get.to(const SearchPage(
          key: Key("Link Deals"),
          screenName: "Link Deals",
          appBarName: "Link Deals",
          strViewName: "BMS_view_LinkedDeals",
          isAppBarReq: true));*/
    }

    if (text == "Docs") {
      dialogDocs();
    }

    if(text == "Save"){
      saveFunCall();
    }
  }

  saveFunCall() async {
    for (int i = 0; i < (linkDealStateManager?.rows.length ?? 0); i++) {
      if ((linkDealStateManager?.rows[i].cells['groupValuationRate']?.value ?? "0")
              .toString()
              .trim() ==
          "0") {
        bool sta = await LoadingDialog.modifyWithAsync(
            "Group Valuation Rate is 0\nDo you want to proceed with the save?");
        if (sta) {
          continue;
        } else {
          return;
        }
      }
    }

    double valuationAmount = 0, billingAmount = 0;

    for (int j = 0; j < (linkDealStateManager?.rows.length ?? 0); j++) {
      if (int.parse((linkDealStateManager?.rows[j].cells['']?.value != null &&
                  linkDealStateManager?.rows[j].cells['recordnumber']?.value != "")
              ? (linkDealStateManager?.rows[j].cells['recordnumber']?.value ?? "0").toString()
              : "0") >
          1000) {
        valuationAmount = valuationAmount +
            ((double.parse((linkDealStateManager?.rows[j].cells['seconds']?.value != null &&
                        linkDealStateManager?.rows[j].cells['seconds']?.value != "")
                    ? (linkDealStateManager?.rows[j].cells['seconds']?.value).toString()
                    : "0")) *
                (double.parse(
                    (linkDealStateManager?.rows[j].cells['groupValuationRate']?.value != null &&
                            linkDealStateManager?.rows[j].cells['groupValuationRate']?.value != "")
                        ? (linkDealStateManager?.rows[j].cells['groupValuationRate']?.value).toString()
                        : "0")));

        billingAmount = billingAmount +
            ((double.parse((linkDealStateManager?.rows[j].cells['seconds']?.value != null &&
                        linkDealStateManager?.rows[j].cells['seconds']?.value != "")
                    ? (linkDealStateManager?.rows[j].cells['seconds']?.value).toString()
                    : "0")) *
                (double.parse((linkDealStateManager?.rows[j].cells['rate']?.value != null &&
                        linkDealStateManager?.rows[j].cells['rate']?.value != "")
                    ? (linkDealStateManager?.rows[j].cells['rate']?.value).toString()
                    : "0")));
      } else {
        valuationAmount = valuationAmount +
            (((double.parse((linkDealStateManager?.rows[j].cells['seconds']?.value != null &&
                            linkDealStateManager?.rows[j].cells['seconds']?.value != "")
                        ? (linkDealStateManager?.rows[j].cells['seconds']?.value).toString()
                        : "0")) *
                    (double.parse((linkDealStateManager?.rows[j].cells['groupValuationRate']?.value !=
                                null &&
                            linkDealStateManager?.rows[j].cells['groupValuationRate']?.value != "")
                        ? (linkDealStateManager?.rows[j].cells['groupValuationRate']?.value).toString()
                        : "0"))) /
                10);

        billingAmount = billingAmount +
            ((double.parse((linkDealStateManager?.rows[j].cells['seconds']?.value != null &&
                        linkDealStateManager?.rows[j].cells['seconds']?.value != "")
                    ? (linkDealStateManager?.rows[j].cells['seconds']?.value).toString()
                    : "0")) *
                (double.parse((linkDealStateManager?.rows[j].cells['rate']?.value != null &&
                        linkDealStateManager?.rows[j].cells['rate']?.value != "")
                    ? (linkDealStateManager?.rows[j].cells['rate']?.value).toString()
                    : "0")));
      }
    }

    print(">>>>>>>>>>>>>>>>>val$valuationAmount     $billingAmount");
    print(">>>>>>>>>>>>>>>>>val${(billingAmount + 100) < valuationAmount}");

    if ((billingAmount + 100) < valuationAmount) {
      LoadingDialog.showErrorDialog1(
          "The difference between the billing and valuation amount is ${(valuationAmount - billingAmount).toStringAsFixed(2)}\nUnable to proceed with save!",
          callback: () {
        return;
      });
    }

    callSaveApiFun();
  }

  callSaveApiFun() {
    try {
      print(">>>>>>>fun call");
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "dealnumber":(linkDealRetrieveModel?.model?.dealcode?? "").toString(),
        "groupNumber":( linkDealRetrieveModel?.model?.groupNumber?? "").toString(),
        "clientCode": linkDealRetrieveModel?.model?.clientCode?? "",
        "agencyCode":linkDealRetrieveModel?.model?.agencyCode?? "",
        "groupdate": linkDealRetrieveModel?.model?.groupdate?? "",
        "dealRequests": getDataFromGrid2(linkDealStateManager)?? []
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.Client_Deal_LINK_DEAL_SAVE,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['model'] != null){
              LoadingDialog.callDataSaved (msg:(map['model']??"").toString());
            }else{
              LoadingDialog.showErrorDialog((map??"").toString());
            }

          },
          failed: (map) {
            closeDialogIfOpen();
            LoadingDialog.showErrorDialog((map??"").toString());
          });
    } catch (e) {
      print(">>>>>>>exception$e");
      closeDialogIfOpen();
    }
  }
}
