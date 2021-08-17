/*
 * *
 *  Created by welcome, Kanmalai Technologies Pvt. Ltd on 2/20/21 10:44 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 2/20/21 9:58 AM by welcome.
 * /
 */

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tct_demographics/api/response/search_campaign_response.dart';

class SharedPref {
  var language = "LANGUAGE";

  setStringPref(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    return true;
  }

  getStringPref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  setStringList(String key, List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, list);
    return true;
  }

  getStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? "";
  }
}
