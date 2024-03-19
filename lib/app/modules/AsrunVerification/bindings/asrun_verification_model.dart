class AsRunDataModel {
  Model? model;

  AsRunDataModel({this.model});

  AsRunDataModel.fromJson(Map<String, dynamic> json) {
    model = json["model"] == null ? null : Model.fromJson(json["model"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (model != null) {
      _data["model"] = model?.toJson();
    }
    return _data;
  }
}

class Model {
  List<AsRunData>? asRunData;
  List<dynamic>? finalAsRun;

  Model({this.asRunData, this.finalAsRun});

  Model.fromJson(Map<String, dynamic> json) {
    asRunData = json["asRunData"] == null
        ? null
        : (json["asRunData"] as List)
            .map((e) => AsRunData.fromJson(e))
            .toList();
    finalAsRun = json["finalAsRun"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (asRunData != null) {
      _data["asRunData"] = asRunData?.map((e) => e.toJson()).toList();
    }
    if (finalAsRun != null) {
      _data["finalAsRun"] = finalAsRun;
    }
    return _data;
  }
}

class AsRunData {
  String? bookingNumber;
  String? clientName;
  String? agencyName;
  String? brandName;
  String? tapeId;
  String? caption;
  num? tapeDuration;
  String? programName;
  String? midPre;
  num? spotAmount;
  String? spotStatus;
  num? telecastDuration;
  String? telecastTime;
  String? billnumber;
  String? scheduleTime;
  String? status;
  String? rosTimeBand;
  dynamic remarks;
  String? clearBy;
  String? clearBySys;
  String? spotPositionShortName;
  String? telecastProgramcode;
  String? telprogname;
  String? telpos;
  num? bookingDetailCode;
  String? dealno;
  String? packagecode;
  num? recordnumber;
  String? modifyStatus;
  String? locationCode;
  String? channelCode;
  String? telecastMidPre;
  String? accountName;
  String? accountCode;
  String? bookedProgramCode;
  num? breakNumber;
  num? positionNumber;

  AsRunData(
      {this.bookingNumber,
      this.clientName,
      this.agencyName,
      this.brandName,
      this.tapeId,
      this.caption,
      this.tapeDuration,
      this.programName,
      this.midPre,
      this.spotAmount,
      this.spotStatus,
      this.telecastDuration,
      this.telecastTime,
      this.billnumber,
      this.scheduleTime,
      this.status,
      this.rosTimeBand,
      this.remarks,
      this.clearBy,
      this.clearBySys,
      this.spotPositionShortName,
      this.telecastProgramcode,
      this.telprogname,
      this.telpos,
      this.bookingDetailCode,
      this.dealno,
      this.packagecode,
      this.recordnumber,
      this.modifyStatus,
      this.locationCode,
      this.channelCode,
      this.telecastMidPre,
      this.accountName,
      this.accountCode,
      this.bookedProgramCode,
      this.breakNumber,
      this.positionNumber});

  AsRunData.fromJson(Map<String, dynamic> json) {
    bookingNumber = json["bookingNumber"];
    clientName = json["clientName"];
    agencyName = json["agencyName"];
    brandName = json["brandName"];
    tapeId = json["tapeID"];
    caption = json["caption"];
    tapeDuration = json["tapeDuration"];
    programName = json["programName"];
    midPre = json["midPre"];
    spotAmount = json["spotAmount"];
    spotStatus = json["spotStatus"];
    telecastDuration = json["telecastDuration"];
    telecastTime = json["telecastTime"];
    billnumber = json["billnumber"];
    scheduleTime = json["scheduleTime"];
    status = json["status"];
    rosTimeBand = json["rosTimeBand"];
    remarks = json["remarks"];
    clearBy = json["clearBy"];
    clearBySys = json["clearBySys"];
    spotPositionShortName = json["spotPositionShortName"];
    telecastProgramcode = json["telecastProgramcode"];
    telprogname = json["telprogname"];
    telpos = json["telpos"];
    bookingDetailCode = json["bookingDetailCode"];
    dealno = json["dealno"];
    packagecode = json["packagecode"];
    recordnumber = json["recordnumber"];
    modifyStatus = json["modifyStatus"];
    locationCode = json["locationCode"];
    channelCode = json["channelCode"];
    telecastMidPre = json["telecastMidPre"];
    accountName = json["accountName"];
    accountCode = json["accountCode"];
    bookedProgramCode = json["bookedProgramCode"];
    breakNumber = json["breakNumber"];
    positionNumber = json["positionNumber"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["bookingNumber"] = bookingNumber;
    _data["clientName"] = clientName;
    _data["agencyName"] = agencyName;
    _data["brandName"] = brandName;
    _data["tapeID"] = tapeId;
    _data["caption"] = caption;
    _data["tapeDuration"] = tapeDuration;
    _data["programName"] = programName;
    _data["midPre"] = midPre;
    _data["spotAmount"] = spotAmount!.toStringAsFixed(2);
    _data["spotStatus"] = spotStatus;
    _data["telecastDuration"] = telecastDuration;
    _data["telecastTime"] = telecastTime;
    _data["billnumber"] = billnumber;
    _data["scheduleTime"] = scheduleTime;
    _data["status"] = status;
    _data["rosTimeBand"] = rosTimeBand;
    _data["remarks"] = remarks;
    _data["clearBy"] = clearBy;
    _data["clearBySys"] = clearBySys;
    _data["spotPositionShortName"] = spotPositionShortName;
    _data["telecastProgramcode"] = telecastProgramcode;
    _data["telprogname"] = telprogname;
    _data["telpos"] = telpos;
    _data["bookingDetailCode"] = bookingDetailCode;
    _data["dealno"] = dealno;
    _data["packagecode"] = packagecode;
    _data["recordnumber"] = recordnumber;
    _data["modifyStatus"] = modifyStatus;
    _data["locationCode"] = locationCode;
    _data["channelCode"] = channelCode;
    _data["telecastMidPre"] = telecastMidPre;
    _data["accountName"] = accountName;
    _data["accountCode"] = accountCode;
    _data["bookedProgramCode"] = bookedProgramCode;
    _data["breakNumber"] = breakNumber;
    _data["positionNumber"] = positionNumber;
    return _data;
  }
}
