/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 3/4/21 2:21 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 3/4/21 2:21 PM by Kanmalai.
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/models/data_model.dart';
import 'package:tct_demographics/ui/questionnaire/stepper/familymembers_step.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class FamilyMemberDetailsPortrait extends StatefulWidget {
  DemographicFamily demographicFamily;
  Orientation orientation;
  bool isMemberStatus;
  FamilyMemberDetailsPortrait(
      this.demographicFamily, this.orientation, this.isMemberStatus);

  @override
  _FamilyMemberDetailsPortraitState createState() =>
      _FamilyMemberDetailsPortraitState(demographicFamily, this.orientation);
}

class _FamilyMemberDetailsPortraitState
    extends State<FamilyMemberDetailsPortrait> {
  bool addfamily = false;
  int familyIndex = -1;
  var height, width;

  DemographicFamily demographicFamily;

  List<Family> familyList = [];
  Orientation orientation;

  _FamilyMemberDetailsPortraitState(this.demographicFamily, this.orientation);

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
    print('GET___________' +
        familyList.length.toString() +
        "_________" +
        orientation.toString());
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
                      debugPrint("LengthOfFamily:${familyList.length}");
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
        Divider(
          height: 1,
        ),
        Visibility(
          visible: familyList.isNotEmpty,
          child: orientation == Orientation.portrait
              ? _portraitMode()
              : _landscapeMode(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Visibility(
              visible: addfamily,
              child: FamilyMemberStep(
                  getDefaultFamily(),
                  familyIndex,
                  refreshFamilyList,
                  cancelFields,
                  deleteFields,
                  familyList,
                  widget.isMemberStatus)),
        ),
      ],
    );
  }

  Family getDefaultFamily() {
    Family newFamily;
    if (familyIndex == -1) {
      newFamily = new Family();
      newFamily.name = "";
      newFamily.aadharNumber = "";
      newFamily.relationship = "";
      newFamily.gender = "";
      newFamily.dob = "";
      newFamily.age = 0;
      newFamily.died=0;
      newFamily.dateOfDemise="";
      newFamily.maritalStatus = "";
      newFamily.pregnantStatus = 0;
      newFamily.pregnantMonths = "";
      newFamily.bloodGroup = "";
      newFamily.physicallyChallenge = 0;
      newFamily.physical = "";
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
      newFamily.migrate = 0;
      newFamily.migrateReason = "";

      //habit
      newFamily.anyMembersWhoUseTobacco = 0;
      newFamily.isVaccinationDone = 0;
      newFamily.firstDose = "";
      newFamily.secondDose = "";
      newFamily.anyMembersWhoDrink = 0;
      newFamily.drinkingUsage = 0;
      newFamily.stoppedBy = 0;
      newFamily.noOfYears = "";
      newFamily.whenTreatment = "";
      newFamily.whereTreatment = "";
      newFamily.anyMembersWhoSmoke = 0;
    } else {
      newFamily = familyList[familyIndex];
    }
    return newFamily;
  }

  void refreshFamilyList(Family family, int position) {
    setState(() {
      if (position < 0)
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
      familyIndex = -1;
    });
  }

  void deleteFields(Family family) {
    setState(() {
      addfamily = false;
      familyList.remove(family);
      familyIndex = -1;
    });
  }

  String getInsurance(Family family) {
    String insurance = "";
    if (family.privateInsurance == 2)
      insurance += DemoLocalization.of(context).translate('Private');
    if (family.govtInsurance == 2) {
      if (insurance != "") insurance += ", ";
      insurance += DemoLocalization.of(context).translate('Government');
    }
    return insurance;
  }

  getPregnant(Family family) {
    String pregnant = "";
    if (family.pregnantStatus == 1)
      pregnant += DemoLocalization.of(context).translate('Yes');
    if (pregnant != "") pregnant += ", ";
    pregnant += family.pregnantMonths != "" && family.pregnantMonths != null
        ? "${family.pregnantMonths} months"
        : "";

    return pregnant;
  }

  String getPension(Family family) {
    String pension = "";
    if (family.oldPension == 2)
      pension += DemoLocalization.of(context).translate('Old Age');
    if (family.retirementPension == 2) {
      if (pension != "") pension += ", ";
      pension += DemoLocalization.of(context).translate('Retirement');
    }
    if (family.widowedPension == 2) {
      if (pension != "") pension += ", ";
      pension += DemoLocalization.of(context).translate('Widowed Pension');
    }
    return pension;
  }

  String getSliderValue(double value) {
    if (value == 2)
      return DemoLocalization.of(context).translate('Yes');
    else if (value == 1)
      return DemoLocalization.of(context).translate('No');
    else
      return DemoLocalization.of(context).translate('Not Answered');
  }

  String getPhysical(Family family) {
    String physical = "";
    if (family.physicallyChallenge == 2 && family.physical != "") {
      physical += DemoLocalization.of(context).translate('Yes') +
          "-" +
          family.physical.toString();
      return physical;
    } else if (family.physicallyChallenge == 1)
      return DemoLocalization.of(context).translate('No');
    else if (family.physicallyChallenge == 0) {
      return DemoLocalization.of(context).translate('Not Answered');
    }
  }

  String getDied(Family family) {
    String died="";
    if (family.died == 1 && family.dateOfDemise != "") {
      died += DemoLocalization.of(context).translate('Died') +
          "-" +
          family.dateOfDemise.toString();
      return died;
    } else if (family.died == 0)
      return DemoLocalization.of(context).translate('alive');
  }

  String getMigrate(Family family) {
    String migrate = "";
    if (family.migrate == 1 && family.migrateReason != "") {
      migrate += DemoLocalization.of(context).translate('Yes') +
          "-" +
          family.migrateReason.toString();
      return migrate;
    } else if (family.migrate == 0)
      return DemoLocalization.of(context).translate('No');
  }

  getTexts(Family family) {
    String toReturn = family.gender;
    if (toReturn.length > 0 && family.bloodGroup.length > 0) {
      toReturn += ", ";
    }
    toReturn += family.bloodGroup;
    if (toReturn.length > 0 &&
        family.maritalStatus != null &&
        family.maritalStatus.length > 0) {
      toReturn += ", ";
    }
    toReturn += family.maritalStatus;
    return toReturn;
  }

  Widget _portraitMode() {
    return ListView.builder(
      itemCount: familyList.length,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        debugPrint("familyPhoto:${familyList[index].photo}");
        familyList.sort((a, b) => a.position.compareTo(b.position));
        debugPrint("demographicList:${familyList[index].position}");
        return Column(
          children: [
            Container(
              child: InkWell(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 140,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: familyList[index].photo != ""
                                  ? Image.network(familyList[index].photo,
                                      fit: BoxFit.fill)
                                  : familyList[index].gender == ""
                                      ? Image.asset(imgCamera, fit: BoxFit.fill)
                                      : familyList[index].gender == "Male" ||
                                              familyList[index].gender == "?????????"
                                          ? SvgPicture.asset(
                                              svgMan,
                                              semanticsLabel: "Logo",
                                              height: height / 12,
                                              width: width / 8,
                                              fit: BoxFit.contain,
                                              allowDrawingOutsideViewBox: true,
                                            )
                                          : familyList[index].gender ==
                                                      "Transgender" ||
                                                  familyList[index].gender ==
                                                      "???????????????????????????"
                                              ? SvgPicture.asset(
                                                  svgGender,
                                                  semanticsLabel: "Logo",
                                                  height: height / 12,
                                                  width: width / 8,
                                                  fit: BoxFit.contain,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                )
                                              : SvgPicture.asset(
                                                  svgWoman,
                                                  semanticsLabel: "Logo",
                                                  height: height / 10,
                                                  width: width / 10,
                                                  fit: BoxFit.contain,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: getName(familyList[index]),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text:
                                      "${familyList[index].age == 0 ? "" : familyList[index].age.toString()}${familyList[index].dob.toString().length > 0 ? "," + familyList[index].dob.toString() : ""}",
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: getTexts(familyList[index]),
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: getPregnant(familyList[index]),
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
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
                                height: 10,
                              ),
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
                                  text: getMaskedNo(
                                      familyList[index].aadharNumber),
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Education Qualification'),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SizedBox(
                                  width: 120,
                                  child: TextWidget(
                                    text: familyList[index].education,
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
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Section'),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: TextWidget(
                                  text: familyList[index].community,
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Caste'),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SizedBox(
                                  width: 120,
                                  child: TextWidget(
                                    text: familyList[index].caste,
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Business'),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: familyList[index].occupation,
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SizedBox(
                                  width: 120,
                                  child: TextWidget(
                                    text: DemoLocalization.of(context)
                                        .translate('Annual Income'),
                                    weight: FontWeight.w800,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SizedBox(
                                  width: 120,
                                  child: TextWidget(
                                    text: familyList[index]
                                        .annualIncome
                                        .toString(),
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    familyList[index].isExpanded == "Show Less"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Smart phone'),
                                        weight: FontWeight.w800,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: getSliderValue(
                                            familyList[index].smartphone),
                                        weight: FontWeight.w400,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Pension'),
                                        weight: FontWeight.w800,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: SizedBox(
                                        width: 150,
                                        child: TextWidget(
                                          text: getPension(familyList[index]),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Physically challenged'),
                                        weight: FontWeight.w800,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: getPhysical(familyList[index]),
                                        weight: FontWeight.w400,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: SizedBox(
                                        width: 150,
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate(
                                                  'Any Members who Smoke?'),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: getSliderValue(familyList[index]
                                            .anyMembersWhoSmoke),
                                        weight: FontWeight.w400,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: SizedBox(
                                        width: 150,
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate(
                                                  'Any Members who use Tobacco?'),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: getSliderValue(familyList[index]
                                            .anyMembersWhoUseTobacco),
                                        weight: FontWeight.w400,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate(
                                                  'Any Members who Drink?'),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: getSliderValue(familyList[index]
                                              .anyMembersWhoDrink),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate('Drinking Usage'),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: getDrinkingUsage(
                                              familyList[index].drinkingUsage),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate('Stopped by'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: getStoppedValue(
                                              familyList[index].stoppedBy),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate('No of years'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text:familyList[index]
                                              .noOfYears !=
                                              ""
                                              ? familyList[index].noOfYears:"-",
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate(
                                                    'When you had a treatment'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: familyList[index]
                                                      .whenTreatment !=
                                                  ""
                                              ? familyList[index].whenTreatment
                                              : "-",
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate(
                                                    'Where you had a treatment'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: familyList[index]
                                                      .whereTreatment !=
                                                  ""
                                              ? familyList[index].whereTreatment
                                              : "-",
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate("Status?"),
                                        weight: FontWeight.w800,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: getDied(familyList[index]),
                                        weight: FontWeight.w400,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate("Migrate"),
                                        weight: FontWeight.w800,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: getMigrate(familyList[index]),
                                        weight: FontWeight.w400,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate("Vaccination Done"),
                                        weight: FontWeight.w800,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: getSliderValue(familyList[index]
                                            .isVaccinationDone),
                                        weight: FontWeight.w400,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate("1st Dose Date"),
                                        weight: FontWeight.w800,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: familyList[index].firstDose == ""
                                            ? DemoLocalization.of(context)
                                                .translate('Not Answered')
                                            : familyList[index].firstDose,
                                        weight: FontWeight.w400,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate("2nd Dose Date"),
                                        weight: FontWeight.w800,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: familyList[index].secondDose == ""
                                            ? DemoLocalization.of(context)
                                                .translate('Not Answered')
                                            : familyList[index].secondDose,
                                        weight: FontWeight.w400,
                                        color: darkColor,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (familyList[index].isExpanded == "Show More")
                            familyList[index].isExpanded = "Show Less";
                          else
                            familyList[index].isExpanded = "Show More";
                        });
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, bottom: 8),
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate(familyList[index].isExpanded),
                            weight: FontWeight.w600,
                            color: primaryColor,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
                onTap: () {
                  if (familyIndex > 0) {
                    final snackBar = SnackBar(
                        content: Text(
                            'Save or cancel the current member before editing another'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }
                  setState(() {
                    familyIndex = index;
                    addfamily = true;
                  });
                },
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        );
      },
    );
  }

  Widget _landscapeMode() {
    return ListView.builder(
      itemCount: familyList.length,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        debugPrint("familyPhoto:${familyList[index].photo}");
        familyList.sort((a, b) => a.position.compareTo(b.position));
        debugPrint("demographicList:${familyList[index].position}");
        return Column(
          children: [
            Container(
              child: InkWell(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 140,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: familyList[index].photo != ""
                                  ? Image.network(familyList[index].photo,
                                      fit: BoxFit.fill)
                                  : familyList[index].gender == ""
                                      ? Image.asset(imgCamera, fit: BoxFit.fill)
                                      : familyList[index].gender == "Male" ||
                                              familyList[index].gender == "?????????"
                                          ? SvgPicture.asset(
                                              svgMan,
                                              semanticsLabel: "Logo",
                                              height: height / 12,
                                              width: width / 8,
                                              fit: BoxFit.contain,
                                              allowDrawingOutsideViewBox: true,
                                            )
                                          : familyList[index].gender ==
                                                      "Transgender" ||
                                                  familyList[index].gender ==
                                                      "???????????????????????????"
                                              ? SvgPicture.asset(
                                                  svgGender,
                                                  semanticsLabel: "Logo",
                                                  height: height / 12,
                                                  width: width / 8,
                                                  fit: BoxFit.contain,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                )
                                              : SvgPicture.asset(
                                                  svgWoman,
                                                  semanticsLabel: "Logo",
                                                  height: height / 10,
                                                  width: width / 10,
                                                  fit: BoxFit.contain,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: getName(familyList[index]),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text:
                                      "${familyList[index].age == 0 ? "" : familyList[index].age.toString()}${familyList[index].dob.toString().length > 0 ? "," + familyList[index].dob.toString() : ""}",
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: getTexts(familyList[index]),
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: getPregnant(familyList[index]),
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
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
                                height: 10,
                              ),
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
                                  text: getMaskedNo(
                                      familyList[index].aadharNumber),
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Education Qualification'),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SizedBox(
                                  width: 120,
                                  child: TextWidget(
                                    text: familyList[index].education,
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Business'),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: familyList[index].occupation,
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
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
                                child: SizedBox(
                                  width: 120,
                                  child: TextWidget(
                                    text: familyList[index]
                                        .annualIncome
                                        .toString(),
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
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Section'),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: TextWidget(
                                  text: familyList[index].community,
                                  weight: FontWeight.w400,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Caste'),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SizedBox(
                                  width: 120,
                                  child: TextWidget(
                                    text: familyList[index].caste,
                                    weight: FontWeight.w400,
                                    color: darkColor,
                                    size: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Pension'),
                                  weight: FontWeight.w800,
                                  color: darkColor,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SizedBox(
                                  width: 150,
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
                      ],
                    ),
                    familyList[index].isExpanded == "Show Less"
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate('Insurance'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextWidget(
                                            text:
                                                getInsurance(familyList[index]),
                                            weight: FontWeight.w400,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate('Smart phone'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextWidget(
                                            text: getSliderValue(
                                                familyList[index].smartphone),
                                            weight: FontWeight.w400,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate(
                                                    'Physically challenged'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextWidget(
                                            text:
                                                getPhysical(familyList[index]),
                                            weight: FontWeight.w400,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: SizedBox(
                                            width: 150,
                                            child: TextWidget(
                                              text: DemoLocalization.of(context)
                                                  .translate(
                                                      'Any Members who Smoke?'),
                                              weight: FontWeight.w800,
                                              color: darkColor,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextWidget(
                                            text: getSliderValue(
                                                familyList[index]
                                                    .anyMembersWhoSmoke),
                                            weight: FontWeight.w400,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate(
                                                    'Any Members who use Tobacco?'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: getSliderValue(familyList[index]
                                              .anyMembersWhoUseTobacco),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate(
                                                  'Any Members who Drink?'),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: getSliderValue(familyList[index]
                                              .anyMembersWhoDrink),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate('Drinking Usage'),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: getDrinkingUsage(
                                              familyList[index].drinkingUsage),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate('Stopped by'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: getStoppedValue(
                                              familyList[index].stoppedBy),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate('No of years'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text:
                                              familyList[index].noOfYears != ""
                                                  ? familyList[index].noOfYears
                                                  : "-",
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate(
                                                    'When you had a treatment'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: familyList[index]
                                                      .whenTreatment !=
                                                  ""
                                              ? familyList[index].whenTreatment
                                              : "-",
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate(
                                                    'Where you had a treatment'),
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: familyList[index]
                                                      .whereTreatment !=
                                                  ""
                                              ? familyList[index].whereTreatment
                                              : "-",
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate("Status?"),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: getDied(familyList[index]),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate("Migrate"),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: getMigrate(familyList[index]),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate("Vaccination Done"),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: getSliderValue(familyList[index]
                                              .isVaccinationDone),
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate("1st Dose Date"),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text:
                                              familyList[index].firstDose == ""
                                                  ? DemoLocalization.of(context)
                                                      .translate('Not Answered')
                                                  : familyList[index].firstDose,
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate("2nd Dose Date"),
                                          weight: FontWeight.w800,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextWidget(
                                          text: familyList[index].secondDose ==
                                                  ""
                                              ? DemoLocalization.of(context)
                                                  .translate('Not Answered')
                                              : familyList[index].secondDose,
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (familyList[index].isExpanded == "Show More")
                            familyList[index].isExpanded = "Show Less";
                          else
                            familyList[index].isExpanded = "Show More";
                        });
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, bottom: 8),
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate(familyList[index].isExpanded),
                            weight: FontWeight.w600,
                            color: primaryColor,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
                onTap: () {
                  if (familyIndex > 0) {
                    final snackBar = SnackBar(
                        content: Text(
                            'Save or cancel the current member before editing another'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }
                  setState(() {
                    familyIndex = index;
                    addfamily = true;
                  });
                },
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        );
      },
    );
  }

  getMaskedNo(String aadharNumber) {
    if (aadharNumber == "") {
      return aadharNumber = "";
    } else {
      aadharNumber = aadharNumber.replaceRange(0, aadharNumber.length - 4, "*");
      return "*******" + aadharNumber;
    }
  }

  String getDrinkingUsage(double value) {
    if (value == 0)
      return DemoLocalization.of(context).translate('Not Answered');
    if (value == 1) return DemoLocalization.of(context).translate('Occasional');
    if (value == 2) return DemoLocalization.of(context).translate('Moderate');
    if (value == 3) return DemoLocalization.of(context).translate('Heavy');
    if (value == 4) return DemoLocalization.of(context).translate('Stopped');
  }

  String getStoppedValue(double value) {
    if (value == 0)
      return DemoLocalization.of(context).translate('Not Answered');
    else if (value == 1)
      return DemoLocalization.of(context).translate('Own');
    else
      return DemoLocalization.of(context).translate('Treatment');
  }

  getName(Family family) {
    String name = "";
    if (family.position != null) {
      name += family.position + ")" + " ";
    }
    if (family.name != null) name += family.name;
    return name;
  }
}
