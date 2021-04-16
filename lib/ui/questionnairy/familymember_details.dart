/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 3/4/21 2:21 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 3/4/21 2:21 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/familymembers_step.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class FamilyMemberDetails extends StatefulWidget {
  @override
  _FamilyMemberDetailsState createState() => _FamilyMemberDetailsState();
}

class _FamilyMemberDetailsState extends State<FamilyMemberDetails> {
  bool addfamily = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FractionallySizedBox(
          widthFactor: 0.38,
          child: InkWell(
            onTap: () {
              addFamilyField();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.black45,
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.add),
                    TextWidget(
                      text: DemoLocalization.of(context)
                          .translate('Add Family Member'),
                      color: darkColor,
                      weight: FontWeight.w800,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FractionallySizedBox(
                          widthFactor: 0.5,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0)),
                              ),
                              child: Image.asset(imgLightLogo))),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment(-5.0, 2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5),
                            child: TextWidget(
                              text: "Saravanakumar (Son)",
                              weight: FontWeight.w800,
                              color: darkColor,
                              size: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5),
                            child: TextWidget(
                              text: "24 Yrs (15 Feb 1996)",
                              weight: FontWeight.w600,
                              color: darkColor,
                              size: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5),
                            child: TextWidget(
                              text: "Male, O+, Married",
                              weight: FontWeight.w600,
                              color: darkColor,
                              size: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5),
                            child: TextWidget(
                              text: "+91 97101 52525",
                              weight: FontWeight.w600,
                              color: darkColor,
                              size: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5),
                            child: TextWidget(
                              text: "saravanakumar@gmail.com",
                              weight: FontWeight.w600,
                              color: darkColor,
                              size: 18,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: adhaarNumber,
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextWidget(
                            text: "546546565654",
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: occupation,
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextWidget(
                            text: "IT employee",
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: community,
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextWidget(
                            text: "MBC",
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: insurance,
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextWidget(
                            text: "gvt,pvt",
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: educationQualification,
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextWidget(
                            text: "BE",
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: annualIncome,
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextWidget(
                            text: "RS:60,000",
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: caste,
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextWidget(
                            text: "Agamudayar",
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: pension,
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextWidget(
                            text: "Old Age,Retirement",
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: smartphone,
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextWidget(
                            text: "Yes",
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: physicallyChallenged,
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextWidget(
                            text: "No",
                            weight: FontWeight.w600,
                            color: darkColor,
                            size: 18,
                          ),
                        ),
                        SizedBox(
                          height: 125,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Divider(
          height: 1,
        ),
        Visibility(visible: addfamily, child: FamilyMemberStep()),
      ],
    );
  }

  void addFamilyField() {
    setState(() {
      addfamily = !addfamily;
    });
  }
}
