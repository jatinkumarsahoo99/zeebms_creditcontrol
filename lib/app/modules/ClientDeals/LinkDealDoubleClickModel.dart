import '../../../widgets/PlutoGrid/src/model/pluto_cell.dart';

class LinkDealDoubleClickModel {
  List<Model>? model;

  LinkDealDoubleClickModel({this.model});

  LinkDealDoubleClickModel.fromJson(Map<String, dynamic> json) {
    if (json['model'] != null) {
      model = <Model>[];
      json['model'].forEach((v) {
        model!.add(new Model.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.model != null) {
      data['model'] = this.model!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Model {
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

  Model(
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

  Model.fromJson(Map<String, dynamic> json) {
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

  Map<String, PlutoCell> toJson1(int index) {
    final Map<String, PlutoCell> data =  Map<String, PlutoCell>();
    data['locationname'] = PlutoCell(value:locationname ?? "" ) ;
    data['channelName'] = PlutoCell(value:channelName ?? "" );
    data['dealCode'] =  PlutoCell(value:dealCode ?? "" );
    data['dealDetailCode'] = PlutoCell(value:dealDetailCode ?? "" );
    data['primaryEventCode'] = PlutoCell(value:primaryEventCode ?? "" );
    data['locationcode'] = PlutoCell(value:locationcode ?? "" );
    data['channelcode'] = PlutoCell(value:channelcode ?? "" );
    data['dealnumber'] = PlutoCell(value:dealnumber ?? "" );
    data['recordnumber'] = PlutoCell(value:recordnumber ?? "" );
    data['sponsorTypeCode'] = PlutoCell(value:sponsorTypeCode ?? "" );
    data['sponsorTypeName'] = PlutoCell(value:sponsorTypeName ?? "" );
    data['programCode'] = PlutoCell(value:programCode ?? "" );
    data['programname'] = PlutoCell(value:programname ?? "" );
    data['programCategoryCode'] = PlutoCell(value:programCategoryCode ?? "" );
    data['programCategoryName'] = PlutoCell(value:programCategoryName ?? "" );
    data['starttime'] = PlutoCell(value:starttime ?? "" );
    data['endTime'] = PlutoCell(value:endTime ?? "" );
    data['seconds'] = PlutoCell(value:seconds ?? "" );
    data['rate'] = PlutoCell(value:rate ?? "" );
    data['amount'] = PlutoCell(value:amount ?? "" );
    data['bandcode'] = PlutoCell(value:bandcode ?? "" );
    data['timeband'] = PlutoCell(value:timeband ?? "" );
    data['valuationrate'] = PlutoCell(value:valuationrate ?? "" );
    data['netcode'] = PlutoCell(value:netcode ?? "" );
    data['networkname'] = PlutoCell(value:networkname ?? "" );
    data['sun'] = PlutoCell(value:sun ?? "" );
    data['mon'] = PlutoCell(value:mon ?? "" );
    data['tue'] = PlutoCell(value:tue ?? "" );
    data['wed'] = PlutoCell(value:wed ?? "" );
    data['thu'] = PlutoCell(value:thu ?? "" );
    data['fri'] = PlutoCell(value:fri ?? "" );
    data['sat'] = PlutoCell(value:sat ?? "" );
    data['revflag'] = PlutoCell(value:revflag ?? "" );
    data['accountCode'] = PlutoCell(value:accountCode ?? "" );
    data['accountname'] = PlutoCell(value:accountname ?? "" );
    data['eventcode'] = PlutoCell(value:eventcode ?? "" );
    data['eventname'] = PlutoCell(value:eventname ?? "" );
    data['bookedSeconds'] = PlutoCell(value:bookedSeconds ?? "" );
    data['spots'] = PlutoCell(value:spots ?? "" );
    data['groupValuationRate'] = PlutoCell(value:groupValuationRate ?? "" );
    data['no'] = PlutoCell(value:(index??"1").toString());
    return data;
  }
}
