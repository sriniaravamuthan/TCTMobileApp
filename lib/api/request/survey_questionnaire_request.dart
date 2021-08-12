class SurveyQuestionnaireRequest {
  String familyId;
  String campaignId;
  String languageCode;

  SurveyQuestionnaireRequest(
      {this.familyId, this.campaignId, this.languageCode});

  SurveyQuestionnaireRequest.fromJson(Map<String, dynamic> json) {
    familyId = json['familyId'];
    campaignId = json['campaignId'];
    languageCode = json['languageCode'];
  }
}
