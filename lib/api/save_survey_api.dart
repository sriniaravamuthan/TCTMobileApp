import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tct_demographics/api/request/save_survey_request.dart';
import 'package:tct_demographics/api/response/save_survey_response.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/util/snack_bar.dart';

void setSaveSurveyAPI(
    SaveSurveyRequest surveyQuestionnaireRequest, BuildContext context) async {
  String url;
  url = "https://run.mocky.io/v3/417138ce-10e3-47fc-b2a0-eeaa441c9242";
  // String token = await SharedPref().getStringPref(SharedPref().token);
  // debugPrint("Token:$token");
  Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  debugPrint("URl $url");
  final response = await http.get(Uri.parse(url), headers: requestHeaders);
  var data = SaveSurveyResponse.fromJson(json.decode(response.body));

  debugPrint("product: ${data.data}");

  if (response.statusCode == 200) {
    if (!data.isError) {
      Navigator.pop(context, false);
    } else {
      snackBarAlert(warning, data.data.toString(), yellowColor);
    }

    debugPrint("product: ${response.body}");
  } else {
    snackBarAlert(error, data.data.toString(), errorColor);
  }
}

void setSaveOfflineSurveyAPI(
    SaveSurveyRequest surveyQuestionnaireRequest, BuildContext context) async {
  db
      .collection('survey_list')
      .doc(surveyQuestionnaireRequest.campaignId)
      .collection('familyId')
      .doc(surveyQuestionnaireRequest.familyId)
      .set(surveyQuestionnaireRequest.toJson())
      .then((value) => {debugPrint("DB Added Survey: $value")});
}
