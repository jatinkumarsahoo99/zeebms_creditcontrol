class InvoiceRevisionModel {
  List<Retrieve>? retrieve;

  InvoiceRevisionModel({this.retrieve});

  InvoiceRevisionModel.fromJson(Map<String, dynamic> json) {
    retrieve = json["retrieve"] == null
        ? null
        : (json["retrieve"] as List).map((e) => Retrieve.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (retrieve != null) {
      _data["retrieve"] = retrieve?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Retrieve {
  String? locationName;
  String? channelName;
  String? clientName;
  String? agencyName;
  String? payrouteName;
  String? sapInvoiceNo;
  String? billDate;
  String? toNumber;
  int? bookingAmount;
  String? channelcode;
  String? locationcode;
  String? currencytype;
  String? clientCode;
  String? agencyCode;
  String? payrouteCode;

  Retrieve(
      {this.locationName,
      this.channelName,
      this.clientName,
      this.agencyName,
      this.payrouteName,
      this.sapInvoiceNo,
      this.billDate,
      this.toNumber,
      this.bookingAmount,
      this.channelcode,
      this.locationcode,
      this.currencytype,
      this.clientCode,
      this.agencyCode,
      this.payrouteCode});

  Retrieve.fromJson(Map<String, dynamic> json) {
    locationName = json["locationName"];
    channelName = json["channelName"];
    clientName = json["clientName"];
    agencyName = json["agencyName"];
    payrouteName = json["payrouteName"];
    sapInvoiceNo = json["sapInvoiceNo"];
    billDate = json["billDate"];
    toNumber = json["toNumber"];
    bookingAmount = json["bookingAmount"];
    channelcode = json["channelcode"];
    locationcode = json["locationcode"];
    currencytype = json["currencytype"];
    clientCode = json["clientCode"];
    agencyCode = json["agencyCode"];
    payrouteCode = json["payrouteCode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["locationName"] = locationName;
    _data["channelName"] = channelName;
    _data["clientName"] = clientName;
    _data["agencyName"] = agencyName;
    _data["payrouteName"] = payrouteName;
    _data["sapInvoiceNo"] = sapInvoiceNo;
    _data["billDate"] = billDate;
    _data["toNumber"] = toNumber;
    _data["bookingAmount"] = bookingAmount;
    _data["channelcode"] = channelcode;
    _data["locationcode"] = locationcode;
    _data["currencytype"] = currencytype;
    _data["clientCode"] = clientCode;
    _data["agencyCode"] = agencyCode;
    _data["payrouteCode"] = payrouteCode;
    return _data;
  }
}
