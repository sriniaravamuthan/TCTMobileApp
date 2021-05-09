/*
 *
 *  Created by Mahendra Vijay, Kanmalai Technologies Pvt. Ltd on 31/3/21 5:42 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 5:42 PM by Mahendra Vijay.
 * /
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/app_colors.dart';


void snackBarAlert(
    String type, String message,  Color bgColor) async {
  Get.snackbar(
    type,
    message,
    margin: const EdgeInsets.all(10.0),
    colorText: darkColor,
    shouldIconPulse: true,
    duration: Duration(seconds: 2),
    backgroundColor: bgColor,
    snackPosition: SnackPosition.BOTTOM,
  );
}
