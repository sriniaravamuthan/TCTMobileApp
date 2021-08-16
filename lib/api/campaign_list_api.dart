import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tct_demographics/api/request/search_campaign_request.dart';
import 'package:tct_demographics/api/response/search_campaign_response.dart';
import 'package:tct_demographics/api/response/survey_question_response.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/util/snack_bar.dart';

Future<SearchCampaignResponse> setSearchCampaignAPI(
    SearchCampaignRequest searchCampaignRequest) async {
  debugPrint("syncSearchCampaignAPI");

  debugPrint(
      "SearchCampaign Request : ${searchCampaignRequest.campaignId} ${searchCampaignRequest.campaignName} ${searchCampaignRequest.villageCode} ${searchCampaignRequest.languageCode}");
  String url = "https://run.mocky.io/v3/941a1c5b-df97-40c6-8090-770313f0e521";
  searchCampaignRequest.languageCode =
      await SharedPref().getStringPref(SharedPref().language);
  // String token = await SharedPref().getStringPref(SharedPref().token);
  // debugPrint("user:$token");

  Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    // 'Access-token': '$token'
  };
  debugPrint("URl122 $url");

  final response =
      // await http.post(Uri.parse(url), body: body, headers: requestHeaders);
      await http.get(Uri.parse(url), headers: requestHeaders);
  var data = SearchCampaignResponse.fromJson(json.decode(response.body));

  if (response.statusCode == 200) {
    debugPrint("Response ${data.toJson()}");
    if (!data.isError) {
      return data;
    } else {
      debugPrint("Response2 ${data.data}");
      snackBarAlert(warning, "API Error", errorColor);
      return null;
    }
  } else {
    debugPrint("Response3 ${data.data}");
    snackBarAlert(error, "Server Error - ${response.statusCode}", errorColor);
    return null;
  }
  // }
}

Future<SearchCampaignResponse> syncSearchCampaignAPI(
    SearchCampaignRequest searchCampaignRequest) async {
  debugPrint("syncSearchCampaignAPI");
  String searchCampaignURL =
      "https://run.mocky.io/v3/941a1c5b-df97-40c6-8090-770313f0e521";
  String surveyCampaignURL =
      "https://run.mocky.io/v3/1b7c2aeb-b877-45d9-9f6c-020e93a11102";
  searchCampaignRequest.languageCode =
      await SharedPref().getStringPref(SharedPref().language);
  Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    // 'Access-token': '$token'
  };
  debugPrint("URl sync: $searchCampaignURL");
  var connectionResult = await (Connectivity().checkConnectivity());
  if (connectionResult == ConnectivityResult.none) {
    Map<String, dynamic> map = await db
        .collection('campaign_list')
        .doc(searchCampaignRequest.campaignId)
        .get();
    debugPrint("Offline List $map");
    return SearchCampaignResponse.fromJson(map);
  } else {
    final responseSearchCampaign =
        // await http.post(Uri.parse(url), body: body, headers: requestHeaders);
        await http.get(Uri.parse(searchCampaignURL), headers: requestHeaders);
    var data = SearchCampaignResponse.fromJson(
        json.decode(responseSearchCampaign.body));
    final responseSurvey =
        // await http.post(Uri.parse(url), body: body, headers: requestHeaders);
        await http.get(Uri.parse(surveyCampaignURL), headers: requestHeaders);
    var dataSurvey =
        SurveyQuestionnaireResponse.fromJson(json.decode(responseSurvey.body));

    if (responseSearchCampaign.statusCode == 200) {
      debugPrint("Response12 ${data.toJson()}");
      if (!data.isError) {
        try {
          db
              .collection('campaign_list')
              .doc(searchCampaignRequest.campaignId)
              .delete();
        } catch (error) {
          debugPrint("Error $error");
        } finally {
          db
              .collection('campaign_list')
              .doc(searchCampaignRequest.campaignId)
              .set(data.toJson())
              .then((value) => {debugPrint("DB Added List: $value")});

          if (responseSurvey.statusCode == 200) {
            debugPrint("Response1 ${dataSurvey.toJson()}");
            if (!dataSurvey.isError) {
              try {
                db
                    .collection('campaign_list')
                    .doc(searchCampaignRequest.campaignId)
                    .collection('survey')
                    .doc(searchCampaignRequest.campaignId)
                    .set(dataSurvey.toJson())
                    .then((value) => {debugPrint("DB Added Survey: $value")});
              } catch (error) {
                debugPrint("Error $error");
              }
            }
          } else {
            debugPrint("Response ${dataSurvey.data}");
            snackBarAlert(warning, "API Error", errorColor);
          }
        }
        return data;
      } else {
        debugPrint("Response2 ${data.data}");
        snackBarAlert(warning, "API Error", errorColor);
        return null;
      }
    } else {
      debugPrint("Response3 ${data.data}");
      snackBarAlert(error,
          "Server Error - ${responseSearchCampaign.statusCode}", errorColor);
      return null;
    }
  }
}
