import 'package:bms_creditcontrol/app/data/DropDownValue.dart';

class BillExportInitModel {
  List<DropDownValue>? lstLocation;
  List<DropDownValue>? lstChannel;
  List<DropDownValue>? lstAgency;

  BillExportInitModel({this.lstLocation, this.lstChannel});

  BillExportInitModel.fromJson(Map<String, dynamic> json) {
    if (json['locations'] != null) {
      lstLocation = <DropDownValue>[];
      json['locations'].forEach((v) {
        lstLocation!.add(new DropDownValue(key: v["locationcode"],value: v["locationname"]));
      });
    }
    if (json['channels'] != null) {
      lstChannel = <DropDownValue>[];
      json['channels'].forEach((v) {
        lstChannel!.add(new DropDownValue(key: v["channelcode"],value: v["channelname"]));
      });
    }
    if (json['agencies'] != null) {
      lstAgency = <DropDownValue>[];
      json['agencies'].forEach((v) {
        lstAgency!.add(new DropDownValue(key: v["agencycode"],value: v["agencyname"]));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstLocation != null) {
      data['lstLocation'] = this.lstLocation!.map((v) => v.toJson()).toList();
    }
    if (this.lstChannel != null) {
      data['lstChannel'] = this.lstChannel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

