import 'package:intl/intl.dart';

class AsrunImportModel {
  Model? model;

  AsrunImportModel({this.model});

  AsrunImportModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  List<AsRunDetails>? asRunDetails;

  Model({this.message, this.asRunDetails});

  Model.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    asRunDetails = json["asRunDetails"] == null
        ? null
        : (json["asRunDetails"] as List)
            .map((e) => AsRunDetails.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if (asRunDetails != null) {
      _data["asRunDetails"] = asRunDetails?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class AsRunDetails {
  dynamic programName;
  String? telecastdate;
  String? telecasttime;
  String? tapeid;
  String? segmentnumber;
  String? caption;
  String? telecastDuration;
  String? fpCtime;
  dynamic bookingNumber;
  dynamic bookingDetailcode;
  dynamic commercialCode;

  AsRunDetails(
      {this.programName,
      this.telecastdate,
      this.telecasttime,
      this.tapeid,
      this.segmentnumber,
      this.caption,
      this.telecastDuration,
      this.fpCtime,
      this.bookingNumber,
      this.bookingDetailcode,
      this.commercialCode});

  AsRunDetails.fromJson(Map<String, dynamic> json) {
    programName = json["programName"];
    telecastdate = json["telecastdate"];
    telecasttime = json["telecasttime"];
    tapeid = json["tapeid"];
    segmentnumber = json["segmentnumber"];
    caption = json["caption"];
    telecastDuration = json["telecastDuration"];
    fpCtime = json["fpCtime"];
    bookingNumber = json["bookingNumber"];
    bookingDetailcode = json["bookingDetailcode"];
    commercialCode = json["commercialCode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["programName"] = programName;
    _data["telecastdate"] = dateConvertToddMMyyyy(telecastdate!);
    _data["telecasttime"] = dateConvertToddMMyyyy(telecasttime!);
    _data["tapeid"] = tapeid;
    _data["segmentnumber"] = segmentnumber;
    _data["caption"] = caption;
    _data["telecastDuration"] = dateConvertToddMMyyyy(telecastDuration!);
    _data["fpCtime"] = dateConvertToddMMyyyy(fpCtime!);
    _data["bookingNumber"] = bookingNumber;
    _data["bookingDetailcode"] = bookingDetailcode;
    _data["commercialCode"] = commercialCode;
    return _data;
  }
}

String dateConvertToddMMyyyy(String date) {
  return (DateFormat('dd-MM-yyyy')
      .format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(date)));
}
