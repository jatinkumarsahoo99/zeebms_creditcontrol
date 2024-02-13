import 'package:intl/intl.dart';

class BillingStatusModel {
  List<Billing>? billing;

  BillingStatusModel({this.billing});

  BillingStatusModel.fromJson(Map<String, dynamic> json) {
    billing = json["billing"] == null
        ? null
        : (json["billing"] as List).map((e) => Billing.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (billing != null) {
      _data["billing"] = billing?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Billing {
  String? telecastDate;
  bool? asRunImport;
  bool? asRunVerification;
  bool? schedulingVerification;
  bool? schedulingClearance;
  bool? finalCheck;
  bool? readyToBill;
  dynamic remark;

  Billing(
      {this.telecastDate,
      this.asRunImport,
      this.asRunVerification,
      this.schedulingVerification,
      this.schedulingClearance,
      this.finalCheck,
      this.readyToBill,
      this.remark});

  Billing.fromJson(Map<String, dynamic> json) {
    telecastDate = json["telecastDate"];
    asRunImport = json["asRunImport"];
    asRunVerification = json["asRunVerification"];
    schedulingVerification = json["schedulingVerification"];
    schedulingClearance = json["schedulingClearance"];
    finalCheck = json["finalCheck"];
    readyToBill = json["readyToBill"];
    remark = json["remark"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["telecastDate"] = dateConvertToddMMyyyy(telecastDate ?? "");
    _data["asRunImport"] = asRunImport.toString();
    _data["asRunVerification"] = asRunVerification.toString();
    _data["schedulingVerification"] = schedulingVerification.toString();
    _data["schedulingClearance"] = schedulingClearance.toString();
    _data["finalCheck"] = finalCheck.toString();
    _data["readyToBill"] = readyToBill.toString();
    _data["remark"] = remark;
    return _data;
  }
}

String dateConvertToddMMyyyy(String date) {
  return (DateFormat('dd-MM-yyyy')
      .format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(date)));
}
