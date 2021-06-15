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
import 'package:flutter/cupertino.dart';
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
import 'package:tct_demographics/util/snack_bar.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class FamilyMemberStep extends StatefulWidget {
  Function refreshFamilyList, cancelFields, deleteFields;
  Family family;
  int familyIndex;

  FamilyMemberStep(this.family, this.familyIndex, this.refreshFamilyList,
      this.cancelFields, this.deleteFields);

  @override
  _FamilyMemberStepState createState() =>
      _FamilyMemberStepState(family, familyIndex);
}

class _FamilyMemberStepState extends State<FamilyMemberStep> {
  GlobalKey<FormState> _stepTwoKey = new GlobalKey<FormState>();
  bool isRelationShip = false,
      isGender = false,
      isMaritalStatus = false,
      isBloodGrp = false,
      isEducation = false,
      isBusiness = false,
      isSection = false,
  isPhysical=false;
  var nameController = TextEditingController();
  var aadharNumberController = TextEditingController();
  var relationshipController = TextEditingController();
  var genderController = TextEditingController();
  var dobController = TextEditingController();
  var ageController = TextEditingController();
  var maritalStatusController = TextEditingController(text: "");
  var bloodGroupController = TextEditingController();
  String physicallyChallenge = "";
  var educationController = TextEditingController();
  var occupationController = TextEditingController();
  var annualController = TextEditingController();

  String annualIncomeVal;
  var mobileNumberController = TextEditingController();
  var mailController = TextEditingController();
  String smartphone = "";
  var communityController = TextEditingController();
  var casteController = TextEditingController();
  var physicalController = TextEditingController();

  // var photoController = TextEditingController();
  String govtInsurance = "";
  String privateInsurance = "";
  String oldPension = "";
  String widowedPension = "";
  String retirementPension = "";

  String textSmoke = "";
  String textDrink = "";
  String textTobacco = "";
  String textVaccine = "";

  double drinkValue = 0;
  TextEditingController firstDosePicker = TextEditingController();
  DateTime date = DateTime.parse("2019-04-16 12:18:06.018950");
  TextEditingController secondDosePicker = TextEditingController();
  List<dynamic> values;
  List genderList = [],
      genderListLang = [],
      relationList = [],
      relationLangList = [],
      educationList = [],
      educationLangList = [],
      maritalList = [],
      maritalLangList = [],
      businessList = [],
      businessLangList = [],
      incomeList = [],
      incomeListLang = [],
      bloodGrpList = [],
      bloodGrpLangList = [],
      sectionList = [],
      sectionLangList = [];
  String relationshipVal,
      maritalStatusVal,
      qualificationVal,
      occupationVal,
      communityVal;
  int ageVal;
  TextEditingController datePicker = TextEditingController();

  // DateTime date = DateTime.parse("2019-04-16 12:18:06.018950");
  String gender = "";
  File _image;
  final picker = ImagePicker();
  String language;

  Family family;
  int familyIndex;

  bool isLoading = false;

