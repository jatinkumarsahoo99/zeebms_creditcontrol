class GridData {
  bool? select;
  String? Select;
  String? printBillNumber;
  String? currencyTypename;
  String? colagentName;
  String? companyName;
  String? sapProfitCentre;

  GridData({
    this.select,
    this.Select,
    this.printBillNumber,
  });

  GridData.fromJson(Map<String, dynamic> json) {
    select = json['select'];
    Select = "";
    printBillNumber = json['printBillNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['select'] = this.select;
    // data['Select'] = "";
    data['printBillNumber'] = this.printBillNumber;
    return data;
  }
}
