import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tct_demographics/api/request/search_campaign_request.dart';
import 'package:tct_demographics/api/response/search_campaign_response.dart';

void setSearchCampaignAPI(SearchCampaignRequest searchCampaignRequest) async {
  String url;
  url = "https://run.mocky.io/v3/0d027d73-6a5f-4338-ba8d-c01d1798518b";

  // String token = await SharedPref().getStringPref(SharedPref().token);
  // debugPrint("user:$token");

  Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    // 'Access-token': '$token'
  };
  // debugPrint("URl $url");
  var body = json.encode(searchCampaignRequest);
  debugPrint("product_body: $body");

  final response =
      await http.post(Uri.parse(url), body: body, headers: requestHeaders);
  var data = SearchCampaignResponse.fromJson(json.decode(response.body));

  if (response.statusCode == 200) {
    debugPrint("Response ${data.data}");
    if (!data.isError) {
      // snackBarAlert(
      //     success, data.message.toString(), Icon(Icons.done), chartColor10);
    } else {
      // snackBarAlert(warning, data.message.toString(),
      //     Icon(Icons.warning_amber_outlined), warningColor);
    }
  } else {
    // snackBarAlert(
    //     error, data.message.toString(), Icon(Icons.error_outline), errorColor);
  }
}
