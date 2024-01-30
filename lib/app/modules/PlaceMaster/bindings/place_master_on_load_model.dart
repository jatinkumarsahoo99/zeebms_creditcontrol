class PlaceMasterOnLoadModel {
  PlaceMasterOnLoad? placeMasterOnLoad;

  PlaceMasterOnLoadModel({this.placeMasterOnLoad});

  PlaceMasterOnLoadModel.fromJson(Map<String, dynamic> json) {
    placeMasterOnLoad = json["placeMasterOnLoad"] == null
        ? null
        : PlaceMasterOnLoad.fromJson(json["placeMasterOnLoad"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (placeMasterOnLoad != null) {
      _data["placeMasterOnLoad"] = placeMasterOnLoad?.toJson();
    }
    return _data;
  }
}

class PlaceMasterOnLoad {
  List<LstZonename>? lstZonename;
  List<LstPlaceType>? lstPlaceType;
  List<LstParentPlaceName>? lstParentPlaceName;

  PlaceMasterOnLoad(
      {this.lstZonename, this.lstPlaceType, this.lstParentPlaceName});

  PlaceMasterOnLoad.fromJson(Map<String, dynamic> json) {
    lstZonename = json["lstZonename"] == null
        ? null
        : (json["lstZonename"] as List)
            .map((e) => LstZonename.fromJson(e))
            .toList();
    lstPlaceType = json["lstPlaceType"] == null
        ? null
        : (json["lstPlaceType"] as List)
            .map((e) => LstPlaceType.fromJson(e))
            .toList();
    lstParentPlaceName = json["lstParentPlaceName"] == null
        ? null
        : (json["lstParentPlaceName"] as List)
            .map((e) => LstParentPlaceName.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstZonename != null) {
      _data["lstZonename"] = lstZonename?.map((e) => e.toJson()).toList();
    }
    if (lstPlaceType != null) {
      _data["lstPlaceType"] = lstPlaceType?.map((e) => e.toJson()).toList();
    }
    if (lstParentPlaceName != null) {
      _data["lstParentPlaceName"] =
          lstParentPlaceName?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class LstParentPlaceName {
  String? placeCode;
  String? placeName;
  String? placeShortName;
  String? placeTypeCode;
  String? parentPlaceCode;
  String? zoneCode;
  dynamic ibfBranchCode;
  dynamic sapCode;

  LstParentPlaceName(
      {this.placeCode,
      this.placeName,
      this.placeShortName,
      this.placeTypeCode,
      this.parentPlaceCode,
      this.zoneCode,
      this.ibfBranchCode,
      this.sapCode});

  LstParentPlaceName.fromJson(Map<String, dynamic> json) {
    placeCode = json["placeCode"];
    placeName = json["placeName"];
    placeShortName = json["placeShortName"];
    placeTypeCode = json["placeTypeCode"];
    parentPlaceCode = json["parentPlaceCode"];
    zoneCode = json["zoneCode"];
    ibfBranchCode = json["ibfBranchCode"];
    sapCode = json["sapCode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["placeCode"] = placeCode;
    _data["placeName"] = placeName;
    _data["placeShortName"] = placeShortName;
    _data["placeTypeCode"] = placeTypeCode;
    _data["parentPlaceCode"] = parentPlaceCode;
    _data["zoneCode"] = zoneCode;
    _data["ibfBranchCode"] = ibfBranchCode;
    _data["sapCode"] = sapCode;
    return _data;
  }
}

class LstPlaceType {
  String? placeTypeCode;
  String? placeTypeName;

  LstPlaceType({this.placeTypeCode, this.placeTypeName});

  LstPlaceType.fromJson(Map<String, dynamic> json) {
    placeTypeCode = json["placeTypeCode"];
    placeTypeName = json["placeTypeName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["placeTypeCode"] = placeTypeCode;
    _data["placeTypeName"] = placeTypeName;
    return _data;
  }
}

class LstZonename {
  String? zoneCode;
  String? zoneName;
  String? shortName;
  int? startSeries;
  String? bShortName;
  String? sapSalesGroup;

  LstZonename(
      {this.zoneCode,
      this.zoneName,
      this.shortName,
      this.startSeries,
      this.bShortName,
      this.sapSalesGroup});

  LstZonename.fromJson(Map<String, dynamic> json) {
    zoneCode = json["zoneCode"];
    zoneName = json["zoneName"];
    shortName = json["shortName"];
    startSeries = json["startSeries"];
    bShortName = json["bShortName"];
    sapSalesGroup = json["sapSalesGroup"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["zoneCode"] = zoneCode;
    _data["zoneName"] = zoneName;
    _data["shortName"] = shortName;
    _data["startSeries"] = startSeries;
    _data["bShortName"] = bShortName;
    _data["sapSalesGroup"] = sapSalesGroup;
    return _data;
  }
}
