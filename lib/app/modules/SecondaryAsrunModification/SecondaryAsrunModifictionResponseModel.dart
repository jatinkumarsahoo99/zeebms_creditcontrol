class SecondaryAsrunModifictionResponseModel {
  PostSave? postSave;

  SecondaryAsrunModifictionResponseModel({this.postSave});

  SecondaryAsrunModifictionResponseModel.fromJson(Map<String, dynamic> json) {
    postSave = json['postSave'] != null
        ? new PostSave.fromJson(json['postSave'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.postSave != null) {
      data['postSave'] = this.postSave!.toJson();
    }
    return data;
  }
}

class PostSave {
  List<DgvAsRunModification>? dgvAsRunModification;
  List<DgvTelecasted>? dgvTelecasted;
  String? message;

  PostSave({this.dgvAsRunModification, this.dgvTelecasted, this.message});

  PostSave.fromJson(Map<String, dynamic> json) {
    if (json['dgvAsRunModification'] != null) {
      dgvAsRunModification = <DgvAsRunModification>[];
      json['dgvAsRunModification'].forEach((v) {
        dgvAsRunModification!.add(new DgvAsRunModification.fromJson(v));
      });
    }
    if (json['dgvTelecasted'] != null) {
      dgvTelecasted = <DgvTelecasted>[];
      json['dgvTelecasted'].forEach((v) {
        dgvTelecasted!.add(new DgvTelecasted.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dgvAsRunModification != null) {
      data['dgvAsRunModification'] =
          this.dgvAsRunModification!.map((v) => v.toJson()).toList();
    }
    if (this.dgvTelecasted != null) {
      data['dgvTelecasted'] =
          this.dgvTelecasted!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class DgvAsRunModification {
  String? bookingNumber;
  String? tapeID;
  int? tapeDuration;
  String? programName;
  String? spotStatus;
  int? telecastDuration;
  String? scheduleTime;
  String? telecastTime;
  String? rosTimeBand;
  String? spotAmount;
  int? bookingdetailcode;
  String? clientName;
  String? agencyName;
  String? brandName;
  String? caption;
  String? miDPre;
  String? billnumber;
  String? status;
  String? remarks;
  String? clearBy;
  String? clearBySys;
  String? spotPositionShortName;
  String? telecastProgramcode;
  String? telprogname;
  String? telpos;
  int? bookingDetailCode1;
  String? dealno;
  String? packagecode;
  int? recordnumber;
  String? modifyStatus;
  String? locationCode;
  String? channelCode;
  String? telecastMidPre;
  String? accountName;
  String? accountCode;
  String? bookedProgramCode;

  DgvAsRunModification(
      {this.bookingNumber,
        this.tapeID,
        this.tapeDuration,
        this.programName,
        this.spotStatus,
        this.telecastDuration,
        this.scheduleTime,
        this.telecastTime,
        this.rosTimeBand,
        this.spotAmount,
        this.bookingdetailcode,
        this.clientName,
        this.agencyName,
        this.brandName,
        this.caption,
        this.miDPre,
        this.billnumber,
        this.status,
        this.remarks,
        this.clearBy,
        this.clearBySys,
        this.spotPositionShortName,
        this.telecastProgramcode,
        this.telprogname,
        this.telpos,
        this.bookingDetailCode1,
        this.dealno,
        this.packagecode,
        this.recordnumber,
        this.modifyStatus,
        this.locationCode,
        this.channelCode,
        this.telecastMidPre,
        this.accountName,
        this.accountCode,
        this.bookedProgramCode});

  DgvAsRunModification.fromJson(Map<String, dynamic> json) {
    bookingNumber = json['bookingNumber'];
    tapeID = json['tapeID'];
    tapeDuration = json['tapeDuration'];
    programName = json['programName'];
    spotStatus = json['spotStatus'];
    telecastDuration = json['telecastDuration'];
    scheduleTime = json['scheduleTime'];
    telecastTime = json['telecastTime'];
    rosTimeBand = json['rosTimeBand'];
    spotAmount = json['SpotAmount'];
    bookingdetailcode = json['bookingdetailcode'];
    clientName = json['clientName'];
    agencyName = json['agencyName'];
    brandName = json['brandName'];
    caption = json['caption'];
    miDPre = json['midPre'];
    billnumber = json['billnumber'];
    status = json['status'];
    remarks = json['remarks'];
    clearBy = json['clearBy'];
    clearBySys = json['clearBySys'];
    spotPositionShortName = json['spotPositionShortName'];
    telecastProgramcode = json['telecastProgramcode'];
    telprogname = json['telprogname'];
    telpos = json['telpos'];
    bookingDetailCode1 = json['bookingDetailCode1'];
    dealno = json['dealno'];
    packagecode = json['packagecode'];
    recordnumber = json['recordnumber'];
    modifyStatus = json['modifyStatus'];
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    telecastMidPre = json['telecastMidPre'];
    accountName = json['accountName'];
    accountCode = json['accountCode'];
    bookedProgramCode = json['bookedProgramCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingNumber'] = this.bookingNumber;
    data['tapeID'] = this.tapeID;
    data['tapeDuration'] = this.tapeDuration;
    data['programName'] = this.programName;
    data['spotStatus'] = this.spotStatus;
    data['telecastDuration'] = this.telecastDuration;
    data['scheduleTime'] = this.scheduleTime;
    data['telecastTime'] = this.telecastTime;
    data['rosTimeBand'] = this.rosTimeBand;
    data['SpotAmount'] = this.spotAmount;
    data['bookingdetailcode'] = this.bookingdetailcode;
    data['clientName'] = this.clientName;
    data['agencyName'] = this.agencyName;
    data['brandName'] = this.brandName;
    data['caption'] = this.caption;
    data['midPre'] = this.miDPre;
    data['billnumber'] = this.billnumber;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['clearBy'] = this.clearBy;
    data['clearBySys'] = this.clearBySys;
    data['spotPositionShortName'] = this.spotPositionShortName;
    data['telecastProgramcode'] = this.telecastProgramcode;
    data['telprogname'] = this.telprogname;
    data['telpos'] = this.telpos;
    data['bookingDetailCode1'] = this.bookingDetailCode1;
    data['dealno'] = this.dealno;
    data['packagecode'] = this.packagecode;
    data['recordnumber'] = this.recordnumber;
    data['modifyStatus'] = this.modifyStatus;
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['telecastMidPre'] = this.telecastMidPre;
    data['accountName'] = this.accountName;
    data['accountCode'] = this.accountCode;
    data['bookedProgramCode'] = this.bookedProgramCode;
    return data;
  }
}

class DgvTelecasted {
  String? exportTapeCode;
  String? exportTapeCaption;
  String? tapeDuration;
  String? programname;
  String? telecastTime;
  String? spotStatus;
  String? spotPosition;
  String? segmentNumber;
  String? programCode;

  DgvTelecasted(
      {this.exportTapeCode,
        this.exportTapeCaption,
        this.tapeDuration,
        this.programname,
        this.telecastTime,
        this.spotStatus,
        this.spotPosition,
        this.segmentNumber,
        this.programCode});

  DgvTelecasted.fromJson(Map<String, dynamic> json) {
    exportTapeCode = json['exportTapeCode'];
    exportTapeCaption = json['exportTapeCaption'];
    tapeDuration = (json['tapeDuration']??"0").toString();
    programname = json['programname'];
    telecastTime = json['telecastTime'];
    spotStatus = json['spotStatus'];
    spotPosition = json['spotPosition'];
    segmentNumber = json['segmentNumber'];
    programCode = json['programCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exportTapeCode'] = this.exportTapeCode;
    data['exportTapeCaption'] = this.exportTapeCaption;
    data['tapeDuration'] = this.tapeDuration;
    data['programname'] = this.programname;
    data['telecastTime'] = this.telecastTime;
    data['spotStatus'] = this.spotStatus;
    data['spotPosition'] = this.spotPosition;
    data['segmentNumber'] = this.segmentNumber;
    data['programCode'] = this.programCode;
    return data;
  }
}
