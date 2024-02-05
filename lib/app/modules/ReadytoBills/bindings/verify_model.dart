class VerifyModel {
  List<Verify>? verify;

  VerifyModel({this.verify});

  VerifyModel.fromJson(Map<String, dynamic> json) {
    verify = json["verify"] == null
        ? null
        : (json["verify"] as List).map((e) => Verify.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (verify != null) {
      _data["verify"] = verify?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Verify {
  String? verr;
  String? bookingNumber;
  String? clientName;
  String? agencyName;
  String? bmsVersionName;
  String? exporttapecode;
  int? episodenumber;
  String? rmsprogram;
  String? sapProjectcode;
  String? wbscode;
  int? rmsprogramcode;
  String? ptype;
  int? vWbs;
  String? clcode;
  String? agcode;

  Verify(
      {this.verr,
      this.bookingNumber,
      this.clientName,
      this.agencyName,
      this.bmsVersionName,
      this.exporttapecode,
      this.episodenumber,
      this.rmsprogram,
      this.sapProjectcode,
      this.wbscode,
      this.rmsprogramcode,
      this.ptype,
      this.vWbs,
      this.clcode,
      this.agcode});

  Verify.fromJson(Map<String, dynamic> json) {
    verr = json["verr"];
    bookingNumber = json["bookingNumber"];
    clientName = json["clientName"];
    agencyName = json["agencyName"];
    bmsVersionName = json["bmsVersionName"];
    exporttapecode = json["exporttapecode"];
    episodenumber = json["episodenumber"];
    rmsprogram = json["rmsprogram"];
    sapProjectcode = json["sapProjectcode"];
    wbscode = json["wbscode"];
    rmsprogramcode = json["rmsprogramcode"];
    ptype = json["ptype"];
    vWbs = json["v_wbs"];
    clcode = json["clcode"];
    agcode = json["agcode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["verr"] = verr;
    _data["bookingNumber"] = bookingNumber;
    _data["clientName"] = clientName;
    _data["agencyName"] = agencyName;
    _data["bmsVersionName"] = bmsVersionName;
    _data["exporttapecode"] = exporttapecode;
    _data["episodenumber"] = episodenumber;
    _data["rmsprogram"] = rmsprogram;
    _data["sapProjectcode"] = sapProjectcode;
    _data["wbscode"] = wbscode;
    _data["rmsprogramcode"] = rmsprogramcode;
    _data["ptype"] = ptype;
    _data["v_wbs"] = vWbs;
    _data["clcode"] = clcode;
    _data["agcode"] = agcode;
    return _data;
  }
}
