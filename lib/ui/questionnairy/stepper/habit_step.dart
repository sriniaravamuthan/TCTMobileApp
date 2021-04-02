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
import 'package:tct_demographics/widgets/text_widget.dart';

class HabitsStep extends StatefulWidget {
  @override
  _HabitsStepState createState() => _HabitsStepState();
}

class _HabitsStepState extends State<HabitsStep> {
  GlobalKey<FormState> _stepFourKey = new GlobalKey<FormState>();
  bool isSwitched = false;
  var textValue = 'Yes';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _stepFourKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextWidget(
              text: statusHouse,
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
                text: "No",
                size: 18,
                weight: FontWeight.w600,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextWidget(
              text: statusHouse,
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
                text: "No",
                size: 18,
                weight: FontWeight.w600,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextWidget(
              text: statusHouse,
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
                text: "No",
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

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }
}

