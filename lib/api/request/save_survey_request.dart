class SaveSurveyRequest {
  String familyId;
  String campaignId;
  String languageCode;
  String survey;

  SaveSurveyRequest(
      {this.familyId, this.campaignId, this.languageCode, this.survey});

  SaveSurveyRequest.fromJson(Map<String, dynamic> json) {
    familyId = json['familyId'];
    campaignId = json['campaignId'];
    languageCode = json['languageCode'];
    survey = json['survey'];
  }
}
