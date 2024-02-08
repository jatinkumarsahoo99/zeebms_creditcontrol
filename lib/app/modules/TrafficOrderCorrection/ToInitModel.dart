import '../../data/DropDownValue.dart';

class ToInitModel {
  Onload? onload;

  ToInitModel({this.onload});

  ToInitModel.fromJson(Map<String, dynamic> json) {
    onload =
    json['onload'] != null ? new Onload.fromJson(json['onload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onload != null) {
      data['onload'] = this.onload!.toJson();
    }
    return data;
  }
}

class Onload {
  String? fromDate;
  String? toDate;
  List<DropDownValue>? lstLocation;
  List<DropDownValue>? lstZone;

  Onload({this.fromDate, this.toDate, this.lstLocation, this.lstZone});

  Onload.fromJson(Map<String, dynamic> json) {
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    if (json['lstLocation'] != null) {
      lstLocation = <DropDownValue>[];
      json['lstLocation'].forEach((v) {
        lstLocation!.add(new DropDownValue(key: v["locationCode"],value: v["locationName"]));
      });
    }
    if (json['lstZone'] != null) {
      lstZone = <DropDownValue>[];
      json['lstZone'].forEach((v) {
        lstZone!.add(new DropDownValue(key: v["zoneCode"],value: v["zoneName"]));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    if (this.lstLocation != null) {
      data['lstLocation'] = this.lstLocation!.map((v) => v.toJson()).toList();
    }
    if (this.lstZone != null) {
      data['lstZone'] = this.lstZone!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}