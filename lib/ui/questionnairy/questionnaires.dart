/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 3:21 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 3:21 PM by Kanmalai.
 * /
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/models/data_model.dart';
import 'package:tct_demographics/services/firestore_service.dart';
import 'package:tct_demographics/ui/questionnairy/familymember_details.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/familymembers_step.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/habit_step.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/property_step.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class QuestionnairesScreen extends StatefulWidget {
  @override
  _QuestionnairesScreenState createState() => _QuestionnairesScreenState();
}

class _QuestionnairesScreenState extends State<QuestionnairesScreen> {
  FireStoreService api =FireStoreService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<Family>familyDataList;
  Family familyData;
  int _currentStep = 0;
  FocusNode mailFocusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String villageCodeVal,panchayatCodeVal,villageNameVal,streetName,contactPerson ;
  int formNoVal,projectCodeVal,panchayatNoVal,doorNumberVal,noOfFamilyMembersVal;

  //property
  GlobalKey<FormState> _stepThreeKey = new GlobalKey<FormState>();
  bool isSwitched = false;
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  String textValue = 'No';
  String textValue1 = 'No';
  String textValue2 = 'No';
  String textValue3 = 'No';
  String statusOfHouseVal,typeofHouseVal, livestockTypeVal;
  bool toiletFacilityVal,ownLandVal,ownVehicleVal,ownLiveStocksVal;
  int wetLandInAcresVal,dryLandInAcresVal,noOfVehicleOwnVal,twoWheelerVal,threeWheelerVal ,fourWheelerVal ,othersVal,livestockCountVal;

  //family
  GlobalKey<FormState> _stepTwoKey = new GlobalKey<FormState>();
  bool isSwitched4 = false;
  bool isSwitched5 = false;
  String textValue4 = 'No';
  String textValue5 = 'No';
  String nameVal,relationshipVal,genderVal,dateOfBirthVal,maritalStatusVal,bloodGroupVal,qualificationVal,occupationVal,mailVal,communityVal,castVal,photoVal;
  int aadharNumberVal,ageVal,annualIncomeVal,mobileNumberVal;
  bool physicallyChallengeVal,smartphoneVal;
  TextEditingController datePicker = TextEditingController();
  DateTime date = DateTime.parse("2019-04-16 12:18:06.018950");

  //habit
  GlobalKey<FormState> _stepFourKey = new GlobalKey<FormState>();
  bool isSwitched6 = false;
  String textValue6 = 'No';
  bool isSwitched7 = false;
  String textValue7 = 'No';
  bool isSwitched8 = false;
  String textValue8 = 'No';

  bool anyMembersWhoSmokeVal,anyMembersWhoDrinkVal,anyMembersWhoUseTobaccoVal;

