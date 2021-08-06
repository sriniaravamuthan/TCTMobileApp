import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

Future<bool> checkInternetConnection() async {
  var connectionResult = await (Connectivity().checkConnectivity());
  debugPrint("ConnectionResult: $connectionResult");
  if (connectionResult == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}
