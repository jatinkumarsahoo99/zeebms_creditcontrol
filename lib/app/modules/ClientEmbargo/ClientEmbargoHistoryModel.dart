class ClientEmbargoHistoryModel {
  ClientNameClick? clientNameClick;

  ClientEmbargoHistoryModel({this.clientNameClick});

  ClientEmbargoHistoryModel.fromJson(Map<String, dynamic> json) {
    clientNameClick = json['clientNameClick'] != null
        ? new ClientNameClick.fromJson(json['clientNameClick'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientNameClick != null) {
      data['clientNameClick'] = this.clientNameClick!.toJson();
    }
    return data;
  }
}

class ClientNameClick {
  List<LstClient>? lstClient;
  String? strCode;

  ClientNameClick({this.lstClient, this.strCode});

  ClientNameClick.fromJson(Map<String, dynamic> json) {
    if (json['lstClient'] != null) {
      lstClient = <LstClient>[];
      json['lstClient'].forEach((v) {
        lstClient!.add(new LstClient.fromJson(v));
      });
    }
    strCode = json['strCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstClient != null) {
      data['lstClient'] = this.lstClient!.map((v) => v.toJson()).toList();
    }
    data['strCode'] = this.strCode;
    return data;
  }
}

class LstClient {
  String? clientname;
  String? fromDate;
  String? todate;
  String? reason;

  LstClient({this.clientname, this.fromDate, this.todate, this.reason});

  LstClient.fromJson(Map<String, dynamic> json) {
    clientname = json['clientname'];
    fromDate = json['fromDate'];
    todate = json['todate'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientname'] = this.clientname;
    data['fromDate'] = this.fromDate;
    data['todate'] = this.todate;
    data['reason'] = this.reason;
    return data;
  }
}
