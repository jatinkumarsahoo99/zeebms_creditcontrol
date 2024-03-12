class ClientDealRetrieveModel {
  AgencyLeaveModel? agencyLeaveModel;

  ClientDealRetrieveModel({this.agencyLeaveModel});

  ClientDealRetrieveModel.fromJson(Map<String, dynamic> json) {
    agencyLeaveModel = json['agencyLeaveModel'] != null
        ? new AgencyLeaveModel.fromJson(json['agencyLeaveModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agencyLeaveModel != null) {
      data['agencyLeaveModel'] = this.agencyLeaveModel!.toJson();
    }
    return data;
  }
}

class PaymentModels {
  String? paymentmodecaption;
  String? paymentmodecode;

  PaymentModels({this.paymentmodecaption, this.paymentmodecode});

  PaymentModels.fromJson(Map<String, dynamic> json) {
    paymentmodecaption = json['paymentmodecaption'];
    paymentmodecode = json['paymentmodecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentmodecaption'] = this.paymentmodecaption;
    data['paymentmodecode'] = this.paymentmodecode;
    return data;
  }
}

class AgencyLeaveModel {
  List<PaymentModels>? paymentModels;
  List<RemarksData>? remarks;
  List<NewDetails>? newDetails;
  List<Retrieve>? retrieve;
  List<AddInfo>? addInfo;
  String? linkedDealNumber;
  String? totalSeconds;
  String? totalDeaAmount;
  String? totalSecondsUsed;

  AgencyLeaveModel(
      {this.paymentModels,
        this.remarks,
        this.newDetails,
        this.retrieve,
        this.addInfo,
        this.linkedDealNumber,
        this.totalSeconds,
        this.totalDeaAmount,
        this.totalSecondsUsed});

  AgencyLeaveModel.fromJson(Map<String, dynamic> json) {
    if (json['paymentModels'] != null) {
      paymentModels = <PaymentModels>[];
      json['paymentModels'].forEach((v) {
        paymentModels!.add( PaymentModels.fromJson(v));
      });
    }
    if (json['remarks'] != null) {
      remarks = <RemarksData>[];
      json['remarks'].forEach((v) {
        remarks!.add(new RemarksData.fromJson(v));
      });
    }
    if (json['newDetails'] != null) {
      newDetails = <NewDetails>[];
      json['newDetails'].forEach((v) {
        newDetails!.add(new NewDetails.fromJson(v));
      });
    }
    if (json['retrieve'] != null) {
      retrieve = <Retrieve>[];
      json['retrieve'].forEach((v) {
        retrieve!.add(new Retrieve.fromJson(v));
      });
    }
    if (json['addInfo'] != null) {
      addInfo = <AddInfo>[];
      json['addInfo'].forEach((v) {
        addInfo!.add(new AddInfo.fromJson(v));
      });
    }
    linkedDealNumber = json['linkedDealNumber'];
    totalSeconds = json['totalSeconds'];
    totalDeaAmount = json['totalDeaAmount'];
    totalSecondsUsed = json['totalSecondsUsed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentModels != null) {
      data['paymentModels'] =
          this.paymentModels!.map((v) => v.toJson()).toList();
    }
    if (this.remarks != null) {
      data['remarks'] = this.remarks!.map((v) => v.toJson()).toList();
    }
    if (this.newDetails != null) {
      data['newDetails'] = this.newDetails!.map((v) => v.toJson()).toList();
    }
    if (this.retrieve != null) {
      data['retrieve'] = this.retrieve!.map((v) => v.toJson()).toList();
    }
    if (this.addInfo != null) {
      data['addInfo'] = this.addInfo!.map((v) => v.toJson()).toList();
    }
    data['linkedDealNumber'] = this.linkedDealNumber;
    data['totalSeconds'] = this.totalSeconds;
    data['totalDeaAmount'] = this.totalDeaAmount;
    data['totalSecondsUsed'] = this.totalSecondsUsed;
    return data;
  }
}

class RemarksData {
  String? remark;

  RemarksData({this.remark});

  RemarksData.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remark'] = this.remark;
    return data;
  }
}

class NewDetails {
  String? primaryEventCode;
  String? recordnumber;
  String? sponsorTypeCode;
  String? sponsorTypeName;
  String? programCode;
  String? programName;
  String? programCategoryCode;
  String? starttime;
  String? endTime;
  String? seconds;
  String? rate;
  String? amount;
  String? valuationRate;
  String? bookedSeconds;
  String? balanceSeconds;
  String? balanceAmount;
  String? bandCode;
  String? timeBand;
  String? netCode;
  String? netWorkName;
  String? sun;
  String? mon;
  String? tue;
  String? wed;
  String? thu;
  String? fri;
  String? sat;
  String? revflag;
  String? accountCode;
  String? accountname;
  String? eventcode;
  String? eventname;
  String? spots;
  String? paymentmodecaption;
  String? revenueTypeName;
  String? revenueTypeCode;
  String? subRevenueTypeName;
  String? subRevenueTypeCode;
  String? countBased;
  String? baseDuration;

