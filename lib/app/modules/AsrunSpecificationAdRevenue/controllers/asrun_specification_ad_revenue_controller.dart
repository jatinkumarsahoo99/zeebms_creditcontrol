import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../ResponseModel.dart';

class AsrunSpecificationAdRevenueController extends GetxController {
  List<DropDownValue>? lstlocation;
  List<DropDownValue>? lstChannel;
  List<DropDownValue>? lstfiletype;

  DropDownValue? selectLocation;
  DropDownValue? selectChannel;
  DropDownValue? selectFileType;
  DropDownValue? selectTimeDiff;

  ResponseModel? response;

  TextEditingController embarNo1 = TextEditingController();
  TextEditingController embarNo2 = TextEditingController();
  TextEditingController telDt1 = TextEditingController();
  TextEditingController telDt2 = TextEditingController();
  TextEditingController telTime1 = TextEditingController();
  TextEditingController telTime2 = TextEditingController();
  TextEditingController expTapeCode1 = TextEditingController();
  TextEditingController expTapeCode2 = TextEditingController();
  TextEditingController segNo1 = TextEditingController();
  TextEditingController segNo2 = TextEditingController();
  TextEditingController expCap1 = TextEditingController();
  TextEditingController expCap2 = TextEditingController();
  TextEditingController tapDur1 = TextEditingController();
  TextEditingController tapDur2 = TextEditingController();
  TextEditingController reconKey1 = TextEditingController();
  TextEditingController reconKey2 = TextEditingController();
  TextEditingController endTime1 = TextEditingController();
  TextEditingController endTime2 = TextEditingController();

  TextEditingController dateFormat = TextEditingController();
  TextEditingController hhMM = TextEditingController();
  TextEditingController asRunType = TextEditingController();
  TextEditingController sapFlag = TextEditingController();
  TextEditingController newFormat = TextEditingController();
  TextEditingController maxDuration = TextEditingController();
  TextEditingController fileName = TextEditingController();

  bool isEnableRightSide = true;
  bool isEnableLeftSide = true;

  bool isFpc = false;
  bool isMarkSlot = false;
  bool isDontUpdate = false;
  bool revRunOrder = false;

  // bool isFpc = false;

  @override
  void onInit() {
    getInit();
    super.onInit();
  }

