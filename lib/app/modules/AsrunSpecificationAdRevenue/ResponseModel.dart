class ResponseModel {
  List<PouplateData>? pouplateData;

  ResponseModel({this.pouplateData});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['pouplateData'] != null) {
      pouplateData = <PouplateData>[];
      json['pouplateData'].forEach((v) {
        pouplateData!.add(new PouplateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pouplateData != null) {
      data['pouplateData'] = this.pouplateData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PouplateData {
  String? channelCode;
  String? locationCode;
  int? eventNoCol;
  int? eventNoLen;
  int? telecastDateCol;
  int? telecastDateLen;
  int? telecastTimeCol;
  int? telecastTimeLen;
  int? exportTapeCodeCol;
  int? exportTapeCodeLen;
  int? segmentNumberCol;
  int? segmentNumberLen;
  int? exportTapeCaptionCol;
  int? exportTapeCaptionLen;
  int? tapeDurationCol;
  int? tapeDurationLen;
  String? modifiedBy;
  String? modifiedOn;
  String? asrunDifference;
  String? asrunFlag;
  int? endTimelen;
  int? endTimecol;
  int? asrunType;
  int? saPflag;
  int? newformat;
  int? maxDurationDifference;
  String? defaultfilename;
  int? fpc;
  int? markSlots;
  int? dontUpdateExposure;
  int? reconKeyCol;
  int? reconKeyLen;
  int? reverseAsRunOrder;
  String? dateFormat;
  String? importFileType;

  PouplateData(
      {this.channelCode,
        this.locationCode,
        this.eventNoCol,
        this.eventNoLen,
        this.telecastDateCol,
        this.telecastDateLen,
        this.telecastTimeCol,
        this.telecastTimeLen,
        this.exportTapeCodeCol,
        this.exportTapeCodeLen,
        this.segmentNumberCol,
        this.segmentNumberLen,
        this.exportTapeCaptionCol,
        this.exportTapeCaptionLen,
        this.tapeDurationCol,
        this.tapeDurationLen,
        this.modifiedBy,
        this.modifiedOn,
        this.asrunDifference,
        this.asrunFlag,
        this.endTimelen,
        this.endTimecol,
        this.asrunType,
        this.saPflag,
        this.newformat,
        this.maxDurationDifference,
        this.defaultfilename,
        this.fpc,
        this.markSlots,
        this.dontUpdateExposure,
        this.reconKeyCol,
        this.reconKeyLen,
        this.reverseAsRunOrder,
        this.dateFormat,
        this.importFileType});

  PouplateData.fromJson(Map<String, dynamic> json) {
    channelCode = json['channelCode'];
    locationCode = json['locationCode'];
    eventNoCol = json['eventNoCol'];
    eventNoLen = json['eventNoLen'];
    telecastDateCol = json['telecastDateCol'];
    telecastDateLen = json['telecastDateLen'];
    telecastTimeCol = json['telecastTimeCol'];
    telecastTimeLen = json['telecastTimeLen'];
    exportTapeCodeCol = json['exportTapeCodeCol'];
    exportTapeCodeLen = json['exportTapeCodeLen'];
    segmentNumberCol = json['segmentNumberCol'];
    segmentNumberLen = json['segmentNumberLen'];
    exportTapeCaptionCol = json['exportTapeCaptionCol'];
    exportTapeCaptionLen = json['exportTapeCaptionLen'];
    tapeDurationCol = json['tapeDurationCol'];
    tapeDurationLen = json['tapeDurationLen'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    asrunDifference = json['asrunDifference'];
    asrunFlag = json['asrunFlag'];
    endTimelen = json['endTimelen'];
    endTimecol = json['endTimecol'];
    asrunType = json['asrunType'];
    saPflag = json['saPflag'];
    newformat = json['newformat'];
    maxDurationDifference = json['maxDurationDifference'];
    defaultfilename = json['defaultfilename'];
    fpc = json['fpc'];
    markSlots = json['markSlots'];
    dontUpdateExposure = json['dontUpdateExposure'];
    reconKeyCol = json['reconKeyCol'];
    reconKeyLen = json['reconKeyLen'];
    reverseAsRunOrder = json['reverseAsRunOrder'];
    dateFormat = json['date_format'];
    importFileType = json['importFileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelCode'] = this.channelCode;
    data['locationCode'] = this.locationCode;
    data['eventNoCol'] = this.eventNoCol;
    data['eventNoLen'] = this.eventNoLen;
    data['telecastDateCol'] = this.telecastDateCol;
    data['telecastDateLen'] = this.telecastDateLen;
    data['telecastTimeCol'] = this.telecastTimeCol;
    data['telecastTimeLen'] = this.telecastTimeLen;
    data['exportTapeCodeCol'] = this.exportTapeCodeCol;
    data['exportTapeCodeLen'] = this.exportTapeCodeLen;
    data['segmentNumberCol'] = this.segmentNumberCol;
    data['segmentNumberLen'] = this.segmentNumberLen;
    data['exportTapeCaptionCol'] = this.exportTapeCaptionCol;
    data['exportTapeCaptionLen'] = this.exportTapeCaptionLen;
    data['tapeDurationCol'] = this.tapeDurationCol;
    data['tapeDurationLen'] = this.tapeDurationLen;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    data['asrunDifference'] = this.asrunDifference;
    data['asrunFlag'] = this.asrunFlag;
    data['endTimelen'] = this.endTimelen;
    data['endTimecol'] = this.endTimecol;
    data['asrunType'] = this.asrunType;
    data['saPflag'] = this.saPflag;
    data['newformat'] = this.newformat;
    data['maxDurationDifference'] = this.maxDurationDifference;
    data['defaultfilename'] = this.defaultfilename;
    data['fpc'] = this.fpc;
    data['markSlots'] = this.markSlots;
    data['dontUpdateExposure'] = this.dontUpdateExposure;
    data['reconKeyCol'] = this.reconKeyCol;
    data['reconKeyLen'] = this.reconKeyLen;
    data['reverseAsRunOrder'] = this.reverseAsRunOrder;
    data['date_format'] = this.dateFormat;
    data['importFileType'] = this.importFileType;
    return data;
  }
}
