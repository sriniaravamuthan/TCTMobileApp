import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstore/localstore.dart';
import 'package:tct_demographics/api/request/search_campaign_request.dart';
import 'package:tct_demographics/api/response/search_campaign_response.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/util/snack_bar.dart';

Future<SearchCampaignResponse> setSearchCampaignAPI(
    SearchCampaignRequest searchCampaignRequest) async {
  debugPrint(
      "SearchCampaign Request : ${searchCampaignRequest.campaignId} ${searchCampaignRequest.campaignName} ${searchCampaignRequest.villageCode} ${searchCampaignRequest.languageCode}");
  String url = "https://run.mocky.io/v3/0d027d73-6a5f-4338-ba8d-c01d1798518b";
  searchCampaignRequest.languageCode =
      await SharedPref().getStringPref(SharedPref().language);
  // String token = await SharedPref().getStringPref(SharedPref().token);
  // debugPrint("user:$token");

  Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    // 'Access-token': '$token'
  };
  debugPrint("URl $url");
  // var body = json.encode(searchCampaignRequest);
  // debugPrint("product_body: $body");
  // final db = Localstore.instance;
  // var connectionResult = await (Connectivity().checkConnectivity());
  // if (connectionResult == ConnectivityResult.none) {
  //   Map<String, dynamic> map =
  //   await db.collection('campaign_list').doc("list").get();
  //   debugPrint("Offline List $map");
  //   return SearchCampaignResponse.fromJson(map);
  // } else {
  final response =
      // await http.post(Uri.parse(url), body: body, headers: requestHeaders);
      await http.get(Uri.parse(url), headers: requestHeaders);
  var data = SearchCampaignResponse.fromJson(json.decode(response.body));

  if (response.statusCode == 200) {
    debugPrint("Response ${data.toJson()}");
    if (!data.isError) {
      // try {
      //   db.collection('campaign_list').doc("list").delete();
      // } catch (error) {
      //   debugPrint("Error $error");
      // } finally {
      //   db.collection('campaign_list').doc("list").set(data.toJson());
      // }
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
  String url = "https://run.mocky.io/v3/0d027d73-6a5f-4338-ba8d-c01d1798518b";
  searchCampaignRequest.languageCode =
      await SharedPref().getStringPref(SharedPref().language);
  Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    // 'Access-token': '$token'
  };
  debugPrint("URl $url");
  final db = Localstore.instance;
  var connectionResult = await (Connectivity().checkConnectivity());
  if (connectionResult == ConnectivityResult.none) {
    Map<String, dynamic> map =
        await db.collection('campaign_list').doc("list").get();
    debugPrint("Offline List $map");
    return SearchCampaignResponse.fromJson(map);
  } else {
    final response =
        // await http.post(Uri.parse(url), body: body, headers: requestHeaders);
        await http.get(Uri.parse(url), headers: requestHeaders);
    var data = SearchCampaignResponse.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      debugPrint("Response ${data.toJson()}");
      if (!data.isError) {
        try {
          db.collection('campaign_list').doc("list").delete();
        } catch (error) {
          debugPrint("Error $error");
        } finally {
          db.collection('campaign_list').doc("list").set(data.toJson());
        }
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
  }
}
