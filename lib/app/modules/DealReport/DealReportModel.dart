class DealReportModel {
  List<Genrate>? genrate;

  DealReportModel({this.genrate});

  DealReportModel.fromJson(Map<String, dynamic> json) {
    if (json['genrate'] != null) {
      genrate = <Genrate>[];
      json['genrate'].forEach((v) {
        genrate!.add(new Genrate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genrate != null) {
      data['genrate'] = this.genrate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genrate {
  String? dealNumber;
  String? dealDate;
  String? referenceNumber;
  String? referenceDate;
  String? clientname;
  String? agencyname;
  String? brandname;
  String? currency;
  double? totalsec;
  double? dealAmount;
  String? fromDate;
  String? todate;
  String? starttime;
  String? endTime;
  double? seconds;
  double? rate;
  double? totalDealamount;
  double? valuationrate;
  String? bandcode;
  String? networkname;
  String? sponsorTypename;
  String? programcategory;
  String? programname;
  String? dealTypeShortName;
  String? channelname;
  String? infoname;
  String? infovalue;

  Genrate(
      {this.dealNumber,
        this.dealDate,
        this.referenceNumber,
        this.referenceDate,
        this.clientname,
        this.agencyname,
        this.brandname,
        this.currency,
        this.totalsec,
        this.dealAmount,
        this.fromDate,
        this.todate,
        this.starttime,
        this.endTime,
        this.seconds,
        this.rate,
        this.totalDealamount,
        this.valuationrate,
        this.bandcode,
        this.networkname,
        this.sponsorTypename,
        this.programcategory,
        this.programname,
        this.dealTypeShortName,
        this.channelname,
        this.infoname,
        this.infovalue});

  Genrate.fromJson(Map<String, dynamic> json) {
    dealNumber = json['dealNumber'];
    dealDate = json['dealDate'];
    referenceNumber = json['referenceNumber'];
    referenceDate = json['referenceDate'];
    clientname = json['clientname'];
    agencyname = json['agencyname'];
    brandname = json['brandname'];
    currency = json['currency'];
    totalsec = json['totalsec'];
    dealAmount = json['dealAmount'];
    fromDate = json['fromDate'];
    todate = json['todate'];
    starttime = json['starttime'];
    endTime = json['endTime'];
    seconds = json['seconds'];
    rate = json['rate'];
    totalDealamount = json['totalDealamount'];
    valuationrate = json['valuationrate'];
    bandcode = json['bandcode'];
    networkname = json['networkname'];
    sponsorTypename = json['sponsorTypename'];
    programcategory = json['programcategory'];
    programname = json['programname'];
    dealTypeShortName = json['dealTypeShortName'];
    channelname = json['channelname'];
    infoname = json['infoname'];
    infovalue = json['infovalue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealNumber'] = this.dealNumber;
    data['dealDate'] = this.dealDate;
    data['referenceNumber'] = this.referenceNumber;
    data['referenceDate'] = this.referenceDate;
    data['clientname'] = this.clientname;
    data['agencyname'] = this.agencyname;
    data['brandname'] = this.brandname;
    data['currency'] = this.currency;
    data['totalsec'] = this.totalsec;
    data['dealAmount'] = this.dealAmount;
    data['fromDate'] = this.fromDate;
    data['todate'] = this.todate;
    data['starttime'] = this.starttime;
    data['endTime'] = this.endTime;
    data['seconds'] = this.seconds;
    data['rate'] = this.rate;
    data['totalDealamount'] = this.totalDealamount;
    data['valuationrate'] = this.valuationrate;
    data['bandcode'] = this.bandcode;
    data['networkname'] = this.networkname;
    data['sponsorTypename'] = this.sponsorTypename;
    data['programcategory'] = this.programcategory;
    data['programname'] = this.programname;
    data['dealTypeShortName'] = this.dealTypeShortName;
    data['channelname'] = this.channelname;
    data['infoname'] = this.infoname;
    data['infovalue'] = this.infovalue;
    return data;
  }
}
