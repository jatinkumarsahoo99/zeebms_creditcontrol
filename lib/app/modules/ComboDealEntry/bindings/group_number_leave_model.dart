import 'package:intl/intl.dart';

class GroupNumberLeave {
  CdeRecord? cdeRecord;

  GroupNumberLeave({this.cdeRecord});

  GroupNumberLeave.fromJson(Map<String, dynamic> json) {
    cdeRecord = json["cdeRecord"] == null
        ? null
        : CdeRecord.fromJson(json["cdeRecord"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (cdeRecord != null) {
      _data["cdeRecord"] = cdeRecord?.toJson();
    }
    return _data;
  }
}

class CdeRecord {
  List<LstLinkeddeal>? lstLinkeddeal;
  List<Lstdealrecord>? lstTbldeal;
  List<LstTblLinkDeal>? lsttblLinkedDeals;
  List<LstAgency>? lstAgency;

  CdeRecord(
      {this.lstLinkeddeal,
      this.lstTbldeal,
      this.lsttblLinkedDeals,
      this.lstAgency});

  CdeRecord.fromJson(Map<String, dynamic> json) {
    lstLinkeddeal = json["lstLinkeddeal"] == null
        ? null
        : (json["lstLinkeddeal"] as List)
            .map((e) => LstLinkeddeal.fromJson(e))
            .toList();
    lstTbldeal = json["lstTbldeal"] == null
        ? null
        : (json["lstTbldeal"] as List)
            .map((e) => Lstdealrecord.fromJson(e))
            .toList();
    lsttblLinkedDeals = json["lsttblLinkedDeals"] == null
        ? null
        : (json["lsttblLinkedDeals"] as List)
            .map((e) => LstTblLinkDeal.fromJson(e))
            .toList();
    lstAgency = json["lstAgency"] == null
        ? null
        : (json["lstAgency"] as List)
            .map((e) => LstAgency.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstLinkeddeal != null) {
      _data["lstLinkeddeal"] = lstLinkeddeal?.map((e) => e.toJson()).toList();
    }
    if (lstTbldeal != null) {
      _data["lstTbldeal"] = lstTbldeal?.map((e) => e.toJson()).toList();
    }
    if (lsttblLinkedDeals != null) {
      _data["lsttblLinkedDeals"] =
          lsttblLinkedDeals?.map((e) => e.toJson()).toList();
    }
    if (lstAgency != null) {
      _data["lstAgency"] = lstAgency?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class LstAgency {
  String? agencyCode;
  String? agencyName;

  LstAgency({this.agencyCode, this.agencyName});

  LstAgency.fromJson(Map<String, dynamic> json) {
    agencyCode = json["agencyCode"];
    agencyName = json["agencyName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["agencyCode"] = agencyCode;
    _data["agencyName"] = agencyName;
    return _data;
  }
}

class LstTblLinkDeal {
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
  String? programCode;
  String? programname;
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

  LstTblLinkDeal(
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

  LstTblLinkDeal.fromJson(Map<String, dynamic> json) {
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

class Lstdealrecord {
  bool? selected;
  String? locationcode;
  String? channelcode;
  String? locationname;
  String? channelname;
  String? dealnumber;
  String? dealdate;
  String? fromdate;
  String? todate;
  num? maxspend;

  Lstdealrecord(
      {this.selected,
      this.locationcode,
      this.channelcode,
      this.locationname,
      this.channelname,
      this.dealnumber,
      this.dealdate,
      this.fromdate,
      this.todate,
      this.maxspend});

  Lstdealrecord.fromJson(Map<String, dynamic> json) {
    selected = json["selected"];
    locationcode = json["locationcode"];
    channelcode = json["channelcode"];
    locationname = json["locationname"];
    channelname = json["channelname"];
    dealnumber = json["dealnumber"];
    dealdate = json["dealdate"];
    fromdate = json["fromdate"];
    todate = json["todate"];
    maxspend = json["maxspend"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["selected"] = selected.toString();
    _data["locationcode"] = locationcode;
    _data["channelcode"] = channelcode;
    _data["locationname"] = locationname;
    _data["channelname"] = channelname;
    _data["dealnumber"] = dealnumber;
    _data["dealdate"] = dateConvertToddMMyyyy(dealdate ?? "");
    _data["fromdate"] = dateConvertToddMMyyyy(fromdate ?? "");
    _data["todate"] = dateConvertToddMMyyyy(todate ?? "");
    _data["maxspend"] = maxspend;
    return _data;
  }
}

class LstLinkeddeal {
  num? dealcode;
  num? groupNumber;
  String? clientCode;
  String? agencyCode;
  String? groupdate;
  String? clientName;

  LstLinkeddeal(
      {this.dealcode,
      this.groupNumber,
      this.clientCode,
      this.agencyCode,
      this.groupdate,
      this.clientName});

  LstLinkeddeal.fromJson(Map<String, dynamic> json) {
    dealcode = json["dealcode"];
    groupNumber = json["groupNumber"];
    clientCode = json["clientCode"];
    agencyCode = json["agencyCode"];
    groupdate = json["groupdate"];
    clientName = json["clientName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["dealcode"] = dealcode;
    _data["groupNumber"] = groupNumber;
    _data["clientCode"] = clientCode;
    _data["agencyCode"] = agencyCode;
    _data["groupdate"] = groupdate;
    _data["clientName"] = clientName;
    return _data;
  }
}

String dateConvertToddMMyyyy(String date) {
  return (DateFormat('dd-MM-yyyy')
      .format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(date)));
}
