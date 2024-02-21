class CompareModelList {
  List<Model>? model;

  CompareModelList({this.model});

  CompareModelList.fromJson(Map<String, dynamic> json) {
    if (json['model'] != null) {
      model = <Model>[];
      json['model'].forEach((v) {
        model!.add(new Model.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.model != null) {
      data['model'] = this.model!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Model {
  int? recordnumber;
  String? sponsortypenameProposed;
  String? sponsortypenameCurrent;
  String? programnameProposed;
  String? programnameCurrent;
  String? starttimeProposed;
  String? starttimeCurrent;
  String? endTimeProposed;
  String? endTimeCurrent;
  int? secondsProposed;
  int? secondsCurrent;
  int? rateProposed;
  int? rateCurrent;
  int? amountProposed;
  int? amountCurrent;
  int? valuationRateProposed;
  int? valuationRateCurrent;

  Model(
      {this.recordnumber,
        this.sponsortypenameProposed,
        this.sponsortypenameCurrent,
        this.programnameProposed,
        this.programnameCurrent,
        this.starttimeProposed,
        this.starttimeCurrent,
        this.endTimeProposed,
        this.endTimeCurrent,
        this.secondsProposed,
        this.secondsCurrent,
        this.rateProposed,
        this.rateCurrent,
        this.amountProposed,
        this.amountCurrent,
        this.valuationRateProposed,
        this.valuationRateCurrent});

  Model.fromJson(Map<String, dynamic> json) {
    recordnumber = json['recordnumber'];
    sponsortypenameProposed = json['sponsortypename_Proposed'];
    sponsortypenameCurrent = json['sponsortypename_Current'];
    programnameProposed = json['programname_Proposed'];
    programnameCurrent = json['programname_Current'];
    starttimeProposed = json['starttime_Proposed'];
    starttimeCurrent = json['starttime_Current'];
    endTimeProposed = json['endTime_Proposed'];
    endTimeCurrent = json['endTime_Current'];
    secondsProposed = json['seconds_Proposed'];
    secondsCurrent = json['seconds_Current'];
    rateProposed = json['rate_Proposed'];
    rateCurrent = json['rate_Current'];
    amountProposed = json['amount_Proposed'];
    amountCurrent = json['amount_Current'];
    valuationRateProposed = json['valuationRate_Proposed'];
    valuationRateCurrent = json['valuationRate_Current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordnumber'] = this.recordnumber;
    data['sponsortypename_Proposed'] = this.sponsortypenameProposed;
    data['sponsortypename_Current'] = this.sponsortypenameCurrent;
    data['programname_Proposed'] = this.programnameProposed;
    data['programname_Current'] = this.programnameCurrent;
    data['starttime_Proposed'] = this.starttimeProposed;
    data['starttime_Current'] = this.starttimeCurrent;
    data['endTime_Proposed'] = this.endTimeProposed;
    data['endTime_Current'] = this.endTimeCurrent;
    data['seconds_Proposed'] = this.secondsProposed;
    data['seconds_Current'] = this.secondsCurrent;
    data['rate_Proposed'] = this.rateProposed;
    data['rate_Current'] = this.rateCurrent;
    data['amount_Proposed'] = this.amountProposed;
    data['amount_Current'] = this.amountCurrent;
    data['valuationRate_Proposed'] = this.valuationRateProposed;
    data['valuationRate_Current'] = this.valuationRateCurrent;
    return data;
  }
}
