class ServiceListModel {
  List<ServiceRetrieve>? serviceRetrieve;

  ServiceListModel({this.serviceRetrieve});

  ServiceListModel.fromJson(Map<dynamic, dynamic> json) {
    serviceRetrieve = json == null
        ? null
        : (json as List).map((e) => ServiceRetrieve.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (serviceRetrieve != null) {
      _data["serviceRetrieve"] =
          serviceRetrieve?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ServiceRetrieve {
  String? payroutecode;
  String? payroutename;
  String? currencyType;
  int? mainCompanyShare;
  int? collectionAgentShare;
  int? agencyShare;
  int? amount;
  String? accountcode;
  String? accountname;

  ServiceRetrieve(
      {this.payroutecode,
      this.payroutename,
      this.currencyType,
      this.mainCompanyShare,
      this.collectionAgentShare,
      this.agencyShare,
      this.amount,
      this.accountcode,
      this.accountname});

  ServiceRetrieve.fromJson(Map<String, dynamic> json) {
    payroutecode = json["payroutecode"];
    payroutename = json["payroutename"];
    currencyType = json["currencyType"];
    mainCompanyShare = json["mainCompanyShare"];
    collectionAgentShare = json["collectionAgentShare"];
    agencyShare = json["agencyShare"];
    amount = json["amount"];
    accountcode = json["accountcode"];
    accountname = json["accountname"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["payroutecode"] = payroutecode;
    _data["payroutename"] = payroutename;
    _data["currencyType"] = currencyType;
    _data["mainCompanyShare"] = mainCompanyShare;
    _data["collectionAgentShare"] = collectionAgentShare;
    _data["agencyShare"] = agencyShare;
    _data["amount"] = amount;
    _data["accountcode"] = accountcode;
    _data["accountname"] = accountname;
    return _data;
  }
}
