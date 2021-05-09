/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 1/4/21 3:44 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 1/4/21 3:44 PM by Kanmalai.
 * /
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/models/data_model.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String dropDownLang;
  var height, width;
  DemographicFamily demographicList;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String userName = "";
  String userMail = "";
  int familyIndex = -1;
  List<String> streets = [];
  String documentId ="";
  bool isEdit = false;

  @override
  void initState() {
    if (firebaseAuth.currentUser != null) {
      userName = firebaseAuth.currentUser.displayName;
      userMail = firebaseAuth.currentUser.email;

      debugPrint("userEmail:${firebaseAuth.currentUser}");
    }
    var arguments = Get.arguments;
    demographicList = arguments[0];
    streets = arguments[1];
    documentId = arguments[2];
    isEdit = arguments[3];

    debugPrint("demographicList:${demographicList.location.contactPerson}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  svgTctLogo,
                  semanticsLabel: "Logo",
                  height: height / 12,
                  width: width / 12,
                  fit: BoxFit.contain,
                  allowDrawingOutsideViewBox: true,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                            child: firebaseAuth.currentUser.photoURL == null
                                ? Image.asset(user,fit: BoxFit.fill)
                                : Image.network(firebaseAuth.currentUser.photoURL)),
                        SizedBox(
                          width: 10,
                        ),
                        userMail != null
                            ? Text(
                          userMail,
                          style:
                          TextStyle(fontSize: 16, color: darkColor),
                        )
                            : Text(
                          userName,
                          style:
                          TextStyle(fontSize: 16, color: darkColor),
                        ),
                      ],
                    )),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    AuthenticationService(FirebaseAuth.instance).signOut();
                  },
                  child: Icon(
                    Icons.power_settings_new_outlined,
                    color: darkColor,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imgBG),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: (height) * 0.02,
                              left: (width) * 0.02,
                              right: (width) * 0.02,
                              bottom: (height) * 0.02,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed('/homeScreen');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          border: Border.all(
                                            color: Colors.black45,
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.keyboard_arrow_left,
                                          size: 20,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                TextWidget(
                                  text: demographicList.location.contactPerson,
                                  color: darkColor,
                                  weight: FontWeight.w600,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: TextWidget(
                              text: "*IN PROGRESS",
                              color: yellowColor,
                              weight: FontWeight.w600,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 1,
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 8),
                                    child: TextWidget(
                                      text: DemoLocalization.of(context)
                                          .translate('Location'),
                                      size: 16,
                                      weight: FontWeight.w800,
                                      color: darkColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 80,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate('Form No'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: demographicList.location.formNo,
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate('Door No'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text:demographicList.location.doorNumber,
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Project Code No'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: demographicList.location.projectCode,
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Street Name'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: demographicList.location.streetName,
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Village Code'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: demographicList.location.villagesCode.toString(),
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 50,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Panchayat No'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: demographicList.location.panchayatNo.toString(),
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Village Name'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: demographicList.location.villageName.toString(),
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Panchayat Code'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text:demographicList.location.panchayatCode,
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Contact Person'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: demographicList.location.contactPerson,
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 8.0),
                                    child: TextWidget(
                                      text: DemoLocalization.of(context)
                                          .translate('Property Details')
                                          .toUpperCase(),
                                      size: 16,
                                      color: darkColor,
                                      weight: FontWeight.w800,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Status of House'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text:demographicList.property.statusofHouse,
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Vehicle Details'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: TextWidget(
                                                    text:getVehicle(demographicList.property),
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 4, bottom: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Type of House'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: demographicList.property.typeofHouse,
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 50,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Toilet Facility at Home'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text:getSliderValue( demographicList.property.toiletFacility),
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 50,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 120,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Wet Land Holding(In Acres)'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: demographicList.property.wetLandInAcres,
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Livestock Details'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text:getLiveStock(demographicList.property),
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Dry Land Holding(In Acres)'),
                                                    size: 14,
                                                    color: darkGreyColor,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 120,
                                                  child: TextWidget(
                                                    text: demographicList.property.dryLandInAcres,
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 8.0),
                                    child: TextWidget(
                                      text: DemoLocalization.of(context)
                                          .translate('Habits')
                                          .toUpperCase(),
                                      size: 16,
                                      color: darkColor,
                                      weight: FontWeight.w800,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: TextWidget(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Any Members who Smoke?'),
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text:getSliderValue(demographicList.habits.anyMembersWhoSmoke),
                                                      size: 14,
                                                      color: darkColor,
                                                      weight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: TextWidget(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Any Members who Drink?'),
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text:getSliderValue(demographicList.habits.anyMembersWhoDrink),
                                                      size: 14,
                                                      color: darkColor,
                                                      weight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: TextWidget(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Any Members who use Tobacco?'),
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text:getSliderValue(demographicList.habits.anyMembersWhoUseTobacco),
                                                      size: 14,
                                                      color: darkColor,
                                                      weight: FontWeight.w400,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: TextWidget(
                                                      text: DemoLocalization.of(context)
                                                          .translate("Vaccination Done") ,
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text:getSliderValue(demographicList.habits.isVaccinationDone),
                                                      size: 14,
                                                      color: darkColor,
                                                      weight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: TextWidget(
                                                      text:  DemoLocalization.of(context)
                                                          .translate("1st Dose Date") ,
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text:demographicList.habits.firstDose,
                                                      size: 14,
                                                      color: darkColor,
                                                      weight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: TextWidget(
                                                      text: DemoLocalization.of(context)
                                                          .translate("2nd Dose Date") ,
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text:demographicList.habits.secondDose,
                                                      size: 14,
                                                      color: darkColor,
                                                      weight: FontWeight.w400,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            demographicList.family.length>0?   Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 8.0),
                                    child: TextWidget(
                                      text: DemoLocalization.of(context)
                                          .translate('Family Members'),
                                      size: 16,
                                      color: darkColor,
                                      weight: FontWeight.w800,
                                    ),
                                  ),
                                  ListView.builder(
                                    itemCount: demographicList.family.length,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      debugPrint("familyPhoto:${demographicList.family[index].photo}");
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            familyIndex = index;
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
                                                    child:  demographicList.family[index].photo== ""
                                                        ? SvgPicture.asset(
                                                      svgTctLogo,
                                                      semanticsLabel: "Logo",
                                                      height: height / 10,
                                                      width: width / 10,
                                                      fit: BoxFit.contain,
                                                      allowDrawingOutsideViewBox: true,
                                                    )
                                                        : Image.network(demographicList.family[index].photo,fit: BoxFit.fill)),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: TextWidget(
                                                          text: demographicList.family[index].name,
                                                          weight: FontWeight.w800,
                                                          color: darkColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: TextWidget(
                                                          text:
                                                          "${demographicList.family[index].age.toString()},${demographicList.family[index].dob.toString()}",
                                                          weight: FontWeight.w400,
                                                          color: darkColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: TextWidget(
                                                          text:
                                                          "${demographicList.family[index].gender} ,${demographicList.family[index].bloodGroup},${demographicList.family[index].maritalStatus} ",
                                                          weight: FontWeight.w400,
                                                          color: darkColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: TextWidget(
                                                          text: demographicList.family[index].mobileNumber,
                                                          weight: FontWeight.w400,
                                                          color: darkColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: TextWidget(
                                                          text: demographicList.family[index].mail,
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
                                                          text:  DemoLocalization.of(context)
                                                              .translate('Aadhaar No'),
                                                          weight: FontWeight.w800,
                                                          color: darkColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: TextWidget(
                                                          text: demographicList.family[index].aadharNumber,
                                                          weight: FontWeight.w400,
                                                          color: darkColor,
                                                          size: 14,
                                                        ),
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
                                                          text: demographicList.family[index].occupation,
                                                          weight: FontWeight.w400,
                                                          color: darkColor,
                                                          size: 14,
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
                                                      TextWidget(
                                                        text: demographicList.family[index].community,
                                                        weight: FontWeight.w400,
                                                        color: darkColor,
                                                        size: 14,
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
                                                          text: getInsurance(demographicList.family[index]),
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
                                                          text: demographicList.family[index].education,
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
                                                          demographicList.family[index].annualIncome.toString(),
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
                                                          text: demographicList.family[index].caste,
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
                                                        child: TextWidget(
                                                          text: getPension(demographicList.family[index]),
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
                                                          text: getSliderValue(demographicList.family[index].smartphone),
                                                          weight: FontWeight.w400,
                                                          color: darkColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: TextWidget(
                                                          text:  DemoLocalization.of(context)
                                                              .translate('Physically challenged'),
                                                          weight: FontWeight.w800,
                                                          color: darkColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: TextWidget(
                                                          text: getSliderValue(demographicList.family[index].physicallyChallenge),
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
                                  ),
                                ],
                              ),
                            ):Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 50.0, bottom: 50.0),
        child: FloatingActionButton(
          // isExtended: true,
          child: Icon(
            Icons.edit,
            size: 25,
          ),
          backgroundColor: primaryColor,
          onPressed: () {
            setState(() {

              Get.toNamed('/questionnery', arguments: [demographicList , streets, documentId, true],);
            });
          },
        ),
      ),
    );
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

  String getLiveStock(Property property) {
    String liveStock = "";
    if (property.ownLivestocks == 2)
      liveStock += property.livestockType.toString() + "-" + property.livestockCount ;
    return liveStock;
  }


  String getVehicle(Property property) {
    String vehicles = "";
    if (property.ownVehicle == 2)
      vehicles += DemoLocalization.of(context).translate('Two Wheeler')+"-" +property.twoWheeler.toString()+ "," + DemoLocalization.of(context).translate('Three Wheeler')+"""
-"""+ property.threeWheeler+ "," + DemoLocalization.of(context).translate('Four Wheeler')+"-" +property.fourWheeler.toString();
    return vehicles;
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
