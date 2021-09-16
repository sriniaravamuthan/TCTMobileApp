class SaveSurveyResponse {
  String message;
  bool error;
  String apiname;

  SaveSurveyResponse({this.message, this.error, this.apiname});

  SaveSurveyResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    apiname = json['apiname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['apiname'] = this.apiname;
    return data;
  }
}