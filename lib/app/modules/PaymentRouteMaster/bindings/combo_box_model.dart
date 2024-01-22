import 'package:bms_creditcontrol/app/data/DropDownValue.dart';

class PaymentRouteMasterComboBoxes {
  Lstcombobox? lstcombobox;

  PaymentRouteMasterComboBoxes({this.lstcombobox});

  PaymentRouteMasterComboBoxes.fromJson(Map<String, dynamic> json) {
    lstcombobox = json["lstcombobox"] == null
        ? null
        : Lstcombobox.fromJson(json["lstcombobox"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstcombobox != null) {
      _data["lstcombobox"] = lstcombobox?.toJson();
    }
    return _data;
  }
}

class Lstcombobox {
  List<LstLocation>? lstLocation;
  List<LstCurrency>? lstCurrency;
  List<LstPayRouteCategory>? lstPayRouteCategory;

  Lstcombobox({this.lstLocation, this.lstCurrency, this.lstPayRouteCategory});

  Lstcombobox.fromJson(Map<String, dynamic> json) {
    lstLocation = json["lstLocation"] == null
        ? null
        : (json["lstLocation"] as List)
            .map((e) => LstLocation.fromJson(e))
            .toList();
    lstCurrency = json["lstCurrency"] == null
        ? null
        : (json["lstCurrency"] as List)
            .map((e) => LstCurrency.fromJson(e))
            .toList();
    lstPayRouteCategory = json["lstPayRouteCategory"] == null
        ? null
        : (json["lstPayRouteCategory"] as List)
            .map((e) => LstPayRouteCategory.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstLocation != null) {
      _data["lstLocation"] = lstLocation?.map((e) => e.toJson()).toList();
    }
    if (lstCurrency != null) {
      _data["lstCurrency"] = lstCurrency?.map((e) => e.toJson()).toList();
    }
    if (lstPayRouteCategory != null) {
      _data["lstPayRouteCategory"] =
          lstPayRouteCategory?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class LstPayRouteCategory {
  String? payrouteCategoryCode;
  String? payrouteCategoryName;
  String? modifiedBy;
  String? modifiedOn;
  String? r4Yn;

  LstPayRouteCategory(
      {this.payrouteCategoryCode,
      this.payrouteCategoryName,
      this.modifiedBy,
      this.modifiedOn,
      this.r4Yn});

  LstPayRouteCategory.fromJson(Map<String, dynamic> json) {
    payrouteCategoryCode = json["payrouteCategoryCode"];
    payrouteCategoryName = json["payrouteCategoryName"];
    modifiedBy = json["modifiedBy"];
    modifiedOn = json["modifiedOn"];
    r4Yn = json["r4_YN"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["payrouteCategoryCode"] = payrouteCategoryCode;
    _data["payrouteCategoryName"] = payrouteCategoryName;
    _data["modifiedBy"] = modifiedBy;
    _data["modifiedOn"] = modifiedOn;
    _data["r4_YN"] = r4Yn;
    return _data;
  }
}

class LstCurrency {
  String? currencyTypeCode;
  String? currencyTypeName;
  String? defaultCurrency;
  String? currencyType;
  String? currencyShortName;
  String? locationCode;
  dynamic lowercurrencyname;
  String? currency;

  LstCurrency(
      {this.currencyTypeCode,
      this.currencyTypeName,
      this.defaultCurrency,
      this.currencyType,
      this.currencyShortName,
      this.locationCode,
      this.lowercurrencyname,
      this.currency});

  LstCurrency.fromJson(Map<String, dynamic> json) {
    currencyTypeCode = json["currencyTypeCode"];
    currencyTypeName = json["currencyTypeName"];
    defaultCurrency = json["defaultCurrency"];
    currencyType = json["currencyType"];
    currencyShortName = json["currencyShortName"];
    locationCode = json["locationCode"];
    lowercurrencyname = json["lowercurrencyname"];
    currency = json["currency"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["currencyTypeCode"] = currencyTypeCode;
    _data["currencyTypeName"] = currencyTypeName;
    _data["defaultCurrency"] = defaultCurrency;
    _data["currencyType"] = currencyType;
    _data["currencyShortName"] = currencyShortName;
    _data["locationCode"] = locationCode;
    _data["lowercurrencyname"] = lowercurrencyname;
    _data["currency"] = currency;
    return _data;
  }
}

class LstLocation {
  String? locationCode;
  String? locationName;

  LstLocation({this.locationCode, this.locationName});

  LstLocation.fromJson(Map<String, dynamic> json) {
    locationCode = json["locationCode"];
    locationName = json["locationName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["locationCode"] = locationCode;
    _data["locationName"] = locationName;
    return _data;
  }
}
