import 'package:intl/intl.dart';

class TabelDealModel {
  LstDeals? lstDeals;

  TabelDealModel({this.lstDeals});

  TabelDealModel.fromJson(Map<String, dynamic> json) {
    lstDeals =
        json["lstDeals"] == null ? null : LstDeals.fromJson(json["lstDeals"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstDeals != null) {
      _data["lstDeals"] = lstDeals?.toJson();
    }
    return _data;
  }
}

class LstDeals {
  List<Lstdealrecord>? lstdealrecord;

  LstDeals({this.lstdealrecord});

  LstDeals.fromJson(Map<String, dynamic> json) {
    lstdealrecord = json["lstdealrecord"] == null
        ? null
        : (json["lstdealrecord"] as List)
            .map((e) => Lstdealrecord.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstdealrecord != null) {
      _data["lstdealrecord"] = lstdealrecord?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Lstdealrecord {
  bool? selected;
  String? locationcode;
  String? channelcode;
  String? locationname;
  String? channelname;
  String? dealnumber;
  String? dealdate;
  String? fromdate;
  String? todate;
  int? maxspend;

  Lstdealrecord(
      {this.selected,
      this.locationcode,
      this.channelcode,
      this.locationname,
      this.channelname,
      this.dealnumber,
      this.dealdate,
      this.fromdate,
      this.todate,
      this.maxspend});

  Lstdealrecord.fromJson(Map<String, dynamic> json) {
    selected = json["selected"];
    locationcode = json["locationcode"];
    channelcode = json["channelcode"];
    locationname = json["locationname"];
    channelname = json["channelname"];
    dealnumber = json["dealnumber"];
    dealdate = json["dealdate"];
    fromdate = json["fromdate"];
    todate = json["todate"];
    maxspend = json["maxspend"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["selected"] = selected.toString();
    _data["locationcode"] = locationcode;
    _data["channelcode"] = channelcode;
    _data["locationname"] = locationname;
    _data["channelname"] = channelname;
    _data["dealnumber"] = dealnumber;
    _data["dealdate"] = dateConvertToddMMyyyy(dealdate ?? "");
    _data["fromdate"] = dateConvertToddMMyyyy(fromdate ?? "");
    _data["todate"] = dateConvertToddMMyyyy(todate ?? "");
    _data["maxspend"] = maxspend;
    return _data;
  }
}

String dateConvertToddMMyyyy(String date) {
  return (DateFormat('dd-MM-yyyy')
      .format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(date)));
}
