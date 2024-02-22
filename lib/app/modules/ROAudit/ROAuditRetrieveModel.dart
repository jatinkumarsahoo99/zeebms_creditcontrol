class ROAuditRetrieveModel {
  InfoBindList? infoBindList;

  ROAuditRetrieveModel({this.infoBindList});

  ROAuditRetrieveModel.fromJson(Map<String, dynamic> json) {
    infoBindList = json['infoBindList'] != null
        ? new InfoBindList.fromJson(json['infoBindList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.infoBindList != null) {
      data['infoBindList'] = this.infoBindList!.toJson();
    }
    return data;
  }
}

class InfoBindList {
  dynamic lstPendingAudit;
  List<LstAdditions>? lstAdditions;
  List<LstCancellation>? lstCancellation;
  List<LstReschedule>? lstReschedule;
  dynamic lstDealApprovals;

  InfoBindList(
      {this.lstPendingAudit,
        this.lstAdditions,
        this.lstCancellation,
        this.lstReschedule,
        this.lstDealApprovals});

  InfoBindList.fromJson(Map<String, dynamic> json) {
    lstPendingAudit = json['lstPendingAudit'];
    if (json['lstAdditions'] != null) {
      lstAdditions = <LstAdditions>[];
      json['lstAdditions'].forEach((v) {
        lstAdditions!.add(new LstAdditions.fromJson(v));
      });
    }
    if (json['lstCancellation'] != null) {
      lstCancellation = <LstCancellation>[];
      json['lstCancellation'].forEach((v) {
        lstCancellation!.add(new LstCancellation.fromJson(v));
      });
    }
    if (json['lstReschedule'] != null) {
      lstReschedule = <LstReschedule>[];
      json['lstReschedule'].forEach((v) {
        lstReschedule!.add(new LstReschedule.fromJson(v));
      });
    }
    lstDealApprovals = json['lstDealApprovals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lstPendingAudit'] = this.lstPendingAudit;
    if (this.lstAdditions != null) {
      data['lstAdditions'] = this.lstAdditions!.map((v) => v.toJson()).toList();
    }
    if (this.lstCancellation != null) {
      data['lstCancellation'] =
          this.lstCancellation!.map((v) => v.toJson()).toList();
    }
    if (this.lstReschedule != null) {
      data['lstReschedule'] =
          this.lstReschedule!.map((v) => v.toJson()).toList();
    }
    data['lstDealApprovals'] = this.lstDealApprovals;
    return data;
  }
}

class LstAdditions {
  int? bookingmonth;
  int? bookingnumber;
  String? zonename;
  String? clientname;
  String? agencyname;
  String? brandname;
  int? totalspots;
  int? auditedSpots;
  double? bookedAMount;
  double? auditedamount;
  String? payroutename;
  int? unauditedSpots;
  int? dropped;
  String? bookingno;
  String? bookicongReferenceNumber;
  String? bookedBy;
  String? salesBook;
  String? enteredOn;
  String? agencyGSTNumber;
  String? plantName;
  String? column1;

  LstAdditions(
      {this.bookingmonth,
        this.bookingnumber,
        this.zonename,
        this.clientname,
        this.agencyname,
        this.brandname,
        this.totalspots,
        this.auditedSpots,
        this.bookedAMount,
        this.auditedamount,
        this.payroutename,
        this.unauditedSpots,
        this.dropped,
        this.bookingno,
        this.bookicongReferenceNumber,
        this.bookedBy,
        this.salesBook,
        this.enteredOn,
        this.agencyGSTNumber,
        this.plantName,
        this.column1});

  LstAdditions.fromJson(Map<String, dynamic> json) {
    bookingmonth = json['bookingmonth'];
    bookingnumber = json['bookingnumber'];
    zonename = json['zonename'];
    clientname = json['clientname'];
    agencyname = json['agencyname'];
    brandname = json['brandname'];
    totalspots = json['totalspots'];
    auditedSpots = json['auditedSpots'];
    bookedAMount = json['bookedAMount'];
    auditedamount = json['auditedamount'];
    payroutename = json['payroutename'];
    unauditedSpots = json['unaudited_spots'];
    dropped = json['dropped'];
    bookingno = json['bookingno'];
    bookicongReferenceNumber = json['bookicongReferenceNumber'];
    bookedBy = json['bookedBy'];
    salesBook = json['salesBook'];
    enteredOn = json['enteredOn'];
    agencyGSTNumber = json['agencyGSTNumber'];
    plantName = json['plantName'];
    column1 = json['column1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingmonth'] = this.bookingmonth;
    data['bookingnumber'] = this.bookingnumber;
    data['zonename'] = this.zonename;
    data['clientname'] = this.clientname;
    data['agencyname'] = this.agencyname;
    data['brandname'] = this.brandname;
    data['totalspots'] = this.totalspots;
    data['auditedSpots'] = this.auditedSpots;
    data['bookedAMount'] = this.bookedAMount;
    data['auditedamount'] = this.auditedamount;
    data['payroutename'] = this.payroutename;
    data['unaudited_spots'] = this.unauditedSpots;
    data['dropped'] = this.dropped;
    data['bookingno'] = this.bookingno;
    data['bookicongReferenceNumber'] = this.bookicongReferenceNumber;
    data['bookedBy'] = this.bookedBy;
    data['salesBook'] = this.salesBook;
    data['enteredOn'] = this.enteredOn;
    data['agencyGSTNumber'] = this.agencyGSTNumber;
    data['plantName'] = this.plantName;
    data['column1'] = this.column1;
    return data;
  }
}

class LstCancellation {
  String? clientname;
  String? agencyname;
  String? brandName;
  String? payroutename;
  String? zoneName;
  int? cancelmonth;
  int? cancelNumber;
  String? bookingnumber;
  int? totalspots;
  int? auditedSpots;
  String? cancellationNumber;
  double? spotamount;
  String? auditedBy;
  String? salesBook;

  LstCancellation(
      {this.clientname,
        this.agencyname,
        this.brandName,
        this.payroutename,
        this.zoneName,
        this.cancelmonth,
        this.cancelNumber,
        this.bookingnumber,
        this.totalspots,
        this.auditedSpots,
        this.cancellationNumber,
        this.spotamount,
        this.auditedBy,
        this.salesBook});

  LstCancellation.fromJson(Map<String, dynamic> json) {
    clientname = json['clientname'];
    agencyname = json['agencyname'];
    brandName = json['brandName'];
    payroutename = json['payroutename'];
    zoneName = json['zoneName'];
    cancelmonth = json['cancelmonth'];
    cancelNumber = json['cancelNumber'];
    bookingnumber = json['bookingnumber'];
    totalspots = json['totalspots'];
    auditedSpots = json['auditedSpots'];
    cancellationNumber = json['cancellationNumber'];
    spotamount = json['spotamount'];
    auditedBy = json['auditedBy'];
    salesBook = json['salesBook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientname'] = this.clientname;
    data['agencyname'] = this.agencyname;
    data['brandName'] = this.brandName;
    data['payroutename'] = this.payroutename;
    data['zoneName'] = this.zoneName;
    data['cancelmonth'] = this.cancelmonth;
    data['cancelNumber'] = this.cancelNumber;
    data['bookingnumber'] = this.bookingnumber;
    data['totalspots'] = this.totalspots;
    data['auditedSpots'] = this.auditedSpots;
    data['cancellationNumber'] = this.cancellationNumber;
    data['spotamount'] = this.spotamount;
    data['auditedBy'] = this.auditedBy;
    data['salesBook'] = this.salesBook;
    return data;
  }
}

class LstReschedule {
  String? clientname;
  String? agencyname;
  String? brandName;
  int? reschedulemonth;
  int? rescheduleNumber;
  String? bookingnumber;
  int? totalspots;
  int? auditedSpots;
  String? rescheduledBy;
  String? salesBook;

  LstReschedule(
      {this.clientname,
        this.agencyname,
        this.brandName,
        this.reschedulemonth,
        this.rescheduleNumber,
        this.bookingnumber,
        this.totalspots,
        this.auditedSpots,
        this.rescheduledBy,
        this.salesBook});

  LstReschedule.fromJson(Map<String, dynamic> json) {
    clientname = json['clientname'];
    agencyname = json['agencyname'];
    brandName = json['brandName'];
    reschedulemonth = json['reschedulemonth'];
    rescheduleNumber = json['rescheduleNumber'];
    bookingnumber = json['bookingnumber'];
    totalspots = json['totalspots'];
    auditedSpots = json['auditedSpots'];
    rescheduledBy = json['rescheduledBy'];
    salesBook = json['salesBook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientname'] = this.clientname;
    data['agencyname'] = this.agencyname;
    data['brandName'] = this.brandName;
    data['reschedulemonth'] = this.reschedulemonth;
    data['rescheduleNumber'] = this.rescheduleNumber;
    data['bookingnumber'] = this.bookingnumber;
    data['totalspots'] = this.totalspots;
    data['auditedSpots'] = this.auditedSpots;
    data['rescheduledBy'] = this.rescheduledBy;
    data['salesBook'] = this.salesBook;
    return data;
  }
}