  _FamilyMemberStepState(this.family, this.familyIndex);

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
    if (value == DemoLocalization.of(context).translate('Yes'))
      return 2;
    else if (value == DemoLocalization.of(context).translate('No')) return 1;
    return 0;
  }

  Future uploadFile() async {
    family.name = nameController.text;
    family.aadharNumber = aadharNumberController.text;
    family.relationship = relationshipController.text;
    family.gender = genderController.text;
    family.dob = dobController.text;
    family.age = int.tryParse(ageController.text);
    family.maritalStatus = maritalStatusController.text;
    family.bloodGroup = bloodGroupController.text;
    family.physicallyChallenge = getSwitchValues(physicallyChallenge);
    family.education = educationController.text;
    family.occupation = occupationController.text;
    family.annualIncome = annualController.text;
    family.mobileNumber = mobileNumberController.text;
    family.mail = mailController.text;
    family.smartphone = getSwitchValues(smartphone);
    family.community = communityController.text;
    family.caste = casteController.text;
    family.physical = physicalController.text;
    family.govtInsurance = getSwitchValues(govtInsurance);
    family.privateInsurance = getSwitchValues(privateInsurance);
    family.oldPension = getSwitchValues(oldPension);
    family.widowedPension = getSwitchValues(widowedPension);
    family.retirementPension = getSwitchValues(retirementPension);

    if (_image != null) {
      firebase_storage.Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('tct/${Path.basename(_image.path)}}');

      TaskSnapshot snapshot = await storageReference.putFile(_image);

      String picUrl = "";
      if (snapshot.state == TaskState.success) {
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        picUrl = downloadUrl;
        final snackBar = SnackBar(content: Text('Upload successful'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print('Error from image repo ${snapshot.state.toString()}');
      }
      if (family.photo != null) {
        family.photo = picUrl;
      } else {
        family.photo = "";
      }
    }
    setState(() {
      this.isLoading = false;
    });
    widget.refreshFamilyList(family, familyIndex);
  }

  @override
  void dispose() {
    datePicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("stringList1$genderListLang");
    debugPrint("isPhysical$isPhysical");

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
                                  left: 2, right: 16.0, top: 1.0, bottom: 1.0),
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
                                right: 16.0, top: 1.0, bottom: 1.0),
                            child: TextFormField(
                              controller: aadharNumberController,
                              maxLength: 12,
                              textInputAction: TextInputAction.next,
                              autocorrect: true,
                              enableSuggestions: true,
                              /*inputFormatters: [
                                // MaskTextInputFormatter(mask: "********####", filter: {"*": RegExp(r'[0-9]')})
                                *//*MaskedTextInputFormatterShifter(
                                    maskONE:"********XXXX",
                                    maskTWO:"XXX.XXX/XXXX-XX"
                                ),*//*
                                ],*/
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
                                right: 16.0,  top: 1.0, bottom: 1.0),
                            child: AutoCompleteTextField(
                                controller: relationshipController,
                                clearOnSubmit: false,
                                itemSubmitted: (item) {
                                  relationshipController.text = item;
                                  isRelationShip = true;
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
                                  isRelationShip = false;

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
                                              top: 1.0, bottom: 1.0),
                                          child: AutoCompleteTextField(
                                              controller: genderController,
                                              clearOnSubmit: false,
                                              itemSubmitted: (item) {
                                                genderController.text = item;
                                                isGender=true;
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
                                                isGender=false;

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
                                widthFactor: 1.05,
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
                                      width: 250,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 1.0, top: 1, bottom: 1),
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
                                            String dateFormat =
                                                DateFormat("d-MMMM-y")
                                                    .format(date);
                                            datePicker.text = dateFormat;
                                            dobController.text =
                                                datePicker.text;
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
                                widthFactor: 0.75,
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
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16.0,  top: 1.0, bottom: 1.0),
                                        child: TextFormField(
                                          maxLength: 3,
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
                                          keyboardType: TextInputType.number,
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
                                      height: 59,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2.0,
                                            right: 16.0,
                                            top: 1.0, bottom: 1.0),
                                        child: AutoCompleteTextField(
                                            controller: maritalStatusController,
                                            clearOnSubmit: false,
                                            itemSubmitted: (item) {
                                              maritalStatusController.text =
                                                  item;
                                              isMaritalStatus=true;
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
                                              isMaritalStatus=false;

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
                                            right: 16.0, top: 1.0, bottom: 1.0),
                                        child: AutoCompleteTextField(
                                            controller: bloodGroupController,
                                            clearOnSubmit: false,
                                            itemSubmitted: (item) {
                                              bloodGroupController.text = item;
                                              isBloodGrp=true;
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
                                              isBloodGrp=false;
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
                                      padding: const EdgeInsets.only(top: 4.0),
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
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor: primaryColor,
                                            inactiveTrackColor:
                                                Colors.lightBlueAccent,
                                            trackShape:
                                                RectangularSliderTrackShape(),
                                            trackHeight: 4.0,
                                            thumbColor: primaryColor,
                                            thumbShape: RoundSliderThumbShape(
                                                enabledThumbRadius: 12.0),
                                            overlayColor:
                                                Colors.white.withAlpha(32),
                                            overlayShape:
                                                RoundSliderOverlayShape(
                                                    overlayRadius: 28.0),
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
                                child: family.photo == ""
                                    ? _image == null
                                        ? Image.asset(imgCamera)
                                        : Image.file(_image)
                                    : Image.network(family.photo,
                                        fit: BoxFit.fill)),
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
                physicallyChallenge=="Yes" ||  physicallyChallenge=="ஆம்"? Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Physically challenged'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0,  top: 1.0, bottom: 1.0),
                              child: TextFormField(
                                controller: physicalController,
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
                ):Container(),
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
                                left: 2,
                                right: 16.0,
                                  top: 1.0, bottom: 1.0
                              ),
                              child: AutoCompleteTextField(
                                  controller: educationController,
                                  clearOnSubmit: false,
                                  itemSubmitted: (item) {
                                    educationController.text = item;
                                    isEducation=true;
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
                                    isEducation=false;

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
                                  right: 16.0,  top: 1.0, bottom: 1.0),
                              child: AutoCompleteTextField(
                                  controller: occupationController,
                                  clearOnSubmit: false,
                                  itemSubmitted: (item) {
                                    occupationController.text = item;
                                    isBusiness=true;
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
                                    isBusiness=false;
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
                                  right: 16.0,  top: 1.0, bottom: 1.0),
                              child: AutoCompleteTextField(
                                  keyboardType: TextInputType.number,
                                  controller: annualController,
                                  clearOnSubmit: false,
                                  itemSubmitted: (item) {
                                    annualController.text = item;
                                  },
                                  suggestions: incomeListLang,
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
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 2.0,
                                  right: 16.0,
                                  top: 1.0, bottom: 1.0),
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
                                  validator: (value) {
                                    if (value.isNotEmpty) {
                                      if (value.length != 10)
                                        return 'Enter a valid mobile!';
                                    }
                                    return null;
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
                                  .translate('Email'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0,  top: 1.0, bottom: 1.0),
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
                                  setState(() {
                                    mailController.text = val;
                                  });
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
                          padding: const EdgeInsets.only(top: 4.0),
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
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                overlayColor: Colors.white.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
                              ),
                              child: Slider(
                                value: family.smartphone,
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
                                  top: 1.0, bottom: 1.0
                              ),
                              child: AutoCompleteTextField(
                                  controller: communityController,
                                  clearOnSubmit: false,
                                  itemSubmitted: (item) {
                                    communityController.text = item;
                                    isSection=true;
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
                                    isSection=false;
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
                            padding: const EdgeInsets.only(top: 4.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context).translate(
                                  'Caste'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0,  top: 1.0, bottom: 1.0),
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
                Container(
                  width: 160,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
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
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                overlayColor: Colors.white.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
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
                ),
                Expanded(
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
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 12.0),
                                  overlayColor: Colors.white.withAlpha(32),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 28.0),
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
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
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
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                overlayColor: Colors.white.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                            padding: const EdgeInsets.only(top: 4.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Widowed Pension?'),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 250,
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: primaryColor,
                                    inactiveTrackColor: Colors.lightBlueAccent,
                                    trackShape: RectangularSliderTrackShape(),
                                    trackHeight: 4.0,
                                    thumbColor: primaryColor,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 12.0),
                                    overlayColor: Colors.white.withAlpha(32),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 28.0),
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
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: TextWidget(
                                text: DemoLocalization.of(context)
                                    .translate('Retirement Pension?'),
                                size: 14,
                                weight: FontWeight.w600,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 250,

                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: primaryColor,
                                      inactiveTrackColor: Colors.lightBlueAccent,
                                      trackShape: RectangularSliderTrackShape(),
                                      trackHeight: 4.0,
                                      thumbColor: primaryColor,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 12.0),
                                      overlayColor: Colors.white.withAlpha(32),
                                      overlayShape: RoundSliderOverlayShape(
                                          overlayRadius: 28.0),
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
                ),
                Container(
                  width: 180,
                )

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.05,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Any Members who Smoke?'),
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
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                overlayColor: Colors.white.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
                              ),
                              child: Slider(
                                value: family.anyMembersWhoSmoke,
                                min: 0,
                                max: 2,
                                divisions: 2,
                                onChanged: (value) {
                                  toggleSwitch(value);
                                },
                              ),
                            ),
                            TextWidget(
                              text: textSmoke,
                              size: 14,
                              weight: FontWeight.w600,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.05,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Any Members who Drink?'),
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
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                overlayColor: Colors.white.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
                              ),
                              child: Slider(
                                value: family.anyMembersWhoDrink,
                                min: 0,
                                max: 2,
                                divisions: 2,
                                onChanged: (value) {
                                  toggleSwitch1(value);
                                },
                              ),
                            ),
                            TextWidget(
                              text: textDrink,
                              size: 14,
                              weight: FontWeight.w600,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.05,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Any Members who use Tobacco?'),
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
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                overlayColor: Colors.white.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
                              ),
                              child: Slider(
                                value: family.anyMembersWhoUseTobacco,
                                min: 0,
                                max: 2,
                                divisions: 2,
                                onChanged: (value) {
                                  toggleSwitch2(value);
                                },
                              ),
                            ),
                            TextWidget(
                              text: textTobacco,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.05,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate("Vaccination Done"),
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
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 12.0),
                                  overlayColor: Colors.white.withAlpha(32),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 28.0),
                                ),
                                child: Slider(
                                  value: family.isVaccinationDone,
                                  min: 0,
                                  max: 2,
                                  divisions: 2,
                                  onChanged: (value) {
                                    toggleSwitch3(value);
                                  },
                                ),
                              ),
                              TextWidget(
                                text: textVaccine,
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
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate("1st Dose Date"),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, top: 1.0, bottom: 1.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autocorrect: true,
                                controller: firstDosePicker,
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
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2022));
                                  String dateFormat =
                                  DateFormat(" d-MMMM-y").format(date);
                                  family.firstDose = dateFormat;
                                  firstDosePicker.text = dateFormat;
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
                            padding: const EdgeInsets.all(8.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate("2nd Dose Date"),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 16.0,
                                  top: 1.0, bottom: 1.0
                              ),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autocorrect: true,
                                controller: secondDosePicker,
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
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());

                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2022));
                                  String dateFormat =
                                      DateFormat(" d-MMMM-y").format(date);
                                  secondDosePicker.text = dateFormat;
                                  family.secondDose = dateFormat;
                                  // "${date.day}/${date.month}/${date.year}";
                                },
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      if (_stepTwoKey.currentState.validate()) {
                        // if (_stepTwoKey != null) {
                        _stepTwoKey.currentState.save();
                        print("GET_____________________________" + isRelationShip.toString());
                        if (relationshipController.text != "" && !isRelationShip) {
                          setState(() {
                            relationshipController.text = "";
                            snackBarAlert("Error",
                                "RelationShip  must be in List", errorColor);
                            return;
                          });
                        }  else if (genderController.text != "" &&
                            !isGender) {
                          setState(() {
                            genderController.text = "";
                            snackBarAlert("Error",
                                "Gender  must be in List", errorColor);
                            return;
                          });
                        }else if (maritalStatusController.text != "" &&
                            !isMaritalStatus) {
                          setState(() {
                            maritalStatusController.text = "";
                            snackBarAlert("Error",
                                "Marital Status  must be in List", errorColor);
                            return;
                          });
                        }else if (bloodGroupController.text != "" &&
                            !isBloodGrp) {
                          setState(() {
                            bloodGroupController.text = "";
                            snackBarAlert("Error",
                                "Blood Group  must be in List", errorColor);
                            return;
                          });
                        }else if (educationController.text != "" &&
                            !isEducation) {
                          setState(() {
                            educationController.text = "";
                            snackBarAlert("Error",
                                "Education Qualification must be in List", errorColor);
                            return;
                          });
                        }else if (occupationController.text != "" &&
                            !isBusiness) {
                          setState(() {
                            occupationController.text = "";
                            snackBarAlert("Error",
                                "Business must be in List", errorColor);
                            return;
                          });
                        }else if (communityController.text != "" &&
                            !isSection) {
                          setState(() {
                            communityController.text = "";
                            snackBarAlert("Error",
                                "Section must be in List", errorColor);
                            return;
                          });
                        }
                        else {
                          setState(() {
                            this.isLoading = true;
                          });
                          uploadFile();
                        }                          // }
                      }
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
                      child: Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: successColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Save'),
                              color: darkColor,
                              weight: FontWeight.w700,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () {
                        widget.cancelFields();
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
                        child: Row(
                          children: [
                            Icon(Icons.cancel_outlined),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: TextWidget(
                                text: DemoLocalization.of(context)
                                    .translate('Cancel'),
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
                  familyIndex >= 0
                      ? Container(
                    margin: EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () {
                        widget.deleteFields(family);
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_forever_outlined,
                              color: errorColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: TextWidget(
                                text: DemoLocalization.of(context)
                                    .translate('Delete'),
                                color: darkColor,
                                weight: FontWeight.w700,
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : Container(),
                  isLoading
                      ? Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CircularProgressIndicator())
                      : Visibility(visible: false, child: Text("Saving")),
                  Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void togglePhysicallyChallenge(double value) {
    family.physicallyChallenge = value;
    setState(() {
      if (value == 0)
        physicallyChallenge =
            DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1) {
        physicallyChallenge = DemoLocalization.of(context).translate('No');
        debugPrint("isPhysical2$isPhysical");

      } else {
        physicallyChallenge = DemoLocalization.of(context).translate('Yes');
        isPhysical=true;
        debugPrint("isPhysical1$isPhysical");

      }
    });
  }

  void toggleSmartphone(double value) {
    family.smartphone = value;
    setState(() {
      if (value == 0)
        smartphone = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        smartphone = smartphone = DemoLocalization.of(context).translate('No');
      else
        smartphone = smartphone = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleGovtInsurance(double value) {
    family.govtInsurance = value;
    setState(() {
      if (value == 0)
        govtInsurance = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        govtInsurance = DemoLocalization.of(context).translate('No');
      else
        govtInsurance = DemoLocalization.of(context).translate('Yes');
    });
  }

  void togglePrivateInsurance(double value) {
    family.privateInsurance = value;
    setState(() {
      if (value == 0)
        privateInsurance = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        privateInsurance = DemoLocalization.of(context).translate('No');
      else
        privateInsurance = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleOldPension(double value) {
    family.oldPension = value;
    setState(() {
      if (value == 0)
        oldPension = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        oldPension = DemoLocalization.of(context).translate('No');
      else
        oldPension = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleWidowedPension(double value) {
    family.widowedPension = value;
    setState(() {
      if (value == 0)
        widowedPension = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        widowedPension = DemoLocalization.of(context).translate('No');
      else
        widowedPension = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleRetirementPension(double value) {
    family.retirementPension = value;
    setState(() {
      if (value == 0)
        retirementPension =
            DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        retirementPension = DemoLocalization.of(context).translate('No');
      else
        retirementPension = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleSwitch(double value) {
    family.anyMembersWhoSmoke = value;
    setState(() {
      if (value == 0)
        textSmoke = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        textSmoke = DemoLocalization.of(context).translate('No');
      else
        textSmoke = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleSwitch1(double value) {
    family.anyMembersWhoDrink = value;
    setState(() {
      if (value == 0)
        textDrink = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        textDrink = DemoLocalization.of(context).translate('No');
      else
        textDrink = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleSwitch2(double value) {
    family.anyMembersWhoUseTobacco = value;
    setState(() {
      if (value == 0)
        textTobacco = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        textTobacco = DemoLocalization.of(context).translate('No');
      else
        textTobacco = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleSwitch3(double value) {
    family.isVaccinationDone = value;
    setState(() {
      if (value == 0)
        textVaccine = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        textVaccine = DemoLocalization.of(context).translate('No');
      else
        textVaccine = DemoLocalization.of(context).translate('Yes');
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

  getIncome() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionAnnualIncome).get();
    incomeList = querySnapshot.docs.map((doc) => doc.data()).toList();
    incomeList.forEach((element) {
      final incomeData = element[mapAnnualIncome];
      debugPrint("sectionData:$incomeData");
      if (incomeData != null) {
        incomeListLang.add(incomeData);
        debugPrint("incomeListLang:$incomeListLang");
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
    smartphone = DemoLocalization.of(context).translate('Not Answer');
    physicallyChallenge = DemoLocalization.of(context).translate('Not Answer');
    govtInsurance = DemoLocalization.of(context).translate('Not Answer');
    privateInsurance = DemoLocalization.of(context).translate('Not Answer');
    oldPension = DemoLocalization.of(context).translate('Not Answer');
    widowedPension = DemoLocalization.of(context).translate('Not Answer');
    retirementPension = DemoLocalization.of(context).translate('Not Answer');

    if (family != null) {
      if (family.smartphone == 0)
        smartphone = DemoLocalization.of(context).translate('Not Answer');
      else if (family.smartphone == 1)
        smartphone = DemoLocalization.of(context).translate('No');
      else
        smartphone = DemoLocalization.of(context).translate('Yes');

      if (family.physicallyChallenge == 0)
        physicallyChallenge =
            DemoLocalization.of(context).translate('Not Answer');
      else if (family.physicallyChallenge == 1)
        physicallyChallenge = DemoLocalization.of(context).translate('No');
      else
        physicallyChallenge = DemoLocalization.of(context).translate('Yes');

      if (family.govtInsurance == 0)
        govtInsurance = DemoLocalization.of(context).translate('Not Answer');
      else if (family.govtInsurance == 1)
        govtInsurance = DemoLocalization.of(context).translate('No');
      else
        govtInsurance = DemoLocalization.of(context).translate('Yes');

      if (family.privateInsurance == 0)
        privateInsurance = DemoLocalization.of(context).translate('Not Answer');
      else if (family.privateInsurance == 1)
        privateInsurance = DemoLocalization.of(context).translate('No');
      else
        privateInsurance = DemoLocalization.of(context).translate('Yes');

      if (family.oldPension == 0)
        oldPension = DemoLocalization.of(context).translate('Not Answer');
      else if (family.oldPension == 1)
        oldPension = DemoLocalization.of(context).translate('No');
      else
        oldPension = DemoLocalization.of(context).translate('Yes');

      if (family.widowedPension == 0)
        widowedPension = DemoLocalization.of(context).translate('Not Answer');
      else if (family.widowedPension == 1)
        widowedPension = DemoLocalization.of(context).translate('No');
      else
        widowedPension = DemoLocalization.of(context).translate('Yes');

      if (family.retirementPension == 0)
        retirementPension =
            DemoLocalization.of(context).translate('Not Answer');
      else if (family.retirementPension == 1)
        retirementPension = DemoLocalization.of(context).translate('No');
      else
        retirementPension = DemoLocalization.of(context).translate('Yes');

      if (family.anyMembersWhoSmoke == 0)
        textSmoke = DemoLocalization.of(context).translate('Not Answer');
      else if (family.anyMembersWhoSmoke == 1)
        textSmoke = DemoLocalization.of(context).translate('No');
      else
        textSmoke = DemoLocalization.of(context).translate('Yes');

      if (family.anyMembersWhoDrink == 0)
        textDrink = DemoLocalization.of(context).translate('Not Answer');
      else if (family.anyMembersWhoDrink == 1)
        textDrink = DemoLocalization.of(context).translate('No');
      else
        textDrink = DemoLocalization.of(context).translate('Yes');

      if (family.anyMembersWhoUseTobacco == 0)
        textTobacco = DemoLocalization.of(context).translate('Not Answer');
      else if (family.anyMembersWhoUseTobacco == 1)
        textTobacco = DemoLocalization.of(context).translate('No');
      else
        textTobacco = DemoLocalization.of(context).translate('Yes');

      if (family.isVaccinationDone == 0)
        textVaccine = DemoLocalization.of(context).translate('Not Answer');
      else if (family.isVaccinationDone == 1)
        textVaccine = DemoLocalization.of(context).translate('No');
      else
        textVaccine = DemoLocalization.of(context).translate('Yes');

      nameController.text = family.name.toString();
      aadharNumberController.text = family.aadharNumber.toString();
      relationshipController.text = family.relationship.toString();
      genderController.text = family.gender.toString();
      dobController.text = family.dob.toString();
      datePicker.text = family.dob.toString();
      ageController.text = family.age.toString();
      maritalStatusController.text = family.maritalStatus.toString();
      bloodGroupController.text = family.bloodGroup.toString();
      educationController.text = family.education.toString();
      occupationController.text = family.occupation.toString();
      annualController.text = family.annualIncome.toString();
      annualIncomeVal = family.annualIncome.toString();
      mobileNumberController.text = family.mobileNumber.toString();
      mailController.text = family.mail.toString();
      communityController.text = family.community.toString();
      casteController.text = family.caste.toString();
      physicalController.text = family.physical.toString();
debugPrint("physically:${family.physical.toString()}");
      if (family.relationship != "") {
        isRelationShip = true;
      }
      if (family.gender != "") {
        isGender = true;
      }
      if (family.maritalStatus != "") {
        isMaritalStatus = true;
      }
      if (family.bloodGroup != "") {
        isBloodGrp = true;
      }
      if (family.education != "") {
        isEducation = true;
      }
      if (family.occupation != "") {
        isBusiness = true;
      }
      if (family.community != "") {
        isSection = true;
      }

      firstDosePicker.text = family.firstDose;
      secondDosePicker.text = family.secondDose;
    }

    getGender();
    getRelationShip();
    getEducation();
    getMaritalStatus();
    getBusiness();
    getBloodGroup();
    getSection();
    getIncome();
    setState(() {});
  }
}
