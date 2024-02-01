class BillingsValueModel {
  List<Billings>? billings;

  BillingsValueModel({this.billings});

  BillingsValueModel.fromJson(Map<String, dynamic> json) {
    billings = json["billings"] == null
        ? null
        : (json["billings"] as List).map((e) => Billings.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (billings != null) {
      _data["billings"] = billings?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Billings {
  bool? checked;
  dynamic zonename;
  String? companyname;
  String? saPprofitcentre;
  String? channelname;
  String? locationname;
  String? clientname;
  String? agencyname;
  String? bookingnumber;
  String? sFlag;
  String? currency;
  int? spotAmount;
  int? totdur;
  int? noofspot;
  int? cAgencyShare;
  dynamic zoneCode;

  Billings(
      {this.checked,
      this.zonename,
      this.companyname,
      this.saPprofitcentre,
      this.channelname,
      this.locationname,
      this.clientname,
      this.agencyname,
      this.bookingnumber,
      this.sFlag,
      this.currency,
      this.spotAmount,
      this.totdur,
      this.noofspot,
      this.cAgencyShare,
      this.zoneCode});

  Billings.fromJson(Map<String, dynamic> json) {
    checked = json["checked"];
    zonename = json["zonename"];
    companyname = json["companyname"];
    saPprofitcentre = json["saPprofitcentre"];
    channelname = json["channelname"];
    locationname = json["locationname"];
    clientname = json["clientname"];
    agencyname = json["agencyname"];
    bookingnumber = json["bookingnumber"];
    sFlag = json["sFlag"];
    currency = json["currency"];
    spotAmount = json["spotAmount"];
    totdur = json["totdur"];
    noofspot = json["noofspot"];
    cAgencyShare = json["cAgencyShare"];
    zoneCode = json["zoneCode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["checked"] = checked.toString();
    _data["zonename"] = zonename;
    _data["companyname"] = companyname;
    _data["saPprofitcentre"] = saPprofitcentre;
    _data["channelname"] = channelname;
    _data["locationname"] = locationname;
    _data["clientname"] = clientname;
    _data["agencyname"] = agencyname;
    _data["bookingnumber"] = bookingnumber;
    _data["sFlag"] = sFlag;
    _data["currency"] = currency;
    _data["spotAmount"] = spotAmount;
    _data["totdur"] = totdur;
    _data["noofspot"] = noofspot;
    _data["cAgencyShare"] = cAgencyShare;
    _data["zoneCode"] = zoneCode;
    return _data;
  }
}
