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
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/models/data_model.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class FamilyMemberStep extends StatefulWidget {

  Function refreshFamilyList;
  Family family;
  FamilyMemberStep(this.family, this.refreshFamilyList);

  @override
  _FamilyMemberStepState createState() => _FamilyMemberStepState(family);
}

class _FamilyMemberStepState extends State<FamilyMemberStep> {
  GlobalKey<FormState> _stepTwoKey = new GlobalKey<FormState>();

  var nameController = TextEditingController();
  var aadharNumberController = TextEditingController();
  var relationshipController = TextEditingController();
  var genderController = TextEditingController();
  var dobController = TextEditingController();
  var ageController = TextEditingController();
  var maritalStatusController = TextEditingController();
  var bloodGroupController = TextEditingController();
  String physicallyChallenge = 'Not Answer';
  var educationController = TextEditingController();
  var occupationController = TextEditingController();
  String annualIncomeVal;
  var mobileNumberController = TextEditingController();
  var mailController = TextEditingController();
  String smartphone = 'Not Answer';
  var communityController = TextEditingController();
  var casteController = TextEditingController();
  var photoController = TextEditingController();
  String govtInsurance = 'Not Answer';
  String privateInsurance = 'Not Answer';
  String oldPension = 'Not Answer';
  String widowedPension = 'Not Answer';
  String retirementPension = 'Not Answer';

  List<dynamic> values;
  List genderList = [],genderListLang = [],relationList = [],relationLangList = [],educationList = [],educationLangList = [],maritalList = [],
      maritalLangList = [],businessList = [],businessLangList = [],bloodGrpList = [],bloodGrpLangList = [],sectionList = [],sectionLangList = [];
  String relationshipVal, maritalStatusVal, qualificationVal, occupationVal, communityVal;
  int ageVal;
  TextEditingController datePicker = TextEditingController();
  DateTime date = DateTime.parse("2019-04-16 12:18:06.018950");
  String gender = "";
  File _image;
  final picker = ImagePicker();
  String language;

  Family family;

  _FamilyMemberStepState(this.family);

