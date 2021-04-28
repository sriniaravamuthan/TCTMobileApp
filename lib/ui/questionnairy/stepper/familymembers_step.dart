/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 2/4/21 3:27 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 2/4/21 3:27 PM by Kanmalai.
 * /
 */

import 'dart:collection';
import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class FamilyMemberStep extends StatefulWidget {
  @override
  _FamilyMemberStepState createState() => _FamilyMemberStepState();
}

class _FamilyMemberStepState extends State<FamilyMemberStep> {
  GlobalKey<FormState> _stepTwoKey = new GlobalKey<FormState>();
  bool isSwitched = false;
  bool isSwitched1 = false;
  String textValue = 'No';
  String textValue1 = 'No';
  double minPrice = 0;
  double maxPrice = 100;
  double _lowerValue = 0;
  double _upperValue = 100;
  var genderController = TextEditingController();
  var relationController = TextEditingController();
  var educationController = TextEditingController();

  TextEditingController ageController = TextEditingController();
  List<dynamic> values;
  List genderList;
  List genderListLang;
  List relationList;
  List relationLangList;
  List educationList;
  List educationLangList;
  String nameVal,
      relationshipVal,
      genderVal,
      dateOfBirthVal,
      maritalStatusVal,
      bloodGroupVal,
      qualificationVal,
      occupationVal,
      mailVal,
      communityVal,
      castVal,
      annualIncomeVal,
      photoVal;

  int aadharNumberVal, ageVal, mobileNumberVal;
  bool physicallyChallengeVal, smartphoneVal;
  TextEditingController datePicker = TextEditingController();
  DateTime date = DateTime.parse("2019-04-16 12:18:06.018950");
  String gender = "";
  File _image;
  final picker = ImagePicker();
  String language;

