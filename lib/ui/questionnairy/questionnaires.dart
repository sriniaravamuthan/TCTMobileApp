/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 3:21 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 3:21 PM by Kanmalai.
 * /
 */

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/models/data_model.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/services/firestore_service.dart';
import 'package:tct_demographics/ui/questionnairy/familymember_details.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/habit_step.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/property_step.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/util/snack_bar.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class QuestionnairesScreen extends StatefulWidget {
  @override
  _QuestionnairesScreenState createState() => _QuestionnairesScreenState();
}

class _QuestionnairesScreenState extends State<QuestionnairesScreen> {
  int _currentStep = 0;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool isCancel = false;
  DemographicFamily demographicFamily = new DemographicFamily();
  String language;

  Location location = new Location();

  var fromNoController,
      projectCodeController,
      streetNameController,
      doorNoController,
      contactPersonController,
      noOfFamilyPersonController;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var villageNameController;
  var villageCodeController;
  var panchayatCodeController = TextEditingController();
  var panchayatNoController = TextEditingController();
  String userName = "";
  String userMail = "";
  List<QueryDocumentSnapshot> snap;
  List villageCodeList,
      villageNameList,
      demoList = [],
      demoLanList = [],
      originalVillageCodeList = [],
      originalVillageNameList = [];
  List<String> panchayatCodeList = [], panchayatNoList = [];
  var height, width;
  List<String> streets = [];
  String documentId = "";
  bool isEdit = false;
  Function makeLoadData;