  @override
  void initState(){

    familyDataList = [];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: lightColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: (){

                    },
                    child: Row(
                      children: [
                        Icon(Icons.language, size: 24,color: darkColor,),
                        SizedBox(width: 10,),
                        Text("English",
                          style: TextStyle(fontSize: 18,color: darkColor),),
                      ],
                    )
                ),
                SizedBox(width: 50,),
                InkWell(
                    onTap: (){

                    },
                    child: Row(
                      children: [
                        Text("Senthil Kumar",
                          style: TextStyle(fontSize: 18,color: darkColor),),
                        SizedBox(width: 10,),
                        Container(
                            padding: EdgeInsets.only(left:8.0),
                            height: 30,
                            width: 30,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new AssetImage(user)
                                )
                            )
                        )
                      ],
                    )
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
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:24.0,left: 30.0,right: 30.0,bottom: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: questionery,
                              color: darkColor,
                              weight:  FontWeight.w600,
                              size: 24,
                            ),
                            TextWidget(
                              text: mandatory,
                              color: darkColor,
                              weight:  FontWeight.w600,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1.5,),
                      Expanded(
                          child: Stepper(
                            type: StepperType.horizontal,
                            physics: ScrollPhysics(),
                            currentStep: this._currentStep,
                            onStepTapped: (step) => tapped(step),
                            onStepContinue: continued,
                            onStepCancel: cancel,
                            // controlsBuilder: (BuildContext context,{VoidCallback? onStepContinue, VoidCallback onStepCancel}){
                            //   return
                            // },
                            steps: <Step>[
                              Step(
                                title: TextWidget(
                                  text: "Location",
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
                                                widthFactor:0.5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: formNumber,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-3.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: projectCode,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                  ],
                                                ),
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
                                              alignment:Alignment.topLeft,
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: villageCode,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButtonFormField<String>(
                                                        isExpanded: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),

                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            ),
                                                        value: villageCodeVal,
                                                        validator: (value) => value == null
                                                            ? 'Source Type must not be empty'
                                                            : null,
                                                        onChanged: (value) =>
                                                            setState(() => villageCodeVal = value),
                                                        items: <String>[
                                                          'VLR',
                                                          'VLR',
                                                          'VLR',
                                                        ].map<DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                  text: value,
                                                                  color: darkColor,
                                                                  weight: FontWeight.w400,
                                                                  size: 16,
                                                                ),
                                                              );
                                                            }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-3.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: panchayatNo,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButtonFormField<String>(
                                                        isExpanded: true,
                                                        decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),

                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                        ),
                                                        //value: panchayatNoVal,
                                                        validator: (value) => value == null
                                                            ? 'Source Type must not be empty'
                                                            : null,
                                                        // onChanged: (value) =>
                                                        //     setState(() => panchayatNoVal = value),
                                                        items: <String>[
                                                          '1212',
                                                          '2325',
                                                          '6558',
                                                        ].map<DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                  text: value,
                                                                  color: darkColor,
                                                                  weight: FontWeight.w400,
                                                                  size: 16,
                                                                ),
                                                              );
                                                            }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-5.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: panchayatCode,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButtonFormField<String>(
                                                        isExpanded: true,
                                                        decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),

                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                        ),
                                                        value: panchayatCodeVal,
                                                        validator: (value) => value == null
                                                            ? 'Source Type must not be empty'
                                                            : null,
                                                        onChanged: (value) =>
                                                            setState(() => panchayatCodeVal = value),
                                                        items: <String>[
                                                          '98',
                                                          '988',
                                                          '999',
                                                        ].map<DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                  text: value,
                                                                  color: darkColor,
                                                                  weight: FontWeight.w400,
                                                                  size: 16,
                                                                ),
                                                              );
                                                            }).toList(),
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
                                                widthFactor: 0.5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: villageName,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButtonFormField<String>(
                                                        isExpanded: true,
                                                        decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),

                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                        ),
                                                        value: villageNameVal,
                                                        validator: (value) => value == null
                                                            ? 'Source Type must not be empty'
                                                            : null,
                                                        onChanged: (value) =>
                                                            setState(() => villageNameVal = value),
                                                        items: <String>[
                                                          'kangeyam',
                                                          'puthupalayam',
                                                          'nallur',
                                                        ].map<DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                  text: value,
                                                                  color: darkColor,
                                                                  weight: FontWeight.w400,
                                                                  size: 16,
                                                                ),
                                                              );
                                                            }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: TextWidget(
                                                    text: streetName,
                                                    size: 18,
                                                    weight: FontWeight.w600,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: TextFormField(
                                                    textInputAction: TextInputAction.next,
                                                    autocorrect: true,
                                                    enableSuggestions: true,
                                                    decoration: InputDecoration(
                                                        border: new OutlineInputBorder(
                                                          borderSide: BorderSide.none,
                                                          borderRadius:
                                                          BorderRadius.only(topRight :Radius.circular(50.0),
                                                              bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.only(topRight :Radius.circular(50.0),
                                                              bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          borderSide:
                                                          BorderSide(color: lightGreyColor),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.only(topRight :Radius.circular(50.0),
                                                              bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          borderSide:
                                                          BorderSide(color: lightGreyColor),
                                                        ),
                                                        focusedErrorBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.only(topRight :Radius.circular(50.0),
                                                              bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          borderSide:
                                                          BorderSide(color: lightGreyColor),
                                                        ),
                                                        errorBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.only(topRight :Radius.circular(50.0),
                                                              bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-1.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: doorNumber,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                  ],
                                                ),
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
                                                widthFactor:0.5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: contactPerson,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
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
                                      text: family,
                                      color: darkColor,
                                      size: 14,
                                      weight: FontWeight.w600,
                                    ),
                                content: Form(
                                  key: _stepTwoKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: FractionallySizedBox(
                                                widthFactor: 1.0,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: name,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextWidget(
                                                      text: adhaarNumber,
                                                      size: 18,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      textInputAction: TextInputAction.next,
                                                      autocorrect: true,
                                                      enableSuggestions: true,
                                                      decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          focusedErrorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextWidget(
                                                      text: relationship,
                                                      size: 18,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: DropdownButtonFormField<String>(
                                                      isExpanded: true,
                                                      decoration: InputDecoration(
                                                        border: new OutlineInputBorder(
                                                          borderSide: BorderSide.none,
                                                          borderRadius:
                                                          BorderRadius.only(topRight :Radius.circular(50.0),
                                                              bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.only(topRight :Radius.circular(50.0),
                                                              bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          borderSide:
                                                          BorderSide(color: lightGreyColor),
                                                        ),

                                                        errorBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.only(topRight :Radius.circular(50.0),
                                                              bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          borderSide:
                                                          BorderSide(color: lightGreyColor),
                                                        ),
                                                      ),
                                                      value: relationshipVal,
                                                      validator: (value) => value == null
                                                          ? 'Source Type must not be empty'
                                                          : null,
                                                      onChanged: (value) =>
                                                          setState(() => relationshipVal = value),
                                                      items: <String>[
                                                        'Son',
                                                        'Father',
                                                        'Mother',
                                                      ].map<DropdownMenuItem<String>>(
                                                              (String value) {
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              child: TextWidget(
                                                                text: value,
                                                                color: darkColor,
                                                                weight: FontWeight.w400,
                                                                size: 16,
                                                              ),
                                                            );
                                                          }).toList(),
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
                                                        alignment:Alignment.topLeft,
                                                        child: FractionallySizedBox(
                                                          widthFactor: 1,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: TextWidget(
                                                                  text: gender,
                                                                  size: 18,
                                                                  weight: FontWeight.w600,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: DropdownButtonFormField<String>(
                                                                  isExpanded: true,
                                                                  decoration: InputDecoration(
                                                                    border: new OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius:
                                                                      BorderRadius.only(topRight :Radius.circular(50.0),
                                                                          bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.only(topRight :Radius.circular(50.0),
                                                                          bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                      borderSide:
                                                                      BorderSide(color: lightGreyColor),
                                                                    ),

                                                                    errorBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.only(topRight :Radius.circular(50.0),
                                                                          bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                      borderSide:
                                                                      BorderSide(color: lightGreyColor),
                                                                    ),
                                                                  ),
                                                                  value: genderVal,
                                                                  validator: (value) => value == null
                                                                      ? 'Source Type must not be empty'
                                                                      : null,
                                                                  onChanged: (value) =>
                                                                      setState(() => genderVal = value),
                                                                  items: <String>[
                                                                    'Male',
                                                                    'Female',
                                                                    'Others',
                                                                  ].map<DropdownMenuItem<String>>(
                                                                          (String value) {
                                                                        return DropdownMenuItem<String>(
                                                                          value: value,
                                                                          child: TextWidget(
                                                                            text: value,
                                                                            color: darkColor,
                                                                            weight: FontWeight.w400,
                                                                            size: 16,
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment(-3.0,0.2),
                                                        child: FractionallySizedBox(
                                                          widthFactor: 1,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: TextWidget(
                                                                  text: dateOfBirth,
                                                                  size: 18,
                                                                  weight: FontWeight.w600,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: TextFormField(
                                                                  textInputAction: TextInputAction.next,
                                                                  autocorrect: true,
                                                                  controller: datePicker,
                                                                  enableSuggestions: true,
                                                                  decoration: InputDecoration(
                                                                      border: new OutlineInputBorder(
                                                                        borderSide: BorderSide.none,
                                                                        borderRadius:
                                                                        BorderRadius.only(topRight :Radius.circular(50.0),
                                                                            bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                      ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius.only(topRight :Radius.circular(50.0),
                                                                            bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                        borderSide:
                                                                        BorderSide(color: lightGreyColor),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius.only(topRight :Radius.circular(50.0),
                                                                            bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                        borderSide:
                                                                        BorderSide(color: lightGreyColor),
                                                                      ),
                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius.only(topRight :Radius.circular(50.0),
                                                                            bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                        borderSide:
                                                                        BorderSide(color: lightGreyColor),
                                                                      ),
                                                                      errorBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius.only(topRight :Radius.circular(50.0),
                                                                            bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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

                                                                    datePicker.text =
                                                                    "${date.year}/${date.month}/${date.day}";

                                                                    dateOfBirthVal = datePicker.text;
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
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment(-5.0,0.2),
                                                        child: FractionallySizedBox(
                                                          widthFactor: 1,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: TextWidget(
                                                                  text: "Age",
                                                                  size: 18,
                                                                  weight: FontWeight.w600,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: TextFormField(
                                                                  textInputAction: TextInputAction.next,
                                                                  autocorrect: true,
                                                                  enableSuggestions: true,
                                                                  decoration: InputDecoration(
                                                                      border: new OutlineInputBorder(
                                                                        borderSide: BorderSide.none,
                                                                        borderRadius:
                                                                        BorderRadius.only(topRight :Radius.circular(50.0),
                                                                            bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                      ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius.only(topRight :Radius.circular(50.0),
                                                                            bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                        borderSide:
                                                                        BorderSide(color: lightGreyColor),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius.only(topRight :Radius.circular(50.0),
                                                                            bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                        borderSide:
                                                                        BorderSide(color: lightGreyColor),
                                                                      ),
                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius.only(topRight :Radius.circular(50.0),
                                                                            bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                        borderSide:
                                                                        BorderSide(color: lightGreyColor),
                                                                      ),
                                                                      errorBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius.only(topRight :Radius.circular(50.0),
                                                                            bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                        alignment:Alignment.topLeft,
                                                        child: FractionallySizedBox(
                                                          widthFactor: 1,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: TextWidget(
                                                                  text: maritalStatus,
                                                                  size: 18,
                                                                  weight: FontWeight.w600,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: DropdownButtonFormField<String>(
                                                                  isExpanded: true,
                                                                  decoration: InputDecoration(
                                                                    border: new OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius:
                                                                      BorderRadius.only(topRight :Radius.circular(50.0),
                                                                          bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.only(topRight :Radius.circular(50.0),
                                                                          bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                      borderSide:
                                                                      BorderSide(color: lightGreyColor),
                                                                    ),

                                                                    errorBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.only(topRight :Radius.circular(50.0),
                                                                          bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                      borderSide:
                                                                      BorderSide(color: lightGreyColor),
                                                                    ),
                                                                  ),
                                                                  value: maritalStatusVal,
                                                                  validator: (value) => value == null
                                                                      ? 'Source Type must not be empty'
                                                                      : null,
                                                                  onChanged: (value) =>
                                                                      setState(() => maritalStatusVal = value),
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
                                                                            size: 16,
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment(-3.0,0.2),
                                                        child: FractionallySizedBox(
                                                          widthFactor: 1,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: TextWidget(
                                                                  text: bloodGroup,
                                                                  size: 18,
                                                                  weight: FontWeight.w600,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: DropdownButtonFormField<String>(
                                                                  isExpanded: true,
                                                                  decoration: InputDecoration(
                                                                    border: new OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius:
                                                                      BorderRadius.only(topRight :Radius.circular(50.0),
                                                                          bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.only(topRight :Radius.circular(50.0),
                                                                          bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                      borderSide:
                                                                      BorderSide(color: lightGreyColor),
                                                                    ),

                                                                    errorBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.only(topRight :Radius.circular(50.0),
                                                                          bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                                      borderSide:
                                                                      BorderSide(color: lightGreyColor),
                                                                    ),
                                                                  ),
                                                                  value: bloodGroupVal,
                                                                  validator: (value) => value == null
                                                                      ? 'Source Type must not be empty'
                                                                      : null,
                                                                  onChanged: (value) =>
                                                                      setState(() => bloodGroupVal = value),
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
                                                                            size: 16,
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment(-5.0,0.2),
                                                        child: FractionallySizedBox(
                                                          widthFactor: 1,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: TextWidget(
                                                                  text: physicallyChallenged,
                                                                  size: 18,
                                                                  weight: FontWeight.w600,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child:Row(
                                                                  children: [
                                                                    Switch(
                                                                      onChanged: toggleSwitch,
                                                                      value: isSwitched4,
                                                                      activeColor: Colors.blue,
                                                                      activeTrackColor: greyColor,
                                                                      inactiveThumbColor: greyColor,
                                                                      inactiveTrackColor: greyColor,
                                                                    ),
                                                                    TextWidget(
                                                                      text: textValue4,
                                                                      size: 18,
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
                                                    padding: const EdgeInsets.only(left:30.0),
                                                    child: TextWidget(
                                                      text: "Photo",
                                                      size: 18,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:30.0),
                                                    child: Container(
                                                        height: 150,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(50))
                                                        ),
                                                        child: Image.asset(userSquare)),
                                                  ),
                                                  SizedBox(height: 50,),
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
                                              alignment:Alignment.topLeft,
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: educationQualification,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButtonFormField<String>(
                                                        isExpanded: true,
                                                        decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),

                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                        ),
                                                        value: qualificationVal,
                                                        validator: (value) => value == null
                                                            ? 'Source Type must not be empty'
                                                            : null,
                                                        onChanged: (value) =>
                                                            setState(() => qualificationVal = value),
                                                        items: <String>[
                                                          'BE',
                                                          'BSc',
                                                          'Others',
                                                        ].map<DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                  text: value,
                                                                  color: darkColor,
                                                                  weight: FontWeight.w400,
                                                                  size: 16,
                                                                ),
                                                              );
                                                            }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-3.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: occupation,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-5.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: annualIncome,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButtonFormField<String>(
                                                        isExpanded: true,
                                                        decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),

                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                        ),
                                                        //value: annualIncomeVal,
                                                        validator: (value) => value == null
                                                            ? 'Source Type must not be empty'
                                                            : null,
                                                        // onChanged: (value) =>
                                                        //     setState(() => annualIncomeVal = value),
                                                        items: <String>[
                                                          '60000',
                                                          '80000',
                                                          'Others',
                                                        ].map<DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                  text: value,
                                                                  color: darkColor,
                                                                  weight: FontWeight.w400,
                                                                  size: 16,
                                                                ),
                                                              );
                                                            }).toList(),
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
                                              alignment:Alignment.topLeft,
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: mobileNumber,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-3.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: email,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-5.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: smartphone,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child:Row(
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
                                                            size: 18,
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

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: FractionallySizedBox(
                                                widthFactor: 0.30,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: community,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButtonFormField<String>(
                                                        isExpanded: true,
                                                        decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),

                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                        ),
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
                                                        ].map<DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                  text: value,
                                                                  color: darkColor,
                                                                  weight: FontWeight.w400,
                                                                  size: 16,
                                                                ),
                                                              );
                                                            }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-5.7,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.70,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: caste,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButtonFormField<String>(
                                                        isExpanded: true,
                                                        decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),

                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                        ),
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
                                                        ].map<DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                  text: value,
                                                                  color: darkColor,
                                                                  weight: FontWeight.w400,
                                                                  size: 16,
                                                                ),
                                                              );
                                                            }).toList(),
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
                                isActive: _currentStep >= 0,
                                state: _currentStep >= 1 ?
                                StepState.complete : StepState.disabled,
                              ),
                              Step(
                                title: TextWidget(
                                  text: property,
                                  color: darkColor,
                                  size: 14,
                                  weight: FontWeight.w600,
                                ),
                                content:Form(
                                  key: _stepThreeKey,
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
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: statusHouse,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                     Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButtonFormField<String>(
                                                        isExpanded: true,
                                                        decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),

                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                        ),
                                                        value:statusOfHouseVal,
                                                        validator: (value) => value == null
                                                            ? 'Source Type must not be empty'
                                                            : null,
                                                        onChanged: (value) =>
                                                            setState(() =>statusOfHouseVal = value),
                                                        items: <String>[
                                                          'Male',
                                                          'Female',
                                                          'Others',
                                                        ].map<DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                  text: value,
                                                                  color: darkColor,
                                                                  weight: FontWeight.w400,
                                                                  size: 16,
                                                                ),
                                                              );
                                                            }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-3.0,2.0),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: typeofHouse,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButtonFormField<String>(
                                                        isExpanded: true,
                                                        decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),

                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                        ),
                                                        value: typeofHouseVal,
                                                        validator: (value) => value == null
                                                            ? 'Source Type must not be empty'
                                                            : null,
                                                        onChanged: (value) =>
                                                            setState(() => typeofHouseVal = value),
                                                        items: <String>[
                                                          'Male',
                                                          'Female',
                                                          'Others',
                                                        ].map<DropdownMenuItem<String>>(
                                                                (String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: TextWidget(
                                                                  text: value,
                                                                  color: darkColor,
                                                                  weight: FontWeight.w400,
                                                                  size: 16,
                                                                ),
                                                              );
                                                            }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(

                                            child: Align(
                                              alignment: Alignment(-5.0,2.0),
                                              child: FractionallySizedBox(
                                                widthFactor: .75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: toiletFacilityatHome,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child:Row(
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
                                                            size: 18,
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment:Alignment.topLeft,
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: ownsanyLand,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child:Row(
                                                        children: [
                                                          Switch(
                                                            onChanged: toggleSwitch1,
                                                            value: isSwitched5,
                                                            activeColor: Colors.blue,
                                                            activeTrackColor: greyColor,
                                                            inactiveThumbColor: greyColor,
                                                            inactiveTrackColor: greyColor,
                                                          ),
                                                          TextWidget(
                                                            text: textValue5,
                                                            size: 18,
                                                            weight: FontWeight.w600,
                                                          ),
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
                                              alignment: Alignment(-3.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: wetLandinacres,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            fillColor: lightGreyColor),
                                                        keyboardType: TextInputType.text,
                                                        // onSaved: (String val) {
                                                        //   setState(() {
                                                        //     wetLandInAcresVal =val;
                                                        //   });
                                                        // },
                                                        onSaved: (value){
                                                          setState(() {
                                                            wetLandInAcresVal = value as int;
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-5.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: dryLandinacres,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                              alignment:Alignment.topLeft,
                                              child: FractionallySizedBox(
                                                widthFactor: 0.5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: OwnsanyVehicle,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child:Row(
                                                        children: [
                                                          Switch(
                                                            onChanged: toggleSwitch2,
                                                            value: isSwitched2,
                                                            activeColor: Colors.blue,
                                                            activeTrackColor: greyColor,
                                                            inactiveThumbColor: greyColor,
                                                            inactiveTrackColor: greyColor,
                                                          ),
                                                          TextWidget(
                                                            text: textValue2,
                                                            size: 18,
                                                            weight: FontWeight.w600,
                                                          ),
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
                                              alignment: Alignment(-3.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: NoofVehiclesOwned,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                  ],
                                                ),
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
                                              alignment:Alignment.topLeft,
                                              child: FractionallySizedBox(
                                                widthFactor: 1,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: twoWheeler,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: FractionallySizedBox(
                                              widthFactor:1,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextWidget(
                                                      text: threeWheeler,
                                                      size: 18,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      textInputAction: TextInputAction.next,
                                                      autocorrect: true,
                                                      enableSuggestions: true,
                                                      decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          focusedErrorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextWidget(
                                                      text: fourWheeler,
                                                      size: 18,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      textInputAction: TextInputAction.next,
                                                      autocorrect: true,
                                                      enableSuggestions: true,
                                                      decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          focusedErrorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextWidget(
                                                      text: other,
                                                      size: 18,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      textInputAction: TextInputAction.next,
                                                      autocorrect: true,
                                                      enableSuggestions: true,
                                                      decoration: InputDecoration(
                                                          border: new OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          focusedErrorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            borderSide:
                                                            BorderSide(color: lightGreyColor),
                                                          ),
                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.only(topRight :Radius.circular(50.0),
                                                                bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                              alignment:Alignment.topLeft,
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: ownsanyLivestock,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child:Row(
                                                        children: [
                                                          Switch(
                                                            onChanged: toggleSwitch3,
                                                            value: isSwitched3,
                                                            activeColor: Colors.blue,
                                                            activeTrackColor: greyColor,
                                                            inactiveThumbColor: greyColor,
                                                            inactiveTrackColor: greyColor,
                                                          ),
                                                          TextWidget(
                                                            text: textValue3,
                                                            size: 18,
                                                            weight: FontWeight.w600,
                                                          ),
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
                                              alignment: Alignment(-3.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: livestockType,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment(-5.0,0.2),
                                              child: FractionallySizedBox(
                                                widthFactor: 0.75,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextWidget(
                                                        text: livestockCount,
                                                        size: 18,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.next,
                                                        autocorrect: true,
                                                        enableSuggestions: true,
                                                        decoration: InputDecoration(
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                                              borderSide:
                                                              BorderSide(color: lightGreyColor),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.only(topRight :Radius.circular(50.0),
                                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
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
                                isActive: _currentStep >= 0,
                                state: _currentStep >= 2 ?
                                StepState.complete : StepState.disabled,
                              ),
                              Step(
                                title: TextWidget(
                                  text: habits,
                                  color: darkColor,
                                  size: 14,
                                  weight: FontWeight.w600,
                                ),
                                content:Form(
                                  key: _stepFourKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextWidget(
                                          text: Anymemberswhosmoke,
                                          size: 18,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Switch(
                                            onChanged: toggleSwitch,
                                            value: isSwitched6,
                                            activeColor: Colors.blue,
                                            activeTrackColor: greyColor,
                                            inactiveThumbColor: greyColor,
                                            inactiveTrackColor: greyColor,
                                          ),
                                          TextWidget(
                                            text: textValue6,
                                            size: 18,
                                            weight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextWidget(
                                          text: AnymemberswhoDrink,
                                          size: 18,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Switch(
                                            onChanged: toggleSwitch1,
                                            value: isSwitched7,
                                            activeColor: Colors.blue,
                                            activeTrackColor: greyColor,
                                            inactiveThumbColor: greyColor,
                                            inactiveTrackColor: greyColor,
                                          ),
                                          TextWidget(
                                            text: textValue7,
                                            size: 18,
                                            weight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextWidget(
                                          text: AnymemberswhouseTobacco,
                                          size: 18,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Switch(
                                            onChanged: toggleSwitch2,
                                            value: isSwitched8,
                                            activeColor: Colors.blue,
                                            activeTrackColor: greyColor,
                                            inactiveThumbColor: greyColor,
                                            inactiveTrackColor: greyColor,
                                          ),
                                          TextWidget(
                                            text: textValue8,
                                            size: 18,
                                            weight: FontWeight.w600,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                isActive: _currentStep >= 0,
                                state: _currentStep >= 3 ?
                                StepState.complete : StepState.disabled,
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),

          floatingActionButton: Padding(
            padding: const EdgeInsets.only(right:50.0,bottom: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  // isExtended: true,
                  child: Icon(Icons.keyboard_arrow_right,size: 30,color: darkColor,),
                  backgroundColor: lightColor,
                  onPressed: () {
                    setState(() {

                    });
                  },

                ),
                SizedBox(height: 10,),
                FloatingActionButton(
                  // isExtended: true,
                  child: Icon(Icons.done,size: 30,),
                  backgroundColor: primaryColor,
                  onPressed: () {
                    setState(() {
                      addData();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top:38.0),
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
                )
            ),
          ),
        )
      ],
    );
  }
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    // _currentStep < 2 ?
    // setState(() => _currentStep += 1): null;
    // debugPrint("_currentStep: $_currentStep");

    if(_currentStep < 1){
      setState(() {
        _currentStep += 1;
      });
    }else if(_currentStep < 2){
      setState(() {
        _currentStep += 1;
      });
    }else if(_currentStep < 3){
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
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;

  }

  void addData(){
    familyData.photo=photoVal;
    familyDataList.add(familyData);

    final User user = auth.currentUser;
    String uid = user.uid;

    api.createFamily(DemographicFamily(
      uid: uid,

      location: Location(formNo: formNoVal,projectCode: projectCodeVal,panchayatCode: panchayatCodeVal,panchayatNo:panchayatNoVal,contactPerson:contactPerson,
      doorNumber: doorNumberVal,noOfFamilyMembers:noOfFamilyMembersVal,streetName: streetName,villageName: villageNameVal,villagesCode:villageCodeVal),

      property: Property(dryLandInAcres: dryLandInAcresVal,fourWheeler: fourWheelerVal,livestockCount: livestockCountVal,livestockType:livestockTypeVal ,
      noOfVehicleOwn: noOfVehicleOwnVal,others: othersVal,ownLand: ownLandVal,ownLivestocks:ownLiveStocksVal ,ownVehicle:ownVehicleVal ,statusofHouse:statusOfHouseVal ,
      threeWheeler:threeWheelerVal,toiletFacility: toiletFacilityVal,twoWheeler:twoWheelerVal ,typeofHouse: typeofHouseVal,wetLandInAcres:wetLandInAcresVal ),

      habits: Habits(anyMembersWhoDrink: anyMembersWhoDrinkVal,anyMembersWhoSmoke: anyMembersWhoSmokeVal,anyMembersWhoUseTobacco: anyMembersWhoUseTobaccoVal),

      family: familyDataList

    )
    );
  }

  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        textValue = 'Yes';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
        textValue = 'No';
      });
      print('Switch Button is OFF');
    }
  }
  void toggleSwitch1(bool value) {

    if(isSwitched1 == false)
    {
      setState(() {
        isSwitched1 = true;
        textValue1 = 'Yes';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched1 = false;
        textValue1 = 'No';
      });
      print('Switch Button is OFF');
    }
  }
  void toggleSwitch2(bool value) {

    if(isSwitched2 == false)
    {
      setState(() {
        isSwitched2 = true;
        textValue2 = 'Yes';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched2= false;
        textValue2 = 'No';
      });
      print('Switch Button is OFF');
    }
  }
  void toggleSwitch3(bool value) {

    if(isSwitched3 == false)
    {
      setState(() {
        isSwitched3 = true;
        textValue3 = 'Yes';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched3 = false;
        textValue3 = 'No';
      });
      print('Switch Button is OFF');
    }
  }
  void toggleSwitch4(bool value) {

    if(isSwitched4 == false)
    {
      setState(() {
        isSwitched4 = true;
        textValue4 = 'Yes';
      });
    }
    else
    {
      setState(() {
        isSwitched4 = false;
        textValue4 = 'No';
      });
      //print('Switch Button is OFF');
    }
  }
  void toggleSwitch5(bool value) {

    if(isSwitched5 == false)
    {
      setState(() {
        isSwitched5 = true;
        textValue5 = 'Yes';
      });
    }
    else
    {
      setState(() {
        isSwitched5 = false;
        textValue5= 'No';
      });
      //print('Switch Button is OFF');
    }
  }
  void toggleSwitch6(bool value) {

    if(isSwitched6 == false)
    {
      setState(() {
        isSwitched6 = true;
        textValue6 = 'Yes';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched6 = false;
        textValue6 = 'No';
      });
      print('Switch Button is OFF');
    }
  }
  void toggleSwitch7(bool value) {

    if(isSwitched7 == false)
    {
      setState(() {
        isSwitched7 = true;
        textValue7 = 'Yes';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched7 = false;
        textValue7 = 'No';
      });
      print('Switch Button is OFF');
    }
  }
  void toggleSwitch8(bool value) {

    if(isSwitched8 == false)
    {
      setState(() {
        isSwitched8 = true;
        textValue8 = 'Yes';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched8 = false;
        textValue8 = 'No';
      });
      print('Switch Button is OFF');
    }
  }
}

