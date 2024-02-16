class RetriveDataModel {
  CmLoad? cmLoad;

  RetriveDataModel({this.cmLoad});

  RetriveDataModel.fromJson(Map<String, dynamic> json) {
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
}

class CmLoad {
  List<LstCompanyM>? lstCompanyM;

  CmLoad({this.lstCompanyM});

  CmLoad.fromJson(Map<String, dynamic> json) {
    if (json['lstCompanyM'] != null) {
      lstCompanyM = <LstCompanyM>[];
      json['lstCompanyM'].forEach((v) {
        lstCompanyM!.add(new LstCompanyM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstCompanyM != null) {
      data['lstCompanyM'] = this.lstCompanyM!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstCompanyM {
  String? companyCode;
  String? companyName;
  String? companyShortName;
  String? address1;
  String? address2;
  String? placeCode;
  int? pin1;
  String? phone;
  String? fax;
  String? email;
  String? logoFileName;
  String? modifiedBy;
  String? modifiedOn;
  String? pin;
  String? regdAddress1;
  String? regdAddress2;
  String? panNumber;
  String? stNumber;
  String? remark;
  String? sapCompanyCode;
  String? formerCompanyName;
  String? cinNumber;
  String? companyWebSitename;
  String? sapCustomerCode;
  String? syndRemarks;
  String? accountName;
  String? accountNumber;
  String? sortCode;
  String? ibanNumber;
  String? swiftCode;
  String? bankName;
  String? bankAddress;
  String? vatno;
  String? cstNumber;

  LstCompanyM(
      {this.companyCode,
      this.companyName,
      this.companyShortName,
      this.address1,
      this.address2,
      this.placeCode,
      this.pin1,
      this.phone,
      this.fax,
      this.email,
      this.logoFileName,
      this.modifiedBy,
      this.modifiedOn,
      this.pin,
      this.regdAddress1,
      this.regdAddress2,
      this.panNumber,
      this.stNumber,
      this.remark,
      this.sapCompanyCode,
      this.formerCompanyName,
      this.cinNumber,
      this.companyWebSitename,
      this.sapCustomerCode,
      this.syndRemarks,
      this.accountName,
      this.accountNumber,
      this.sortCode,
      this.ibanNumber,
      this.swiftCode,
      this.bankName,
      this.bankAddress,
      this.vatno,
      this.cstNumber});

  LstCompanyM.fromJson(Map<String, dynamic> json) {
    companyCode = json['companyCode'];
    companyName = json['companyName'];
    companyShortName = json['companyShortName'];
    address1 = json['address1'];
    address2 = json['address2'];
    placeCode = json['placeCode'];
    pin1 = json['pin1'];
    phone = json['phone'];
    fax = json['fax'];
    email = json['email'];
    logoFileName = json['logoFileName'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    pin = json['pin'];
    regdAddress1 = json['regdAddress1'];
    regdAddress2 = json['regdAddress2'];
    panNumber = json['panNumber'];
    stNumber = json['stNumber'];
    remark = json['remark'];
    sapCompanyCode = json['sapCompanyCode'];
    formerCompanyName = json['formerCompanyName'];
    cinNumber = json['cinNumber'];
    companyWebSitename = json['companyWebSitename'];
    sapCustomerCode = json['sapCustomerCode'];
    syndRemarks = json['syndRemarks'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
    sortCode = json['sortCode'];
    ibanNumber = json['ibanNumber'];
    swiftCode = json['swiftCode'];
    bankName = json['bankName'];
    bankAddress = json['bankAddress'];
    vatno = json['vatno'];
    cstNumber = json['cstNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyCode'] = this.companyCode;
    data['companyName'] = this.companyName;
    data['companyShortName'] = this.companyShortName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['placeCode'] = this.placeCode;
    data['pin1'] = this.pin1;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['logoFileName'] = this.logoFileName;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    data['pin'] = this.pin;
    data['regdAddress1'] = this.regdAddress1;
    data['regdAddress2'] = this.regdAddress2;
    data['panNumber'] = this.panNumber;
    data['stNumber'] = this.stNumber;
    data['remark'] = this.remark;
    data['sapCompanyCode'] = this.sapCompanyCode;
    data['formerCompanyName'] = this.formerCompanyName;
    data['cinNumber'] = this.cinNumber;
    data['companyWebSitename'] = this.companyWebSitename;
    data['sapCustomerCode'] = this.sapCustomerCode;
    data['syndRemarks'] = this.syndRemarks;
    data['accountName'] = this.accountName;
    data['accountNumber'] = this.accountNumber;
    data['sortCode'] = this.sortCode;
    data['ibanNumber'] = this.ibanNumber;
    data['swiftCode'] = this.swiftCode;
    data['bankName'] = this.bankName;
    data['bankAddress'] = this.bankAddress;
    data['vatno'] = this.vatno;
    data['cstNumber'] = this.cstNumber;
    return data;
  }
}
