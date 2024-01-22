class AgencyLeaveDataModel {
  AgencyLeaveModel? agencyLeaveModel;

  AgencyLeaveDataModel({this.agencyLeaveModel});

  AgencyLeaveDataModel.fromJson(Map<String, dynamic> json) {
    agencyLeaveModel = json['agencyLeaveModel'] != null
        ? new AgencyLeaveModel.fromJson(json['agencyLeaveModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agencyLeaveModel != null) {
      data['agencyLeaveModel'] = this.agencyLeaveModel!.toJson();
    }
    return data;
  }
}

class AgencyLeaveModel {
  List<PaymentModels>? paymentModels;
  String? paymentErrorMsg;
  String? panErrorMsg;
  String? gstErrorMsg;
  String? pan;
  String? gst;
  String? agencyEmbargo;
  String? remark;
  String? personnelname;
  String? currencyTypeCode;
  String? zonename;
  String? payroutename;
  String? plantname;

  AgencyLeaveModel(
      {this.paymentModels,
        this.paymentErrorMsg,
        this.panErrorMsg,
        this.gstErrorMsg,
        this.pan,
        this.gst,
        this.agencyEmbargo,
        this.remark,
        this.personnelname,
        this.currencyTypeCode,
        this.zonename,
        this.payroutename,
        this.plantname});

  AgencyLeaveModel.fromJson(Map<String, dynamic> json) {
    if (json['paymentModels'] != null) {
      paymentModels = <PaymentModels>[];
      json['paymentModels'].forEach((v) {
        paymentModels!.add(new PaymentModels.fromJson(v));
      });
    }
    paymentErrorMsg = json['paymentErrorMsg'];
    panErrorMsg = json['panErrorMsg'];
    gstErrorMsg = json['gstErrorMsg'];
    pan = json['pan'];
    gst = json['gst'];
    agencyEmbargo = json['agencyEmbargo'];
    remark = json['remark'];
    personnelname = json['personnelname'];
    currencyTypeCode = json['currencyTypeCode'];
    zonename = json['zonename'];
    payroutename = json['payroutename'];
    plantname = json['plantname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentModels != null) {
      data['paymentModels'] =
          this.paymentModels!.map((v) => v.toJson()).toList();
    }
    data['paymentErrorMsg'] = this.paymentErrorMsg;
    data['panErrorMsg'] = this.panErrorMsg;
    data['gstErrorMsg'] = this.gstErrorMsg;
    data['pan'] = this.pan;
    data['gst'] = this.gst;
    data['agencyEmbargo'] = this.agencyEmbargo;
    data['remark'] = this.remark;
    data['personnelname'] = this.personnelname;
    data['currencyTypeCode'] = this.currencyTypeCode;
    data['zonename'] = this.zonename;
    data['payroutename'] = this.payroutename;
    data['plantname'] = this.plantname;
    return data;
  }
}

class PaymentModels {
  String? paymentmodecaption;
  String? paymentmodecode;

  PaymentModels({this.paymentmodecaption, this.paymentmodecode});

  PaymentModels.fromJson(Map<String, dynamic> json) {
    paymentmodecaption = json['paymentmodecaption'];
    paymentmodecode = json['paymentmodecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentmodecaption'] = this.paymentmodecaption;
    data['paymentmodecode'] = this.paymentmodecode;
    return data;
  }
}
