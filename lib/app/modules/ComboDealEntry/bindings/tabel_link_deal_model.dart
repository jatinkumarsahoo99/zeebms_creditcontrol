class TabelLinkDealModel {
  LinkedDeals? linkedDeals;

  TabelLinkDealModel({this.linkedDeals});

  TabelLinkDealModel.fromJson(Map<String, dynamic> json) {
    linkedDeals = json["linkedDeals"] == null
        ? null
        : LinkedDeals.fromJson(json["linkedDeals"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (linkedDeals != null) {
      _data["linkedDeals"] = linkedDeals?.toJson();
    }
    return _data;
  }
}

class LinkedDeals {
  List<LstTblLinkDealList>? lstTblLinkDeal;

  LinkedDeals({this.lstTblLinkDeal});

  LinkedDeals.fromJson(Map<String, dynamic> json) {
    lstTblLinkDeal = json["lstTblLinkDeal"] == null
        ? null
        : (json["lstTblLinkDeal"] as List)
            .map((e) => LstTblLinkDealList.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstTblLinkDeal != null) {
      _data["lstTblLinkDeal"] = lstTblLinkDeal?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class LstTblLinkDealList {
  String? locationname;
  String? channelName;
  num? dealCode;
  num? dealDetailCode;
  num? primaryEventCode;
  String? locationcode;
  String? channelcode;
  String? dealnumber;
  num? recordnumber;
  String? sponsorTypeCode;
  String? sponsorTypeName;
  dynamic programCode;
  dynamic programname;
  dynamic programCategoryCode;
  dynamic programCategoryName;
  String? starttime;
  String? endTime;
  num? seconds;
  num? rate;
  num? amount;
  String? bandcode;
  String? timeband;
  num? valuationrate;
  num? netcode;
  String? networkname;
  num? sun;
  num? mon;
  num? tue;
  num? wed;
  num? thu;
  num? fri;
  num? sat;
  num? revflag;
  dynamic accountCode;
  dynamic accountname;
  num? eventcode;
  dynamic eventname;
  num? bookedSeconds;
  num? spots;
  num? groupValuationRate;

  LstTblLinkDealList(
      {this.locationname,
      this.channelName,
      this.dealCode,
      this.dealDetailCode,
      this.primaryEventCode,
      this.locationcode,
      this.channelcode,
      this.dealnumber,
      this.recordnumber,
      this.sponsorTypeCode,
      this.sponsorTypeName,
      this.programCode,
      this.programname,
      this.programCategoryCode,
      this.programCategoryName,
      this.starttime,
      this.endTime,
      this.seconds,
      this.rate,
      this.amount,
      this.bandcode,
      this.timeband,
      this.valuationrate,
      this.netcode,
      this.networkname,
      this.sun,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.sat,
      this.revflag,
      this.accountCode,
      this.accountname,
      this.eventcode,
      this.eventname,
      this.bookedSeconds,
      this.spots,
      this.groupValuationRate});

  LstTblLinkDealList.fromJson(Map<String, dynamic> json) {
    locationname = json["locationname"];
    channelName = json["channelName"];
    dealCode = json["dealCode"];
    dealDetailCode = json["dealDetailCode"];
    primaryEventCode = json["primaryEventCode"];
    locationcode = json["locationcode"];
    channelcode = json["channelcode"];
    dealnumber = json["dealnumber"];
    recordnumber = json["recordnumber"];
    sponsorTypeCode = json["sponsorTypeCode"];
    sponsorTypeName = json["sponsorTypeName"];
    programCode = json["programCode"];
    programname = json["programname"];
    programCategoryCode = json["programCategoryCode"];
    programCategoryName = json["programCategoryName"];
    starttime = json["starttime"];
    endTime = json["endTime"];
    seconds = json["seconds"];
    rate = json["rate"];
    amount = json["amount"];
    bandcode = json["bandcode"];
    timeband = json["timeband"];
    valuationrate = json["valuationrate"];
    netcode = json["netcode"];
    networkname = json["networkname"];
    sun = json["sun"];
    mon = json["mon"];
    tue = json["tue"];
    wed = json["wed"];
    thu = json["thu"];
    fri = json["fri"];
    sat = json["sat"];
    revflag = json["revflag"];
    accountCode = json["accountCode"];
    accountname = json["accountname"];
    eventcode = json["eventcode"];
    eventname = json["eventname"];
    bookedSeconds = json["bookedSeconds"];
    spots = json["spots"];
    groupValuationRate = json["groupValuationRate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["locationname"] = locationname;
    _data["channelName"] = channelName;
    _data["dealCode"] = dealCode;
    _data["dealDetailCode"] = dealDetailCode;
    _data["primaryEventCode"] = primaryEventCode;
    _data["locationcode"] = locationcode;
    _data["channelcode"] = channelcode;
    _data["dealnumber"] = dealnumber;
    _data["recordnumber"] = recordnumber;
    _data["sponsorTypeCode"] = sponsorTypeCode;
    _data["sponsorTypeName"] = sponsorTypeName;
    _data["programCode"] = programCode;
    _data["programname"] = programname;
    _data["programCategoryCode"] = programCategoryCode;
    _data["programCategoryName"] = programCategoryName;
    _data["starttime"] = starttime;
    _data["endTime"] = endTime;
    _data["seconds"] = seconds;
    _data["rate"] = rate;
    _data["amount"] = amount;
    _data["bandcode"] = bandcode;
    _data["timeband"] = timeband;
    _data["valuationrate"] = valuationrate;
    _data["netcode"] = netcode;
    _data["networkname"] = networkname;
    _data["sun"] = sun;
    _data["mon"] = mon;
    _data["tue"] = tue;
    _data["wed"] = wed;
    _data["thu"] = thu;
    _data["fri"] = fri;
    _data["sat"] = sat;
    _data["revflag"] = revflag;
    _data["accountCode"] = accountCode;
    _data["accountname"] = accountname;
    _data["eventcode"] = eventcode;
    _data["eventname"] = eventname;
    _data["bookedSeconds"] = bookedSeconds;
    _data["spots"] = spots;
    _data["groupValuationRate"] = groupValuationRate;
    return _data;
  }
}
