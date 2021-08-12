import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstore/localstore.dart';
import 'package:tct_demographics/api/request/survey_questionnaire_request.dart';

import 'package:tct_demographics/api/response/survey_question_response.dart';
import 'package:tct_demographics/constants/api_constants.dart';

Future<SurveyQuestionnaireResponse> getSurveyQuestionAPI(
    SurveyQuestionnaireRequest surveyQuestionnaireRequest) async {
  String url;
  url = "https://run.mocky.io/v3/1b7c2aeb-b877-45d9-9f6c-020e93a11102";
  // String token = await SharedPref().getStringPref(SharedPref().token);
  // debugPrint("Token:$token");
  Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  debugPrint("URl $url");
  final response = await http.get(Uri.parse(url), headers: requestHeaders);
  var data = SurveyQuestionnaireResponse.fromJson(json.decode(response.body));

  debugPrint("product: ${data.data.campaignName}");

  if (response.statusCode == 200) {
    if (!data.isError) {
      return data;
    } else {
      // snackBarAlert(warning, data.isError.toString());
      return null;
    }

    debugPrint("product: ${response.body}");
  } else {
    // snackBarAlert(
    //     error, data.message.toString(), Icon(Icons.error_outline), errorColor);
    return null;
  }
}

Future<SurveyQuestionnaireResponse> getOfflineSurveyQuestionAPI(
    SurveyQuestionnaireRequest surveyQuestionnaireRequest) async {
  // var connectionResult = await (Connectivity().checkConnectivity());
  // if (connectionResult == ConnectivityResult.none) {
  Map<String, dynamic> map = await db
      .collection('campaign_list')
      .doc(surveyQuestionnaireRequest.campaignId)
      .collection('survey')
      .doc(surveyQuestionnaireRequest.campaignId)
      .get();
  debugPrint("Offline List $map");
  return SurveyQuestionnaireResponse.fromJson(map);
  // } else {
  //   return getSurveyQuestionAPI(surveyQuestionnaireRequest)
  //       .then((value) => value);
  // }
}
