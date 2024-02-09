class DropDownValue {
  String? value;

  String? key;
  String? optional;
  int? selectedIndex = 0;
  bool? isSelected = false;

  DropDownValue({this.value, this.key, this.selectedIndex, this.optional});

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
  Map<String, dynamic> toJsonEbill() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;

    data['key'] = key;
    data[''] = key;
    return data;
  }

  Map<String, dynamic> toJsonCustom(key1,value1) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[value1] = value;

    data[key1] = key;
    return data;
  }
}
