import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:tct_demographics/api/response/survey_question_response.dart';

Future<SurveyQuestionnaireResponse> getSurveyQuestionAPI() async {
  String url;
    url = "https://run.mocky.io/v3/4058182d-33f9-46ca-a7c1-e798e4ab530b";
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
