import '../../../providers/Utils.dart';

class CancellationRetrieveModel {
  InfoCancellationBookingList? infoCancellationBookingList;

  CancellationRetrieveModel({this.infoCancellationBookingList});

  CancellationRetrieveModel.fromJson(Map<String, dynamic> json) {
    infoCancellationBookingList = json['infoCancellationBookingList'] != null
        ? new InfoCancellationBookingList.fromJson(
        json['infoCancellationBookingList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.infoCancellationBookingList != null) {
      data['infoCancellationBookingList'] =
          this.infoCancellationBookingList!.toJson();
    }
    return data;
  }
}

class InfoCancellationBookingList {
  String? locationCode;
  List<LstLocation>? lstLocation;
  String? channelCode;
  List<LstChannel>? lstChannel;
  String? clientCode;
  String? cancelMonth;
  String? cancelNumber;
  String? dealNumber;
  String? agencyCode;
  String? brandCode;
  String? zoneName;
  String? payroute;
  String? personnelCode;
  String? referenceNumber;
  String? referenceDate;
  String? bookingNumber;
  String? payMode;
  CanDisplayDetails? canDisplayDetails;

  InfoCancellationBookingList(
      {this.locationCode,
        this.lstLocation,
        this.channelCode,
        this.lstChannel,
        this.clientCode,
        this.cancelMonth,
        this.cancelNumber,
        this.dealNumber,
        this.agencyCode,
        this.brandCode,
        this.zoneName,
        this.payroute,
        this.personnelCode,
        this.referenceNumber,
        this.referenceDate,
        this.bookingNumber,
        this.payMode,
        this.canDisplayDetails});