  @override
  void initState() {
    genderList = [];
    genderListLang = [];
    relationList = [];
    relationLangList = [];
    educationList = [];
    educationLangList = [];
    getLanguage();
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    datePicker.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("stringList1$genderListLang");
    return Form(
      key: _stepTwoKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Name'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autocorrect: true,
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    debugPrint("empid :yes");
                                    return 'Employee Id must not be empty';
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
                  flex: 1,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Aadhaar No'),
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 58,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              autocorrect: true,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: lightGreyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: lightGreyColor),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: lightGreyColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: lightGreyColor),
                                  ),
                                  fillColor: lightGreyColor),
                              keyboardType: TextInputType.text,
                              onSaved: (String val) {
                                setState(() {});
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  debugPrint("empid :yes");
                                  return 'Employee Id must not be empty';
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
                Expanded(
                  flex: 1,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context).translate(
                                'Relationship method of family head'),
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 58,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: AutoCompleteTextField(
                                controller: relationController,
                                clearOnSubmit: false,
                                itemSubmitted: (item) {
                                  relationController.text = item;
                                  debugPrint(
                                      "stringList1:${relationController.text}");
                                },
                                suggestions: relationLangList,
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 16,
                                ),
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
                                itemBuilder: (context, item) {
                                  return new Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextWidget(
                                        text: item,
                                        color: darkColor,
                                        size: 14,
                                        weight: FontWeight.w600,
                                      ));
                                },
                                itemSorter: (a, b) {
                                  return a.compareTo(b);
                                },
                                itemFilter: (item, query) {
                                  debugPrint("genderItem:$item");
                                  return item
                                      .toLowerCase()
                                      .startsWith(query.toLowerCase());
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: FractionallySizedBox(
                                widthFactor: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Gender'),
                                        size: 14,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 58,
                                      child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: AutoCompleteTextField(
                                              controller: genderController,
                                              clearOnSubmit: false,
                                              itemSubmitted: (item) {
                                                genderController.text = item;
                                                debugPrint(
                                                    "stringList1:${genderController.text}");
                                              },
                                              suggestions: genderListLang,
                                              style: TextStyle(
                                                color: Color(0xFF222222),
                                                fontSize: 16,
                                              ),
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        color: lightGreyColor),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        color: lightGreyColor),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        color: lightGreyColor),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        color: lightGreyColor),
                                                  ),
                                                  fillColor: lightGreyColor),
                                              itemBuilder: (context, item) {
                                                return new Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: TextWidget(
                                                      text: item,
                                                      color: darkColor,
                                                      size: 14,
                                                      weight: FontWeight.w600,
                                                    ));
                                              },
                                              itemSorter: (a, b) {
                                                return a.compareTo(b);
                                              },
                                              itemFilter: (item, query) {
                                                debugPrint("genderItem:$item");
                                                return item
                                                    .toLowerCase()
                                                    .startsWith(
                                                        query.toLowerCase());
                                              })),
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
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Date of Birth'),
                                        size: 14,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 58,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          autocorrect: true,
                                          controller: datePicker,
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
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
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

                                            datePicker.text =
                                                "${date.day}/${date.month}/${date.year}";

                                            dateOfBirthVal = datePicker.text;
                                            calculateAge(date);
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              debugPrint("empid :yes");
                                              return 'Employee Id must not be empty';
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
                              alignment: Alignment.topRight,
                              child: FractionallySizedBox(
                                widthFactor: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Age'),
                                        size: 14,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 58,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TextFormField(
                                          controller: ageController,
                                          textInputAction: TextInputAction.next,
                                          autocorrect: true,
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
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              fillColor: lightGreyColor),
                                          keyboardType: TextInputType.text,
                                          onSaved: (String val) {
                                            setState(() {
                                              ageController.text = val;
                                            });
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              debugPrint("empid :yes");
                                              return 'Employee Id must not be empty';
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: FractionallySizedBox(
                                widthFactor: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Marital status'),
                                        size: 14,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 58,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: DropdownButtonFormField<String>(
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              fillColor: lightGreyColor),
                                          value: maritalStatusVal,
                                          validator: (value) => value == null
                                              ? 'Source Type must not be empty'
                                              : null,
                                          onChanged: (value) => setState(
                                              () => maritalStatusVal = value),
                                          items: <String>[
                                            'Married',
                                            'UnMarried',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Blood Group'),
                                        size: 14,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 58,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: DropdownButtonFormField<String>(
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: lightGreyColor),
                                              ),
                                              fillColor: lightGreyColor),
                                          value: bloodGroupVal,
                                          validator: (value) => value == null
                                              ? 'Source Type must not be empty'
                                              : null,
                                          onChanged: (value) => setState(
                                              () => bloodGroupVal = value),
                                          items: <String>[
                                            'A+',
                                            'A-',
                                            'B+',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Physically challenged'),
                                        size: 14,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Switch(
                                            onChanged: toggleSwitch,
                                            value: isSwitched,
                                            activeColor: Colors.blue,
                                            activeTrackColor: greyColor,
                                            inactiveThumbColor: greyColor,
                                            inactiveTrackColor: greyColor,
                                          ),
                                          TextWidget(
                                            text: textValue,
                                            size: 14,
                                            weight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Photograph'),
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            getImage();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: _image == null
                                    ? Image.asset(imgCamera)
                                    : Image.file(_image)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Education Qualification'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: AutoCompleteTextField(
                                  controller: educationController,
                                  clearOnSubmit: false,
                                  itemSubmitted: (item) {
                                    educationController.text = item;
                                    debugPrint(
                                        "stringList1:${educationController.text}");
                                  },
                                  suggestions: educationLangList,
                                  style: TextStyle(
                                    color: Color(0xFF222222),
                                    fontSize: 16,
                                  ),
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
                                  itemBuilder: (context, item) {
                                    return new Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextWidget(
                                          text: item,
                                          color: darkColor,
                                          size: 14,
                                          weight: FontWeight.w600,
                                        ));
                                  },
                                  itemSorter: (a, b) {
                                    return a.compareTo(b);
                                  },
                                  itemFilter: (item, query) {
                                    debugPrint("genderItem:$item");
                                    return item
                                        .toLowerCase()
                                        .startsWith(query.toLowerCase());
                                  }),
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
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Business'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autocorrect: true,
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    debugPrint("empid :yes");
                                    return 'Employee Id must not be empty';
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
                    alignment: Alignment.topRight,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Annual Income'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
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
                                value: annualIncomeVal,
                                validator: (value) => value == null
                                    ? 'Source Type must not be empty'
                                    : null,
                                onChanged: (value) =>
                                    setState(() => annualIncomeVal = value),
                                items: <String>[
                                  '1,00,000',
                                  '1,50,000',
                                  '3,00,000',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 6.0, bottom: 4.0, left: 4.0, right: 4.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Mobile No'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 75,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autocorrect: true,
                                maxLength: 10,
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
                                keyboardType: TextInputType.phone,
                                onSaved: (String val) {
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    debugPrint("empid :yes");
                                    return 'Employee Id must not be empty';
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
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Email'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autocorrect: true,
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
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (String val) {
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter a  mobile or email!';
                                  } else if (value.isNotEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value)) {
                                      return 'Enter a valid mail!';
                                    }
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
                    alignment: Alignment.topRight,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Smart phone'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Switch(
                                    onChanged: toggleSwitch1,
                                    value: isSwitched1,
                                    activeColor: Colors.blue,
                                    activeTrackColor: greyColor,
                                    inactiveThumbColor: greyColor,
                                    inactiveTrackColor: greyColor,
                                  ),
                                  TextWidget(
                                    text: textValue1,
                                    size: 14,
                                    weight: FontWeight.w600,
                                  ),
                                ],
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Community'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
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
                                value: communityVal,
                                validator: (value) => value == null
                                    ? 'Source Type must not be empty'
                                    : null,
                                onChanged: (value) =>
                                    setState(() => communityVal = value),
                                items: <String>[
                                  'MBC',
                                  'BC',
                                  'Others',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Caste'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
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
                                value: castVal,
                                validator: (value) => value == null
                                    ? 'Source Type must not be empty'
                                    : null,
                                onChanged: (value) =>
                                    setState(() => castVal = value),
                                items: <String>[
                                  'Agamudayar',
                                  'Udayar',
                                  'Others',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Yes';
      });
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'No';
      });
      //print('Switch Button is OFF');
    }
  }

  void toggleSwitch1(bool value) {
    if (isSwitched1 == false) {
      setState(() {
        isSwitched1 = true;
        textValue1 = 'Yes';
      });
    } else {
      setState(() {
        isSwitched1 = false;
        textValue1 = 'No';
      });
      //print('Switch Button is OFF');
    }
  }

  getGender() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionGender).get();
    genderList = querySnapshot.docs.map((doc) => doc.data()).toList();
    genderList.forEach((element) {
      LinkedHashMap<String, dynamic> genderData = element[collectionGender];
      debugPrint("genderdata:$genderData");
      if (genderData != null) {
        gender = genderData[language];
        genderListLang.add(gender);
        debugPrint("stringList:$genderListLang");
      }
    });
  }

  getRelationShip() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionRelation).get();
    relationList = querySnapshot.docs.map((doc) => doc.data()).toList();
    relationList.forEach((element) {
      LinkedHashMap<String, dynamic> relationData = element[mapRelation];
      debugPrint("relationData:$relationData");
      if (relationData != null) {
        relationshipVal = relationData[language];
        relationLangList.add(relationshipVal);
        debugPrint("relationLangList:$relationLangList");
      }
    });
  }

  getEducation() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionEducation).get();
    educationList = querySnapshot.docs.map((doc) => doc.data()).toList();
    educationList.forEach((element) {
      LinkedHashMap<String, dynamic> educationData =
          element[collectionEducation];
      debugPrint("educationData:$educationData");
      if (educationData != null) {
        qualificationVal = educationData[language];
        educationLangList.add(qualificationVal);
        debugPrint("educationLangList:$educationLangList");
      }
    });
  }

  calculateAge(DateTime date) {
    DateTime currentDate = DateTime.now();
    ageVal = currentDate.year - date.year;
    int month1 = currentDate.month;
    int month2 = date.month;
    if (month2 > month1) {
      ageVal--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = date.day;
      if (day2 > day1) {
        ageVal--;
      }
    }
    ageController.text = ageVal.toString();
    debugPrint("Age:$ageVal");
    return ageVal;
  }

  void getLanguage() async {
    language = await SharedPref().getStringPref(SharedPref().language);
    debugPrint("language:$language");
    getGender();
    getRelationShip();
    getEducation();
  }
}
