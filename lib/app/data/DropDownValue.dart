class DropDownValue {
  String? value;

  String? key;
  int? selectedIndex = 0;

  DropDownValue({this.value, this.key,this.selectedIndex});

  DropDownValue.fromJson(Map<String, dynamic> json) {
    value = json['value'];

    key = json['key'];
  }

  DropDownValue.fromJsonDynamic(
      Map<String, dynamic> json, String keyData, String name,
      {int? index = 0}) {
    value = json[name].toString();
    key = json[keyData].toString();
    selectedIndex = index;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;

    data['key'] = key;
    return data;
  }
}
