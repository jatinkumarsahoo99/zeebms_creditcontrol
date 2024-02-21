class LinkDealRetrieveModel {
  Model? model;

  LinkDealRetrieveModel({this.model});

  LinkDealRetrieveModel.fromJson(Map<String, dynamic> json) {
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    return data;
  }
}

class Model {
  int? dealcode;
  int? groupNumber;
  String? clientCode;
  String? agencyCode;
  String? groupdate;
  List<Deals>? deals;
  List<LinkedDeal>? linkedDeal;
  String? clientName;
  String? agencyName;

  Model(
      {this.dealcode,
        this.groupNumber,
        this.clientCode,
        this.agencyCode,
        this.groupdate,
        this.deals,
        this.linkedDeal,
        this.clientName,
        this.agencyName});

  Model.fromJson(Map<String, dynamic> json) {
    dealcode = json['dealcode'];
    groupNumber = json['groupNumber'];
    clientCode = json['clientCode'];
    agencyCode = json['agencyCode'];
    groupdate = json['groupdate'];
    if (json['deals'] != null) {
      deals = <Deals>[];
      json['deals'].forEach((v) {
        deals!.add(new Deals.fromJson(v));
      });
    }
    if (json['linkedDeal'] != null) {
      linkedDeal = <LinkedDeal>[];
      json['linkedDeal'].forEach((v) {
        linkedDeal!.add(new LinkedDeal.fromJson(v));
      });
    }
    clientName = json['clientName'];
    agencyName = json['agencyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealcode'] = this.dealcode;
    data['groupNumber'] = this.groupNumber;
    data['clientCode'] = this.clientCode;
    data['agencyCode'] = this.agencyCode;
    data['groupdate'] = this.groupdate;
    if (this.deals != null) {
      data['deals'] = this.deals!.map((v) => v.toJson()).toList();
    }
    if (this.linkedDeal != null) {
      data['linkedDeal'] = this.linkedDeal!.map((v) => v.toJson()).toList();
    }
    data['clientName'] = this.clientName;
    data['agencyName'] = this.agencyName;
    return data;
  }
}

class Deals {
  bool? selected;
  String? locationcode;
  String? channelcode;
  String? locationname;
  String? channelname;
  String? dealnumber;
  String? dealdate;
  String? fromdate;
  String? todate;
  int? maxspend;

  Deals(
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

  Deals.fromJson(Map<String, dynamic> json) {
    selected = json['selected'];
    locationcode = json['locationcode'];
    channelcode = json['channelcode'];
    locationname = json['locationname'];
    channelname = json['channelname'];
    dealnumber = json['dealnumber'];
    dealdate = json['dealdate'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    maxspend = json['maxspend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selected'] = this.selected;
    data['locationcode'] = this.locationcode;
    data['channelcode'] = this.channelcode;
    data['locationname'] = this.locationname;
    data['channelname'] = this.channelname;
    data['dealnumber'] = this.dealnumber;
    data['dealdate'] = this.dealdate;
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    data['maxspend'] = this.maxspend;
    return data;
  }
}

class LinkedDeal {
  String? locationname;
  String? channelName;
  int? dealCode;
  int? dealDetailCode;
  int? primaryEventCode;
  String? locationcode;
  String? channelcode;
  String? dealnumber;
  int? recordnumber;
  String? sponsorTypeCode;
  String? sponsorTypeName;
  String? programCode;
  String? programname;
  String? programCategoryCode;
  String? programCategoryName;
  String? starttime;
  String? endTime;
  int? seconds;
  int? rate;
  int? amount;
  String? bandcode;
  String? timeband;
  int? valuationrate;
  int? netcode;
  String? networkname;
  int? sun;
  int? mon;
  int? tue;
  int? wed;
  int? thu;
  int? fri;
  int? sat;
  int? revflag;
  String? accountCode;
  String? accountname;
  int? eventcode;
  String? eventname;
  int? bookedSeconds;
  int? spots;
  int? groupValuationRate;

  LinkedDeal(
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

  LinkedDeal.fromJson(Map<String, dynamic> json) {
    locationname = json['locationname'];
    channelName = json['channelName'];
    dealCode = json['dealCode'];
    dealDetailCode = json['dealDetailCode'];
    primaryEventCode = json['primaryEventCode'];
    locationcode = json['locationcode'];
    channelcode = json['channelcode'];
    dealnumber = json['dealnumber'];
    recordnumber = json['recordnumber'];
    sponsorTypeCode = json['sponsorTypeCode'];
    sponsorTypeName = json['sponsorTypeName'];
    programCode = json['programCode'];
    programname = json['programname'];
    programCategoryCode = json['programCategoryCode'];
    programCategoryName = json['programCategoryName'];
    starttime = json['starttime'];
    endTime = json['endTime'];
    seconds = json['seconds'];
    rate = json['rate'];
    amount = json['amount'];
    bandcode = json['bandcode'];
    timeband = json['timeband'];
    valuationrate = json['valuationrate'];
    netcode = json['netcode'];
    networkname = json['networkname'];
    sun = json['sun'];
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thu = json['thu'];
    fri = json['fri'];
    sat = json['sat'];
    revflag = json['revflag'];
    accountCode = json['accountCode'];
    accountname = json['accountname'];
    eventcode = json['eventcode'];
    eventname = json['eventname'];
    bookedSeconds = json['bookedSeconds'];
    spots = json['spots'];
    groupValuationRate = json['groupValuationRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationname'] = this.locationname;
    data['channelName'] = this.channelName;
    data['dealCode'] = this.dealCode;
    data['dealDetailCode'] = this.dealDetailCode;
    data['primaryEventCode'] = this.primaryEventCode;
    data['locationcode'] = this.locationcode;
    data['channelcode'] = this.channelcode;
    data['dealnumber'] = this.dealnumber;
    data['recordnumber'] = this.recordnumber;
    data['sponsorTypeCode'] = this.sponsorTypeCode;
    data['sponsorTypeName'] = this.sponsorTypeName;
    data['programCode'] = this.programCode;
    data['programname'] = this.programname;
    data['programCategoryCode'] = this.programCategoryCode;
    data['programCategoryName'] = this.programCategoryName;
    data['starttime'] = this.starttime;
    data['endTime'] = this.endTime;
    data['seconds'] = this.seconds;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['bandcode'] = this.bandcode;
    data['timeband'] = this.timeband;
    data['valuationrate'] = this.valuationrate;
    data['netcode'] = this.netcode;
    data['networkname'] = this.networkname;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tue'] = this.tue;
    data['wed'] = this.wed;
    data['thu'] = this.thu;
    data['fri'] = this.fri;
    data['sat'] = this.sat;
    data['revflag'] = this.revflag;
    data['accountCode'] = this.accountCode;
    data['accountname'] = this.accountname;
    data['eventcode'] = this.eventcode;
    data['eventname'] = this.eventname;
    data['bookedSeconds'] = this.bookedSeconds;
    data['spots'] = this.spots;
    data['groupValuationRate'] = this.groupValuationRate;
    return data;
  }
}
