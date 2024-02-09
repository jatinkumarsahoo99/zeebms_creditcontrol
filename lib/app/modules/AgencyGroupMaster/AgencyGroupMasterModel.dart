class AgencyGroupMasterModel {
  RetrieveRecord? retrieveRecord;

  AgencyGroupMasterModel({this.retrieveRecord});

  AgencyGroupMasterModel.fromJson(Map<String, dynamic> json) {
    retrieveRecord = json['retrieveRecord'] != null
        ? new RetrieveRecord.fromJson(json['retrieveRecord'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retrieveRecord != null) {
      data['retrieveRecord'] = this.retrieveRecord!.toJson();
    }
    return data;
  }
}

class RetrieveRecord {
  List<LstGroup>? lstGroup;
  List<Lstagencymaster>? lstagencymaster;

  RetrieveRecord({this.lstGroup, this.lstagencymaster});

  RetrieveRecord.fromJson(Map<String, dynamic> json) {
    if (json['lstGroup'] != null) {
      lstGroup = <LstGroup>[];
      json['lstGroup'].forEach((v) {
        lstGroup!.add(new LstGroup.fromJson(v));
      });
    }
    if (json['lstagencymaster'] != null) {
      lstagencymaster = <Lstagencymaster>[];
      json['lstagencymaster'].forEach((v) {
        lstagencymaster!.add(new Lstagencymaster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstGroup != null) {
      data['lstGroup'] = this.lstGroup!.map((v) => v.toJson()).toList();
    }
    if (this.lstagencymaster != null) {
      data['lstagencymaster'] =
          this.lstagencymaster!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstGroup {
  String? groupCode;
  String? groupName;
  String? groupShortName;
  String? modifiedBy;
  String? modifiedOn;

  LstGroup(
      {this.groupCode,
        this.groupName,
        this.groupShortName,
        this.modifiedBy,
        this.modifiedOn});

  LstGroup.fromJson(Map<String, dynamic> json) {
    groupCode = json['groupCode'];
    groupName = json['groupName'];
    groupShortName = json['groupShortName'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupCode'] = this.groupCode;
    data['groupName'] = this.groupName;
    data['groupShortName'] = this.groupShortName;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    return data;
  }
}

class Lstagencymaster {
  String? agencyCode;
  String? agencyName;

  Lstagencymaster({this.agencyCode, this.agencyName});

  Lstagencymaster.fromJson(Map<String, dynamic> json) {
    agencyCode = json['agencyCode'];
    agencyName = json['agencyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agencyCode'] = this.agencyCode;
    data['agencyName'] = this.agencyName;
    return data;
  }
}
