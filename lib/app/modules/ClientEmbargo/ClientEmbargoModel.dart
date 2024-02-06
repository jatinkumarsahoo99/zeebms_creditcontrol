class ClientEmbargoModel {
  CeLoad? ceLoad;

  ClientEmbargoModel({this.ceLoad});

  ClientEmbargoModel.fromJson(Map<String, dynamic> json) {
    ceLoad =
    json['ceLoad'] != null ? new CeLoad.fromJson(json['ceLoad']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ceLoad != null) {
      data['ceLoad'] = this.ceLoad!.toJson();
    }
    return data;
  }
}

class CeLoad {
  List<LstclientEmbs>? lstclientEmbs;
  String? minfromDate;

  CeLoad({this.lstclientEmbs, this.minfromDate});

  CeLoad.fromJson(Map<String, dynamic> json) {
    if (json['lstclientEmbs'] != null) {
      lstclientEmbs = <LstclientEmbs>[];
      json['lstclientEmbs'].forEach((v) {
        lstclientEmbs!.add(new LstclientEmbs.fromJson(v));
      });
    }
    minfromDate = json['minfromDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstclientEmbs != null) {
      data['lstclientEmbs'] =
          this.lstclientEmbs!.map((v) => v.toJson()).toList();
    }
    data['minfromDate'] = this.minfromDate;
    return data;
  }
}

class LstclientEmbs {
  String? locationcode;
  String? channelcode;
  int? embargoNo;
  String? clientcode;
  String? clientname;
  String? fromdate;
  String? todate;
  String? reason;

  LstclientEmbs(
      {this.locationcode,
        this.channelcode,
        this.embargoNo,
        this.clientcode,
        this.clientname,
        this.fromdate,
        this.todate,
        this.reason});

  LstclientEmbs.fromJson(Map<String, dynamic> json) {
    locationcode = json['locationcode'];
    channelcode = json['channelcode'];
    embargoNo = json['embargoNo'];
    clientcode = json['clientcode'];
    clientname = json['clientname'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationcode'] = this.locationcode;
    data['channelcode'] = this.channelcode;
    data['embargoNo'] = this.embargoNo;
    data['clientcode'] = this.clientcode;
    data['clientname'] = this.clientname;
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    data['reason'] = this.reason;
    return data;
  }
}
