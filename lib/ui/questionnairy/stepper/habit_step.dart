/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 2/4/21 7:19 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 2/4/21 7:19 PM by Kanmalai.
 * /
 */
import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/models/data_model.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class HabitsStep extends StatefulWidget {
  DemographicFamily demographicFamily;

  HabitsStep(this.demographicFamily);

  @override
  _HabitsStepState createState() => _HabitsStepState(demographicFamily);
}

class _HabitsStepState extends State<HabitsStep> {
  GlobalKey<FormState> _stepFourKey = new GlobalKey<FormState>();
  String textSmoke = 'No';
  String textDrink = 'No';
  String textTobacco = 'No';
  DemographicFamily demographicFamily;
  Habits habits = new Habits();

  _HabitsStepState(this.demographicFamily);

  @override
  void initState() {
    if (demographicFamily.habits == null) {
      habits.anyMembersWhoUseTobacco = false;
      habits.anyMembersWhoDrink = false;
      habits.anyMembersWhoSmoke = false;
      demographicFamily.habits = habits;
    } else {
      habits = demographicFamily.habits;
      if (habits.anyMembersWhoSmoke == true) textSmoke = "Yes";
      if (habits.anyMembersWhoDrink == true) textDrink = "Yes";
      if (habits.anyMembersWhoUseTobacco == true) textTobacco = "Yes";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _stepFourKey,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 1.05,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Any Members who Smoke?'),
                        size: 14,
                        weight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Switch(
                          onChanged: toggleSwitch,
                          value: habits.anyMembersWhoSmoke,
                          activeColor: Colors.blue,
                          activeTrackColor: greyColor,
                          inactiveThumbColor: greyColor,
                          inactiveTrackColor: greyColor,
                        ),
                        TextWidget(
                          text: textSmoke,
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 1.05,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Any Members who Drink?'),
                        size: 14,
                        weight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Switch(
                          onChanged: toggleSwitch1,
                          value: habits.anyMembersWhoDrink,
                          activeColor: Colors.blue,
                          activeTrackColor: greyColor,
                          inactiveThumbColor: greyColor,
                          inactiveTrackColor: greyColor,
                        ),
                        TextWidget(
                          text: textDrink,
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 1.05,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Any Members who use Tobacco?'),
                        size: 14,
                        weight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Switch(
                          onChanged: toggleSwitch2,
                          value: habits.anyMembersWhoUseTobacco,
                          activeColor: Colors.blue,
                          activeTrackColor: greyColor,
                          inactiveThumbColor: greyColor,
                          inactiveTrackColor: greyColor,
                        ),
                        TextWidget(
                          text: textTobacco,
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void toggleSwitch(bool value) {
    if (habits.anyMembersWhoSmoke == false) {
      setState(() {
        textSmoke = 'Yes';
        habits.anyMembersWhoSmoke = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        textSmoke = 'No';
        habits.anyMembersWhoSmoke = false;
      });
      print('Switch Button is OFF');
    }
  }

  void toggleSwitch1(bool value) {
    if (habits.anyMembersWhoDrink == false) {
      setState(() {
        textDrink = 'Yes';
        habits.anyMembersWhoDrink = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        textDrink = 'No';
        habits.anyMembersWhoDrink = false;
      });
      print('Switch Button is OFF');
    }
  }

  void toggleSwitch2(bool value) {
    if (habits.anyMembersWhoUseTobacco == false) {
      setState(() {
        textTobacco = 'Yes';
        habits.anyMembersWhoUseTobacco = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        textTobacco = 'No';
        habits.anyMembersWhoUseTobacco = false;
      });
      print('Switch Button is OFF');
    }
  }
}
