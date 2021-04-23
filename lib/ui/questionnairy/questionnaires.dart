/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 3:21 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 3:21 PM by Kanmalai.
 * /
 */

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/ui/questionnairy/familymember_details.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/habit_step.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/property_step.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

import '../../main.dart';

class QuestionnairesScreen extends StatefulWidget {
  @override
  _QuestionnairesScreenState createState() => _QuestionnairesScreenState();
}

class _QuestionnairesScreenState extends State<QuestionnairesScreen> {
  int _currentStep = 0;
  FocusNode mailFocusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FocusNode familyMemFocus = new FocusNode();

  String formNo,
      projectCode,
      villageCodeValue,
      panNoVal,
      panCodeVal,
      villageNameVal,
      streetName,
      doorNumber,
      contactPerson;
  String dropDownLang;
  var villageController = TextEditingController();
  List villageCodeList = ["AAR", "ADR", "ARD"];
  var height, width;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _getVillageCode(villageController.text);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: lightColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16, right: 100),
              child: Container(
                child: Image.asset(
                  imgLightLogo,
                  fit: BoxFit.contain,
                  height: height / 11,
                  width: width / 20,
                ),
              ),
            ),
            Row(
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
                  width: 20,
                ),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgBG),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: (height) * 0.02,
                    left: (width) * 0.02,
                    right: (width) * 0.02,
                    bottom: (height) * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
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
                          TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Demographics questionnaires'),
                            color: darkColor,
                            weight: FontWeight.w600,
                            size: 16,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Mandatory Fields'),
                            color: darkColor,
                            weight: FontWeight.w600,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stepper(
                    type: StepperType.horizontal,
                    physics: ClampingScrollPhysics(),
                    currentStep: this._currentStep,
                    onStepTapped: (step) => tapped(step),
                    // onStepContinue: continued,
                    // onStepCancel: cancel,
                    controlsBuilder: (BuildContext context,
                        {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                // isExtended: true,
                                child: Icon(
                                  Icons.keyboard_arrow_left,
                                  size: 30,
                                  color: darkColor,
                                ),
                                backgroundColor: lightColor,
                                onPressed: () {
                                  cancel();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                // isExtended: true,
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 30,
                                  color: darkColor,
                                ),
                                backgroundColor: lightColor,
                                onPressed: () {
                                  continued();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                // isExtended: true,
                                child: Icon(
                                  Icons.done,
                                  size: 30,
                                ),
                                backgroundColor: primaryColor,
                                onPressed: () {
                                  setState(() {
                                    if (_formKey.currentState.validate()) {
                                      if (_formKey != null) {
                                        _formKey.currentState.save();
                                        addData();
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    steps: <Step>[
                      Step(
                        title: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Location'),
                          color: darkColor,
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                        content: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextWidget(
                                                text:
                                                    DemoLocalization.of(context)
                                                        .translate('Form No'),
                                                size: 14,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 58,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: TextFormField(
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  enableSuggestions: true,
                                                  decoration: InputDecoration(
                                                      border:
                                                          new OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      fillColor:
                                                          lightGreyColor),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onSaved: (String val) {
                                                    setState(() {
                                                      formNo = val;
                                                    });
                                                  },
                                                  // validator: (value) {
                                                  //   if (value.isEmpty) {
                                                  //     debugPrint(
                                                  //         "empid :yes");
                                                  //     return 'Employee Id must not be empty';
                                                  //   }
                                                  //   return null;
                                                  // },
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextWidget(
                                                text:
                                                    DemoLocalization.of(context)
                                                        .translate(
                                                            'Project Code No'),
                                                size: 14,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 58,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: TextFormField(
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  enableSuggestions: true,
                                                  decoration: InputDecoration(
                                                      border:
                                                          new OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      fillColor:
                                                          lightGreyColor),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onSaved: (String val) {
                                                    setState(() {
                                                      projectCode = val;
                                                    });
                                                  },
                                                  // validator: (value) {
                                                  //   if (value.isEmpty) {
                                                  //     debugPrint(
                                                  //         "empid :yes");
                                                  //     return 'Employee Id must not be empty';
                                                  //   }
                                                  //   return null;
                                                  // },
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
                                      alignment: Alignment.topRight,
                                      child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextWidget(
                                                text: DemoLocalization.of(
                                                        context)
                                                    .translate('Village Code'),
                                                size: 14,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 58,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: AutoCompleteTextField(
                                                      controller:
                                                          villageController,
                                                      clearOnSubmit: false,
                                                      itemSubmitted: (item) {
                                                        villageController.text =
                                                            item;
                                                      },
                                                      suggestions:
                                                          villageCodeList,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF222222),
                                                        fontSize: 16,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            new OutlineInputBorder(
                                                          borderRadius: BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                        ),
                                                      ),
                                                      itemBuilder:
                                                          (context, item) {
                                                        return new Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: TextWidget(
                                                              text: item,
                                                              color: darkColor,
                                                              size: 14,
                                                              weight: FontWeight
                                                                  .w600,
                                                            ));
                                                      },
                                                      itemSorter: (a, b) {
                                                        return a.compareTo(b);
                                                      },
                                                      itemFilter:
                                                          (item, query) {
                                                        return item
                                                            .toLowerCase()
                                                            .startsWith(query
                                                                .toLowerCase());
                                                      })
                                                  //     DropdownButtonFormField<
                                                  //         String>(
                                                  //   isExpanded: true,
                                                  //   decoration:
                                                  //       InputDecoration(
                                                  //     border:
                                                  //         new OutlineInputBorder(
                                                  //       borderSide:
                                                  //           BorderSide.none,
                                                  //       borderRadius: BorderRadius.only(
                                                  //           topRight: Radius
                                                  //               .circular(
                                                  //                   50.0),
                                                  //           bottomLeft: Radius
                                                  //               .circular(
                                                  //                   50.0),
                                                  //           bottomRight: Radius
                                                  //               .circular(
                                                  //                   50.0)),
                                                  //     ),
                                                  //     enabledBorder:
                                                  //         OutlineInputBorder(
                                                  //       borderRadius: BorderRadius.only(
                                                  //           topRight: Radius
                                                  //               .circular(
                                                  //                   50.0),
                                                  //           bottomLeft: Radius
                                                  //               .circular(
                                                  //                   50.0),
                                                  //           bottomRight: Radius
                                                  //               .circular(
                                                  //                   50.0)),
                                                  //       borderSide: BorderSide(
                                                  //           color:
                                                  //               lightGreyColor),
                                                  //     ),
                                                  //     errorBorder:
                                                  //         OutlineInputBorder(
                                                  //       borderRadius: BorderRadius.only(
                                                  //           topRight: Radius
                                                  //               .circular(
                                                  //                   50.0),
                                                  //           bottomLeft: Radius
                                                  //               .circular(
                                                  //                   50.0),
                                                  //           bottomRight: Radius
                                                  //               .circular(
                                                  //                   50.0)),
                                                  //       borderSide: BorderSide(
                                                  //           color:
                                                  //               lightGreyColor),
                                                  //     ),
                                                  //   ),
                                                  //   value: villageCodeValue,
                                                  //   validator: (value) =>
                                                  //       value == null
                                                  //           ? 'Source Type must not be empty'
                                                  //           : null,
                                                  //   onChanged: (value) =>
                                                  //       setState(() =>
                                                  //           villageCodeValue =
                                                  //               value),
                                                  //   items: <String>[
                                                  //     'VLR',
                                                  //     'CLR',
                                                  //     'MLR',
                                                  //   ].map<
                                                  //           DropdownMenuItem<
                                                  //               String>>(
                                                  //       (String value) {
                                                  //     return DropdownMenuItem<
                                                  //         String>(
                                                  //       value: value,
                                                  //       child: TextWidget(
                                                  //         text: value,
                                                  //         color: darkColor,
                                                  //         weight:
                                                  //             FontWeight.w400,
                                                  //         size: 16,
                                                  //       ),
                                                  //     );
                                                  //   }).toList(),
                                                  // ),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextWidget(
                                                text: DemoLocalization.of(
                                                        context)
                                                    .translate('Panchayat No'),
                                                size: 14,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 58,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  isExpanded: true,
                                                  decoration: InputDecoration(
                                                    border:
                                                        new OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                      borderSide: BorderSide(
                                                          color:
                                                              lightGreyColor),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                      borderSide: BorderSide(
                                                          color:
                                                              lightGreyColor),
                                                    ),
                                                  ),
                                                  value: panNoVal,
                                                  // validator: (value) => value ==
                                                  //         null
                                                  //     ? 'Source Type must not be empty'
                                                  //     : null,
                                                  onChanged: (value) =>
                                                      setState(() =>
                                                          panNoVal = value),
                                                  items: <String>[
                                                    '1212',
                                                    '2325',
                                                    '6558',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: TextWidget(
                                                        text: value,
                                                        color: darkColor,
                                                        weight: FontWeight.w400,
                                                        size: 14,
                                                      ),
                                                    );
                                                  }).toList(),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextWidget(
                                                text:
                                                    DemoLocalization.of(context)
                                                        .translate(
                                                            'Panchayat Code'),
                                                size: 14,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 58,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  isExpanded: true,
                                                  decoration: InputDecoration(
                                                    border:
                                                        new OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                      borderSide: BorderSide(
                                                          color:
                                                              lightGreyColor),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                      borderSide: BorderSide(
                                                          color:
                                                              lightGreyColor),
                                                    ),
                                                  ),
                                                  value: panCodeVal,
                                                  // validator: (value) => value ==
                                                  //         null
                                                  //     ? 'Source Type must not be empty'
                                                  //     : null,
                                                  onChanged: (value) =>
                                                      setState(() =>
                                                          panCodeVal = value),
                                                  items: <String>[
                                                    '98',
                                                    '988',
                                                    '999',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: TextWidget(
                                                        text: value,
                                                        color: darkColor,
                                                        weight: FontWeight.w400,
                                                        size: 14,
                                                      ),
                                                    );
                                                  }).toList(),
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
                                      alignment: Alignment.topRight,
                                      child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextWidget(
                                                text: DemoLocalization.of(
                                                        context)
                                                    .translate('Village Name'),
                                                size: 14,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 58,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  isExpanded: true,
                                                  decoration: InputDecoration(
                                                    border:
                                                        new OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                      borderSide: BorderSide(
                                                          color:
                                                              lightGreyColor),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                      borderSide: BorderSide(
                                                          color:
                                                              lightGreyColor),
                                                    ),
                                                  ),
                                                  value: villageNameVal,
                                                  // validator: (value) => value ==
                                                  //         null
                                                  //     ? 'Source Type must not be empty'
                                                  //     : null,
                                                  onChanged: (value) =>
                                                      setState(() =>
                                                          villageNameVal =
                                                              value),
                                                  items: <String>[
                                                    'kangeyam',
                                                    'puthupalayam',
                                                    'nallur',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: TextWidget(
                                                        text: value,
                                                        color: darkColor,
                                                        weight: FontWeight.w400,
                                                        size: 14,
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextWidget(
                                                text: DemoLocalization.of(
                                                        context)
                                                    .translate('Village Name'),
                                                size: 14,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 58,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  isExpanded: true,
                                                  decoration: InputDecoration(
                                                    border:
                                                        new OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                      borderSide: BorderSide(
                                                          color:
                                                              lightGreyColor),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50.0),
                                                              bottomLeft:
                                                                  Radius
                                                                      .circular(
                                                                          50.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      50.0)),
                                                      borderSide: BorderSide(
                                                          color:
                                                              lightGreyColor),
                                                    ),
                                                  ),
                                                  value: villageNameVal,
                                                  // validator: (value) => value ==
                                                  //         null
                                                  //     ? 'Source Type must not be empty'
                                                  //     : null,
                                                  onChanged: (value) =>
                                                      setState(() =>
                                                          villageNameVal =
                                                              value),
                                                  items: <String>[
                                                    'kangeyam',
                                                    'puthupalayam',
                                                    'nallur',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: TextWidget(
                                                        text: value,
                                                        color: darkColor,
                                                        weight: FontWeight.w400,
                                                        size: 14,
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate('Street Name'),
                                            size: 14,
                                            weight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 58,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: TextFormField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              enableSuggestions: true,
                                              decoration: InputDecoration(
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    50.0)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    50.0)),
                                                    borderSide: BorderSide(
                                                        color: lightGreyColor),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    50.0)),
                                                    borderSide: BorderSide(
                                                        color: lightGreyColor),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    50.0)),
                                                    borderSide: BorderSide(
                                                        color: lightGreyColor),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    50.0)),
                                                    borderSide: BorderSide(
                                                        color: lightGreyColor),
                                                  ),
                                                  fillColor: lightGreyColor),
                                              keyboardType: TextInputType.text,
                                              onSaved: (String val) {
                                                setState(() {});
                                              },
                                              // validator: (value) {
                                              //   if (value.isEmpty) {
                                              //     debugPrint("empid :yes");
                                              //     return 'Employee Id must not be empty';
                                              //   }
                                              //   return null;
                                              // },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextWidget(
                                                text:
                                                    DemoLocalization.of(context)
                                                        .translate('Door No'),
                                                size: 14,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 58,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: TextFormField(
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  enableSuggestions: true,
                                                  decoration: InputDecoration(
                                                      border:
                                                          new OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      fillColor:
                                                          lightGreyColor),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onSaved: (String val) {
                                                    setState(() {});
                                                  },
                                                  // validator: (value) {
                                                  //   if (value.isEmpty) {
                                                  //     debugPrint(
                                                  //         "empid :yes");
                                                  //     return 'Employee Id must not be empty';
                                                  //   }
                                                  //   return null;
                                                  // },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextWidget(
                                                text:
                                                    DemoLocalization.of(context)
                                                        .translate(
                                                            'Contact Person'),
                                                size: 14,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 58,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: TextFormField(
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  enableSuggestions: true,
                                                  decoration: InputDecoration(
                                                      border:
                                                          new OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      fillColor:
                                                          lightGreyColor),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onSaved: (String val) {
                                                    setState(() {});
                                                  },
                                                  // validator: (value) {
                                                  //   if (value.isEmpty) {
                                                  //     debugPrint(
                                                  //         "empid :yes");
                                                  //     return 'Employee Id must not be empty';
                                                  //   }
                                                  //   return null;
                                                  // },
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
                                      alignment: Alignment.topLeft,
                                      child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextWidget(
                                                text: DemoLocalization.of(
                                                        context)
                                                    .translate(
                                                        'Number of Family Members'),
                                                size: 14,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 58,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: TextFormField(
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  enableSuggestions: true,
                                                  decoration: InputDecoration(
                                                      border:
                                                          new OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                lightGreyColor),
                                                      ),
                                                      fillColor:
                                                          lightGreyColor),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onSaved: (String val) {
                                                    setState(() {});
                                                  },
                                                  // validator: (value) {
                                                  //   if (value.isEmpty) {
                                                  //     debugPrint(
                                                  //         "empid :yes");
                                                  //     return 'Employee Id must not be empty';
                                                  //   }
                                                  //   return null;
                                                  // },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
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
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Family Members'),
                          color: darkColor,
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                        content: FamilyMemberDetails(),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Property Details'),
                          color: darkColor,
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                        content: PropertyDetailStep(),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: TextWidget(
                          text:
                              DemoLocalization.of(context).translate('Habits'),
                          color: darkColor,
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                        content: HabitsStep(),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(right: 50.0, bottom: 50.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       FloatingActionButton(
      //         // isExtended: true,
      //         child: Icon(
      //           Icons.keyboard_arrow_right,
      //           size: 30,
      //           color: darkColor,
      //         ),
      //         backgroundColor: lightColor,
      //         onPressed: () {
      //           setState(() {});
      //         },
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       FloatingActionButton(
      //         // isExtended: true,
      //         child: Icon(
      //           Icons.done,
      //           size: 30,
      //         ),
      //         backgroundColor: primaryColor,
      //         onPressed: () {
      //           setState(() {});
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  tapped(int step) {
    if (step > _currentStep) {
      setState(() => _currentStep = step);
    }
  }

  continued() {
    // _currentStep < 2 ?
    // setState(() => _currentStep += 1): null;
    // debugPrint("_currentStep: $_currentStep");

    if (_currentStep < 1) {
      setState(() {
        _currentStep += 1;
      });
    } else if (_currentStep < 2) {
      setState(() {
        _currentStep += 1;
      });
    } else if (_currentStep < 3) {
      setState(() {
        _currentStep += 1;
      });
    }
    debugPrint("_currentStep: $_currentStep");
  }

  cancel() {
    // _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    // _stepTwoKey.currentState.reset();
    // _formKey.currentState.reset();
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
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

  Future<List<dynamic>> _getVillageCode(String text) {
    debugPrint(
        "VillageCode:${FirebaseFirestore.instance.collection(collectionVillageCode).where(collectionVillageCode, isEqualTo: text)}");
    // FirebaseFirestore.instance
    //      .collection('villageCode')
    //      .where('villageCode', isEqualTo: text)
    //      .snapshots();
  }

  void addData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('demographicData');
    collectionReference.add({
      'location': {
        "formNo ": formNo,
        "projectCode ": projectCode,
        "villagesCode ": villageController.text
      }
    });
  }
}