  NewDetails(
      {this.primaryEventCode,
        this.recordnumber,
        this.sponsorTypeCode,
        this.sponsorTypeName,
        this.programCode,
        this.programName,
        this.programCategoryCode,
        this.starttime,
        this.endTime,
        this.seconds,
        this.rate,
        this.amount,
        this.valuationRate,
        this.bookedSeconds,
        this.balanceSeconds,
        this.balanceAmount,
        this.bandCode,
        this.timeBand,
        this.netCode,
        this.netWorkName,
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
        this.spots,
        this.paymentmodecaption,
        this.revenueTypeName,
        this.revenueTypeCode,
        this.subRevenueTypeName,
        this.subRevenueTypeCode,
        this.countBased,
        this.baseDuration});

  NewDetails.fromJson(Map<String, dynamic> json) {
    primaryEventCode = (json['primaryEventCode']??"").toString();
    recordnumber = (json['recordnumber']??"").toString();
    sponsorTypeCode = json['sponsorTypeCode'];
    sponsorTypeName = json['sponsorTypeName'];
    programCode = json['programCode'];
    programName = json['programName'];
    programCategoryCode = json['programCategoryCode'];
    starttime = json['starttime'];
    endTime = json['endTime'];
    seconds = (json['seconds']??"").toString();
    rate = (json['rate']??"").toString();
    amount = (json['amount']??"").toString();
    valuationRate = (json['valuationRate']??"").toString();
    bookedSeconds = (json['bookedSeconds']??"").toString();
    balanceSeconds = (json['balanceSeconds']??"").toString();
    balanceAmount = (json['balanceAmount']??"").toString();
    bandCode = json['bandCode'];
    timeBand = json['timeBand'];
    netCode = (json['netCode']??"").toString();
    netWorkName = json['netWorkName'];
    sun = (json['sun']??"").toString();
    mon = (json['mon']??"").toString();
    tue = (json['tue']??"").toString();
    wed = (json['wed']??"").toString();
    thu = (json['thu']??"").toString();
    fri = (json['fri']??"").toString();
    sat = (json['sat']??"").toString();
    revflag = (json['revflag']??"").toString();
    accountCode = json['accountCode'];
    accountname = json['accountname'];
    eventcode = (json['eventcode']??"").toString();
    eventname = json['eventname'];
    spots = (json['spots']??"").toString();
    paymentmodecaption = json['paymentmodecaption'];
    revenueTypeName = json['revenueTypeName'];
    revenueTypeCode = json['revenueTypeCode'];
    subRevenueTypeName = json['subRevenueTypeName'];
    subRevenueTypeCode = (json['subRevenueTypeCode']??"").toString();
    countBased = (json['countBased']??"").toString();
    baseDuration = (json['baseDuration']??"").toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primaryEventCode'] = this.primaryEventCode;
    data['recordnumber'] = this.recordnumber;
    data['sponsorTypeCode'] = this.sponsorTypeCode;
    data['sponsorTypeName'] = this.sponsorTypeName;
    data['programCode'] = this.programCode;
    data['programName'] = this.programName;
    data['programCategoryCode'] = this.programCategoryCode;
    data['starttime'] = this.starttime;
    data['endTime'] = this.endTime;
    data['seconds'] = this.seconds;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['valuationRate'] = this.valuationRate;
    data['bookedSeconds'] = this.bookedSeconds;
    data['balanceSeconds'] = this.balanceSeconds;
    data['balanceAmount'] = this.balanceAmount;
    data['bandCode'] = this.bandCode;
    data['timeBand'] = this.timeBand;
    data['netCode'] = this.netCode;
    data['netWorkName'] = this.netWorkName;
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
    data['spots'] = this.spots;
    data['paymentmodecaption'] = this.paymentmodecaption;
    data['revenueTypeName'] = this.revenueTypeName;
    data['revenueTypeCode'] = this.revenueTypeCode;
    data['subRevenueTypeName'] = this.subRevenueTypeName;
    data['subRevenueTypeCode'] = this.subRevenueTypeCode;
    data['countBased'] = this.countBased;
    data['baseDuration'] = this.baseDuration;
    return data;
  }
}

class Retrieve {
  String? locationcode;
  String? channelCode;
  String? dealNumber;
  String? dealDate;
  String? referenceNumber;
  String? referenceDate;
  String? clientcode;
  String? agencyCode;
  String? agencyName;
  String? brandCode;
  String? currencytypecode;
  int? seconds;
  int? dealAmount;
  String? fromDate;
  String? todate;
  int? secondused;
  int? bookedamount;
  String? groupCode;
  String? paymentmodecode;
  int? maxspend;
  String? modifiedon;
  String? modifiedby;
  String? dealTypeCode;
  int? effectiveRateYN;
  String? agencyshortname;
  String? gstNumber;
  dynamic approvalStatus;