  @override
  void initState() {
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

  double getSwitchValues(String value) {
    if (value == "Yes")
      return 2;
    else if (value == "No")
      return 1;
    return 0;
  }

  Future uploadFile() async {
    family.name = nameController.text;
    family.aadharNumber = aadharNumberController.text;
    family.relationship = relationshipController.text;
    family.gender = genderController.text;
    family.dob = dobController.text;
    family.age = double.parse(ageController.text);
    family.maritalStatus = maritalStatusController.text;
    family.bloodGroup = bloodGroupController.text;
    family.physicallyChallenge = getSwitchValues(physicallyChallenge);
    family.education = educationController.text;
    family.occupation = occupationController.text;
    family.annualIncome = annualIncomeVal;
    family.mobileNumber = mobileNumberController.text;
    family.mail = mailController.text;
    family.smartphone = getSwitchValues(smartphone);
    family.community = communityController.text;
    family.caste = casteController.text;
    family.photo = photoController.text;
    family.govtInsurance = getSwitchValues(govtInsurance);
    family.privateInsurance = getSwitchValues(privateInsurance);
    family.oldPension = getSwitchValues(oldPension);
    family.widowedPension = getSwitchValues(widowedPension);
    family.retirementPension = getSwitchValues(retirementPension);

    widget.refreshFamilyList(family);
    if(_image == null) {
      return;
    }
    firebase_storage.Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('tct/${Path.basename(_image.path)}}');
    print('path:$storageReference');

    firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);
    print('File Uploaded');
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.snapshot;

    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
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
                            child: RichText(
                              text: TextSpan(
                                  text: DemoLocalization.of(context)
                                      .translate('Name'),
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: darkColor,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14.0),
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 2, right: 16.0, top: 2.0, bottom: 2.0),
                              child: TextFormField(
                                controller: nameController,
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
                            padding: const EdgeInsets.only(
                                right: 16.0, top: 2.0, bottom: 2.0),
                            child: TextFormField(
                              controller: aadharNumberController,
                              maxLength: 12,
                              textInputAction: TextInputAction.next,
                              autocorrect: true,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                counterText: "",
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
                              keyboardType: TextInputType.number,
                              onSaved: (String val) {
                                setState(() {});
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
                          child: RichText(
                            text: TextSpan(
                                text: DemoLocalization.of(context).translate(
                                    'Relationship method of family head'),
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: darkColor,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14.0),
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 58,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16.0, top: 2.0, bottom: 2.0),
                            child: AutoCompleteTextField(
                                controller: relationshipController,
                                clearOnSubmit: false,
                                itemSubmitted: (item) {
                                  relationshipController.text = item;
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
                                      child: RichText(
                                        text: TextSpan(
                                            text: DemoLocalization.of(context)
                                                .translate('Gender'),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: darkColor,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600),
                                            children: [
                                              TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14.0),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 58,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2,
                                              right: 16.0,
                                              top: 2.0,
                                              bottom: 2.0),
                                          child: AutoCompleteTextField(
                                              controller: genderController,
                                              clearOnSubmit: false,
                                              itemSubmitted: (item) {
                                                genderController.text = item;
                                                debugPrint("stringList1:${genderController.text}");
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
                                      child: RichText(
                                        text: TextSpan(
                                            text: DemoLocalization.of(context)
                                                .translate('Date of Birth'),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: darkColor,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600),
                                            children: [
                                              TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14.0),
                                              ),
                                            ]),
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
                                            String dateFormat = DateFormat(" d-MMMM-y").format(date);
                                            datePicker.text = dateFormat;
                                            dobController.text = datePicker.text;
                                            calculateAge(date);
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
                                      child: RichText(
                                        text: TextSpan(
                                            text: DemoLocalization.of(context)
                                                .translate('Age'),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: darkColor,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600),
                                            children: [
                                              TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14.0),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 54,
                                      width: 120,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16.0, top: 2.0, bottom: 2.0),
                                        child: TextFormField(
                                          maxLength: 2,
                                          controller: ageController,
                                          textInputAction: TextInputAction.next,
                                          autocorrect: true,
                                          enableSuggestions: true,
                                          decoration: InputDecoration(
                                              counterText: "",
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
                                        padding: const EdgeInsets.only(
                                            left: 2.0,
                                            right: 16.0,
                                            top: 2.0,
                                            bottom: 2.0),
                                        child: AutoCompleteTextField(
                                            controller: maritalStatusController,
                                            clearOnSubmit: false,
                                            itemSubmitted: (item) {
                                              maritalStatusController.text = item;
                                            },
                                            suggestions: maritalLangList,
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
                                                errorBorder: OutlineInputBorder(
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
                                                  .startsWith(
                                                      query.toLowerCase());
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
                                            .translate('Blood Group'),
                                        size: 14,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 58,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16.0, top: 2.0, bottom: 2.0),
                                        child: AutoCompleteTextField(
                                            controller: bloodGroupController,
                                            clearOnSubmit: false,
                                            itemSubmitted: (item) {
                                              bloodGroupController.text = item;
                                            },
                                            suggestions: bloodGrpLangList,
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
                                                errorBorder: OutlineInputBorder(
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
                                              return item
                                                  .toLowerCase()
                                                  .startsWith(
                                                      query.toLowerCase());
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
                              alignment: Alignment.topRight,
                              child: FractionallySizedBox(
                                widthFactor: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:4.0),
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Physically challenged'),
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
                                            value: family.physicallyChallenge,
                                            min: 0,
                                            max: 2,
                                            divisions: 2,
                                            onChanged: (value) {
                                              togglePhysicallyChallenge(value);
                                            },
                                          ),
                                        ),
                                        TextWidget(
                                          text: physicallyChallenge,
                                          size: 14,
                                          weight: FontWeight.w600,
                                        )
                                      ],
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
                            padding: const EdgeInsets.only(
                                right: 16.0, top: 2.0, bottom: 2.0),
                            child: Container(
                                height: 140,
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
                              padding: const EdgeInsets.only(
                                  left: 2, right: 16.0, top: 2.0, bottom: 2.0),
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
                              padding: const EdgeInsets.only(
                                  right: 16.0, top: 2.0, bottom: 2.0),
                              child: AutoCompleteTextField(
                                  controller: occupationController,
                                  clearOnSubmit: false,
                                  itemSubmitted: (item) {
                                    occupationController.text = item;
                                  },
                                  suggestions: businessLangList,
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
                              padding: const EdgeInsets.only(
                                  right: 16.0, top: 2.0, bottom: 2.0),
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
                              padding: const EdgeInsets.only(
                                  left: 2.0,
                                  right: 16.0,
                                  top: 2.0,
                                  bottom: 2.0),
                              child: TextFormField(
                                controller: mobileNumberController,
                                textInputAction: TextInputAction.next,
                                autocorrect: true,
                                maxLength: 10,
                                enableSuggestions: true,
                                decoration: InputDecoration(
                                  counterText: "",
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
                              padding: const EdgeInsets.only(
                                  right: 16.0, top: 2.0, bottom: 2.0),
                              child: TextFormField(
                                controller: mailController,
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
                                  if (value.isNotEmpty) {
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
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:4.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Smart phone'),
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
                                value:  family.smartphone,
                                min: 0,
                                max: 2,
                                divisions: 2,
                                onChanged: (value) {
                                  toggleSmartphone(value);
                                },
                              ),
                            ),
                            TextWidget(
                              text: smartphone,
                              size: 14,
                              weight: FontWeight.w600,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
                            child: RichText(
                              text: TextSpan(
                                  text: DemoLocalization.of(context)
                                      .translate('Section'),
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: darkColor,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14.0),
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 2.0,
                                  right: 16.0,
                                  top: 2.0,
                                  bottom: 2.0),
                              child: AutoCompleteTextField(
                                  controller: communityController,
                                  clearOnSubmit: false,
                                  itemSubmitted: (item) {
                                    communityController.text = item;
                                  },
                                  suggestions: sectionLangList,
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
                            child: RichText(
                              text: TextSpan(
                                  text: DemoLocalization.of(context)
                                      .translate('Caste'),
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: darkColor,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14.0),
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, top: 2.0, bottom: 2.0),
                              child: TextFormField(
                                controller: casteController,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:4.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context).translate(
                                'Government Insurance/Health Insurance?'),
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
                                value: family.govtInsurance,
                                min: 0,
                                max: 2,
                                divisions: 2,
                                onChanged: (value) {
                                  toggleGovtInsurance(value);
                                },
                              ),
                            ),
                            TextWidget(
                              text: govtInsurance,
                              size: 14,
                              weight: FontWeight.w600,
                            )
                          ],
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
                    alignment: Alignment.topRight,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context).translate(
                                  'Private Insurance/Health Insurance?'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16.0, top: 2.0, bottom: 2.0),
                            child: Column(
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
                                    value: family.privateInsurance,
                                    min: 0,
                                    max: 2,
                                    divisions: 2,
                                    onChanged: (value) {
                                      togglePrivateInsurance(value);
                                    },
                                  ),
                                ),
                                TextWidget(
                                  text: privateInsurance,
                                  size: 14,
                                  weight: FontWeight.w600,
                                )
                              ],
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
                            padding: const EdgeInsets.only(top:4.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Old age Pension?'),
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
                                  value: family.oldPension,
                                  min: 0,
                                  max: 2,
                                  divisions: 2,
                                  onChanged: (value) {
                                    toggleOldPension(value);
                                  },
                                ),
                              ),
                              TextWidget(
                                text: oldPension,
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
                    alignment: Alignment.topRight,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:4.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Widowed Pension?'),
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
                                  value: family.widowedPension,
                                  min: 0,
                                  max: 2,
                                  divisions: 2,
                                  onChanged: (value) {
                                    toggleWidowedPension(value);
                                  },
                                ),
                              ),
                              TextWidget(
                                text: widowedPension,
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
                    alignment: Alignment.topRight,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top:4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: TextWidget(
                                text: DemoLocalization.of(context)
                                    .translate('Retirement Pension?'),
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
                                    value: family.retirementPension,
                                    min: 0,
                                    max: 2,
                                    divisions: 2,
                                    onChanged: (value) {
                                      toggleRetirementPension(value);
                                    },
                                  ),
                                ),
                                TextWidget(
                                  text: retirementPension,
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
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    uploadFile();
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
                      padding: const EdgeInsets.all(6.0),
                      child: TextWidget(
                        text: DemoLocalization.of(context).translate('Save'),
                        color: darkColor,
                        weight: FontWeight.w700,
                        size: 14,
                      ),
                    ),
                  ),
                ),
                Container()
              ],
            )
          ],
        ),
      ),
    );
  }

  void togglePhysicallyChallenge(double value) {
    family.physicallyChallenge = value;
    setState(() {
      if(value==0)
        physicallyChallenge='Not Answer';
      else if(value==1)
        physicallyChallenge='No';
      else
        physicallyChallenge='Yes';
    });
  }

  void toggleSmartphone(double value) {
    family.smartphone = value;
    setState(() {
      if(value==0)
        smartphone='Not Answer';
      else if(value==1)
        smartphone='No';
      else
        smartphone='Yes';
    });
  }

  void toggleGovtInsurance(double value) {
    family.govtInsurance = value;
    setState(() {
      if(value==0)
        govtInsurance='Not Answer';
      else if(value==1)
        govtInsurance='No';
      else
        govtInsurance='Yes';
    });
  }

  void togglePrivateInsurance(double value) {
    family.privateInsurance = value;
    setState(() {
      if(value==0)
        privateInsurance='Not Answer';
      else if(value==1)
        privateInsurance='No';
      else
        privateInsurance='Yes';
    });
  }

  void toggleOldPension(double value) {
    family.oldPension = value;
    setState(() {
      if(value==0)
        oldPension='Not Answer';
      else if(value==1)
        oldPension='No';
      else
        oldPension='Yes';
    });
  }

  void toggleWidowedPension(double value) {
    family.widowedPension = value;
    setState(() {
      if(value==0)
        widowedPension='Not Answer';
      else if(value==1)
        widowedPension='No';
      else
        widowedPension='Yes';
    });
  }

  void toggleRetirementPension(double value) {
    family.retirementPension = value;
    setState(() {
      if(value==0)
        retirementPension = 'Not Answer';
      else if(value==1)
        retirementPension='No';
      else
        retirementPension='Yes';
    });
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

  getMaritalStatus() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionMaritalStatus).get();
    maritalList = querySnapshot.docs.map((doc) => doc.data()).toList();
    maritalList.forEach((element) {
      LinkedHashMap<String, dynamic> maritalData =
          element[collectionMaritalStatus];
      debugPrint("maritalData:$maritalData");
      if (maritalData != null) {
        maritalStatusVal = maritalData[language];
        maritalLangList.add(maritalStatusVal);
        debugPrint("maritalLangList:$maritalLangList");
      }
    });
  }

  getBusiness() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionBusiness).get();
    businessList = querySnapshot.docs.map((doc) => doc.data()).toList();
    businessList.forEach((element) {
      LinkedHashMap<String, dynamic> businessData = element[collectionBusiness];
      debugPrint("businessData:$businessData");
      if (businessData != null) {
        occupationVal = businessData[language];
        businessLangList.add(occupationVal);
        debugPrint("businessLangList:$businessLangList");
      }
    });
  }

  getSection() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionSection).get();
    sectionList = querySnapshot.docs.map((doc) => doc.data()).toList();
    sectionList.forEach((element) {
      LinkedHashMap<String, dynamic> sectionData = element[collectionSection];
      debugPrint("sectionData:$sectionData");
      if (sectionData != null) {
        communityVal = sectionData[language];
        sectionLangList.add(communityVal);
        debugPrint("sectionLangList:$sectionLangList");
      }
    });
  }

  getBloodGroup() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionBloodGroup).get();
    bloodGrpList = querySnapshot.docs.map((doc) => doc.data()).toList();
    debugPrint("bloodGrpList:$bloodGrpList");

    bloodGrpList.forEach((element) {
      final bloodGrpData = element[collectionBloodGroup];
      debugPrint("bloodGrpData:$bloodGrpData");
      if (bloodGrpData != null) {
        bloodGrpLangList.add(bloodGrpData);
        debugPrint("bloodGrpLangList:$bloodGrpLangList");
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
    getMaritalStatus();
    getBusiness();
    getBloodGroup();
    getSection();
  }

}
