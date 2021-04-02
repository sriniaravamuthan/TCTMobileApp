/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 3:21 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 3:21 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/familymembers_step.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/habit_step.dart';
import 'package:tct_demographics/ui/questionnairy/stepper/property_step.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class QuestionnairesScreen extends StatefulWidget {
  @override
  _QuestionnairesScreenState createState() => _QuestionnairesScreenState();
}

class _QuestionnairesScreenState extends State<QuestionnairesScreen> {
  int _currentStep = 0;
  FocusNode mailFocusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey<FormState> _stepTwoKey = new GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                                    text: panchayatNo,
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
                                                    text: panchayatCode,
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
                            content:FamilyMemberStep(),
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
                            content:PropertyDetailStep(),
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
                            content:HabitsStep(),
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
    );
  }
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }

  cancel() {
    // _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    // _stepTwoKey.currentState.reset();
    // _formKey.currentState.reset();
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;

  }
}
