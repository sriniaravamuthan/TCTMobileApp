/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 1/4/21 3:44 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 1/4/21 3:44 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/main.dart';
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
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: lightColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton(
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.language,
                    color: Colors.black87,
                  ),
                  items: ['Tamil', 'English'].map((val) {
                    return new DropdownMenuItem<String>(
                      value: val,
                      child: new Text(val),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      dropDownLang = val;
                      _changeLanguage();
                    });
                    print("Language:$val");
                  },
                ),
                SizedBox(
                  width: 50,
                ),
                InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          "Senthil Kumar",
                          style: TextStyle(fontSize: 18, color: darkColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 8.0),
                            height: 30,
                            width: 30,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new AssetImage(user))))
                      ],
                    )),
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
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, top: 16),
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate('Location'),
                                            size: 16,
                                            weight: FontWeight.w800,
                                            color: darkColor,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Form No'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "12345",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Door No'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "12",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Project Code No'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "12345",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Street Name'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "Lalikuppam",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Village Code'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "12345",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 43,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Panchayat No'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "12345",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Village Name'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "Lalikuppam",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Panchayat Code'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "12345",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Contact Person'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "Ramasamy",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, top: 16.0),
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
                                          padding: const EdgeInsets.all(16.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Status of House'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Own Land'),
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text:
                                                              "Vehicle Details",
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "Two Wheeler-1",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text:
                                                              "Types Of House",
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "Hut House",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 43,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Toilet Facility at Home'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "Yes",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 43,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Wet Land Holding(In Acres)'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "2",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Livestock Details'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "COW-2",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Dry Land Holding(In Acres)'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "1",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 16.0,
                                            top: 16.0,
                                          ),
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
                                          padding: const EdgeInsets.all(16.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Any Members who Smoke?'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "No",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: DemoLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'Any Members who Drink?'),
                                                          size: 14,
                                                          color: darkGreyColor,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextWidget(
                                                          text: "Yes",
                                                          size: 14,
                                                          color: darkColor,
                                                          weight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextWidget(
                                                        text: DemoLocalization
                                                                .of(context)
                                                            .translate(
                                                                'Any Members who use Tobacco?'),
                                                        size: 14,
                                                        color: darkGreyColor,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextWidget(
                                                        text: "No",
                                                        size: 14,
                                                        color: darkColor,
                                                        weight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 16.0,
                                            top: 16.0,
                                          ),
                                          child: TextWidget(
                                            text: family.toUpperCase(),
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
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(
                                                      text:
                                                          "Saravanakumar (Son)",
                                                      color: darkGreyColor,
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
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
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Mobile No'),
                                                      color: darkGreyColor,
                                                      size: 14,
                                                      weight: FontWeight.w600,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextWidget(
                                                      text: "+91 8989898888",
                                                      color: darkColor,
                                                      size: 14,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate('Email'),
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        "saravanakumar@gmail.com",
                                                    color: darkColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
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
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Aadhaar No'),
                                                      color: darkGreyColor,
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextWidget(
                                                      text: "5465 4654 6688",
                                                      color: darkColor,
                                                      size: 14,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Education Qualification'),
                                                      color: darkGreyColor,
                                                      size: 14,
                                                      weight: FontWeight.w600,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextWidget(
                                                      text: "BSc",
                                                      color: darkColor,
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate('Business'),
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextWidget(
                                                    text: "Farmer",
                                                    color: darkColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ],
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate(
                                                            'Annual Income'),
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextWidget(
                                                    text: "60000",
                                                    color: darkColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
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
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Smart phone'),
                                                      color: darkGreyColor,
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextWidget(
                                                      text: "yes",
                                                      color: darkColor,
                                                      size: 14,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Physically challenged'),
                                                      color: darkGreyColor,
                                                      size: 14,
                                                      weight: FontWeight.w600,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextWidget(
                                                      text: "No",
                                                      color: darkColor,
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text: DemoLocalization.of(
                                                            context)
                                                        .translate('Community'),
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextWidget(
                                                    text: "MBC",
                                                    color: darkColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
                                                  ),
                                                ],
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text: caste,
                                                    color: darkGreyColor,
                                                    size: 14,
                                                    weight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextWidget(
                                                    text: "Agamudayar",
                                                    color: darkColor,
                                                    size: 14,
                                                    weight: FontWeight.w700,
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
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(
                                                      text: insurance,
                                                      color: darkGreyColor,
                                                      size: 14,
                                                      weight: FontWeight.w700,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextWidget(
                                                      text:
                                                          "Government,Private",
                                                      color: darkColor,
                                                      size: 14,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24,
                                                  right: 8,
                                                  bottom: 2),
                                              child: Expanded(
                                                  child: Align(
                                                alignment:
                                                    Alignment(-2.42, 2.0),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                        text: pension,
                                                        color: darkGreyColor,
                                                        size: 14,
                                                        weight: FontWeight.w600,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
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
                                                        text:
                                                            "Old age,Retirement",
                                                        color: darkColor,
                                                        size: 14,
                                                        weight: FontWeight.w700,
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
                size: 30,
              ),
              backgroundColor: primaryColor,
              onPressed: () {
                setState(() {
                  Get.toNamed('/questionnaire');
                });
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      // decoration: BoxDecoration(
                      //   borderRadius:
                      //   BorderRadius.all(Radius.circular(50.0),),
                      // ),
                      child: Image.asset(imgLightLogo)),
                )),
          ),
        )
      ],
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
