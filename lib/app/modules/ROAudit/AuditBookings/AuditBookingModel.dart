class AuditBookingModel {
  InfoShowBookingList? infoShowBookingList;

  AuditBookingModel({this.infoShowBookingList});

  AuditBookingModel.fromJson(Map<String, dynamic> json) {
    infoShowBookingList = json['infoShowBookingList'] != null
        ? new InfoShowBookingList.fromJson(json['infoShowBookingList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.infoShowBookingList != null) {
      data['infoShowBookingList'] = this.infoShowBookingList!.toJson();
    }
    return data;
  }
}

class InfoShowBookingList {
  String? locationCode;
  String? channelCode;
  List<LstChannel>? lstChannel;
  String? clientCode;
  String? bookingMonth;
  String? bookingNumber;
  String? remarks;
  String? agencyCode;
  String? brandCode;
  String? zoneName;
  String? payRouteName;
  String? personnelCode;
  String? bookingRefNumber;
  String? bookingRefDate;
  String? payMode;
  String? pdcInfo;
  String? remark;
  String? isPdcEnterd;
  DisplayDetails? displayDetails;
  DislpayDealDetails? dislpayDealDetails;
  DisplayBookingStatus? displayBookingStatus;
  String? sGetCurrentSQLDate;
  String? sGetCurrentSQLTime;

  InfoShowBookingList(
      {this.locationCode,
        this.channelCode,
        this.lstChannel,
        this.clientCode,
        this.bookingMonth,
        this.bookingNumber,
        this.remarks,
        this.agencyCode,
        this.brandCode,
        this.zoneName,
        this.payRouteName,
        this.personnelCode,
        this.bookingRefNumber,
        this.bookingRefDate,
        this.payMode,
        this.pdcInfo,
        this.remark,
        this.displayDetails,
        this.dislpayDealDetails,
        this.displayBookingStatus,
        this.sGetCurrentSQLDate,
        this.isPdcEnterd,
        this.sGetCurrentSQLTime});

  InfoShowBookingList.fromJson(Map<String, dynamic> json) {
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    if (json['lstChannel'] != null) {
      lstChannel = <LstChannel>[];
      json['lstChannel'].forEach((v) {
        lstChannel!.add(new LstChannel.fromJson(v));
      });
    }
    clientCode = json['clientCode'];
    isPdcEnterd = (json['isPdcEnterd']??"").toString();
    bookingMonth = json['bookingMonth'];
    bookingNumber = json['bookingNumber'];
    remarks = json['remarks'];
    agencyCode = json['agencyCode'];
    brandCode = json['brandCode'];
    zoneName = json['zoneName'];
    payRouteName = json['payRouteName'];
    personnelCode = json['personnelCode'];
    bookingRefNumber = json['bookingRefNumber'];
    bookingRefDate = json['bookingRefDate'];
    payMode = json['payMode'];
    pdcInfo = json['pdcInfo'];
    remark = json['remark'];
    displayDetails = json['displayDetails'] != null
        ? new DisplayDetails.fromJson(json['displayDetails'])
        : null;
    dislpayDealDetails = json['dislpayDealDetails'] != null
        ? new DislpayDealDetails.fromJson(json['dislpayDealDetails'])
        : null;
    displayBookingStatus = json['displayBookingStatus'] != null
        ? new DisplayBookingStatus.fromJson(json['displayBookingStatus'])
        : null;
    sGetCurrentSQLDate = json['sGetCurrentSQLDate'];
    sGetCurrentSQLTime = json['sGetCurrentSQLTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    if (this.lstChannel != null) {
      data['lstChannel'] = this.lstChannel!.map((v) => v.toJson()).toList();
    }
    data['clientCode'] = this.clientCode;
    data['bookingMonth'] = this.bookingMonth;
    data['bookingNumber'] = this.bookingNumber;
    data['remarks'] = this.remarks;
    data['agencyCode'] = this.agencyCode;
    data['brandCode'] = this.brandCode;
    data['zoneName'] = this.zoneName;
    data['payRouteName'] = this.payRouteName;
    data['personnelCode'] = this.personnelCode;
    data['bookingRefNumber'] = this.bookingRefNumber;
    data['bookingRefDate'] = this.bookingRefDate;
    data['payMode'] = this.payMode;
    data['pdcInfo'] = this.pdcInfo;
    data['remark'] = this.remark;
    data['isPdcEnterd'] = this.isPdcEnterd;
    if (this.displayDetails != null) {
      data['displayDetails'] = this.displayDetails!.toJson();
    }
    if (this.dislpayDealDetails != null) {
      data['dislpayDealDetails'] = this.dislpayDealDetails!.toJson();
    }
    if (this.displayBookingStatus != null) {
      data['displayBookingStatus'] = this.displayBookingStatus!.toJson();
    }
    data['sGetCurrentSQLDate'] = this.sGetCurrentSQLDate;
    data['sGetCurrentSQLTime'] = this.sGetCurrentSQLTime;
    return data;
  }
}

class LstChannel {
  String? channelCode;
  String? channelName;

  LstChannel({this.channelCode, this.channelName});

  LstChannel.fromJson(Map<String, dynamic> json) {
    channelCode = json['channelCode'];
    channelName = json['channelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelCode'] = this.channelCode;
    data['channelName'] = this.channelName;
    return data;
  }
}

class DisplayDetails {
  List<LstSpot>? lstSpot;
  List<String>? columnVisiableTrue;
  String? allowColumnEditing;

  DisplayDetails(
      {this.lstSpot, this.columnVisiableTrue, this.allowColumnEditing});

  DisplayDetails.fromJson(Map<String, dynamic> json) {
    if (json['lstSpot'] != null) {
      lstSpot = <LstSpot>[];
      json['lstSpot'].forEach((v) {
        lstSpot!.add(new LstSpot.fromJson(v));
      });
    }
    columnVisiableTrue = json['columnVisiableTrue'].cast<String>();
    allowColumnEditing = json['allowColumnEditing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstSpot != null) {
      data['lstSpot'] = this.lstSpot!.map((v) => v.toJson()).toList();
    }
    data['columnVisiableTrue'] = this.columnVisiableTrue;
    data['allowColumnEditing'] = this.allowColumnEditing;
    return data;
  }
}

class LstSpot {
  bool? audited;
  int? rowNumber;
  String? scheduleDate;
  String? start;
  String? endTime;
  String? programname;
  String? tapeid;
  String? commercialcaption;
  int? commercialduration;
  int? spotamount;
  String? dealNumber;
  int? dealrownumber;
  int? totalspots;
  int? auditedSpots;
  String? tONumber;
  String? auditedBy;
  String? auditedOn;

  LstSpot(
      {this.audited,
        this.rowNumber,
        this.scheduleDate,
        this.start,
        this.endTime,
        this.programname,
        this.tapeid,
        this.commercialcaption,
        this.commercialduration,
        this.spotamount,
        this.dealNumber,
        this.dealrownumber,
        this.totalspots,
        this.auditedSpots,
        this.tONumber,
        this.auditedBy,
        this.auditedOn});

  LstSpot.fromJson(Map<String, dynamic> json) {
    audited = json['audited'];
    rowNumber = json['rowNumber'];
    scheduleDate = json['scheduleDate'];
    start = json['start'];
    endTime = json['endTime'];
    programname = json['programname'];
    tapeid = json['tapeid'];
    commercialcaption = json['commercialcaption'];
    commercialduration = json['commercialduration'];
    spotamount = json['spotamount'];
    dealNumber = json['deal_Number'];
    dealrownumber = json['dealrownumber'];
    totalspots = json['totalspots'];
    auditedSpots = json['auditedSpots'];
    tONumber = json['tO_Number'];
    auditedBy = json['auditedBy'];
    auditedOn = json['auditedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audited'] = this.audited??false;
    data['rowNumber'] = this.rowNumber??"";
    data['scheduleDate'] = this.scheduleDate??"";
    data['start'] = this.start??"";
    data['endTime'] = this.endTime??"";
    data['programname'] = this.programname??"";
    data['tapeid'] = this.tapeid??"";
    data['commercialcaption'] = this.commercialcaption??"";
    data['commercialduration'] = this.commercialduration??"";
    data['spotamount'] = this.spotamount??"";
    data['deal_Number'] = this.dealNumber??"";
    data['dealrownumber'] = this.dealrownumber??"";
    data['totalspots'] = this.totalspots??"";
    data['auditedSpots'] = this.auditedSpots??"";
    data['tO_Number'] = this.tONumber??"";
    data['auditedBy'] = this.auditedBy??"";
    data['auditedOn'] = this.auditedOn??"";
    return data;
  }
}

class DislpayDealDetails {
  bool? chkDealNegativeBalance;
  int? bookedAmount;
  int? bookedValue;
  bool? chkValuation;
  bool? chkMaxSpendcheck;
  String? dealMaxSpend;
  bool? chkClientEmbargo;
  bool? chkAgencyEmbargo;
  bool? chkCommDurMismatch;

  DislpayDealDetails(
      {this.chkDealNegativeBalance,
        this.bookedAmount,
        this.bookedValue,
        this.chkValuation,
        this.chkMaxSpendcheck,
        this.dealMaxSpend,
        this.chkClientEmbargo,
        this.chkAgencyEmbargo,
        this.chkCommDurMismatch});

  DislpayDealDetails.fromJson(Map<String, dynamic> json) {
    chkDealNegativeBalance = json['chkDealNegativeBalance'];
    bookedAmount = json['bookedAmount'];
    bookedValue = json['bookedValue'];
    chkValuation = json['chkValuation'];
    chkMaxSpendcheck = json['chkMaxSpendcheck'];
    dealMaxSpend = json['dealMaxSpend'];
    chkClientEmbargo = json['chkClientEmbargo'];
    chkAgencyEmbargo = json['chkAgencyEmbargo'];
    chkCommDurMismatch = json['chkCommDurMismatch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chkDealNegativeBalance'] = this.chkDealNegativeBalance;
    data['bookedAmount'] = this.bookedAmount;
    data['bookedValue'] = this.bookedValue;
    data['chkValuation'] = this.chkValuation;
    data['chkMaxSpendcheck'] = this.chkMaxSpendcheck;
    data['dealMaxSpend'] = this.dealMaxSpend;
    data['chkClientEmbargo'] = this.chkClientEmbargo;
    data['chkAgencyEmbargo'] = this.chkAgencyEmbargo;
    data['chkCommDurMismatch'] = this.chkCommDurMismatch;
    return data;
  }
}

class DisplayBookingStatus {
  List<LstBookingDetails>? lstBookingDetails;

  DisplayBookingStatus({this.lstBookingDetails});

  DisplayBookingStatus.fromJson(Map<String, dynamic> json) {
    if (json['lstBookingDetails'] != null) {
      lstBookingDetails = <LstBookingDetails>[];
      json['lstBookingDetails'].forEach((v) {
        lstBookingDetails!.add(new LstBookingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstBookingDetails != null) {
      data['lstBookingDetails'] =
          this.lstBookingDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstBookingDetails {
  String? status;
  String? bookingNumber;
  int? bookingDetailCode;
  String? scheduleDate;
  String? scheduleTime;
  String? programname;
  String? commercialCaption;
  String? exportTapeCode;
  int? tapeDuration;
  int? spotAmount;
  String? packagecode;
  String? bookingStatus;

  LstBookingDetails(
      {this.status,
        this.bookingNumber,
        this.bookingDetailCode,
        this.scheduleDate,
        this.scheduleTime,
        this.programname,
        this.commercialCaption,
        this.exportTapeCode,
        this.tapeDuration,
        this.spotAmount,
        this.packagecode,
        this.bookingStatus});

  LstBookingDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bookingNumber = json['bookingNumber'];
    bookingDetailCode = json['bookingDetailCode'];
    scheduleDate = json['scheduleDate'];
    scheduleTime = json['scheduleTime'];
    programname = json['programname'];
    commercialCaption = json['commercialCaption'];
    exportTapeCode = json['exportTapeCode'];
    tapeDuration = json['tapeDuration'];
    spotAmount = json['spotAmount'];
    packagecode = json['packagecode'];
    bookingStatus = json['bookingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['bookingNumber'] = this.bookingNumber;
    data['bookingDetailCode'] = this.bookingDetailCode;
    data['scheduleDate'] = this.scheduleDate;
    data['scheduleTime'] = this.scheduleTime;
    data['programname'] = this.programname;
    data['commercialCaption'] = this.commercialCaption;
    data['exportTapeCode'] = this.exportTapeCode;
    data['tapeDuration'] = this.tapeDuration;
    data['spotAmount'] = this.spotAmount;
    data['packagecode'] = this.packagecode;
    data['bookingStatus'] = this.bookingStatus;
    return data;
  }
}
