class SelectExecutiveModel {
  String? userName;
  String? personnelName;
  String? personnelCode;
  String? personnelNo;
  String? personnelShortName;
  String? employeeName;
  String? email;
  String? mobileNo;
  String? department;
  String? designation;
  String? stationCode;
  String? locationCode;
  String? companyCode;
  String? placeCode;
  int? status;

  SelectExecutiveModel(
      {this.userName,
      this.personnelName,
      this.personnelCode,
      this.personnelNo,
      this.personnelShortName,
      this.employeeName,
      this.email,
      this.mobileNo,
      this.department,
      this.designation,
      this.stationCode,
      this.locationCode,
      this.companyCode,
      this.placeCode,
      this.status});

  SelectExecutiveModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    personnelName = json['personnelName'];
    personnelCode = json['personnelCode'];
    personnelNo = json['personnelNo'];
    personnelShortName = json['personnelShortName'];
    employeeName = json['employeeName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    department = json['department'];
    designation = json['designation'];
    stationCode = json['stationCode'];
    locationCode = json['locationCode'];
    companyCode = json['companyCode'];
    placeCode = json['placeCode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['personnelName'] = this.personnelName;
    data['personnelCode'] = this.personnelCode;
    data['personnelNo'] = this.personnelNo;
    data['personnelShortName'] = this.personnelShortName;
    data['employeeName'] = this.employeeName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['department'] = this.department;
    data['designation'] = this.designation;
    data['stationCode'] = this.stationCode;
    data['locationCode'] = this.locationCode;
    data['companyCode'] = this.companyCode;
    data['placeCode'] = this.placeCode;
    data['status'] = this.status;
    return data;
  }
}
