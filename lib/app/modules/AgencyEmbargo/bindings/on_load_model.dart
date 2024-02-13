class AgencyEmbargoOnLoadModel {
  List<Onload>? onload;

  AgencyEmbargoOnLoadModel({this.onload});

  AgencyEmbargoOnLoadModel.fromJson(Map<String, dynamic> json) {
    onload = json["onload"] == null
        ? null
        : (json["onload"] as List).map((e) => Onload.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (onload != null) {
      _data["onload"] = onload?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Onload {
  String? locationcode;
  String? channelcode;
  int? embargoNo;
  String? agencycode;
  String? agencyName;
  String? fromDate;
  dynamic todate;
  String? reason;

  Onload(
      {this.locationcode,
      this.channelcode,
      this.embargoNo,
      this.agencycode,
      this.agencyName,
      this.fromDate,
      this.todate,
      this.reason});

  Onload.fromJson(Map<String, dynamic> json) {
    locationcode = json["locationcode"];
    channelcode = json["channelcode"];
    embargoNo = json["embargoNo"];
    agencycode = json["agencycode"];
    agencyName = json["agencyName"];
    fromDate = json["fromDate"];
    todate = json["todate"];
    reason = json["reason"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["locationcode"] = locationcode;
    _data["channelcode"] = channelcode;
    _data["embargoNo"] = embargoNo;
    _data["agencycode"] = agencycode;
    _data["agencyName"] = agencyName;
    _data["fromDate"] = fromDate;
    _data["todate"] = todate;
    _data["reason"] = reason;
    return _data;
  }
}
