import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tct_demographics/api/request/survey_questionnaire_request.dart';

import 'package:tct_demographics/api/response/survey_question_response.dart';
import 'package:tct_demographics/constants/api_constants.dart';

Future<SurveyQuestionnaireResponse> getSurveyQuestionAPI(
    SurveyQuestionnaireRequest surveyQuestionnaireRequest) async {
  String url;
  url = "https://run.mocky.io/v3/28e4af66-ec82-4a14-b54a-2e364b2b05c9";
  // String token = await SharedPref().getStringPref(SharedPref().token);
  // debugPrint("Token:$token");
  Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  debugPrint("URl $url");
  final response = await http.get(Uri.parse(url), headers: requestHeaders);
  var data = SurveyQuestionnaireResponse.fromJson(json.decode(response.body));

  debugPrint("campaignName: ${data.data.campaignName}");

  if (response.statusCode == 200) {
    if (!data.isError) {
      return data;
    } else {
      // snackBarAlert(warning, data.isError.toString());
      return null;
    }
  } else {
    // snackBarAlert(
    //     error, data.message.toString(), Icon(Icons.error_outline), errorColor);
    return null;
  }
}

Future<SurveyQuestionnaireResponse> getOfflineSurveyQuestionAPI(
    SurveyQuestionnaireRequest surveyQuestionnaireRequest) async {
 debugPrint("campaignId__:${surveyQuestionnaireRequest.campaignId}");

 Map<String, dynamic> map = await db
     .collection('campaign_list')
     .doc(surveyQuestionnaireRequest.campaignId)
     .collection('survey')
     .doc(surveyQuestionnaireRequest.campaignId)
     .get();
 debugPrint("Offline List $map");
  return SurveyQuestionnaireResponse.fromJson(map);
}
