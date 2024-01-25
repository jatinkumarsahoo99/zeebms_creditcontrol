import '../../data/DropDownValue.dart';

class SalesExecutiveMasterModel {
  List<LstCompanyMaster>? lstCompanyMaster;
  List<DropDownValue>? lstCompanyMaster1;
  List<LstLocationMaster>? lstLocationMaster;
  List<DropDownValue>? lstLocationMaster1;
  List<LstPlaceMaster>? lstPlaceMaster;
  List<DropDownValue>? lstPlaceMaster1;
  List<LstStationMaster>? lstStationMaster;
  List<DropDownValue>? lstStationMaster1;

  SalesExecutiveMasterModel(
      {this.lstCompanyMaster,
      this.lstLocationMaster,
      this.lstPlaceMaster,
      this.lstStationMaster});

  SalesExecutiveMasterModel.fromJson(Map<String, dynamic> json) {
    if (json['lstCompanyMaster'] != null) {
      lstCompanyMaster = <LstCompanyMaster>[];
      lstCompanyMaster1 = <DropDownValue>[];
      int i = -1;
      json['lstCompanyMaster'].forEach((v) {
        lstCompanyMaster!.add(new LstCompanyMaster.fromJson(v));
        lstCompanyMaster1!.add(new DropDownValue(
            key: v["companyCode"],
            value: v["companyName"],
            selectedIndex: ++i));
      });
    }
    if (json['lstLocationMaster'] != null) {
      lstLocationMaster = <LstLocationMaster>[];
      lstLocationMaster1 = <DropDownValue>[];
      int i = -1;
      json['lstLocationMaster'].forEach((v) {
        lstLocationMaster!.add(new LstLocationMaster.fromJson(v));
        lstLocationMaster1!.add(new DropDownValue(
            key: v["locationCode"], value: v["locationName"],selectedIndex: ++i));
      });
    }
    if (json['lstPlaceMaster'] != null) {
      lstPlaceMaster = <LstPlaceMaster>[];
      lstPlaceMaster1 = <DropDownValue>[];
      int i = -1;
      json['lstPlaceMaster'].forEach((v) {
        lstPlaceMaster!.add(new LstPlaceMaster.fromJson(v));
        lstPlaceMaster1!
            .add(new DropDownValue(key: v["placeCode"], value: v["placeName"],selectedIndex: ++i));
      });
    }
    if (json['lstStationMaster'] != null) {
      lstStationMaster = <LstStationMaster>[];
      lstStationMaster1 = <DropDownValue>[];
      int i = -1;
      json['lstStationMaster'].forEach((v) {
        lstStationMaster!.add(new LstStationMaster.fromJson(v));
        lstStationMaster1!.add(
            new DropDownValue(key: v["stationCode"], value: v["stationName"],selectedIndex: ++i));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstCompanyMaster != null) {
      data['lstCompanyMaster'] =
          this.lstCompanyMaster!.map((v) => v.toJson()).toList();
    }
    if (this.lstLocationMaster != null) {
      data['lstLocationMaster'] =
          this.lstLocationMaster!.map((v) => v.toJson()).toList();
    }
    if (this.lstPlaceMaster != null) {
      data['lstPlaceMaster'] =
          this.lstPlaceMaster!.map((v) => v.toJson()).toList();
    }
    if (this.lstStationMaster != null) {
      data['lstStationMaster'] =
          this.lstStationMaster!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstCompanyMaster {
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

  LstCompanyMaster(
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
      this.pin,
      this.regdAddress1,
      this.regdAddress2,
      this.panNumber,
      this.stNumber,
      this.remark,
      this.sapCompanyCode,
      this.formerCompanyName,
      this.cinNumber,
      this.companyWebSitename});

  LstCompanyMaster.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class LstLocationMaster {
  String? locationCode;
  String? locationName;

  LstLocationMaster({this.locationCode, this.locationName});

  LstLocationMaster.fromJson(Map<String, dynamic> json) {
    locationCode = json['locationCode'];
    locationName = json['locationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    data['locationName'] = this.locationName;
    return data;
  }
}

class LstPlaceMaster {
  String? placeCode;
  String? placeName;
  String? placeShortName;
  String? placeTypeCode;
  String? parentPlaceCode;
  String? zoneCode;
  String? ibfBranchCode;
  String? sapCode;

  LstPlaceMaster(
      {this.placeCode,
      this.placeName,
      this.placeShortName,
      this.placeTypeCode,
      this.parentPlaceCode,
      this.zoneCode,
      this.ibfBranchCode,
      this.sapCode});

  LstPlaceMaster.fromJson(Map<String, dynamic> json) {
    placeCode = json['placeCode'];
    placeName = json['placeName'];
    placeShortName = json['placeShortName'];
    placeTypeCode = json['placeTypeCode'];
    parentPlaceCode = json['parentPlaceCode'];
    zoneCode = json['zoneCode'];
    ibfBranchCode = json['ibfBranchCode'];
    sapCode = json['sapCode'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placeCode'] = this.placeCode;
    data['placeName'] = this.placeName;
    data['placeShortName'] = this.placeShortName;
    data['placeTypeCode'] = this.placeTypeCode;
    data['parentPlaceCode'] = this.parentPlaceCode;
    data['zoneCode'] = this.zoneCode;
    data['ibfBranchCode'] = this.ibfBranchCode;
    data['sapCode'] = this.sapCode;
    return data;
  }
}

class LstStationMaster {
  String? stationCode;
  String? stationName;
  String? zoneCode;
  String? modifiedBy;
  String? modifiedOn;

  LstStationMaster(
      {this.stationCode,
      this.stationName,
      this.zoneCode,
      this.modifiedBy,
      this.modifiedOn});

  LstStationMaster.fromJson(Map<String, dynamic> json) {
    stationCode = json['stationCode'];
    stationName = json['stationName'];
    zoneCode = json['zoneCode'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationCode'] = this.stationCode;
    data['stationName'] = this.stationName;
    data['zoneCode'] = this.zoneCode;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    return data;
  }
}
