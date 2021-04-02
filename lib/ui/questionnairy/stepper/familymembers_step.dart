/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 2/4/21 3:27 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 2/4/21 3:27 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class FamilyMemberStep extends StatefulWidget {
  @override
  _FamilyMemberStepState createState() => _FamilyMemberStepState();
}

class _FamilyMemberStepState extends State<FamilyMemberStep> {
  GlobalKey<FormState> _stepTwoKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Form(
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
                            text: gender,
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
                    widthFactor: 0.75,
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
                            text: bloodGroup,
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
                            text: physicallyChallenged,
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
                            text: caste,
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

        ],
      ),
    );
  }
}
