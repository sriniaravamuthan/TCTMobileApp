/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 3/4/21 2:21 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 3/4/21 2:21 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/models/data_model.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/familymembers_step.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class FamilyMemberDetails extends StatefulWidget {
  DemographicFamily demographicFamily;

  FamilyMemberDetails(this.demographicFamily);

  @override
  _FamilyMemberDetailsState createState() =>
      _FamilyMemberDetailsState(demographicFamily);
}

class _FamilyMemberDetailsState extends State<FamilyMemberDetails> {
  bool addfamily = false;
  int familyIndex = -1;
  var height, width;

  DemographicFamily demographicFamily;

  List<Family> familyList = [];

  _FamilyMemberDetailsState(this.demographicFamily);

  @override
  void initState() {
    if (demographicFamily.family != null) {
      familyList = demographicFamily.family;
    } else {
      familyList.forEach((element) {
        element.physicallyChallenge = 0;
        element.smartphone = 0;
      });
      demographicFamily.family = familyList;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    debugPrint("FamilyMember:$familyList");
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      addfamily = !addfamily;
                      familyIndex = -1;
                    });
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
              ],
            ),
          ),
        ),
        Visibility(
            visible: familyList.isNotEmpty,
            child:
                // FutureBuilder(
                //   future: refreshFamilyList(family),
                //   builder: (context, projectSnap) {
                //     if (projectSnap.connectionState == ConnectionState.waiting) {
                //       return Center(child: CircularProgressIndicator());
                //     } else if (projectSnap.connectionState == ConnectionState.done) {
                //
                //       return
                ListView.builder(
              itemCount: familyList.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                debugPrint("familyPhoto:${familyList[index].photo}");
                return InkWell(
                  onTap: () {
                    if (familyIndex > 0) {
                      final snackBar = SnackBar(content: Text('Save or cancel the current member before editing another'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    setState(() {
                      familyIndex = index;
                      addfamily = true;
                    });
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              height: 140,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                              child:  familyList[index].photo== ""
                                  ? SvgPicture.asset(
                                svgTctLogo,
                                semanticsLabel: "Logo",
                                height: height / 10,
                                width: width / 10,
                                fit: BoxFit.contain,
                                allowDrawingOutsideViewBox: true,
                              )
                                  : Image.network(familyList[index].photo,fit: BoxFit.fill)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text: familyList[index].name,
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text:
                                        "${familyList[index].age.toString()},${familyList[index].dob.toString()}",
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    width: 100,
                                    child: TextWidget(
                                      text: "${familyList[index].gender} ,${familyList[index].bloodGroup},${familyList[index].maritalStatus != null ? familyList[index].maritalStatus : ""}",
                                      weight: FontWeight.w400,
                                      color: darkColor,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text: familyList[index].mobileNumber,
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text: familyList[index].mail,
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
                                    text: DemoLocalization.of(context)
                                        .translate('Aadhaar No'),
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text: familyList[index].aadharNumber,
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text:  DemoLocalization.of(context)
                                        .translate('Business'),
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    width: 130,
                                    child: TextWidget(
                                      text: familyList[index].occupation,
                                      weight: FontWeight.w400,
                                      color: darkColor,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text:  DemoLocalization.of(context)
                                        .translate('Section'),
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: TextWidget(
                                    text: familyList[index].community,
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text:  DemoLocalization.of(context)
                                        .translate('Insurance'),
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text: getInsurance(familyList[index]),
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
                                    text:  DemoLocalization.of(context)
                                        .translate('Education Qualification'),
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text: familyList[index].education,
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text: DemoLocalization.of(context)
                                        .translate('Annual Income'),
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text:
                                        familyList[index].annualIncome.toString(),
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text:  DemoLocalization.of(context)
                                        .translate('Caste'),
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text: familyList[index].caste,
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text:  DemoLocalization.of(context)
                                        .translate('Pension'),
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    width: 130,
                                    child: TextWidget(
                                      text: getPension(familyList[index]),
                                      weight: FontWeight.w400,
                                      color: darkColor,
                                      size: 14,
                                    ),
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
                                    text:  DemoLocalization.of(context)
                                        .translate('Smart phone'),
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text: getSliderValue(familyList[index].smartphone),
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: SizedBox(
                                      width: 150,
                                      child: TextWidget(
                                        text:  DemoLocalization.of(context)
                                            .translate('Physically challenged'),
                                        weight: FontWeight.w800,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextWidget(
                                    text: getSliderValue(familyList[index].physicallyChallenge),
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
                    ],
                  ),
                );
              },
            )
            //     } else {
            //       return Text("Error ${projectSnap.error}");
            //     }
            //   },
            // ),
            ),
        Divider(
          height: 1,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Visibility(
              visible: addfamily,
              child: FamilyMemberStep(getDefaultFamily(), familyIndex, refreshFamilyList, cancelFields)),
        ),
      ],
    );
  }

  Family getDefaultFamily() {
    Family newFamily;
    if(familyIndex == -1) {
      newFamily = new Family();
      newFamily.name = "";
      newFamily.aadharNumber = "";
      newFamily.relationship = "";
      newFamily.gender = "";
      newFamily.dob = "";
      newFamily.age = 0;
      newFamily.maritalStatus = "";
      newFamily.bloodGroup = "";
      newFamily.physicallyChallenge = 0;
      newFamily.education = "";
      newFamily.occupation = "";
      newFamily.annualIncome = "";
      newFamily.mobileNumber = "";
      newFamily.mail = "";
      newFamily.smartphone = 0;
      newFamily.community = "";
      newFamily.caste = "";
      newFamily.photo = "";
      newFamily.govtInsurance = 0;
      newFamily.privateInsurance = 0;
      newFamily.oldPension = 0;
      newFamily.widowedPension = 0;
      newFamily.retirementPension = 0;
    } else {
      newFamily = familyList[familyIndex];
    }
    return newFamily;
  }

  void refreshFamilyList(Family family, int position) {
    setState(() {
      if(position < 0)
        familyList.add(family);
      else
        familyList[position] = family;
      addfamily = false;
      familyIndex = -1;
    });
  }

  void cancelFields() {
    setState(() {
      addfamily = false;
    });
  }

  String getInsurance(Family family) {
    String insurance = "";
    if (family.privateInsurance == 2)
      insurance += DemoLocalization.of(context).translate('Private');
    if (family.govtInsurance == 2) {
      if (insurance != "")
        insurance += ", ";
      insurance += DemoLocalization.of(context).translate('Government');
    }
    return insurance;
  }

  String getPension(Family family) {
    String pension = "";
    if (family.oldPension == 2)
      pension += DemoLocalization.of(context).translate('Old Age');
    if (family.retirementPension == 2) {
      if (pension != "")
        pension += ", ";
      pension += DemoLocalization.of(context).translate('Retirement');
    }
    if (family.widowedPension == 2) {
      if (pension != "")
        pension += ", ";
      pension += DemoLocalization.of(context).translate('Widowed Pension');
    }
    return pension;
  }

  String getSliderValue(double value) {
    if (value == 2)
      return DemoLocalization.of(context).translate('Yes');
    else if (value == 1)
      return  DemoLocalization.of(context).translate('No');
    else
      return "";
  }

}
