import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tct_demographics/localization/localization.dart';

String getTranslated(BuildContext context, String key) {
  DemoLocalization.of(context).translate(key);
}

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String TAMIL = 'ta';
const String TELUGU = 'te';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case TAMIL:
      return Locale(TAMIL, "IN");
    case TELUGU:
      return Locale(TELUGU, "IN");
    default:
      return Locale(ENGLISH, 'US');
  }
}
