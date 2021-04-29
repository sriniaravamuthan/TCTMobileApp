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
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String dropDownLang;
  var height, width;

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
            SvgPicture.asset(
              svgTctLogo,
              semanticsLabel: "Logo",
              height: height / 12,
              width: width / 12,
              fit: BoxFit.contain,
              allowDrawingOutsideViewBox: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 8.0),
                            height: 30,
                            width: 30,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new AssetImage(user)))),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Senthil Kumar",
                          style: TextStyle(fontSize: 16, color: darkColor),
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
                                  text: "Senthil Kumar",
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
                      AspectRatio(
                        aspectRatio: 24 / 10,
                        child: SingleChildScrollView(
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
                                                left: 4,
                                                right: 4,
                                                bottom: 24),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 80,
                                                    child: TextWidget(
                                                      text:
                                                          DemoLocalization.of(
                                                                  context)
                                                              .translate(
                                                                  'Form No'),
                                                      size: 14,
                                                      color: darkGreyColor,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: "12345",
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text:
                                                          DemoLocalization.of(
                                                                  context)
                                                              .translate(
                                                                  'Door No'),
                                                      size: 14,
                                                      color: darkGreyColor,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: "12",
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: DemoLocalization
                                                              .of(context)
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: "12345",
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: DemoLocalization
                                                              .of(context)
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: "Lalikuppam",
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
                                                left: 4,
                                                right: 4,
                                                bottom: 80),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: DemoLocalization
                                                              .of(context)
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: "12345",
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
                                                left: 4,
                                                right: 4,
                                                bottom: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: DemoLocalization
                                                              .of(context)
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: "12345",
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: DemoLocalization
                                                              .of(context)
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: "Lalikuppam",
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: DemoLocalization
                                                              .of(context)
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: "12345",
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: DemoLocalization
                                                              .of(context)
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: "Ramasamy",
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
                                                      const EdgeInsets.all(
                                                          4.0),
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,
                                                    child: TextWidget(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Own Land'),
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,

                                                    child: TextWidget(
                                                      text: "Vehicle Details",
                                                      size: 14,
                                                      color: darkGreyColor,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,

                                                    child: TextWidget(
                                                      text: "Two Wheeler-1",
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
                                                      const EdgeInsets.all(
                                                          4.0),
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,

                                                    child: TextWidget(
                                                      text: "Hut House",
                                                      size: 14,
                                                      color: darkColor,
                                                      weight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 43,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4.0),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4.0),
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
                                                      const EdgeInsets.all(
                                                          4.0),
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,

                                                    child: TextWidget(
                                                      text: "Yes",
                                                      size: 14,
                                                      color: darkColor,
                                                      weight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 43,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4.0),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4.0),
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
                                                SizedBox(
                                                  width: 120,

                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,

                                                    child: TextWidget(
                                                      text: "2",
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
                                                      const EdgeInsets.all(
                                                          4.0),
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,

                                                    child: TextWidget(
                                                      text: "COW-2",
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
                                                      const EdgeInsets.all(
                                                          4.0),
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
                                                      const EdgeInsets.all(
                                                          4.0),
                                                  child: SizedBox(
                                                    width: 120,

                                                    child: TextWidget(
                                                      text: "1",
                                                      size: 14,
                                                      color: darkColor,
                                                      weight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 72,
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
                                child:
                                Column(
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 250,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(context)
                                                        .translate('Any Members who Smoke?'),
                                                    size: 14,
                                                    weight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    4.0),
                                                child: SizedBox(
                                                  width: 120,

                                                  child: TextWidget(
                                                    text: "Yes",
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
                                                padding: const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 250,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(context)
                                                        .translate('Any Members who Drink?'),
                                                    size: 14,
                                                    weight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    4.0),
                                                child: SizedBox(
                                                  width: 120,

                                                  child: TextWidget(
                                                    text: "No",
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
                                                padding: const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 250,
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(context)
                                                        .translate('Any Members who use Tobacco?'),
                                                    size: 14,
                                                    weight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    4.0),
                                                child: SizedBox(
                                                  width: 120,

                                                  child: TextWidget(
                                                    text: "Yes",
                                                    size: 14,
                                                    color: darkColor,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              )     ],
                                          )
                                        ],
                                      ),
                                    ),
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
                                        left: 4.0,
                                        top: 4.0,
                                      ),
                                      child: TextWidget(
                                        text:  DemoLocalization.of(context)
                                            .translate('Family Members'),
                                        size: 16,
                                        color: darkColor,
                                        weight: FontWeight.w800,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2,top:4),
                                          child: Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: TextWidget(
                                                    text: "Saravanakumar (Son)",
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),

                                                TextWidget(
                                                  text: "24" +
                                                      "YRS" +
                                                      "(15 Feb 1996)," +
                                                      "Male," +
                                                      "O+" +
                                                      "Married",
                                                  color: darkColor,
                                                  size: 14,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate('Mobile No'),
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),

                                                TextWidget(
                                                  text: "+91 8989898888",
                                                  color: darkColor,
                                                  size: 14,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: TextWidget(
                                                  text:
                                                      DemoLocalization.of(context)
                                                          .translate('Email'),
                                                  color: darkGreyColor,
                                                  size: 14,
                                                  weight: FontWeight.w700,
                                                ),
                                              ),

                                              TextWidget(
                                                text: "saravanakumar@gmail.com",
                                                color: darkColor,
                                                size: 14,
                                                weight: FontWeight.w400,
                                              ),
                                            ],
                                          )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate('Aadhaar No'),
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),

                                                TextWidget(
                                                  text: "5465 4654 6688",
                                                  color: darkColor,
                                                  size: 14,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Education Qualification'),
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),

                                                TextWidget(
                                                  text: "BSc",
                                                  color: darkColor,
                                                  size: 14,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: TextWidget(
                                                  text:
                                                      DemoLocalization.of(context)
                                                          .translate('Business'),
                                                  color: darkGreyColor,
                                                  size: 14,
                                                  weight: FontWeight.w700,
                                                ),
                                              ),

                                              TextWidget(
                                                text: "Farmer",
                                                color: darkColor,
                                                size: 14,
                                                weight: FontWeight.w400,
                                              ),
                                            ],
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: TextWidget(
                                                  text: DemoLocalization.of(
                                                          context)
                                                      .translate('Annual Income'),
                                                  color: darkGreyColor,
                                                  size: 14,
                                                  weight: FontWeight.w700,
                                                ),
                                              ),

                                              TextWidget(
                                                text: "60000",
                                                color: darkColor,
                                                size: 14,
                                                weight: FontWeight.w400,
                                              ),
                                            ],
                                          )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate('Smart phone'),
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),

                                                TextWidget(
                                                  text: "yes",
                                                  color: darkColor,
                                                  size: 14,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Physically challenged'),
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),

                                                TextWidget(
                                                  text: "No",
                                                  color: darkColor,
                                                  size: 14,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: TextWidget(
                                                  text:
                                                      DemoLocalization.of(context)
                                                          .translate('Community'),
                                                  color: darkGreyColor,
                                                  size: 14,
                                                  weight: FontWeight.w700,
                                                ),
                                              ),

                                              TextWidget(
                                                text: "MBC",
                                                color: darkColor,
                                                size: 14,
                                                weight: FontWeight.w400,
                                              ),
                                            ],
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: TextWidget(
                                                  text: caste,
                                                  color: darkGreyColor,
                                                  size: 14,
                                                  weight: FontWeight.w700,
                                                ),
                                              ),

                                              TextWidget(
                                                text: "Agamudayar",
                                                color: darkColor,
                                                size: 14,
                                                weight: FontWeight.w400,
                                              ),
                                            ],
                                          )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: TextWidget(
                                                    text: insurance,
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ),

                                                TextWidget(
                                                  text: "Government,Private",
                                                  color: darkColor,
                                                  size: 14,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, bottom: 2),
                                          child: Expanded(
                                              child: Align(
                                            alignment: Alignment(-2.42, 2.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: TextWidget(
                                                      text: pension,
                                                      color: darkGreyColor,
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),

                                                  // Text(
                                                  //   "Old age,Retirement",
                                                  //   overflow: TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     color: darkColor,
                                                  //     fontSize: 16,
                                                  //     fontWeight: FontWeight.w700,),
                                                  // )
                                                  TextWidget(
                                                    text: "Old age,Retirement",
                                                    color: darkColor,
                                                    size: 14,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
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
              Get.toNamed('/questionnaire');
            });
          },
        ),
      ),
    );
  }

  void _changeLanguage() async {
    // Locale _temp = await setLocale(language.languageCode);
    // SplashScreen.setLocale(context, _temp);

    if (dropDownLang == "Tamil") {
      setState(() {
        MyApp.setLocale(context, Locale('ta', 'IN'));
      });
    } else {
      setState(() {
        MyApp.setLocale(context, Locale('en', 'US'));
      });
    }
  }
}
