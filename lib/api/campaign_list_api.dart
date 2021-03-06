import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tct_demographics/api/request/search_campaign_request.dart';
import 'package:tct_demographics/api/response/save_survey_response.dart';
import 'package:tct_demographics/api/response/search_campaign_response.dart';
import 'package:tct_demographics/api/response/survey_question_response.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/util/snack_bar.dart';

Future<SearchCampaignResponse> syncSearchCampaignAPI(
    SearchCampaignRequest searchCampaignRequest) async {
  debugPrint("syncSearchCampaignAPI");
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
        .doc(searchCampaignRequest.campaignID)
        .get();
    debugPrint("Offline List $map");
    return SearchCampaignResponse.fromJson(map);
  } else {
    Map map = {
      "campaignID": searchCampaignRequest.campaignID,
      "campaignName": searchCampaignRequest.campaignName,
      "villageCode": searchCampaignRequest.villageCode,
      "languageCode": searchCampaignRequest.languageCode,
      "searchKey": null,
      "offline":true
    };
    String body = json.encode(map);
    final responseSearchCampaign = await http.post(Uri.parse(searchCampaignURL),
        body: body, headers: requestHeaders);
    var data = SearchCampaignResponse.fromJson(
        json.decode(responseSearchCampaign.body));
    Map questionMap = {
      "campaignID": searchCampaignRequest.campaignID,
      "familyId": data?.data?.first?.campaignList?.first?.familyId,
      "languageCode": searchCampaignRequest.languageCode,
    };
    String questionBody = json.encode(questionMap);
    debugPrint("questionBody $questionBody");

    final responseSurvey = await http.post(Uri.parse(surveyCampaignURL),
        body: questionBody, headers: requestHeaders);
    // await http.get(Uri.parse(surveyCampaignURL), headers: requestHeaders);
    var dataSurvey =
        SurveyQuestionnaireResponse.fromJson(json.decode(responseSurvey.body));

    if (responseSearchCampaign.statusCode == 200) {
      debugPrint("Response12 ${data.toJson()}");
      if (!data.error) {
        try {
          db
              .collection('campaign_list')
              .doc(searchCampaignRequest.campaignID)
              .delete();
        } catch (error) {
          debugPrint("Error $error");
        } finally {
          debugPrint("data.toJson(): ${data.toJson()}");
          db
              .collection('campaign_list')
              .doc(searchCampaignRequest.campaignID)
              .set(data.toJson())
              .then((value) => {debugPrint("DB Added List: $value")});

          if (responseSurvey.statusCode == 200) {
            debugPrint("Response1 ${dataSurvey.toJson()}");
            if (!dataSurvey.error) {
              try {
                db
                    .collection('campaign_list')
                    .doc(searchCampaignRequest.campaignID)
                    .collection('survey')
                    .doc(searchCampaignRequest.campaignID)
                    .set(dataSurvey.toJson())
                    .then((value) => {debugPrint("DB Added Survey: $value")});
              } catch (error) {
                debugPrint("Error $error");
              } finally {
                try {
                  Map<String, dynamic> future = await db
                      .collection('survey_list')
                      .doc(searchCampaignRequest.campaignID)
                      .collection('familyId')
                      .get();
                  debugPrint("Offline_Survey:${future.length}");
                  future.forEach((key, value) async {
                    debugPrint("Offline_Survey_Key:${key.split("/").last}");
                    debugPrint("Offline_Survey_Key:$key");
                    debugPrint("Value:$value");

                    var surveyFamilyId = key.split("/").last;
                    String body = json.encode(value);
                    debugPrint("SaveSurveyRequestBody $body");

                    final responseSurveySave = await http.post(
                        Uri.parse(surveySaveCampaignURL),
                        headers: requestHeaders,
                        body: body);
                    debugPrint("statusCode ${responseSurveySave.statusCode}");
                    debugPrint("Response12 ${responseSurveySave.body}");

                    var dataSaveSurvey = SaveSurveyResponse.fromJson(
                        json.decode(responseSurveySave.body));
                    /*  var dataSaveSurvey = SurveyQuestionnaireResponse.fromJson(
                        json.decode(responseSurveySave.body.toString()));*/
                    if (responseSurveySave.statusCode == 200) {
                      // debugPrint("Response12 ${data.toJson()}");
                      if (!dataSaveSurvey.error) {
                        try {
                          db
                              .collection('survey_list')
                              .doc(searchCampaignRequest.campaignID)
                              .collection('familyId')
                              .doc(surveyFamilyId)
                              .delete();
                        } catch (err) {
                          debugPrint("Error $err");
                        }
                      } else {
                        debugPrint("Response ${dataSurvey.data}");
                        snackBarAlert(warning, "API Error", errorColor);
                      }
                    } else {
                      snackBarAlert(
                          error,
                          "Server Error - ${responseSearchCampaign.statusCode}",
                          errorColor);
                    }
                  });
                } catch (error) {
                  debugPrint("Error $error");
                } finally {}
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
