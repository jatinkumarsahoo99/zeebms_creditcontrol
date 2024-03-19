class InfoDataList {
  List<DataLst>? data;

  InfoDataList({this.data});

  InfoDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataLst>[];
      json['data'].forEach((v) {
        data!.add(new DataLst.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataLst {
  String? infoname;
  dynamic infovalue;
  int? isrequired;
  String? allowedvalues;
  String? selectIndex;
  List<String>? lstData = [];

  DataLst({this.infoname, this.infovalue, this.isrequired, this.allowedvalues,this.lstData,this.selectIndex});

  DataLst.fromJson(Map<String, dynamic> json) {
    infoname = json['infoName'];
    infovalue = json['infoValue'];
    isrequired = json['isRequired'];
    allowedvalues = json['allowedValues'];
    selectIndex = json['selectIndex']??"0";
    lstData = getListOfData(json['allowedvalues']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infoName'] = this.infoname;
    data['infoValue'] = getInfoValue(infovalue);
    data['isRequired'] = this.isrequired;
    data['allowedValues'] = this.allowedvalues;
    data['lstData'] = (this.lstData).toString();
    data['selectIndex'] = this.selectIndex;

    return data;
  }

  getInfoValue(String? infoValue ){
    if(infoValue == null){
      String ? data = lstData?[int.parse(selectIndex??"0")];
      return data;
    }else{
      return infoValue;
    }
  }


  List<String> getListOfData(String? txt){
    if(txt != null && txt != ""){
      try{
        List<String> data = txt.split("~").toList();
        return data;
      }catch(e){
        return [""];
      }
    }else {
      return [""];
    }
  }

}
