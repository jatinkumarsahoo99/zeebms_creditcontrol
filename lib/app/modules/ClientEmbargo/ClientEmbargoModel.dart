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
  Result? result;
  int? id;
  String? exception;
  int? status;
  bool? isCanceled;
  bool? isCompleted;
  bool? isCompletedSuccessfully;
  int? creationOptions;
  String? asyncState;
  bool? isFaulted;

  CeLoad(
      {this.result,
        this.id,
        this.exception,
        this.status,
        this.isCanceled,
        this.isCompleted,
        this.isCompletedSuccessfully,
        this.creationOptions,
        this.asyncState,
        this.isFaulted});

  CeLoad.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    id = json['id'];
    exception = json['exception'];
    status = json['status'];
    isCanceled = json['isCanceled'];
    isCompleted = json['isCompleted'];
    isCompletedSuccessfully = json['isCompletedSuccessfully'];
    creationOptions = json['creationOptions'];
    asyncState = json['asyncState'];
    isFaulted = json['isFaulted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['id'] = this.id;
    data['exception'] = this.exception;
    data['status'] = this.status;
    data['isCanceled'] = this.isCanceled;
    data['isCompleted'] = this.isCompleted;
    data['isCompletedSuccessfully'] = this.isCompletedSuccessfully;
    data['creationOptions'] = this.creationOptions;
    data['asyncState'] = this.asyncState;
    data['isFaulted'] = this.isFaulted;
    return data;
  }
}

class Result {
  List<LstclientEmbs>? lstclientEmbs;
  String? minfromDate;

  Result({this.lstclientEmbs, this.minfromDate});

  Result.fromJson(Map<String, dynamic> json) {
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
