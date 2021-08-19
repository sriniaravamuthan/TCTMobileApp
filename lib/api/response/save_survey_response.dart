class SaveSurveyResponse {
  String aPIName;
  bool isError;
  String data;

  SaveSurveyResponse({this.aPIName, this.isError, this.data});

  SaveSurveyResponse.fromJson(Map<String, dynamic> json) {
    aPIName = json['APIName'];
    isError = json['isError'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['APIName'] = this.aPIName;
    data['isError'] = this.isError;
    data['data'] = this.data;
    return data;
  }
}
