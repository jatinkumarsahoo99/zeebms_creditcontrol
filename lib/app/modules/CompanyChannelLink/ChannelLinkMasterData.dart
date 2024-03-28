import 'package:bms_creditcontrol/app/data/DropDownValue.dart';

import '../../../widgets/CheckBox/multi_check_box.dart';

class ChannelLinkMasterData {
  List<DropDownValue>? lstLocations;
  LstfillComboRes? lstfillComboRes;
  List<CompanyChannelLinkDatas>? companyChannelLinkDatas;

  ChannelLinkMasterData(
      {this.lstLocations, this.lstfillComboRes, this.companyChannelLinkDatas});

  ChannelLinkMasterData.fromJson(Map<String, dynamic> json) {
    if (json['lstLocations'] != null) {
      lstLocations = <DropDownValue>[];
      json['lstLocations'].forEach((v) {
        lstLocations!.add(new DropDownValue(
            key: v["locationCode"], value: v["locationName"]));
      });
    }
    lstfillComboRes = json['lstfillComboRes'] != null
        ? new LstfillComboRes.fromJson(json['lstfillComboRes'])
        : null;
    if (json['companyChannelLinkDatas'] != null) {
      companyChannelLinkDatas = <CompanyChannelLinkDatas>[];
      json['companyChannelLinkDatas'].forEach((v) {
        companyChannelLinkDatas!.add(new CompanyChannelLinkDatas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstLocations != null) {
      data['lstLocations'] = this.lstLocations!.map((v) => v.toJson()).toList();
    }
    if (this.lstfillComboRes != null) {
      data['lstfillComboRes'] = this.lstfillComboRes!.toJson();
    }
    if (this.companyChannelLinkDatas != null) {
      data['companyChannelLinkDatas'] =
          this.companyChannelLinkDatas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstfillComboRes {
  List<DropDownValue>? lstPayRouteCategories;
  List<DropDownValue>? lstCollectionAgent;
  List<DropDownValue>? lstParents;
  List<MultiCheckBoxModel>? lstCurrencies;

  LstfillComboRes(
      {this.lstPayRouteCategories,
      this.lstCollectionAgent,
      this.lstParents,
      this.lstCurrencies});

  LstfillComboRes.fromJson(Map<String, dynamic> json) {
    if (json['lstPayRouteCategories'] != null) {
      lstPayRouteCategories = <DropDownValue>[];
      json['lstPayRouteCategories'].forEach((v) {
        lstPayRouteCategories!.add(new DropDownValue(
            key: v["payrouteCategoryCode"],
            value: v["payrouteCategoryName"],
            optional: v["r4_YN"]));
      });
    }
    if (json['lstCollectionAgent'] != null) {
      lstCollectionAgent = <DropDownValue>[];
      json['lstCollectionAgent'].forEach((v) {
        lstCollectionAgent!.add(
            new DropDownValue(key: v["companyCode"], value: v["companyName"]));
      });
    }
    if (json['lstParents'] != null) {
      lstParents = <DropDownValue>[];
      json['lstParents'].forEach((v) {
        lstParents!.add(
            new DropDownValue(key: v["companyCode"], value: v["companyName"]));
      });
    }
    if (json['lstCurrencies'] != null) {
      lstCurrencies = <MultiCheckBoxModel>[];
      int i = -1;
      json['lstCurrencies'].forEach((v) {
        lstCurrencies!.add(new MultiCheckBoxModel(
            DropDownValue(
                key: v["currencyTypeCode"], value: v["currencyTypeName"]),
            false,
            ++i));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstPayRouteCategories != null) {
      data['lstPayRouteCategories'] =
          this.lstPayRouteCategories!.map((v) => v.toJson()).toList();
    }
    if (this.lstCollectionAgent != null) {
      data['lstCollectionAgent'] =
          this.lstCollectionAgent!.map((v) => v.toJson()).toList();
    }
    if (this.lstParents != null) {
      data['lstParents'] = this.lstParents!.map((v) => v.toJson()).toList();
    }
    /*if (this.lstCurrencies != null) {
      data['lstCurrencies'] =
          this.lstCurrencies!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class CompanyChannelLinkDatas {
  String? locationname;
  String? channelname;
  String? payrouteCategoryName;
  String? currencyTypename;
  String? colagentName;
  String? companyName;
  String? sapProfitCentre;

  CompanyChannelLinkDatas(
      {this.locationname,
      this.channelname,
      this.payrouteCategoryName,
      this.currencyTypename,
      this.colagentName,
      this.companyName,
      this.sapProfitCentre});

  CompanyChannelLinkDatas.fromJson(Map<String, dynamic> json) {
    locationname = json['locationname'];
    channelname = json['channelname'];
    payrouteCategoryName = json['payrouteCategoryName'];
    currencyTypename = json['currencyTypename'];
    colagentName = json['colagentName'];
    companyName = json['companyName'];
    sapProfitCentre = json['sapProfitCentre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationname'] = this.locationname;
    data['channelname'] = this.channelname;
    data['Payroute CategoryName'] = this.payrouteCategoryName;
    data['currency Typename'] = this.currencyTypename;
    data['Colagent Name'] = this.colagentName;
    data['Company Name'] = this.companyName;
    data['sap ProfitCentre'] = this.sapProfitCentre;
    return data;
  }
}
