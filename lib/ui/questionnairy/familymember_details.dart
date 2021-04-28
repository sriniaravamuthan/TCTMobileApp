/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 3/4/21 2:21 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 3/4/21 2:21 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                addFamilyField();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
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
                      FittedBox(
                        fit: BoxFit.cover,
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Add Family Member'),
                          color: darkColor,
                          weight: FontWeight.w700,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              svgTctLogo,
              semanticsLabel: "Logo",
              height: height / 10,
              width: width / 10,
              fit: BoxFit.contain,
              allowDrawingOutsideViewBox: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "Saravanakumar (Son)",
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "24 Yrs (15 Feb 1996)",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "Male, O+, Married",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "+91 97101 52525",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "saravanakumar@gmail.com",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  SizedBox(
                    height: 58,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: adhaarNumber,
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "546546565654",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: occupation,
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "IT employee",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: community,
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  TextWidget(
                    text: "MBC",
                    weight: FontWeight.w400,
                    color: darkColor,
                    size: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: insurance,
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "gvt,pvt",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: educationQualification,
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "BE",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: annualIncome,
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "RS:60,000",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: caste,
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "Agamudayar",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: pension,
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "Old Age,Retirement",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: smartphone,
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "Yes",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: physicallyChallenged,
                      weight: FontWeight.w800,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextWidget(
                      text: "No",
                      weight: FontWeight.w400,
                      color: darkColor,
                      size: 14,
                    ),
                  ),
                  SizedBox(
                    height: 80,
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
