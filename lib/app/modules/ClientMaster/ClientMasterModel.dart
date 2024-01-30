import 'package:bms_creditcontrol/app/data/DropDownValue.dart';

/*class ClientMasterModel {
  CmLoad? cmLoad;

  ClientMasterModel({this.cmLoad});

  ClientMasterModel.fromJson(Map<String, dynamic> json) {
    cmLoad =
    json['cmLoad'] != null ? new CmLoad.fromJson(json['cmLoad']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cmLoad != null) {
      data['cmLoad'] = this.cmLoad!.toJson();
    }
    return data;
  }
}*/

class ClientMasterModel {
  List<DropDownValue>? lstCitys;
  List<DropDownValue>? lstCountryCodes;
  List<DropDownValue>? lstCreditRates;
  List<DropDownValue>? lstPaymentModes;
  List<DropDownValue>? lstlocations;
  String? maxEffectiveDate;

  ClientMasterModel(
      {this.lstCitys,
        this.lstCountryCodes,
        this.lstCreditRates,
        this.lstPaymentModes,
        this.maxEffectiveDate});

  ClientMasterModel.fromJson(Map<String, dynamic> json) {
    if (json['lstCitys'] != null) {
      lstCitys = <DropDownValue>[];
      json['lstCitys'].forEach((v) {
        lstCitys!.add(new DropDownValue(key: v["placecode"] ,value: v["placename"]));
      });
    }
    if (json['lstCountryCodes'] != null) {
      lstCountryCodes = <DropDownValue>[];
      json['lstCountryCodes'].forEach((v) {
        lstCountryCodes!.add(new DropDownValue(key: v["placecode"] ,value: v["placename"]));
      });
    }
    if (json['lstCreditRates'] != null) {
      lstCreditRates = <DropDownValue>[];
      json['lstCreditRates'].forEach((v) {
        lstCreditRates!.add(new DropDownValue(key: v["creditRateCode"] ,value: v["creditRateName"]));
      });
    }
    if (json['lstPaymentModes'] != null) {
      lstPaymentModes = <DropDownValue>[];
      json['lstPaymentModes'].forEach((v) {
        lstPaymentModes!.add(new DropDownValue(key: v["paymentmodecode"] ,value: v["paymentmodecaption"]));
      });
    }
    if (json['lstlocations'] != null) {
      lstlocations = <DropDownValue>[];
      json['lstlocations'].forEach((v) {
        lstlocations!.add(new DropDownValue(key: v["locationCode"] ,value: v["locationName"]));
      });
    }
    maxEffectiveDate = json['maxEffectiveDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstCitys != null) {
      data['lstCitys'] = this.lstCitys!.map((v) => v.toJson()).toList();
    }
    if (this.lstCountryCodes != null) {
      data['lstCountryCodes'] =
          this.lstCountryCodes!.map((v) => v.toJson()).toList();
    }
    if (this.lstCreditRates != null) {
      data['lstCreditRates'] =
          this.lstCreditRates!.map((v) => v.toJson()).toList();
    }
    if (this.lstPaymentModes != null) {
      data['lstPaymentModes'] =
          this.lstPaymentModes!.map((v) => v.toJson()).toList();
    }
    if (this.lstlocations != null) {
      data['lstlocations'] =
          this.lstlocations!.map((v) => v.toJson()).toList();
    }
    data['maxEffectiveDate'] = this.maxEffectiveDate;
    return data;
  }
}