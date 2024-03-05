class SecondaryAsrunGridModel {
  BindGrid? bindGrid;

  SecondaryAsrunGridModel({this.bindGrid});

  SecondaryAsrunGridModel.fromJson(Map<String, dynamic> json) {
    bindGrid = json['bindGrid'] != null
        ? new BindGrid.fromJson(json['bindGrid'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bindGrid != null) {
      data['bindGrid'] = this.bindGrid!.toJson();
    }
    return data;
  }
}

class BindGrid {
  List<Lstbookingdetail>? lstbookingdetail;
  List<LstAsRunBookingDetails>? lstAsRunBookingDetails;
  List<LstFinalAsRun>? lstFinalAsRun;

  BindGrid(
      {
        // this.lstbookingdetail,
        this.lstAsRunBookingDetails, this.lstFinalAsRun});

  BindGrid.fromJson(Map<String, dynamic> json) {

    if (json['lstbookingdetail'] != null) {
      lstbookingdetail = <Lstbookingdetail>[];
      json['lstbookingdetail'].forEach((v) {
        lstbookingdetail!.add(new Lstbookingdetail.fromJson(v));
      });
    }

    if (json['lstAsRunBookingDetails'] != null) {
      lstAsRunBookingDetails = <LstAsRunBookingDetails>[];
      json['lstAsRunBookingDetails'].forEach((v) {
        lstAsRunBookingDetails!.add(new LstAsRunBookingDetails.fromJson(v));
      });
    }

    if (json['lstFinalAsRun'] != null) {
      lstFinalAsRun = <LstFinalAsRun>[];
      json['lstFinalAsRun'].forEach((v) {
        lstFinalAsRun!.add(new LstFinalAsRun.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['lstbookingdetail'] = this.lstbookingdetail;

    if (this.lstbookingdetail != null) {
      data['lstbookingdetail'] =
          this.lstbookingdetail!.map((v) => v.toJson()).toList();
    }

    if (this.lstAsRunBookingDetails != null) {
      data['lstAsRunBookingDetails'] =
          this.lstAsRunBookingDetails!.map((v) => v.toJson()).toList();
    }
    if (this.lstFinalAsRun != null) {
      data['lstFinalAsRun'] =
          this.lstFinalAsRun!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstAsRunBookingDetails {
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

  LstAsRunBookingDetails(
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

  LstAsRunBookingDetails.fromJson(Map<String, dynamic> json) {
    bookingNumber = json['bookingNumber'];
    tapeID = json['tapeID'];
    tapeDuration = json['tapeDuration'];
    programName = json['programName'];
    spotStatus = json['spotStatus'];
    telecastDuration = json['telecastDuration'];
    scheduleTime = json['scheduleTime'];
    telecastTime = json['telecastTime'];
    rosTimeBand = json['rosTimeBand'];
    spotAmount = (json['spotAmount']??"0.00").toString();
    bookingdetailcode = json['bookingdetailcode'];
    clientName = json['clientName'];
    agencyName = json['agencyName'];
    brandName = json['brandName'];
    caption = json['caption'];
    miDPre = json['miD_Pre'];
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
//miD_Pre

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
    data['spotAmount'] = this.spotAmount;
    data['bookingdetailcode'] = this.bookingdetailcode;
    data['clientName'] = this.clientName;
    data['agencyName'] = this.agencyName;
    data['brandName'] = this.brandName;
    data['caption'] = this.caption;
    data['MID/Pre'] = this.miDPre;
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

class LstFinalAsRun {
  String? exportTapeCode;
  String? exportTapeCaption;
  String? tapeDuration;
  String? programname;
  String? telecastTime;
  String? spotStatus;
  String? spotPosition;
  String? segmentNumber;
  String? programCode;

  LstFinalAsRun(
      {this.exportTapeCode,
        this.exportTapeCaption,
        this.tapeDuration,
        this.programname,
        this.telecastTime,
        this.spotStatus,
        this.spotPosition,
        this.segmentNumber,
        this.programCode});

  LstFinalAsRun.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exportTapeCode'] = this.exportTapeCode;
    data['exportTapeCaption'] = this.exportTapeCaption;
    data['tapeDuration'] = (this.tapeDuration != null && this.tapeDuration != "")?int.parse(this.tapeDuration??"0"):0;
    data['programname'] = this.programname;
    data['telecastTime'] = this.telecastTime;
    data['spotStatus'] = this.spotStatus;
    data['spotPosition'] = this.spotPosition;
    data['segmentNumber'] = this.segmentNumber;
    data['programCode'] = this.programCode;
    return data;
  }

}


class Lstbookingdetail {
  String? tapecode;
  String? schtime;

  Lstbookingdetail({this.tapecode, this.schtime});

  Lstbookingdetail.fromJson(Map<String, dynamic> json) {
    tapecode = json['tapecode'];
    schtime = json['schtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tapecode'] = this.tapecode;
    data['schtime'] = this.schtime;
    return data;
  }
}

