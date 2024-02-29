class ReScheduleRetriveDataModel {
  InfoReschduleBookingList? infoReschduleBookingList;

  ReScheduleRetriveDataModel({this.infoReschduleBookingList});

  ReScheduleRetriveDataModel.fromJson(Map<String, dynamic> json) {
    infoReschduleBookingList = json['infoReschduleBookingList'] != null
        ? new InfoReschduleBookingList.fromJson(
        json['infoReschduleBookingList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.infoReschduleBookingList != null) {
      data['infoReschduleBookingList'] =
          this.infoReschduleBookingList!.toJson();
    }
    return data;
  }
}

class InfoReschduleBookingList {
  String? locationCode;
  List<LstLocation>? lstLocation;
  String? channelCode;
  List<LstChannels>? lstChannels;
  String? effectiveDate;
  String? reschduleDate;
  String? referenceNumber;
  String? bookingNumber;
  String? referenceDate;
  String? rescheduleMonth;
  String? rescheduleNumber;
  String? clientcode;
  String? dealNumber;
  String? agencyCode;
  String? brandCode;
  ReschduleDisplay? reschduleDisplay;

  InfoReschduleBookingList(
      {this.locationCode,
        this.lstLocation,
        this.channelCode,
        this.lstChannels,
        this.effectiveDate,
        this.reschduleDate,
        this.referenceNumber,
        this.bookingNumber,
        this.referenceDate,
        this.rescheduleMonth,
        this.rescheduleNumber,
        this.clientcode,
        this.dealNumber,
        this.agencyCode,
        this.brandCode,
        this.reschduleDisplay});

  InfoReschduleBookingList.fromJson(Map<String, dynamic> json) {
    locationCode = json['locationCode'];
    if (json['lstLocation'] != null) {
      lstLocation = <LstLocation>[];
      json['lstLocation'].forEach((v) {
        lstLocation!.add(new LstLocation.fromJson(v));
      });
    }
    channelCode = json['channelCode'];
    if (json['lstChannels'] != null) {
      lstChannels = <LstChannels>[];
      json['lstChannels'].forEach((v) {
        lstChannels!.add(new LstChannels.fromJson(v));
      });
    }
    effectiveDate = json['effectiveDate'];
    reschduleDate = json['reschduleDate'];
    referenceNumber = json['referenceNumber'];
    bookingNumber = json['bookingNumber'];
    referenceDate = json['referenceDate'];
    rescheduleMonth = json['rescheduleMonth'];
    rescheduleNumber = json['rescheduleNumber'];
    clientcode = json['clientcode'];
    dealNumber = json['dealNumber'];
    agencyCode = json['agencyCode'];
    brandCode = json['brandCode'];
    reschduleDisplay = json['reschduleDisplay'] != null
        ? new ReschduleDisplay.fromJson(json['reschduleDisplay'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    if (this.lstLocation != null) {
      data['lstLocation'] = this.lstLocation!.map((v) => v.toJson()).toList();
    }
    data['channelCode'] = this.channelCode;
    if (this.lstChannels != null) {
      data['lstChannels'] = this.lstChannels!.map((v) => v.toJson()).toList();
    }
    data['effectiveDate'] = this.effectiveDate;
    data['reschduleDate'] = this.reschduleDate;
    data['referenceNumber'] = this.referenceNumber;
    data['bookingNumber'] = this.bookingNumber;
    data['referenceDate'] = this.referenceDate;
    data['rescheduleMonth'] = this.rescheduleMonth;
    data['rescheduleNumber'] = this.rescheduleNumber;
    data['clientcode'] = this.clientcode;
    data['dealNumber'] = this.dealNumber;
    data['agencyCode'] = this.agencyCode;
    data['brandCode'] = this.brandCode;
    if (this.reschduleDisplay != null) {
      data['reschduleDisplay'] = this.reschduleDisplay!.toJson();
    }
    return data;
  }
}

class LstLocation {
  String? locationCode;
  String? locationName;

  LstLocation({this.locationCode, this.locationName});

  LstLocation.fromJson(Map<String, dynamic> json) {
    locationCode = json['locationCode'];
    locationName = json['locationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    data['locationName'] = this.locationName;
    return data;
  }
}

class LstChannels {
  String? channelCode;
  String? channelName;

  LstChannels({this.channelCode, this.channelName});

  LstChannels.fromJson(Map<String, dynamic> json) {
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

class ReschduleDisplay {
  List<Reschdule>? reschdule;
  List<OriginalBookings>? originalBookings;
  List<String>? columnVisiableTrue;
  List<String>? allowColumnEditing;

  ReschduleDisplay(
      {this.reschdule, this.columnVisiableTrue, this.allowColumnEditing,this.originalBookings});

  ReschduleDisplay.fromJson(Map<String, dynamic> json) {
    if (json['reschdule'] != null) {
      reschdule = <Reschdule>[];
      json['reschdule'].forEach((v) {
        reschdule!.add(new Reschdule.fromJson(v));
      });
    }
    if (json['originalBookings'] != null) {
      originalBookings = <OriginalBookings>[];
      json['originalBookings'].forEach((v) {
        originalBookings!.add(new OriginalBookings.fromJson(v));
      });
    }
    columnVisiableTrue = json['columnVisiableTrue'].cast<String>();
    allowColumnEditing = json['allowColumnEditing'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reschdule != null) {
      data['reschdule'] = this.reschdule!.map((v) => v.toJson()).toList();
    }
    if (this.originalBookings != null) {
      data['originalBookings'] =
          this.originalBookings!.map((v) => v.toJson()).toList();
    }
    data['columnVisiableTrue'] = this.columnVisiableTrue;
    data['allowColumnEditing'] = this.allowColumnEditing;
    return data;
  }
}

class Reschdule {
  bool? auditStatus;
  String? rescheduleNo;
  int? audited;
  int? rowNumber;
  String? scheduleDate;
  String? programName;
  String? startTime;
  String? endTime;
  String? tapeCode;
  int? segmentNumber;
  String? commercialCaption;
  int? tapeDuration;
  int? spotAmount;
  int? totalspots;
  String? dealNo;
  int? dealRowNumber;
  int? bookingDetailCode;
  String? spotPositionTypeName;
  String? positionName;
  int? breakNumber;
  String? auditedby;
  String? auditedon;
  String? midPre;
  String? positionCode;
  String? locationCode;
  String? channelCode;
  String? bookingNumber;
  String? commercialCode;
  String? programcode;

  Reschdule(
      {this.auditStatus,
        this.rescheduleNo,
        this.audited,
        this.rowNumber,
        this.scheduleDate,
        this.programName,
        this.startTime,
        this.endTime,
        this.tapeCode,
        this.segmentNumber,
        this.commercialCaption,
        this.tapeDuration,
        this.spotAmount,
        this.totalspots,
        this.dealNo,
        this.dealRowNumber,
        this.bookingDetailCode,
        this.spotPositionTypeName,
        this.positionName,
        this.breakNumber,
        this.auditedby,
        this.auditedon,
        this.midPre,
        this.positionCode,
        this.locationCode,
        this.channelCode,
        this.bookingNumber,
        this.commercialCode,
        this.programcode});

  Reschdule.fromJson(Map<String, dynamic> json) {
    auditStatus = json['auditStatus'];
    rescheduleNo = json['rescheduleNo'];
    audited = json['audited'];
    rowNumber = json['rowNumber'];
    scheduleDate = json['scheduleDate'];
    programName = json['programName'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    tapeCode = json['tapeCode'];
    segmentNumber = json['segmentNumber'];
    commercialCaption = json['commercialCaption'];
    tapeDuration = json['tapeDuration'];
    spotAmount = json['spotAmount'];
    totalspots = json['totalspots'];
    dealNo = json['dealNo'];
    dealRowNumber = json['dealRowNumber'];
    bookingDetailCode = json['bookingDetailCode'];
    spotPositionTypeName = json['spotPositionTypeName'];
    positionName = json['positionName'];
    breakNumber = json['breakNumber'];
    auditedby = json['auditedby'];
    auditedon = json['auditedon'];
    midPre = json['midPre'];
    positionCode = json['positionCode'];
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    bookingNumber = json['bookingNumber'];
    commercialCode = json['commercialCode'];
    programcode = json['programcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auditStatus'] = this.auditStatus;
    data['rescheduleNo'] = this.rescheduleNo;
    data['audited'] = this.audited;
    data['rowNumber'] = this.rowNumber;
    data['scheduleDate'] = this.scheduleDate;
    data['programName'] = this.programName;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['tapeCode'] = this.tapeCode;
    data['segmentNumber'] = this.segmentNumber;
    data['commercialCaption'] = this.commercialCaption;
    data['tapeDuration'] = this.tapeDuration;
    data['spotAmount'] = this.spotAmount;
    data['totalspots'] = this.totalspots;
    data['dealNo'] = this.dealNo;
    data['dealRowNumber'] = this.dealRowNumber;
    data['bookingDetailCode'] = this.bookingDetailCode;
    data['spotPositionTypeName'] = this.spotPositionTypeName;
    data['positionName'] = this.positionName;
    data['breakNumber'] = this.breakNumber;
    data['auditedby'] = this.auditedby;
    data['auditedon'] = this.auditedon;
    data['midPre'] = this.midPre;
    data['positionCode'] = this.positionCode;
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['bookingNumber'] = this.bookingNumber;
    data['commercialCode'] = this.commercialCode;
    data['programcode'] = this.programcode;
    return data;
  }
}


class OriginalBookings {
  String? scheduleDate;
  String? programName;
  String? startTime;
  String? tapeCode;
  String? commercialCaption;
  int? tapeDuration;
  String? bookingNumber;
  int? bookingDetailCode;

  OriginalBookings(
      {this.scheduleDate,
        this.programName,
        this.startTime,
        this.tapeCode,
        this.commercialCaption,
        this.tapeDuration,
        this.bookingNumber,
        this.bookingDetailCode});

  OriginalBookings.fromJson(Map<String, dynamic> json) {
    scheduleDate = json['scheduleDate'];
    programName = json['programName'];
    startTime = json['startTime'];
    tapeCode = json['tapeCode'];
    commercialCaption = json['commercialCaption'];
    tapeDuration = json['tapeDuration'];
    bookingNumber = json['bookingNumber'];
    bookingDetailCode = json['bookingDetailCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleDate'] = this.scheduleDate;
    data['programName'] = this.programName;
    data['startTime'] = this.startTime;
    data['tapeCode'] = this.tapeCode;
    data['commercialCaption'] = this.commercialCaption;
    data['tapeDuration'] = this.tapeDuration;
    data['bookingNumber'] = this.bookingNumber;
    data['bookingDetailCode'] = this.bookingDetailCode;
    return data;
  }
}