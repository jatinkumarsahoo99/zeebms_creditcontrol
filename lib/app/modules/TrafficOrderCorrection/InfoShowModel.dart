import 'package:bms_creditcontrol/app/data/DropDownValue.dart';

class InfoShow {
  List<LstToCorrection>? lstToCorrection;
  String? roBrandName;
  String? roZone;
  String? roClient;
  String? roAgency;
  String? roPayRoute;
  String? roBookingReferenceNumber;
  String? bookingReferenceNumber;
  String? roAdRevenue;
  List<DropDownValue>? lstClients;
  String? selectedClientCode;
  List<DropDownValue>? lstBrand;
  String? selectedBrandCode;
  List<DropDownValue>? lstAgency;
  String? selectedAgencyCode;
  List<DropDownValue>? lstPayRoutes;
  String? selectedPayRouteCode;
  List<DropDownValue>? lstplants;
  List<DropDownValue>? lstZone;
  String? selecedZoneCode;
  List<DropDownValue>? lstAdRevenue;
  String? selectedAdRevenue;
  String? roPlant;
  String? plantId;
  List<LstNewDealDetails>? lstNewDealDetails;

  InfoShow(
      {this.lstToCorrection,
      this.roBrandName,
      this.roZone,
      this.roClient,
      this.roAgency,
      this.roPayRoute,
      this.roBookingReferenceNumber,
      this.bookingReferenceNumber,
      this.roAdRevenue,
      this.lstClients,
      this.selectedClientCode,
      this.lstBrand,
      this.selectedBrandCode,
      this.lstAgency,
      this.selectedAgencyCode,
      this.lstPayRoutes,
      this.selectedPayRouteCode,
      this.lstplants,
      this.lstZone,
      this.selecedZoneCode,
      this.lstAdRevenue,
      this.selectedAdRevenue,
      this.roPlant,
      this.plantId,
      this.lstNewDealDetails});