  Retrieve(
      {this.locationcode,
        this.channelCode,
        this.dealNumber,
        this.dealDate,
        this.referenceNumber,
        this.referenceDate,
        this.clientcode,
        this.agencyCode,
        this.agencyName,
        this.brandCode,
        this.currencytypecode,
        this.seconds,
        this.dealAmount,
        this.fromDate,
        this.todate,
        this.secondused,
        this.bookedamount,
        this.groupCode,
        this.paymentmodecode,
        this.maxspend,
        this.modifiedon,
        this.modifiedby,
        this.dealTypeCode,
        this.effectiveRateYN,
        this.agencyshortname,
        this.gstNumber,
        this.approvalStatus});

  Retrieve.fromJson(Map<String, dynamic> json) {
    locationcode = json['locationcode'];
    channelCode = json['channelCode'];
    dealNumber = json['dealNumber'];
    dealDate = json['dealDate'];
    referenceNumber = json['referenceNumber'];
    referenceDate = json['referenceDate'];
    clientcode = json['clientcode'];
    agencyCode = json['agencyCode'];
    agencyName = json['agencyName'];
    brandCode = json['brandCode'];
    currencytypecode = json['currencytypecode'];
    seconds = json['seconds'];
    dealAmount = json['dealAmount'];
    fromDate = json['fromDate'];
    todate = json['todate'];
    secondused = json['secondused'];
    bookedamount = json['bookedamount'];
    groupCode = json['groupCode'];
    paymentmodecode = json['paymentmodecode'];
    maxspend = json['maxspend'];
    modifiedon = json['modifiedon'];
    modifiedby = json['modifiedby'];
    dealTypeCode = json['dealTypeCode'];
    effectiveRateYN = json['effectiveRate_YN'];
    agencyshortname = json['agencyshortname'];
    gstNumber = json['gstNumber'];
    approvalStatus = json['approvalStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationcode'] = this.locationcode;
    data['channelCode'] = this.channelCode;
    data['dealNumber'] = this.dealNumber;
    data['dealDate'] = this.dealDate;
    data['referenceNumber'] = this.referenceNumber;
    data['referenceDate'] = this.referenceDate;
    data['clientcode'] = this.clientcode;
    data['agencyCode'] = this.agencyCode;
    data['agencyName'] = this.agencyName;
    data['brandCode'] = this.brandCode;
    data['currencytypecode'] = this.currencytypecode;
    data['seconds'] = this.seconds;
    data['dealAmount'] = this.dealAmount;
    data['fromDate'] = this.fromDate;
    data['todate'] = this.todate;
    data['secondused'] = this.secondused;
    data['bookedamount'] = this.bookedamount;
    data['groupCode'] = this.groupCode;
    data['paymentmodecode'] = this.paymentmodecode;
    data['maxspend'] = this.maxspend;
    data['modifiedon'] = this.modifiedon;
    data['modifiedby'] = this.modifiedby;
    data['dealTypeCode'] = this.dealTypeCode;
    data['effectiveRate_YN'] = this.effectiveRateYN;
    data['agencyshortname'] = this.agencyshortname;
    data['gstNumber'] = this.gstNumber;
    data['approvalStatus'] = this.approvalStatus;
    return data;
  }
}

class AddInfo {
  String? infoname;
  dynamic infovalue;
  int? isrequired;
  String? allowedvalues;
  String? selectIndex;
  List<String>? lstData = [];

  AddInfo({this.infoname, this.infovalue, this.isrequired, this.allowedvalues,this.lstData,this.selectIndex});

  AddInfo.fromJson(Map<String, dynamic> json) {
    infoname = json['infoname'];
    infovalue = json['infovalue'];
    isrequired = json['isrequired'];
    allowedvalues = json['allowedvalues'];
    selectIndex = json['selectIndex']??"0";
    lstData = getListOfData(json['allowedvalues']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infoname'] = this.infoname;
    data['infovalue'] = getInfoValue(infovalue);
    data['isrequired'] = this.isrequired;
    data['allowedvalues'] = this.allowedvalues;
    data['lstData'] = this.lstData;
    data['selectIndex'] = this.selectIndex;

    return data;
  }

  getInfoValue(String? infoValue ){
    if(infoValue == null){
      String ? data = lstData?[int.parse(selectIndex??"0")];
      return data;
    }else{
      return infoValue;
    }
  }


  List<String> getListOfData(String? txt){
    if(txt != null && txt != ""){
      List<String> data = txt.split("~").toList();
      return data;
    }else {
      return [""];
    }
  }

}
