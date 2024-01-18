class GSTPlantInfoModel {
  List<Load>? load;

  GSTPlantInfoModel({this.load});

  GSTPlantInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['load'] != null) {
      load = <Load>[];
      json['load'].forEach((v) {
        load!.add(new Load.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.load != null) {
      data['load'] = this.load!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Load {
  int? plantID;
  String? plantCode;
  String? plantName;
  String? plantName2;
  String? coCode;
  String? companyName;
  String? houseNumberAndStreet;
  String? postalCode;
  String? city;
  String? countryKey;
  String? countryName;
  String? region;
  String? regionDescription;

  Load(
      {this.plantID,
        this.plantCode,
        this.plantName,
        this.plantName2,
        this.coCode,
        this.companyName,
        this.houseNumberAndStreet,
        this.postalCode,
        this.city,
        this.countryKey,
        this.countryName,
        this.region,
        this.regionDescription});

  Load.fromJson(Map<String, dynamic> json) {
    plantID = json['plantID'];
    plantCode = json['plantCode'];
    plantName = json['plantName'];
    plantName2 = json['plantName2'];
    coCode = json['coCode'];
    companyName = json['companyName'];
    houseNumberAndStreet = json['houseNumberAndStreet'];
    postalCode = json['postalCode'];
    city = json['city'];
    countryKey = json['countryKey'];
    countryName = json['countryName'];
    region = json['region'];
    regionDescription = json['regionDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plantID'] = this.plantID;
    data['plantCode'] = this.plantCode;
    data['plantName'] = this.plantName;
    data['plantName2'] = this.plantName2;
    data['coCode'] = this.coCode;
    data['companyName'] = this.companyName;
    data['houseNumberAndStreet'] = this.houseNumberAndStreet;
    data['postalCode'] = this.postalCode;
    data['city'] = this.city;
    data['countryKey'] = this.countryKey;
    data['countryName'] = this.countryName;
    data['region'] = this.region;
    data['regionDescription'] = this.regionDescription;
    return data;
  }
}
