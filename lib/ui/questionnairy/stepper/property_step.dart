/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 2/4/21 6:23 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 2/4/21 6:23 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class PropertyDetailStep extends StatefulWidget {
  @override
  _PropertyDetailStepState createState() => _PropertyDetailStepState();
}

class _PropertyDetailStepState extends State<PropertyDetailStep> {
  GlobalKey<FormState> _stepThreeKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Form(
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
                            text: ownsanyLand,
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
    );
  }
}
