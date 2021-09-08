import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tct_demographics/api/request/search_campaign_request.dart';
import 'package:tct_demographics/api/response/search_campaign_response.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/util/snack_bar.dart';

Future<SearchCampaignResponse> getSearchCampaignAPI(
    SearchCampaignRequest searchCampaignRequest,
    List campaignIdList,
    List<String> campaignNameList) async {
  debugPrint("getSearchCampaignAPI");
  searchCampaignRequest.languageCode =
      await SharedPref().getStringPref(SharedPref().language);
  debugPrint(
      "SearchCampaign Request : ${searchCampaignRequest.campaignID} ${searchCampaignRequest.campaignName} ${searchCampaignRequest.villageCode} ${searchCampaignRequest.languageCode}");

  debugPrint(
      "searchCampaignRequest.languageCode:${searchCampaignRequest.languageCode}");
  debugPrint("URl122 $searchCampaignURL");
  // String token = await SharedPref().getStringPref(SharedPref().token);
  Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    // 'Access-token': '$token'
  };
  debugPrint("requestHeaders:$requestHeaders");
  Map map = {
    "campaignID": searchCampaignRequest.campaignID,
    "campaignName": searchCampaignRequest.campaignName,
    "villageCode": searchCampaignRequest.villageCode,
    "languageCode": searchCampaignRequest.languageCode,
    "searchKey": null
  };
  String body = json.encode(map);
  debugPrint("Search:$body");
  final response =
      // await http.post(Uri.parse(url), body: body, headers: requestHeaders);
      await http.post(Uri.parse(searchCampaignURL),
          headers: requestHeaders, body: body);
  debugPrint("Search_Datas ${response.body}");

  var data = SearchCampaignResponse.fromJson(json.decode(response.body));
  debugPrint("Search_Data $data");

  if (response.statusCode == 200) {
    debugPrint("Response ${data.toJson()}");
    if (!data.error) {
      data.data.forEach((element) {
        campaignIdList.add(element.campaignId);
        campaignNameList.add(element.campaignName);
        debugPrint("SEARCH:$campaignIdList $campaignNameList");
      });
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