  getInit() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ASRUN_AD_INIT,
        fun: (map) {
          if (map is Map && map.containsKey("asrunSpecificationOnLoad")) {
            lstlocation = [];
            lstfiletype = [];
            map["asrunSpecificationOnLoad"]["lstlocation"].forEach((e) {
              lstlocation?.add(new DropDownValue(
                  key: e["locationCode"], value: e["locationName"]));
            });
            map["asrunSpecificationOnLoad"]["lstfiletype"].forEach((e) {
              lstfiletype?.add(new DropDownValue(
                  key: e["lookupCode"], value: e["lookupName"]));
            });
            update(["init"]);
          }
        });
  }

  getChannel() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ASRUN_AD_CHANNEL_LEAVE + (selectLocation?.key ?? ''),
        fun: (map) {
          if (map is Map &&
              map.containsKey("channel") &&
              map["channel"] != null) {
            lstChannel = [];
            map["channel"].forEach((e) {
              lstChannel?.add(new DropDownValue(
                  key: e["channelcode"], value: e["channelname"]));
            });
            update(["init"]);
          }
        });
  }

  visibleSelected() {
    switch (selectFileType?.value.toString().toLowerCase()) {
      case "csv":
        isEnableRightSide = false;
        isEnableLeftSide = true;
        update(["main1"]);
        break;
      case "fixed lenght":
        isEnableRightSide = true;
        isEnableLeftSide = true;
        update(["main1"]);
        break;
      case "pipe delimited":
        isEnableRightSide = false;
        isEnableLeftSide = true;
        update(["main1"]);
        break;
      case "tab separated":
        isEnableRightSide = false;
        isEnableLeftSide = true;
        update(["main1"]);
        break;
      case "xml":
        isEnableRightSide = false;
        isEnableLeftSide = false;
        update(["main1"]);
        break;
    }
  }

  getPopulate() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ASRUN_AD_POPULATE(
            (selectLocation?.key ?? ''), (selectChannel?.key ?? '')),
        fun: (map) {
          response = ResponseModel.fromJson(map);
          embarNo1.text = (response?.pouplateData![0].eventNoCol != null &&
                  response?.pouplateData![0].eventNoCol != 0)
              ? response?.pouplateData![0].eventNoCol.toString() ?? ""
              : "";
          embarNo2.text = (response?.pouplateData![0].eventNoLen != null &&
                  response?.pouplateData![0].eventNoLen != 0)
              ? response?.pouplateData![0].eventNoLen.toString() ?? ""
              : "";
          telDt1.text = (response?.pouplateData![0].telecastDateCol != null &&
                  response?.pouplateData![0].telecastDateCol != 0)
              ? response?.pouplateData![0].telecastDateCol.toString() ?? ""
              : "";
          telDt2.text = (response?.pouplateData![0].telecastDateLen != null &&
                  response?.pouplateData![0].telecastDateLen != 0)
              ? response?.pouplateData![0].telecastDateLen.toString() ?? ""
              : "";
          telTime1.text = (response?.pouplateData![0].telecastTimeCol != null &&
                  response?.pouplateData![0].telecastTimeCol != 0)
              ? response?.pouplateData![0].telecastTimeCol.toString() ?? ""
              : '';
          telTime2.text = (response?.pouplateData![0].telecastTimeLen != null &&
                  response?.pouplateData![0].telecastTimeLen != 0)
              ? response?.pouplateData![0].telecastTimeLen.toString() ?? ""
              : "";
          expTapeCode1.text = (response?.pouplateData![0].exportTapeCodeCol !=
                      null &&
                  response?.pouplateData![0].exportTapeCodeCol != 0)
              ? response?.pouplateData![0].exportTapeCodeCol.toString() ?? ""
              : "";
          expTapeCode2.text = (response?.pouplateData![0].exportTapeCodeLen !=
                      null &&
                  response?.pouplateData![0].exportTapeCodeLen != 0)
              ? response?.pouplateData![0].exportTapeCodeLen.toString() ?? ""
              : "";
          segNo1.text = (response?.pouplateData![0].segmentNumberCol != null &&
                  response?.pouplateData![0].segmentNumberCol != 0)
              ? response?.pouplateData![0].segmentNumberCol.toString() ?? ""
              : "";
          segNo2.text = (response?.pouplateData![0].segmentNumberLen != null &&
                  response?.pouplateData![0].segmentNumberLen != 0)
              ? response?.pouplateData![0].segmentNumberLen.toString() ?? ""
              : "";
          expCap1.text = (response?.pouplateData![0].exportTapeCaptionCol !=
                      null &&
                  response?.pouplateData![0].exportTapeCaptionCol != 0)
              ? response?.pouplateData![0].exportTapeCaptionCol.toString() ?? ""
              : "";
          expCap2.text = (response?.pouplateData![0].exportTapeCaptionLen !=
                      null &&
                  response?.pouplateData![0].exportTapeCaptionLen != 0)
              ? response?.pouplateData![0].exportTapeCaptionLen.toString() ?? ""
              : "";
          tapDur1.text = (response?.pouplateData![0].tapeDurationCol != null &&
                  response?.pouplateData![0].tapeDurationCol != 0)
              ? response?.pouplateData![0].tapeDurationCol.toString() ?? ""
              : "";
          tapDur2.text = (response?.pouplateData![0].tapeDurationLen != null &&
                  response?.pouplateData![0].tapeDurationLen != 0)
              ? response?.pouplateData![0].tapeDurationLen.toString() ?? ""
              : "";
          reconKey1.text = (response?.pouplateData![0].reconKeyCol != null &&
                  response?.pouplateData![0].reconKeyCol != 0)
              ? response?.pouplateData![0].reconKeyCol.toString() ?? ""
              : "";
          reconKey2.text = (response?.pouplateData![0].reconKeyLen != null &&
                  response?.pouplateData![0].reconKeyLen != 0)
              ? response?.pouplateData![0].reconKeyLen.toString() ?? ""
              : "";
          endTime1.text = (response?.pouplateData![0].endTimecol != null &&
                  response?.pouplateData![0].endTimecol != 0)
              ? response?.pouplateData![0].endTimecol.toString() ?? ""
              : "";
          endTime2.text = (response?.pouplateData![0].endTimelen != null &&
                  response?.pouplateData![0].endTimelen != 0)
              ? response?.pouplateData![0].endTimelen.toString() ?? ""
              : "";
          dateFormat.text = response?.pouplateData![0].dateFormat ?? "";
          fileName.text = response?.pouplateData![0].defaultfilename ?? "";
          asRunType.text = (response?.pouplateData![0].asrunType != null &&
                  response?.pouplateData![0].asrunType != 0)
              ? response?.pouplateData![0].asrunType.toString() ?? ""
              : "";
          sapFlag.text = (response?.pouplateData![0].saPflag != null &&
                  response?.pouplateData![0].saPflag != 0)
              ? response?.pouplateData![0].saPflag.toString() ?? ""
              : "";
          newFormat.text = (response?.pouplateData![0].newformat != null &&
                  response?.pouplateData![0].newformat != 0)
              ? response?.pouplateData![0].newformat.toString() ?? ""
              : "";
          hhMM.text =
              response?.pouplateData![0].asrunDifference.toString() ?? "";
          maxDuration.text =
              (response?.pouplateData![0].maxDurationDifference != null &&
                      response?.pouplateData![0].maxDurationDifference != 0)
                  ? response?.pouplateData![0].maxDurationDifference
                          .toString() ??
                      ""
                  : "";
          isFpc = response?.pouplateData![0].fpc == 1 ? true : false;
          isMarkSlot = response?.pouplateData![0].markSlots == 1 ? true : false;
          isDontUpdate =
              response?.pouplateData![0].dontUpdateExposure == 1 ? true : false;
          revRunOrder =
              response?.pouplateData![0].reverseAsRunOrder == 1 ? true : false;
          update(["main1", "main2"]);
        });
  }

  postData() {
    LoadingDialog.call();
    var jsonData = {
      "channelCode": selectChannel?.key ?? "",
      "locationCode": selectLocation?.key ?? "",
      "importFileType": selectFileType?.value??"",
      "eventNoCol": int.tryParse(embarNo1.text)??0,
      "telecastDateCol": int.tryParse(telDt1.text)??0,
      "telecastTimeCol": int.tryParse(telDt2.text)??0,
      "exportTapeCodeCol": int.tryParse(expTapeCode1.text)??0,
      "segmentNumberCol": int.tryParse(segNo1.text)??0,
      "exportTapeCaptionCol": int.tryParse(expCap1.text)??0,
      "tapeDurationCol": int.tryParse(tapDur1.text)??0,
      "reconKeyCol": int.tryParse(reconKey1.text)??0,
      "endTimecol": int.tryParse(endTime1.text)??0,
      "fileType": selectFileType?.value??"",
      "eventNoLen": int.tryParse(embarNo2.text)??0,
      "telecastDateLen": int.tryParse(telDt2.text)??0,
      "telecastTimeLen": int.tryParse(telTime2.text)??0,
      "exportTapeCodeLen": int.tryParse(expCap2.text)??0,
      "segmentNumberLen": int.tryParse(segNo2.text)??0,
      "exportTapeCaptionLen": int.tryParse(expCap2.text)??0,
      "tapeDurationLen": int.tryParse(tapDur2.text)??0,
      "reconKeyLen": int.tryParse(reconKey2.text)??0,
      "endTimelen": int.tryParse(endTime2.text)??0,
      "asrunDifference": hhMM.text,
      "asrunFlag": selectTimeDiff?.value??"",
      "asrunType": int.tryParse(asRunType.text)??0,
      "saPflag": int.tryParse(sapFlag.text)??0,
      "newformat": int.tryParse(newFormat.text)??0,
      "maxDurationDifference": int.tryParse(maxDuration.text)??0,
      "defaultfilename": fileName.text,
      "fpc": isFpc ? 1 : 0,
      "markSlots": isMarkSlot ? 1 : 0,
      "dontUpdateExposure": isDontUpdate ? 1 : 0,
      "reverseAsRunOrder": revRunOrder ? 1 : 0,
      "date_format": dateFormat.text
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.ASRUN_AD_SAVE,
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey("save") &&
              map["save"] != null) {
            LoadingDialog.callDataSaved(msg: map["save"],callback: (){
              Get.delete<AsrunSpecificationAdRevenueController>();
              Get.find<HomeController>().clearPage1();
            });
          }else{
            LoadingDialog.callErrorMessage1(msg: map.toString());
          }
        },
        json: jsonData);
  }

  formHandler(String data) {
    switch (data) {
      case "Save":
        postData();
        break;
      case "Clear":
        Get.delete<AsrunSpecificationAdRevenueController>();
        Get.find<HomeController>().clearPage1();
        break;
    }
  }
}
