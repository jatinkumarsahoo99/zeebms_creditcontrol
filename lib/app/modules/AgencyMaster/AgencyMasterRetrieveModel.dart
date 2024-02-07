class AgencyMasterRetrieveModel {
  Retrieve? retrieve;

  AgencyMasterRetrieveModel({this.retrieve});

  AgencyMasterRetrieveModel.fromJson(Map<String, dynamic> json) {
    retrieve = json['retrieve'] != null
        ? new Retrieve.fromJson(json['retrieve'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retrieve != null) {
      data['retrieve'] = this.retrieve!.toJson();
    }
    return data;
  }
}

class Retrieve {
  List<LstAGencyMaster>? lstAGencyMaster;
  List<LstClientAgency>? lstClientAgency;

  Retrieve({this.lstAGencyMaster, this.lstClientAgency});

  Retrieve.fromJson(Map<String, dynamic> json) {
    if (json['lstAGencyMaster'] != null) {
      lstAGencyMaster = <LstAGencyMaster>[];
      json['lstAGencyMaster'].forEach((v) {
        lstAGencyMaster!.add(new LstAGencyMaster.fromJson(v));
      });
    }
    if (json['lstClientAgency'] != null) {
      lstClientAgency = <LstClientAgency>[];
      json['lstClientAgency'].forEach((v) {
        lstClientAgency!.add(new LstClientAgency.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstAGencyMaster != null) {
      data['lstAGencyMaster'] =
          this.lstAGencyMaster!.map((v) => v.toJson()).toList();
    }
    if (this.lstClientAgency != null) {
      data['lstClientAgency'] =
          this.lstClientAgency!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstAGencyMaster {
  String? agencyCode;
  String? agencyName;
  String? agencyShortName;
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
  String? pin;
  String? ibf;
  String? ibfcode;
  String? mailto;
  String? mailcc;
  String? sapAgencyCode;
  String? custGroupCode;
  String? changeAgencyCode;
  String? name1;
  String? name2;
  String? name3;
  String? reconNo;
  String? attribute3;
  String? agencyGSTNumber;
  String? groupCode;
  String? groupName;

  LstAGencyMaster(
      {this.agencyCode,
        this.agencyName,
        this.agencyShortName,
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
        this.pin,
        this.ibf,
        this.ibfcode,
        this.mailto,
        this.mailcc,
        this.sapAgencyCode,
        this.custGroupCode,
        this.changeAgencyCode,
        this.name1,
        this.name2,
        this.name3,
        this.reconNo,
        this.attribute3,
        this.agencyGSTNumber,
        this.groupCode,
        this.groupName});

  LstAGencyMaster.fromJson(Map<String, dynamic> json) {
    agencyCode = json['agencyCode'];
    agencyName = json['agencyName'];
    agencyShortName = json['agencyShortName'];
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
    pin = json['pin'];
    ibf = json['ibf'];
    ibfcode = json['ibfcode'];
    mailto = json['mailto'];
    mailcc = json['mailcc'];
    sapAgencyCode = json['sapAgencyCode'];
    custGroupCode = json['cust_group_code'];
    changeAgencyCode = json['changeAgencyCode'];
    name1 = json['name1'];
    name2 = json['name2'];
    name3 = json['name3'];
    reconNo = json['reconNo'];
    attribute3 = json['attribute3'];
    agencyGSTNumber = json['agencyGSTNumber'];
    groupCode = json['groupCode'];
    groupName = json['groupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agencyCode'] = this.agencyCode;
    data['agencyName'] = this.agencyName;
    data['agencyShortName'] = this.agencyShortName;
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
    data['pin'] = this.pin;
    data['ibf'] = this.ibf;
    data['ibfcode'] = this.ibfcode;
    data['mailto'] = this.mailto;
    data['mailcc'] = this.mailcc;
    data['sapAgencyCode'] = this.sapAgencyCode;
    data['cust_group_code'] = this.custGroupCode;
    data['changeAgencyCode'] = this.changeAgencyCode;
    data['name1'] = this.name1;
    data['name2'] = this.name2;
    data['name3'] = this.name3;
    data['reconNo'] = this.reconNo;
    data['attribute3'] = this.attribute3;
    data['agencyGSTNumber'] = this.agencyGSTNumber;
    data['groupCode'] = this.groupCode;
    data['groupName'] = this.groupName;
    return data;
  }
}

class LstClientAgency {
  String? locationCode;
  String? channelCode;
  String? agencyCode;
  String? clientCode;
  String? executiveCode;
  String? payroutecode;
  String? locationName;
  String? channelName;
  String? agencyName;
  String? clientName;
  String? personnelName;
  String? payroutename;
  String? effectiveFrom;
  String? plantid;
  String? plantName;

  LstClientAgency(
      {this.locationCode,
        this.channelCode,
        this.agencyCode,
        this.clientCode,
        this.executiveCode,
        this.payroutecode,
        this.locationName,
        this.channelName,
        this.agencyName,
        this.clientName,
        this.personnelName,
        this.payroutename,
        this.effectiveFrom,
        this.plantid,
        this.plantName});

  LstClientAgency.fromJson(Map<String, dynamic> json) {
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    agencyCode = json['agencyCode'];
    clientCode = json['clientCode'];
    executiveCode = json['executiveCode'];
    payroutecode = json['payroutecode'];
    locationName = json['locationName'];
    channelName = json['channelName'];
    agencyName = json['agencyName'];
    clientName = json['clientName'];
    personnelName = json['personnelName'];
    payroutename = json['payroutename'];
    effectiveFrom = json['effectiveFrom'];
    plantid = json['plantid'];
    plantName = json['plantName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['agencyCode'] = this.agencyCode;
    data['clientCode'] = this.clientCode;
    data['executiveCode'] = this.executiveCode;
    data['payroutecode'] = this.payroutecode;
    data['locationName'] = this.locationName;
    data['channelName'] = this.channelName;
    data['agencyName'] = this.agencyName;
    data['clientName'] = this.clientName;
    data['personnelName'] = this.personnelName;
    data['payroutename'] = this.payroutename;
    data['effectiveFrom'] = this.effectiveFrom;
    data['plantid'] = this.plantid;
    data['plantName'] = this.plantName;
    return data;
  }
}