  @override
  void initState() {
    villageNameList = [];
    villageCodeList = [];
    if (firebaseAuth.currentUser != null) {
      userName = firebaseAuth.currentUser.displayName;
      userMail = firebaseAuth.currentUser.email;

      debugPrint("userEmail:${firebaseAuth.currentUser}");
    }
    getLanguage();
    // _getVillageCode(villageController.text);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    fromNoController = TextEditingController();
    projectCodeController = TextEditingController();
    streetNameController = TextEditingController();
    doorNoController = TextEditingController();
    contactPersonController = TextEditingController();
    noOfFamilyPersonController = TextEditingController();
    villageNameController = TextEditingController();
    villageCodeController = TextEditingController();

    var arguments = Get.arguments;
    demographicFamily = arguments[0];
    streets = arguments[1];
    documentId = arguments[2];
    isEdit = arguments[3];
    makeLoadData = arguments[4];
    debugPrint("isEdit" + isEdit.toString());


    print("GET____________________" + streets.toString());

    if (demographicFamily.location != null) {
      location = demographicFamily.location;

      fromNoController.text = location.formNo;
      projectCodeController.text = location.projectCode;
      streetNameController.text = location.streetName;
      doorNoController.text = location.doorNumber;
      contactPersonController.text = location.contactPerson;
      noOfFamilyPersonController.text = location.noOfFamilyMembers;
      /*if (location.villagesCode.toString().length > 6) {
        fillVillageData(location.villageName);
      } else {*/
        villageNameController.text = location.villageName;
        villageCodeController.text = location.villagesCode;
        panchayatCodeController.text = location.panchayatCode;
        panchayatNoController.text = location.panchayatNo;
      // }
    } else {
      location.formNo = "";
      location.villagesCode = "";
      location.panchayatCode = "";
      location.villageName = "";
      location.streetName = "";
      location.contactPerson = "";
      location.contactNumber = "";
      location.projectCode = "";
      location.panchayatNo = "";
      location.noOfFamilyMembers = "";
    }

    if (demographicFamily.property == null) {
      Property property = new Property();
      property.wetLandInAcres = "";
      property.dryLandInAcres = "";
      property.noOfVehicleOwn = "";
      property.twoWheeler = "";
      property.threeWheeler = "";
      property.fourWheeler = "";
      property.toiletFacility = 0;
      property.ownLand = 0;
      property.ownVehicle = 0;
      property.ownLivestocks = 0;
      property.statusofHouse = "";
      property.typeofHouse = "";
      property.others = "";
      property.livestockType = "";
      property.livestockCount = "";
      demographicFamily.property = property;
    }

    if (demographicFamily.habits == null) {
      Habits habits = new Habits();
      habits.firstDose = "";
      habits.secondDose = "";
      habits.anyMembersWhoUseTobacco = 0;
      habits.isVaccinationDone = 0;
      habits.firstDose = "";
      habits.secondDose = "";
      habits.anyMembersWhoDrink = 0;
      habits.anyMembersWhoSmoke = 0;
      demographicFamily.habits = habits;
    }

    if (demographicFamily.family == null) {
      List<Family> familyList = [];
      demographicFamily.family = familyList;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: lightColor,
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
                                : Image.network(firebaseAuth.currentUser.photoURL,fit: BoxFit.fill,height: 100,width: 60,)),
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
                    AuthenticationService(FirebaseAuth.instance).signOut(context);
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
          padding: const EdgeInsets.all(8.0),
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
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: RichText(
                              text: TextSpan(
                                  text: DemoLocalization.of(context)
                                      .translate('Mandatory Fields'),
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
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: CupertinoStepper(
                      type: StepperType.horizontal,
                      physics: ClampingScrollPhysics(),
                      currentStep: this._currentStep,
                      onStepTapped: (step) => tapped(step),
                      // onStepContinue: continued,
                      // onStepCancel: cancel,
                      controlsBuilder: (BuildContext context,
                          {VoidCallback onStepContinue,
                          VoidCallback onStepCancel}) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isCancel
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
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
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
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
                              padding: const EdgeInsets.all(4.0),
                              child: FloatingActionButton(
                                // isExtended: true,
                                child: Icon(
                                  Icons.done,
                                  size: 30,
                                ),
                                backgroundColor: primaryColor,
                                onPressed: () {
                                  setState(() {
                                    addData();

                                  });
                                },
                              ),
                            ),
                          ],
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
                                                  padding: const EdgeInsets.only(
                                                      left: 2,
                                                      right: 16.0,
                                                      top: 2.0,
                                                      bottom: 2.0),
                                                  child: TextFormField(
                                                    controller: fromNoController,
                                                    maxLength: 4,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    enableSuggestions: true,
                                                    decoration: InputDecoration(
                                                        counterText: "",
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
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
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        fillColor:
                                                            lightGreyColor),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onSaved: (String val) {
                                                      setState(() {
                                                        // demographicFamily.location.formNo = val;
                                                        location.formNo = val;
                                                        fromNoController.text =
                                                            val;
                                                        // debugPrint("formNo:${demographicFamily.location.formNo}");
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
                                                  padding: const EdgeInsets.only(
                                                      right: 16.0,
                                                      top: 2.0,
                                                      bottom: 2.0),
                                                  child: TextFormField(
                                                    controller:
                                                        projectCodeController,
                                                    maxLength: 1,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    enableSuggestions: true,
                                                    decoration: InputDecoration(
                                                        counterText: "",
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
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
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        fillColor:
                                                            lightGreyColor),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onSaved: (String val) {
                                                      setState(() {
                                                        location.projectCode =
                                                            val;
                                                        projectCodeController
                                                            .text = val;
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
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Village Code'),
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          color: darkColor,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 16.0,
                                                            top: 2.0,
                                                            bottom: 2.0),
                                                    child: AutoCompleteTextField(
                                                        controller:
                                                            villageCodeController,
                                                        clearOnSubmit: false,
                                                        itemSubmitted: (item) {
                                                          setState(() {
                                                            villageCodeController
                                                                .text = item;
                                                            for (int i = 0;
                                                                i <
                                                                    originalVillageCodeList
                                                                        .length;
                                                                i++) {
                                                              if (item ==
                                                                  originalVillageCodeList[
                                                                      i]) {
                                                                panchayatCodeController
                                                                        .text =
                                                                    panchayatCodeList[
                                                                        i];
                                                                panchayatNoController
                                                                        .text =
                                                                    panchayatNoList[
                                                                        i];
                                                                break;
                                                              }
                                                            }
                                                            for (int i = 0;
                                                                i <
                                                                    villageCodeList
                                                                        .length;
                                                                i++) {
                                                              if (item ==
                                                                  villageCodeList[
                                                                      i]) {
                                                                villageNameController
                                                                        .text =
                                                                    villageNameList[
                                                                        i];
                                                                break;
                                                              }
                                                            }
                                                          });
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
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              10.0)),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              10.0)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              lightGreyColor),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              10.0)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              lightGreyColor),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              10.0)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              lightGreyColor),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              10.0)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              lightGreyColor),
                                                                ),
                                                                fillColor:
                                                                    lightGreyColor),
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
                                                        })),
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
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Panchayat No'),
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          color: darkColor,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          panchayatNoController,
                                                      clearOnSubmit: false,
                                                      itemSubmitted: (item) {
                                                        panchayatNoController
                                                            .text = item;
                                                        setState(() {
                                                          villageNameController
                                                              .text = "";
                                                          villageCodeController
                                                              .text = "";
                                                          villageCodeList.clear();
                                                          villageNameList.clear();
                                                          snap.forEach((element) {
                                                            if (element
                                                                    .data()[
                                                                        "panchayatNo"]
                                                                    .toString() ==
                                                                item) {
                                                              villageCodeList.add(
                                                                  element
                                                                      .data()[
                                                                          "villageCode"]
                                                                      .toString());
                                                              villageNameList.add(
                                                                  element
                                                                      .data()[
                                                                          "villageName"]
                                                                          [
                                                                          language]
                                                                      .toString());
                                                            }
                                                          });
                                                          for (int i = 0;
                                                              i <
                                                                  panchayatNoList
                                                                      .length;
                                                              i++) {
                                                            if (item ==
                                                                panchayatNoList[
                                                                    i]) {
                                                              panchayatCodeController
                                                                      .text =
                                                                  panchayatCodeList[
                                                                      i];
                                                              break;
                                                            }
                                                          }
                                                        });
                                                      },
                                                      suggestions:
                                                          panchayatNoList,
                                                      style: TextStyle(
                                                        color: Color(0xFF222222),
                                                        fontSize: 16,
                                                      ),
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          fillColor:
                                                              lightGreyColor),
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
                                                              weight:
                                                                  FontWeight.w600,
                                                            ));
                                                      },
                                                      itemSorter: (a, b) {
                                                        return a.compareTo(b);
                                                      },
                                                      itemFilter: (item, query) {
                                                        return item
                                                            .toLowerCase()
                                                            .startsWith(query
                                                                .toLowerCase());
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Panchayat Code'),
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          color: darkColor,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                      right: 16.0,
                                                      top: 2.0,
                                                      bottom: 2.0),
                                                  child: AutoCompleteTextField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          panchayatCodeController,
                                                      clearOnSubmit: false,
                                                      itemSubmitted: (item) {
                                                        panchayatCodeController
                                                            .text = item;
                                                        setState(() {
                                                          villageNameController
                                                              .text = "";
                                                          villageCodeController
                                                              .text = "";
                                                          villageCodeList.clear();
                                                          villageNameList.clear();
                                                          snap.forEach((element) {
                                                            if (element
                                                                    .data()[
                                                                        "panchayatCode"]
                                                                    .toString() ==
                                                                item) {
                                                              villageCodeList.add(
                                                                  element
                                                                      .data()[
                                                                          "villageCode"]
                                                                      .toString());
                                                              villageNameList.add(
                                                                  element
                                                                      .data()[
                                                                          "villageName"]
                                                                          [
                                                                          language]
                                                                      .toString());
                                                            }
                                                          });
                                                          for (int i = 0;
                                                              i <
                                                                  panchayatCodeList
                                                                      .length;
                                                              i++) {
                                                            if (item ==
                                                                panchayatCodeList[
                                                                    i]) {
                                                              panchayatNoController
                                                                      .text =
                                                                  panchayatNoList[
                                                                      i];
                                                              break;
                                                            }
                                                          }
                                                        });
                                                      },
                                                      suggestions:
                                                          panchayatCodeList,
                                                      style: TextStyle(
                                                        color: Color(0xFF222222),
                                                        fontSize: 16,
                                                      ),
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          fillColor:
                                                              lightGreyColor),
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
                                                              weight:
                                                                  FontWeight.w600,
                                                            ));
                                                      },
                                                      itemSorter: (a, b) {
                                                        return a.compareTo(b);
                                                      },
                                                      itemFilter: (item, query) {
                                                        return item
                                                            .toLowerCase()
                                                            .startsWith(query
                                                                .toLowerCase());
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Village Name'),
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          color: darkColor,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                      right: 16.0,
                                                      top: 0.0,
                                                      bottom: 0.0),
                                                  child: AutoCompleteTextField(
                                                      controller:
                                                          villageNameController,
                                                      clearOnSubmit: false,
                                                      itemSubmitted: (item) {
                                                        villageNameController
                                                            .text = item;
                                                        setState(() {
                                                          for (int i = 0;
                                                              i <
                                                                  originalVillageNameList
                                                                      .length;
                                                              i++) {
                                                            if (item ==
                                                                originalVillageNameList[
                                                                    i]) {
                                                              panchayatCodeController
                                                                      .text =
                                                                  panchayatCodeList[
                                                                      i];
                                                              panchayatNoController
                                                                      .text =
                                                                  panchayatNoList[
                                                                      i];
                                                              break;
                                                            }
                                                          }
                                                          for (int i = 0;
                                                              i <
                                                                  villageNameList
                                                                      .length;
                                                              i++) {
                                                            if (item ==
                                                                villageNameList[
                                                                    i]) {
                                                              villageCodeController
                                                                      .text =
                                                                  villageCodeList[
                                                                      i];
                                                              break;
                                                            }
                                                          }
                                                        });
                                                      },
                                                      suggestions:
                                                          villageNameList,
                                                      style: TextStyle(
                                                        color: Color(0xFF222222),
                                                        fontSize: 16,
                                                      ),
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10.0)),
                                                            borderSide: BorderSide(
                                                                color:
                                                                    lightGreyColor),
                                                          ),
                                                          fillColor:
                                                              lightGreyColor),
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
                                                              weight:
                                                                  FontWeight.w600,
                                                            ));
                                                      },
                                                      itemSorter: (a, b) {
                                                        return a.compareTo(b);
                                                      },
                                                      itemFilter: (item, query) {
                                                        debugPrint("item:$item");
                                                        return item
                                                            .toLowerCase()
                                                            .startsWith(query
                                                                .toLowerCase());
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: RichText(
                                              text: TextSpan(
                                                  text: DemoLocalization.of(
                                                          context)
                                                      .translate('Street Name'),
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      color: darkColor,
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                              child: AutoCompleteTextField(
                                                  controller: streetNameController,
                                                  clearOnSubmit: false,
                                                  itemSubmitted: (item) {
                                                    streetNameController.text = item;
                                                  },
                                                  suggestions: streets,
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
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate('Door No'),
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          color: darkColor,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                      right: 16.0,
                                                      top: 2.0,
                                                      bottom: 2.0),
                                                  child: TextFormField(
                                                    controller: doorNoController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    enableSuggestions: true,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
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
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
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
                                                        location.doorNumber = val;
                                                        doorNoController.text =
                                                            val;
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
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: DemoLocalization.of(
                                                              context)
                                                          .translate(
                                                              'Contact Person'),
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          color: darkColor,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                      right: 16.0,
                                                      top: 2.0,
                                                      bottom: 2.0),
                                                  child: TextFormField(
                                                    controller:
                                                        contactPersonController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    enableSuggestions: true,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
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
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
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
                                                        location.contactPerson =
                                                            val;
                                                        contactPersonController
                                                            .text = val;
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
                                          widthFactor: 0.25,
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
                                                width: 120,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 2,
                                                      right: 16.0,
                                                      top: 2.0,
                                                      bottom: 2.0),
                                                  child: TextFormField(
                                                    controller:
                                                        noOfFamilyPersonController,
                                                    maxLength: 2,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    enableSuggestions: true,
                                                    decoration: InputDecoration(
                                                        counterText: "",
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
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
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreyColor),
                                                        ),
                                                        fillColor:
                                                            lightGreyColor),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onSaved: (String val) {
                                                      setState(() {
                                                        location.noOfFamilyMembers =
                                                            val;
                                                        noOfFamilyPersonController
                                                            .text = val;
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
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Container())
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
                          content: FamilyMemberDetails(demographicFamily),
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
                          content: PropertyDetailStep(demographicFamily),
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
                          content: HabitsStep(demographicFamily),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 3
                              ? StepState.complete
                              : StepState.disabled,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
    isCancel = true;
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
    _currentStep > 0
        ? setState(() {
            _currentStep -= 1;
          })
        : null;
  }

  /*Future<void> _getVillageCode(String text) async {
    debugPrint(
        "VillageCode:${FirebaseFirestore.instance.collection(collectionVillageCode).snapshots()}");
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection('demographicData').get();
    // Get data from docs and convert map to List
    print("villageCodeList2:$querySnapshot");

    villageCodeList = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("villageCodeList:$villageCodeList");
    villageCodeList.forEach((element) {
      LinkedHashMap<String, dynamic> data = element['location'];
      values = data.values.toList();

      print("villageCodeList1:${values.last}");
    });
  }*/

  void getLanguage() async {
    language = await SharedPref().getStringPref(SharedPref().language);
    debugPrint("language:$language");
    getVillageDetails(language);
    // getDemoRef();
  }

  void fillVillageData(var village) async {
    DocumentSnapshot snapShot = await firestoreInstance.doc(village.path).get();
    villageNameController.text = snapShot["villageName"][language].toString();
    villageCodeController.text = snapShot["villageCode"].toString();
    panchayatCodeController.text = snapShot["panchayatCode"].toString();
    panchayatNoController.text = snapShot["panchayatNo"].toString();
  }

  void addData() {
    location.formNo = fromNoController.text;
    location.projectCode = projectCodeController.text;
    location.streetName = streetNameController.text;
    location.doorNumber = doorNoController.text;
    location.contactPerson = contactPersonController.text;
    location.noOfFamilyMembers = noOfFamilyPersonController.text;

    if (villageCodeController.text != "") {
      DocumentReference documentReference;
      for (int i = 0; i < snap.length; i++) {
        if (snap[i].data()["villageCode"].toString() ==
            villageCodeController.text) {
          documentReference = firestoreInstance.collection(collectionVillageName).doc(snap[i].id);
          break;
        }
      }
      if (documentReference != null) {
        location.villagesCode = documentReference;
        location.panchayatNo = documentReference;
        location.panchayatCode = documentReference;
        location.villageName = documentReference;
      } else {
        location.villagesCode = villageCodeController.text;
        location.panchayatNo = panchayatNoController.text;
        location.panchayatCode = panchayatCodeController.text;
        location.villageName = villageNameController.text;
      }
    } else if (panchayatNoController.text != "") {
      DocumentReference documentReference;
      for (int i = 0; i < snap.length; i++) {
        if (snap[i].data()["panchayatNo"].toString() == panchayatNoController.text) {
          documentReference = firestoreInstance.collection(collectionVillageName).doc(snap[i].id);
          break;
        }
      }
      if (documentReference != null) {
        location.villagesCode = "";
        location.panchayatNo = documentReference;
        location.panchayatCode = documentReference;
        location.villageName = "";
      } else {
        location.villagesCode = villageCodeController.text;
        location.panchayatNo = panchayatNoController.text;
        location.panchayatCode = panchayatCodeController.text;
        location.villageName = villageNameController.text;
      }
    } else {
      location.villagesCode = villageCodeController.text;
      location.panchayatNo = panchayatNoController.text;
      location.panchayatCode = panchayatCodeController.text;
      location.villageName = villageNameController.text;
    }

    for (int i = 0; i < demographicFamily.family.length; i++) {
      if (demographicFamily.family[i].mobileNumber.isNotEmpty) {
        location.contactNumber = demographicFamily.family[i].mobileNumber;
        break;
      }
    }

    demographicFamily.location = location;

    if (!isEdit) {
      FireStoreService fireStoreService = new FireStoreService();
      fireStoreService.createFamily(demographicFamily).then((value) =>
      {if (value) {
          Navigator.pop(context, false),
        // makeLoadData(),
        // Get.offAndToNamed('/homeScreen'),
      showAddSuccess()
      } else {
        snackBarAlert(error, "Failed to Add", errorColor)
      }});
    } else {
      debugPrint("documentId:$documentId");
      FireStoreService fireStoreService = new FireStoreService();
      fireStoreService.updateFamily(demographicFamily,documentId).then((value) =>
      {if (value) {
          Navigator.pop(context, false),
        makeLoadData(),
        // Get.offAndToNamed('/homeScreen'),
      showUpdateSuccess()
      }  else {
        snackBarAlert(error, "Failed to Update", errorColor)
      }});
    }
  }

  void showAddSuccess() {
    snackBarAlert(success, "Added SuccessFully", successColor);
  }

  void showUpdateSuccess() {
    snackBarAlert(success, "Updated SuccessFully", successColor);
  }

  getVillageDetails(String language) async {
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionVillageName).get();
    setState(() {
      snap = querySnapshot.docs;

      var villageCodeDoc =
          querySnapshot.docs.map((doc) => doc.data()["villageCode"]).toList();
      var villageNameDoc = querySnapshot.docs
          .map((doc) => doc.data()["villageName"][language])
          .toList();
      var panchayatCodeDoc =
          querySnapshot.docs.map((doc) => doc.data()["panchayatCode"]).toList();
      var panchayatNoDoc =
          querySnapshot.docs.map((doc) => doc.data()["panchayatNo"]).toList();

      villageCodeDoc.forEach((element) {
        villageCodeList.add(element.toString());
        originalVillageCodeList.add(element.toString());
      });
      villageNameDoc.forEach((element) {
        villageNameList.add(element.toString());
        originalVillageNameList.add(element.toString());
      });
      panchayatCodeDoc.forEach((element) {
        panchayatCodeList.add(element.toString());
      });
      panchayatNoDoc.forEach((element) {
        panchayatNoList.add(element.toString());
      });
    });
  }
  void showToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All fields are required'),
      ),
    );
  }

}
