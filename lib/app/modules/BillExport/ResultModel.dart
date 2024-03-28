class ResultModel {
  List<Files>? files;

  ResultModel({this.files});

  ResultModel.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  String? fileName;
  String? fileBytes;

  Files({this.fileName, this.fileBytes});

  Files.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    fileBytes = json['fileBytes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['fileBytes'] = this.fileBytes;
    return data;
  }
}


class DataModelList {
  List<DataModel>? dataModels;

  DataModelList({this.dataModels});

  DataModelList.fromJson(Map<String, dynamic> json) {
    if (json['model'] != null) {
      dataModels = <DataModel>[];
      json['model'].forEach((v) {
        dataModels!.add(new DataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataModels != null) {
      data['files'] = this.dataModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataModel {
  String? broadcasterID;
  String? broadcaster;
  String? channelID;
  String? channel;
  String? agencyID;
  String? branchCode;
  String? billNumber;
  String? billdate;
  String? clientCode;
  String? client;
  String? grossAmount;
  String? serviceTax;
  String? netAmount;
  String? agencyCommision;
  String? spotID;
  String? spotDate;
  String? brand;
  String? caption;
  String? programme;
  String? telecastDate;
  String? telecastTime;
  String? day;
  String? stime;
  String? etime;
  int? duration;
  int? rateper10;
  int? amount;
  String? bookingReferenceNumber;
  String? bookingNumber;

  DataModel(
      {this.broadcasterID,
        this.broadcaster,
        this.channelID,
        this.channel,
        this.agencyID,
        this.branchCode,
        this.billNumber,
        this.billdate,
        this.clientCode,
        this.client,
        this.grossAmount,
        this.serviceTax,
        this.netAmount,
        this.agencyCommision,
        this.spotID,
        this.spotDate,
        this.brand,
        this.caption,
        this.programme,
        this.telecastDate,
        this.telecastTime,
        this.day,
        this.stime,
        this.etime,
        this.duration,
        this.rateper10,
        this.amount,
        this.bookingReferenceNumber,
        this.bookingNumber});

  DataModel.fromJson(Map<String, dynamic> json) {
    broadcasterID = json['broadcasterID'];
    broadcaster = json['broadcaster'];
    channelID = json['channelID'];
    channel = json['channel'];
    agencyID = json['agencyID'];
    branchCode = json['branchCode'];
    billNumber = json['billNumber'];
    billdate = json['billdate'];
    clientCode = json['clientCode'];
    client = json['client'];
    grossAmount = json['GrossAmount'];
    serviceTax = json['ServiceTax'];
    netAmount = json['NetAmount'];
    agencyCommision = json['AgencyCommision'];
    spotID = json['spotID'];
    spotDate = json['spotDate'];
    brand = json['brand'];
    caption = json['caption'];
    programme = json['programme'];
    telecastDate = json['telecastDate'];
    telecastTime = json['telecastTime'];
    day = json['day'];
    stime = json['stime'];
    etime = json['etime'];
    duration = json['duration'];
    rateper10 = json['rateper10'];
    amount = json['amount'];
    bookingReferenceNumber = json['bookingReferenceNumber'];
    bookingNumber = json['bookingNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['broadcaster ID'] = this.broadcasterID;
    data['broadcaster'] = this.broadcaster;
    data['channel ID'] = this.channelID;
    data['channel'] = this.channel;
    data['agency ID'] = this.agencyID;
    data['branch Code'] = this.branchCode;
    data['bill No'] = this.billNumber;
    data['bill date'] = this.billdate;
    data['client Code'] = this.clientCode;
    data['client'] = this.client;
    data['Gross Amount'] = this.grossAmount;
    data['Service Tax'] = this.serviceTax;
    data['Net Amount'] = this.netAmount;
    data['Agency Commision'] = this.agencyCommision;
    data['spotID'] = this.spotID;
    data['spot Date'] = this.spotDate;
    data['brand'] = this.brand;
    data['caption'] = this.caption;
    data['programme'] = this.programme;
    data['telecast Date'] = this.telecastDate;
    data['telecast Time'] = this.telecastTime;
    data['day'] = this.day;
    data['stime'] = this.stime;
    data['etime'] = this.etime;
    data['duration'] = this.duration;
    data['rate per10'] = this.rateper10;
    data['amount'] = this.amount;
    data['booking Ref No'] = this.bookingReferenceNumber;
    data['booking No'] = this.bookingNumber;
    return data;
  }
}

