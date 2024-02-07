class ResultModel {
  List<Files>? files;

  ResultModel({this.files});

  ResultModel.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  String? fileName;
  String? fileBytes;

  Files({this.fileName, this.fileBytes});

  Files.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    fileBytes = json['fileBytes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['fileBytes'] = this.fileBytes;
    return data;
  }
}