  InfoCancellationBookingList.fromJson(Map<String, dynamic> json) {
    locationCode = json['locationCode'];
    if (json['lstLocation'] != null) {
      lstLocation = <LstLocation>[];
      json['lstLocation'].forEach((v) {
        lstLocation!.add(new LstLocation.fromJson(v));
      });
    }
    channelCode = json['channelCode'];
    if (json['lstChannel'] != null) {
      lstChannel = <LstChannel>[];
      json['lstChannel'].forEach((v) {
        lstChannel!.add(new LstChannel.fromJson(v));
      });
    }
    clientCode = json['clientCode'];
    cancelMonth = json['cancelMonth'];
    cancelNumber = json['cancelNumber'];
    dealNumber = json['dealNumber'];
    agencyCode = json['agencyCode'];
    brandCode = json['brandCode'];
    zoneName = json['zoneName'];
    payroute = json['payroute'];
    personnelCode = json['personnelCode'];
    referenceNumber = json['referenceNumber'];
    referenceDate = json['referenceDate'];
    bookingNumber = json['bookingNumber'];
    payMode = json['payMode'];
    canDisplayDetails = json['canDisplayDetails'] != null
        ? new CanDisplayDetails.fromJson(json['canDisplayDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    if (this.lstLocation != null) {
      data['lstLocation'] = this.lstLocation!.map((v) => v.toJson()).toList();
    }
    data['channelCode'] = this.channelCode;
    if (this.lstChannel != null) {
      data['lstChannel'] = this.lstChannel!.map((v) => v.toJson()).toList();
    }
    data['clientCode'] = this.clientCode;
    data['cancelMonth'] = this.cancelMonth;
    data['cancelNumber'] = this.cancelNumber;
    data['dealNumber'] = this.dealNumber;
    data['agencyCode'] = this.agencyCode;
    data['brandCode'] = this.brandCode;
    data['zoneName'] = this.zoneName;
    data['payroute'] = this.payroute;
    data['personnelCode'] = this.personnelCode;
    data['referenceNumber'] = this.referenceNumber;
    data['referenceDate'] = this.referenceDate;
    data['bookingNumber'] = this.bookingNumber;
    data['payMode'] = this.payMode;
    if (this.canDisplayDetails != null) {
      data['canDisplayDetails'] = this.canDisplayDetails!.toJson();
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

class CanDisplayDetails {
  List<LstCancellations>? lstCancellations;
  dynamic allowColumnsEditing;

  CanDisplayDetails({this.lstCancellations, this.allowColumnsEditing});

  CanDisplayDetails.fromJson(Map<String, dynamic> json) {
    if (json['lstCancellations'] != null) {
      lstCancellations = <LstCancellations>[];
      json['lstCancellations'].forEach((v) {
        lstCancellations!.add(new LstCancellations.fromJson(v));
      });
    }
    allowColumnsEditing = json['allowColumnsEditing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstCancellations != null) {
      data['lstCancellations'] =
          this.lstCancellations!.map((v) => v.toJson()).toList();
    }
    data['allowColumnsEditing'] = this.allowColumnsEditing;
    return data;
  }
}

class LstCancellations {
  bool? audited;
  bool? requested;
  String? cancelNumber;
  String? locationCode;
  String? channelCode;
  String? bookingNumber;
  int? bookingDetailCode;
  String? commercialCaption;
  String? exportTapeCode;
  int? tapeDuration;
  String? programName;
  String? scheduleDate;
  String? scheduleTime;
  int? spotAmount;
  String? spotStatus;
  String? bookingStatus;
  String? logged;
  String? telecastProgramCode;
  int? status;
  String? dealno;
  int? recordnumber;
  String? auditedBy;
  String? auditedOn;
  int? editable;

  LstCancellations(
      {this.audited,
        this.requested,
        this.cancelNumber,
        this.locationCode,
        this.channelCode,
        this.bookingNumber,
        this.bookingDetailCode,
        this.commercialCaption,
        this.exportTapeCode,
        this.tapeDuration,
        this.programName,
        this.scheduleDate,
        this.scheduleTime,
        this.spotAmount,
        this.spotStatus,
        this.bookingStatus,
        this.logged,
        this.telecastProgramCode,
        this.status,
        this.dealno,
        this.recordnumber,
        this.auditedBy,
        this.auditedOn,
        this.editable});

  LstCancellations.fromJson(Map<String, dynamic> json) {
    audited = json['audited'];
    requested = json['requested'];
    cancelNumber = json['cancelNumber'];
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    bookingNumber = json['bookingNumber'];
    bookingDetailCode = json['bookingDetailCode'];
    commercialCaption = json['commercialCaption'];
    exportTapeCode = json['exportTapeCode'];
    tapeDuration = json['tapeDuration'];
    programName = json['programName'];
    scheduleDate = json['scheduleDate'];
    scheduleTime = json['scheduleTime'];
    spotAmount = json['spotAmount'];
    spotStatus = json['spotStatus'];
    bookingStatus = json['bookingStatus'];
    logged = json['logged'];
    telecastProgramCode = json['telecastProgramCode'];
    status = json['status'];
    dealno = json['dealno'];
    recordnumber = json['recordnumber'];
    auditedBy = json['auditedBy'];
    auditedOn = json['auditedOn'];
    editable = json['editable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audited'] = this.audited;
    data['requested'] = this.requested;
    data['cancelNumber'] = this.cancelNumber;
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['bookingNumber'] = this.bookingNumber;
    data['bookingDetailCode'] = this.bookingDetailCode;
    data['commercialCaption'] = this.commercialCaption;
    data['exportTapeCode'] = this.exportTapeCode;
    data['tapeDuration'] = this.tapeDuration;
    data['programName'] = this.programName;
    data['scheduleDate'] = this.scheduleDate;
    data['scheduleTime'] = this.scheduleTime;
    data['spotAmount'] = this.spotAmount;
    data['spotStatus'] = this.spotStatus;
    data['bookingStatus'] = this.bookingStatus;
    data['logged'] = this.logged;
    data['telecastProgramCode'] = this.telecastProgramCode;
    data['status'] = this.status;
    data['dealno'] = this.dealno;
    data['recordnumber'] = this.recordnumber;
    data['auditedBy'] = this.auditedBy;
    data['auditedOn'] = this.auditedOn;
    data['editable'] = this.editable;
    return data;
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audited'] = this.audited;
    data['requested'] = this.requested;
    data['cancelNumber'] = this.cancelNumber;
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['bookingNumber'] = this.bookingNumber;
    data['bookingDetailCode'] = this.bookingDetailCode;
    data['commercialCaption'] = this.commercialCaption;
    data['exportTapeCode'] = this.exportTapeCode;
    data['tapeDuration'] = this.tapeDuration;
    data['programName'] = this.programName;
    data['scheduleDate'] = Utils.toDateFormat9(this.scheduleDate);
    data['scheduleTime'] = this.scheduleTime;
    data['spotAmount'] = this.spotAmount;
    data['spotStatus'] = this.spotStatus;
    data['bookingStatus'] = this.bookingStatus;
    data['logged'] = this.logged;
    data['telecastProgramCode'] = this.telecastProgramCode;
    data['status'] = this.status;
    data['dealno'] = this.dealno;
    data['recordnumber'] = this.recordnumber;
    data['auditedBy'] = this.auditedBy;
    data['auditedOn'] = Utils.toDateFormat11(this.auditedOn);
    data['editable'] = this.editable;
    return data;
  }

}