  InfoShow.fromJson(Map<String, dynamic> json) {
    if (json['lstToCorrection'] != null) {
      lstToCorrection = <LstToCorrection>[];
      json['lstToCorrection'].forEach((v) {
        lstToCorrection!.add(new LstToCorrection.fromJson(v));
      });
    }
    roBrandName = json['roBrandName'];
    roZone = json['roZone'];
    roClient = json['roClient'];
    roAgency = json['roAgency'];
    roPayRoute = json['roPayRoute'];
    roBookingReferenceNumber = json['roBookingReferenceNumber'];
    bookingReferenceNumber = json['bookingReferenceNumber'];
    roAdRevenue = json['roAdRevenue'];
    if (json['lstClients'] != null) {
      lstClients = <DropDownValue>[];
      json['lstClients'].forEach((v) {
        lstClients!.add(
            new DropDownValue(key: v["clientCode"], value: v["clientName"]));
      });
    }
    selectedClientCode = json['selectedClientCode'];
    if (json['lstBrand'] != null) {
      lstBrand = <DropDownValue>[];
      json['lstBrand'].forEach((v) {
        lstBrand!
            .add(new DropDownValue(key: v["brandcode"], value: v["brandname"]));
      });
    }
    selectedBrandCode = json['selectedBrandCode'];
    if (json['lstAgency'] != null) {
      lstAgency = <DropDownValue>[];
      json['lstAgency'].forEach((v) {
        lstAgency!.add(
            new DropDownValue(key: v["agencycode"], value: v["agencyname"]));
      });
    }
    selectedAgencyCode = json['selectedAgencyCode'];
    if (json['lstPayRoutes'] != null) {
      lstPayRoutes = <DropDownValue>[];
      json['lstPayRoutes'].forEach((v) {
        lstPayRoutes!.add(new DropDownValue(
            key: v["payroutecode"], value: v["payroutename"]));
      });
    }
    selectedPayRouteCode = json['selectedPayRouteCode'];
    if (json['lstplants'] != null) {
      lstplants = <DropDownValue>[];
      json['lstplants'].forEach((v) {
        lstplants!.add(new DropDownValue(
            key: v["plantid"].toString(), value: v["column1"]));
      });
    }
    if (json['lstZone'] != null) {
      lstZone = <DropDownValue>[];
      json['lstZone'].forEach((v) {
        lstZone!.add(new DropDownValue(
            key: v["zoneCode"].toString(), value: v["zoneName"]));
      });
    }
    selecedZoneCode = json['selecedZoneCode'];
    if (json['lstAdRevenue'] != null) {
      lstAdRevenue = <DropDownValue>[];
      json['lstAdRevenue'].forEach((v) {
        lstAdRevenue!.add(new DropDownValue(
            key: v["accountcode"].toString(), value: v["accountname"]));
      });
    }
    selectedAdRevenue = json['selectedAdRevenue'];
    roPlant = json['roPlant'];
    plantId = json['plantId'];
    if (json['lstNewDealDetails'] != null) {
      lstNewDealDetails = <LstNewDealDetails>[];
      json['lstNewDealDetails'].forEach((v) {
        lstNewDealDetails!.add(new LstNewDealDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstToCorrection != null) {
      data['lstToCorrection'] =
          this.lstToCorrection!.map((v) => v.toJson()).toList();
    }
    data['roBrandName'] = this.roBrandName;
    data['roZone'] = this.roZone;
    data['roClient'] = this.roClient;
    data['roAgency'] = this.roAgency;
    data['roPayRoute'] = this.roPayRoute;
    data['roBookingReferenceNumber'] = this.roBookingReferenceNumber;
    data['bookingReferenceNumber'] = this.bookingReferenceNumber;
    data['roAdRevenue'] = this.roAdRevenue;
    if (this.lstClients != null) {
      data['lstClients'] = this.lstClients!.map((v) => v.toJson()).toList();
    }
    data['selectedClientCode'] = this.selectedClientCode;
    if (this.lstBrand != null) {
      data['lstBrand'] = this.lstBrand!.map((v) => v.toJson()).toList();
    }
    data['selectedBrandCode'] = this.selectedBrandCode;
    if (this.lstAgency != null) {
      data['lstAgency'] = this.lstAgency!.map((v) => v.toJson()).toList();
    }
    data['selectedAgencyCode'] = this.selectedAgencyCode;
    if (this.lstPayRoutes != null) {
      data['lstPayRoutes'] = this.lstPayRoutes!.map((v) => v.toJson()).toList();
    }
    data['selectedPayRouteCode'] = this.selectedPayRouteCode;
    if (this.lstplants != null) {
      data['lstplants'] = this.lstplants!.map((v) => v.toJson()).toList();
    }
    if (this.lstZone != null) {
      data['lstZone'] = this.lstZone!.map((v) => v.toJson()).toList();
    }
    data['selecedZoneCode'] = this.selecedZoneCode;
    if (this.lstAdRevenue != null) {
      data['lstAdRevenue'] = this.lstAdRevenue!.map((v) => v.toJson()).toList();
    }
    data['selectedAdRevenue'] = this.selectedAdRevenue;
    data['roPlant'] = this.roPlant;
    data['plantId'] = this.plantId;
    if (this.lstNewDealDetails != null) {
      data['lstNewDealDetails'] =
          this.lstNewDealDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstToCorrection {
  String? bookingNumber;
  int? bookingDetailCode;
  String? scheduleDate;
  String? scheduleTime;
  String? programName;
  String? exportTapeCode;
  String? commercialCaption;
  int? tapeDuration;
  int? spotAmount;
  String? bookingStatus;
  String? spotStatus;
  String? spotType;
  String? telecastTime;
  int? recordNumber;
  String? commercialCode;
  String? remarks;

  LstToCorrection(
      {this.bookingNumber,
      this.bookingDetailCode,
      this.scheduleDate,
      this.scheduleTime,
      this.programName,
      this.exportTapeCode,
      this.commercialCaption,
      this.tapeDuration,
      this.spotAmount,
      this.bookingStatus,
      this.spotStatus,
      this.spotType,
      this.telecastTime,
      this.recordNumber,
      this.commercialCode,
      this.remarks});

  LstToCorrection.fromJson(Map<String, dynamic> json) {
    bookingNumber = json['bookingNumber'];
    bookingDetailCode = json['bookingDetailCode'];
    scheduleDate = json['scheduleDate'];
    scheduleTime = json['scheduleTime'];
    programName = json['programName'];
    exportTapeCode = json['exportTapeCode'];
    commercialCaption = json['commercialCaption'];
    tapeDuration = json['tapeDuration'];
    spotAmount = json['spotAmount'];
    bookingStatus = json['bookingStatus'];
    spotStatus = json['spotStatus'];
    spotType = json['spotType'];
    telecastTime = json['telecastTime'];
    recordNumber = json['recordNumber'];
    commercialCode = json['commercialCode'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingNumber'] = this.bookingNumber;
    data['Booking DetailCode'] = this.bookingDetailCode;
    data['Schedule Date'] = this.scheduleDate;
    data['Schedule Time'] = this.scheduleTime;
    data['Program Name'] = this.programName;
    data['Tape Code'] = this.exportTapeCode;
    data['Caption'] = this.commercialCaption;
    data['Duration'] = this.tapeDuration;
    data['Spot Amount'] = this.spotAmount;
    data['Booking Status'] = this.bookingStatus;
    data['Telecast Status'] = this.spotStatus;
    data['Spot Type'] = this.spotType;
    data['Telecast Time'] = this.telecastTime;
    data['recordNumber'] = this.recordNumber;
    data['commercialCode'] = this.commercialCode;
    data['remarks'] = this.remarks;
    return data;
  }
}

class LstNewDealDetails {
  int? primaryEventCode;
  int? recordnumber;
  String? sponsorTypeCode;
  String? sponsorTypeName;
  String? programCode;
  String? programName;
  String? programCategoryCode;
  String? starttime;
  String? endTime;
  int? seconds;
  double? rate;
  int? amount;
  double? valuationRate;
  int? bookedSeconds;
  int? balanceSeconds;
  int? balanceAmount;
  String? bandCode;
  String? timeBand;
  int? netCode;
  String? netWorkName;
  int? sun;
  int? mon;
  int? tue;
  int? wed;
  int? thu;
  int? fri;
  int? sat;
  int? revflag;
  String? accountCode;
  String? accountname;
  int? eventcode;
  String? eventname;
  int? spots;
  String? paymentmodecaption;
  String? revenueTypeName;
  String? revenueTypeCode;
  String? subRevenueTypeName;
  int? subRevenueTypeCode;
  int? countBased;
  int? baseDuration;

  LstNewDealDetails(
      {this.primaryEventCode,
      this.recordnumber,
      this.sponsorTypeCode,
      this.sponsorTypeName,
      this.programCode,
      this.programName,
      this.programCategoryCode,
      this.starttime,
      this.endTime,
      this.seconds,
      this.rate,
      this.amount,
      this.valuationRate,
      this.bookedSeconds,
      this.balanceSeconds,
      this.balanceAmount,
      this.bandCode,
      this.timeBand,
      this.netCode,
      this.netWorkName,
      this.sun,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.sat,
      this.revflag,
      this.accountCode,
      this.accountname,
      this.eventcode,
      this.eventname,
      this.spots,
      this.paymentmodecaption,
      this.revenueTypeName,
      this.revenueTypeCode,
      this.subRevenueTypeName,
      this.subRevenueTypeCode,
      this.countBased,
      this.baseDuration});

  LstNewDealDetails.fromJson(Map<String, dynamic> json) {
    primaryEventCode = json['primaryEventCode'];
    recordnumber = json['recordnumber'];
    sponsorTypeCode = json['sponsorTypeCode'];
    sponsorTypeName = json['sponsorTypeName'];
    programCode = json['programCode'];
    programName = json['programName'];
    programCategoryCode = json['programCategoryCode'];
    starttime = json['starttime'];
    endTime = json['endTime'];
    seconds = json['seconds'];
    rate = json['rate'];
    amount = json['amount'];
    valuationRate = json['valuationRate'];
    bookedSeconds = json['bookedSeconds'];
    balanceSeconds = json['balanceSeconds'];
    balanceAmount = json['balanceAmount'];
    bandCode = json['bandCode'];
    timeBand = json['timeBand'];
    netCode = json['netCode'];
    netWorkName = json['netWorkName'];
    sun = json['sun'];
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thu = json['thu'];
    fri = json['fri'];
    sat = json['sat'];
    revflag = json['revflag'];
    accountCode = json['accountCode'];
    accountname = json['accountname'];
    eventcode = json['eventcode'];
    eventname = json['eventname'];
    spots = json['spots'];
    paymentmodecaption = json['paymentmodecaption'];
    revenueTypeName = json['revenueTypeName'];
    revenueTypeCode = json['revenueTypeCode'];
    subRevenueTypeName = json['subRevenueTypeName'];
    subRevenueTypeCode = json['subRevenueTypeCode'];
    countBased = json['countBased'];
    baseDuration = json['baseDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primaryEventCode'] = this.primaryEventCode;
    data['recordnumber'] = this.recordnumber;
    data['sponsorTypeCode'] = this.sponsorTypeCode;
    data['sponsorTypeName'] = this.sponsorTypeName;
    data['programCode'] = this.programCode;
    data['programName'] = this.programName;
    data['programCategoryCode'] = this.programCategoryCode;
    data['starttime'] = this.starttime;
    data['endTime'] = this.endTime;
    data['seconds'] = this.seconds;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['valuationRate'] = this.valuationRate;
    data['bookedSeconds'] = this.bookedSeconds;
    data['balanceSeconds'] = this.balanceSeconds;
    data['balanceAmount'] = this.balanceAmount;
    data['bandCode'] = this.bandCode;
    data['timeBand'] = this.timeBand;
    data['netCode'] = this.netCode;
    data['netWorkName'] = this.netWorkName;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tue'] = this.tue;
    data['wed'] = this.wed;
    data['thu'] = this.thu;
    data['fri'] = this.fri;
    data['sat'] = this.sat;
    data['revflag'] = this.revflag;
    data['accountCode'] = this.accountCode;
    data['accountname'] = this.accountname;
    data['eventcode'] = this.eventcode;
    data['eventname'] = this.eventname;
    data['spots'] = this.spots;
    data['paymentmodecaption'] = this.paymentmodecaption;
    data['revenueTypeName'] = this.revenueTypeName;
    data['revenueTypeCode'] = this.revenueTypeCode;
    data['subRevenueTypeName'] = this.subRevenueTypeName;
    data['subRevenueTypeCode'] = this.subRevenueTypeCode;
    data['countBased'] = this.countBased;
    data['baseDuration'] = this.baseDuration;
    return data;
  }
}
