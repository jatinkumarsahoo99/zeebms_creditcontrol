
import '../../data/DropDownValue.dart';
import '../../providers/Utils.dart';

class ClientRetriveDataModel {
  List<LstRecords>? lstRecords;
  String? lstAddInfos;
  List<ClientAgencyMaster>? lstClientAgencyMaster;
  List<LstPayTerm>? lstPayTerm;
  List<DropDownValue>? lstPaymentMaster;

  ClientRetriveDataModel(
      {this.lstRecords,
        this.lstAddInfos,
        this.lstClientAgencyMaster,
        this.lstPayTerm,
        this.lstPaymentMaster});

  ClientRetriveDataModel.fromJson(Map<String, dynamic> json) {
    if (json['lstRecords'] != null) {
      lstRecords = <LstRecords>[];
      json['lstRecords'].forEach((v) {
        lstRecords!.add(new LstRecords.fromJson(v));
      });
    }
    lstAddInfos = json['lstAddInfos'];
    if (json['lstClientAgencyMaster'] != null) {
      lstClientAgencyMaster = <ClientAgencyMaster>[];
      json['lstClientAgencyMaster'].forEach((v) {
        lstClientAgencyMaster!.add(new ClientAgencyMaster.fromJson(v));
      });
    }
    if (json['lstPayTerm'] != null) {
      lstPayTerm = <LstPayTerm>[];
      json['lstPayTerm'].forEach((v) {
        lstPayTerm!.add(new LstPayTerm.fromJson(v));
      });
    }
    if (json['lstPaymentMaster'] != null) {
      lstPaymentMaster = <DropDownValue>[];
      json['lstPaymentMaster'].forEach((v) {
        lstPaymentMaster!.add(new DropDownValue(key: v["paymentmodecode"],value: v["paymentmodecaption"]));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstRecords != null) {
      data['lstRecords'] = this.lstRecords!.map((v) => v.toJson()).toList();
    }
    data['lstAddInfos'] = this.lstAddInfos;
    /*if (this.lstClientAgencyMaster != null) {
      data['lstClientAgencyMaster'] =
          this.lstClientAgencyMaster!.map((v) => v.toJson()).toList();
    }*/
    if (this.lstPayTerm != null) {
      data['lstPayTerm'] = this.lstPayTerm!.map((v) => v.toJson()).toList();
    }
    if (this.lstPaymentMaster != null) {
      data['lstPaymentMaster'] =
          this.lstPaymentMaster!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstRecords {
  String? clientCode;
  String? clientName;
  String? clientShortName;
  String? address1;
  String? address2;
  String? city;
  int? pin1;
  String? phone;
  String? fax;
  String? mobile;
  String? email;
  String? contactPerson;
  String? creditRateCode;
  String? modifiedBy;
  String? modifiedOn;
  bool? chkContractual;
  String? pin;
  String? countrycode;
  bool? chkIBF;
  String? ibfcode;
  String? groupFlag;
  String? psuFlag;
  bool? chkbrandFlag;
  bool? chksurrogateflag;
  bool? chkslotsaleflag;
  bool? chkexposureflag;
  String? sapClinetCode;
  String? clientType;
  String? changeClientCode;
  String? name1;
  String? name2;
  String? name3;
  String? paymentmodecode;
  String? ibfremark;
  String? kamflag;
  String? clientzone;
  bool? chkPdc;
  int? creditdays;
  int? osAmount;
  String? lblBlockedClient;

  LstRecords(
      {this.clientCode,
        this.clientName,
        this.clientShortName,
        this.address1,
        this.address2,
        this.city,
        this.pin1,
        this.phone,
        this.fax,
        this.mobile,
        this.email,
        this.contactPerson,
        this.creditRateCode,
        this.modifiedBy,
        this.modifiedOn,
        this.chkContractual,
        this.pin,
        this.countrycode,
        this.chkIBF,
        this.ibfcode,
        this.groupFlag,
        this.psuFlag,
        this.chkbrandFlag,
        this.chksurrogateflag,
        this.chkslotsaleflag,
        this.chkexposureflag,
        this.sapClinetCode,
        this.clientType,
        this.changeClientCode,
        this.name1,
        this.name2,
        this.name3,
        this.paymentmodecode,
        this.ibfremark,
        this.kamflag,
        this.clientzone,
        this.chkPdc,
        this.creditdays,
        this.osAmount,
        this.lblBlockedClient});

  LstRecords.fromJson(Map<String, dynamic> json) {
    clientCode = json['clientCode'];
    clientName = json['clientName'];
    clientShortName = json['clientShortName'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    pin1 = json['pin1'];
    phone = json['phone'];
    fax = json['fax'];
    mobile = json['mobile'];
    email = json['email'];
    contactPerson = json['contactPerson'];
    creditRateCode = json['creditRateCode'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    chkContractual = json['chkContractual'];
    pin = json['pin'];
    countrycode = json['countrycode'];
    chkIBF = json['chkIBF'];
    ibfcode = json['ibfcode'];
    groupFlag = json['groupFlag'];
    psuFlag = json['psu_Flag'];
    chkbrandFlag = json['chkbrandFlag'];
    chksurrogateflag = json['chksurrogateflag'];
    chkslotsaleflag = json['chkslotsaleflag'];
    chkexposureflag = json['chkexposureflag'];
    sapClinetCode = json['sapClinetCode'];
    clientType = json['clientType'];
    changeClientCode = json['changeClientCode'];
    name1 = json['name1'];
    name2 = json['name2'];
    name3 = json['name3'];
    paymentmodecode = json['paymentmodecode'];
    ibfremark = json['ibfremark'];
    kamflag = json['kamflag'];
    clientzone = json['clientzone'];
    chkPdc = json['chkPdc'];
    creditdays = json['creditdays'];
    osAmount = json['osAmount'];
    lblBlockedClient = json['lblBlockedClient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientCode'] = this.clientCode;
    data['clientName'] = this.clientName;
    data['clientShortName'] = this.clientShortName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['pin1'] = this.pin1;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['contactPerson'] = this.contactPerson;
    data['creditRateCode'] = this.creditRateCode;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    data['chkContractual'] = this.chkContractual;
    data['pin'] = this.pin;
    data['countrycode'] = this.countrycode;
    data['chkIBF'] = this.chkIBF;
    data['ibfcode'] = this.ibfcode;
    data['groupFlag'] = this.groupFlag;
    data['psu_Flag'] = this.psuFlag;
    data['chkbrandFlag'] = this.chkbrandFlag;
    data['chksurrogateflag'] = this.chksurrogateflag;
    data['chkslotsaleflag'] = this.chkslotsaleflag;
    data['chkexposureflag'] = this.chkexposureflag;
    data['sapClinetCode'] = this.sapClinetCode;
    data['clientType'] = this.clientType;
    data['changeClientCode'] = this.changeClientCode;
    data['name1'] = this.name1;
    data['name2'] = this.name2;
    data['name3'] = this.name3;
    data['paymentmodecode'] = this.paymentmodecode;
    data['ibfremark'] = this.ibfremark;
    data['kamflag'] = this.kamflag;
    data['clientzone'] = this.clientzone;
    data['chkPdc'] = this.chkPdc;
    data['creditdays'] = this.creditdays;
    data['osAmount'] = this.osAmount;
    data['lblBlockedClient'] = this.lblBlockedClient;
    return data;
  }
}

class LstPayTerm {
  String? clientcode;
  String? clientName;
  String? agencyCode;
  String? agencyName;
  String? paymentmodecode;
  String? paymentMode;
  String? ibfRemark;

  LstPayTerm(
      {this.clientcode,
        this.clientName,
        this.agencyCode,
        this.agencyName,
        this.paymentmodecode,
        this.paymentMode,
        this.ibfRemark});

  LstPayTerm.fromJson(Map<String, dynamic> json) {
    clientcode = json['clientcode'];
    clientName = json['clientName'];
    agencyCode = json['agencyCode'];
    agencyName = json['agencyName'];
    paymentmodecode = json['paymentmodecode'];
    paymentMode = json['paymentMode'];
    ibfRemark = json['ibfRemark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientcode'] = this.clientcode;
    data['clientName'] = this.clientName;
    data['agencyCode'] = this.agencyCode;
    data['agencyName'] = this.agencyName;
    data['paymentmodecode'] = this.paymentmodecode;
    data['paymentMode'] = this.paymentMode;
    data['ibfRemark'] = this.ibfRemark;
    return data;
  }
}

class LstPaymentMaster {
  String? paymentmodecode;
  String? paymentmodecaption;

  LstPaymentMaster({this.paymentmodecode, this.paymentmodecaption});

  LstPaymentMaster.fromJson(Map<String, dynamic> json) {
    paymentmodecode = json['paymentmodecode'];
    paymentmodecaption = json['paymentmodecaption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentmodecode'] = this.paymentmodecode;
    data['paymentmodecaption'] = this.paymentmodecaption;
    return data;
  }
}


class ClientAgencyMaster {
  String? locationName;
  String? locationCode;
  String? channelName;
  String? channelCode;
  String? agencyName;
  String? agencyCode;
  String? executiveName;
  String? executiveCode;
  String? payroutecode;
  String? payrouteName;
  String? effectiveFrom;
  String? plantid;
  String? plantName;
  String? clientName;

  ClientAgencyMaster(
      {this.locationName,
        this.locationCode,
        this.channelName,
        this.channelCode,
        this.agencyName,
        this.agencyCode,
        this.executiveName,
        this.executiveCode,
        this.payroutecode,
        this.payrouteName,
        this.effectiveFrom,
        this.plantid,
        this.clientName,
        this.plantName});

  ClientAgencyMaster.fromJson(Map<String, dynamic> json) {
    locationName = json['locationName'];
    locationCode = json['locationCode'];
    channelName = json['channelName'];
    channelCode = json['channelCode'];
    agencyName = json['agencyName'];
    agencyCode = json['agencyCode'];
    executiveName = json['executiveName'];
    executiveCode = json['executiveCode'];
    payroutecode = json['payroutecode'];
    payrouteName = json['payrouteName'];
    effectiveFrom = json['effectiveFrom'];
    plantid = json['plantid'].toString();
    plantName = json['plantName'];
    clientName = json['clientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationName'] = this.locationName;
    data['locationCode'] = this.locationCode;
    data['channelName'] = this.channelName;
    data['channelCode'] = this.channelCode;
    data['agencyName'] = this.agencyName;
    data['clientName'] = this.clientName;
    data['personnelName'] = this.executiveName;
    data['payrouteName'] = this.payrouteName;
    data['agencyCode'] = this.agencyCode;
    data['executiveCode'] = this.executiveCode;
    data['payroutecode'] = this.payroutecode;
    data['effectiveFrom'] = this.effectiveFrom;
    data['plantid'] = this.plantid;
    data['plantName'] = this.plantName;

    return data;
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['agencyCode'] = this.agencyCode;
    data['executiveCode'] = this.executiveCode;
    data['payroutecode'] = this.payroutecode;
    data['effectiveFromDate'] = Utils.dateFormatChange(this.effectiveFrom??"","yyyy-MM-ddThh:mm:ss","dd-MM-yyyy");
    data['plantid'] = int.tryParse(this.plantid.toString());
    return data;
  }
}
