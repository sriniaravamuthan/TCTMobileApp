/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 2/4/21 7:19 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 2/4/21 7:19 PM by Kanmalai.
 * /
 */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
  String textVaccine = 'Not Answer';

  String firstDoseVal,secondDoseVal;

  DemographicFamily demographicFamily;
  Habits habits = new Habits();
  double _value = 0;
  TextEditingController firstDosePicker = TextEditingController();
  DateTime date = DateTime.parse("2019-04-16 12:18:06.018950");
  TextEditingController secondDosePicker = TextEditingController();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.05,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextWidget(
                              text: "Vaccination Done?",
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: primaryColor,
                                  inactiveTrackColor: Colors.lightBlueAccent,
                                  trackShape: RectangularSliderTrackShape(),
                                  trackHeight: 4.0,
                                  thumbColor: primaryColor,
                                  thumbShape:
                                      RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                  overlayColor: Colors.white.withAlpha(32),
                                  overlayShape:
                                      RoundSliderOverlayShape(overlayRadius: 28.0),
                                ),
                                child: Slider(
                                  value: _value,
                                  min: 0,
                                  max: 2,
                                  divisions: 2,
                                  onChanged: (value) {
                                    if(value==0){
                                      setState(() {

                                        textVaccine='Not Answer';
                                        _value = value;


                                      });
                                    }else if(value==1){
                                      setState(() {
                                        textVaccine='No';
                                        _value = value;

                                      });
                                    }else{setState(() {
                                      textVaccine='Yes';
                                      _value = value;

                                    });
                                    }

                                  },
                                ),
                              ),
                              TextWidget(
                                text: textVaccine,
                                size: 14,
                                weight: FontWeight.w600,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextWidget(
                              text: "1st Dose Date",
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, top: 2.0, bottom: 2.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autocorrect: true,
                                controller: firstDosePicker,
                                enableSuggestions: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: lightGreyColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: lightGreyColor),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: lightGreyColor),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: lightGreyColor),
                                    ),
                                    fillColor: lightGreyColor),
                                keyboardType: TextInputType.text,
                                onSaved: (String val) {
                                  setState(() {});
                                },
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());

                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2022));
                                  String dateFormat = DateFormat(" d-MMMM-y").format(date);

                                  firstDosePicker.text =dateFormat;

                                  firstDoseVal = firstDosePicker.text;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    debugPrint("empid :yes");
                                    return 'Date of Birth must not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextWidget(
                              text: "2nd Dose Date",
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, top: 2.0, bottom: 2.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autocorrect: true,
                                controller: secondDosePicker,
                                enableSuggestions: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                      BorderSide(color: lightGreyColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                      BorderSide(color: lightGreyColor),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                      BorderSide(color: lightGreyColor),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                      BorderSide(color: lightGreyColor),
                                    ),
                                    fillColor: lightGreyColor),
                                keyboardType: TextInputType.text,
                                onSaved: (String val) {
                                  setState(() {});
                                },
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());

                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2022));
                                  String dateFormat = DateFormat(" d-MMMM-y").format(date);
                                  secondDosePicker.text =dateFormat;
                                  // "${date.day}/${date.month}/${date.year}";

                                  secondDoseVal = secondDosePicker.text;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    debugPrint("empid :yes");
                                    return 'Date of Birth must not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )

              ],
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
