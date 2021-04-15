/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 2/4/21 7:19 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 2/4/21 7:19 PM by Kanmalai.
 * /
 */
import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class HabitsStep extends StatefulWidget {
  @override
  _HabitsStepState createState() => _HabitsStepState();
}

class _HabitsStepState extends State<HabitsStep> {
  GlobalKey<FormState> _stepFourKey = new GlobalKey<FormState>();
  bool isSwitched = false;
  String textValue = 'No';
  bool isSwitched1 = false;
  String textValue1 = 'No';
  bool isSwitched2 = false;
  String textValue2 = 'No';

  bool anyMembersWhoSmokeVal, anyMembersWhoDrinkVal, anyMembersWhoUseTobaccoVal;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _stepFourKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextWidget(
              text: DemoLocalization.of(context)
                  .translate('Any Members who Smoke?'),
              size: 18,
              weight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Switch(
                onChanged: toggleSwitch,
                value: isSwitched,
                activeColor: Colors.blue,
                activeTrackColor: greyColor,
                inactiveThumbColor: greyColor,
                inactiveTrackColor: greyColor,
              ),
              TextWidget(
                text: textValue,
                size: 18,
                weight: FontWeight.w600,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextWidget(
              text: DemoLocalization.of(context)
                  .translate('Any Members who Drink?'),
              size: 18,
              weight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Switch(
                onChanged: toggleSwitch1,
                value: isSwitched1,
                activeColor: Colors.blue,
                activeTrackColor: greyColor,
                inactiveThumbColor: greyColor,
                inactiveTrackColor: greyColor,
              ),
              TextWidget(
                text: textValue1,
                size: 18,
                weight: FontWeight.w600,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextWidget(
              text: DemoLocalization.of(context)
                  .translate('Any Members who use Tobacco?'),
              size: 18,
              weight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Switch(
                onChanged: toggleSwitch2,
                value: isSwitched2,
                activeColor: Colors.blue,
                activeTrackColor: greyColor,
                inactiveThumbColor: greyColor,
                inactiveTrackColor: greyColor,
              ),
              TextWidget(
                text: textValue2,
                size: 18,
                weight: FontWeight.w600,
              ),
            ],
          )
        ],
      ),
    );
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Yes';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'No';
      });
      print('Switch Button is OFF');
    }
  }

  void toggleSwitch1(bool value) {
    if (isSwitched1 == false) {
      setState(() {
        isSwitched1 = true;
        textValue1 = 'Yes';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched1 = false;
        textValue1 = 'No';
      });
      print('Switch Button is OFF');
    }
  }

  void toggleSwitch2(bool value) {
    if (isSwitched2 == false) {
      setState(() {
        isSwitched2 = true;
        textValue2 = 'Yes';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched2 = false;
        textValue2 = 'No';
      });
      print('Switch Button is OFF');
    }
  }
}
