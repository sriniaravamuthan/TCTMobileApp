/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 2/4/21 3:27 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 2/4/21 3:27 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class FamilyMemberStep extends StatefulWidget {
  @override
  _FamilyMemberStepState createState() => _FamilyMemberStepState();
}

class _FamilyMemberStepState extends State<FamilyMemberStep> {
  GlobalKey<FormState> _stepTwoKey = new GlobalKey<FormState>();
  bool isSwitched = false;
  var textValue = 'Yes';
  String dateofBirth;
  TextEditingController datePicker = TextEditingController();
  DateTime date = DateTime.parse("2019-04-16 12:18:06.018950");
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
                          //value: _chosenGender,
                          validator: (value) => value == null
                              ? 'Source Type must not be empty'
                              : null,
                          // onChanged: (value) =>
                          //     setState(() => _chosenGender = value),
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
                                      //value: _chosenGender,
                                      validator: (value) => value == null
                                          ? 'Source Type must not be empty'
                                          : null,
                                      // onChanged: (value) =>
                                      //     setState(() => _chosenGender = value),
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

                                        dateofBirth = datePicker.text;
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
                                      //value: _chosenGender,
                                      validator: (value) => value == null
                                          ? 'Source Type must not be empty'
                                          : null,
                                      // onChanged: (value) =>
                                      //     setState(() => _chosenGender = value),
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
                                      //value: _chosenGender,
                                      validator: (value) => value == null
                                          ? 'Source Type must not be empty'
                                          : null,
                                      // onChanged: (value) =>
                                      //     setState(() => _chosenGender = value),
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
                                          value: isSwitched,
                                          activeColor: Colors.blue,
                                          activeTrackColor: greyColor,
                                          inactiveThumbColor: greyColor,
                                          inactiveTrackColor: greyColor,
                                        ),
                                        TextWidget(
                                          text: "No",
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

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Expanded(
          //       child: Align(
          //         alignment:Alignment.topLeft,
          //         child: FractionallySizedBox(
          //           widthFactor: 0.75,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: TextWidget(
          //                   text: gender,
          //                   size: 18,
          //                   weight: FontWeight.w600,
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: DropdownButtonFormField<String>(
          //                   isExpanded: true,
          //                   decoration: InputDecoration(
          //                     border: new OutlineInputBorder(
          //                       borderSide: BorderSide.none,
          //                       borderRadius:
          //                       BorderRadius.only(topRight :Radius.circular(50.0),
          //                           bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                     ),
          //                     enabledBorder: OutlineInputBorder(
          //                       borderRadius:
          //                       BorderRadius.only(topRight :Radius.circular(50.0),
          //                           bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                       borderSide:
          //                       BorderSide(color: lightGreyColor),
          //                     ),
          //
          //                     errorBorder: OutlineInputBorder(
          //                       borderRadius:
          //                       BorderRadius.only(topRight :Radius.circular(50.0),
          //                           bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                       borderSide:
          //                       BorderSide(color: lightGreyColor),
          //                     ),
          //                   ),
          //                   //value: _chosenGender,
          //                   validator: (value) => value == null
          //                       ? 'Source Type must not be empty'
          //                       : null,
          //                   // onChanged: (value) =>
          //                   //     setState(() => _chosenGender = value),
          //                   items: <String>[
          //                     'Male',
          //                     'Female',
          //                     'Others',
          //                   ].map<DropdownMenuItem<String>>(
          //                           (String value) {
          //                         return DropdownMenuItem<String>(
          //                           value: value,
          //                           child: TextWidget(
          //                             text: value,
          //                             color: darkColor,
          //                             weight: FontWeight.w400,
          //                             size: 16,
          //                           ),
          //                         );
          //                       }).toList(),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Align(
          //         alignment: Alignment(-3.0,0.2),
          //         child: FractionallySizedBox(
          //           widthFactor: 0.75,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: TextWidget(
          //                   text: dateOfBirth,
          //                   size: 18,
          //                   weight: FontWeight.w600,
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: TextFormField(
          //                   textInputAction: TextInputAction.next,
          //                   autocorrect: true,
          //                   controller: datePicker,
          //                   enableSuggestions: true,
          //                   decoration: InputDecoration(
          //                       border: new OutlineInputBorder(
          //                         borderSide: BorderSide.none,
          //                         borderRadius:
          //                         BorderRadius.only(topRight :Radius.circular(50.0),
          //                             bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                       ),
          //                       enabledBorder: OutlineInputBorder(
          //                         borderRadius:
          //                         BorderRadius.only(topRight :Radius.circular(50.0),
          //                             bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                         borderSide:
          //                         BorderSide(color: lightGreyColor),
          //                       ),
          //                       focusedBorder: OutlineInputBorder(
          //                         borderRadius:
          //                         BorderRadius.only(topRight :Radius.circular(50.0),
          //                             bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                         borderSide:
          //                         BorderSide(color: lightGreyColor),
          //                       ),
          //                       focusedErrorBorder: OutlineInputBorder(
          //                         borderRadius:
          //                         BorderRadius.only(topRight :Radius.circular(50.0),
          //                             bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                         borderSide:
          //                         BorderSide(color: lightGreyColor),
          //                       ),
          //                       errorBorder: OutlineInputBorder(
          //                         borderRadius:
          //                         BorderRadius.only(topRight :Radius.circular(50.0),
          //                             bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                         borderSide:
          //                         BorderSide(color: lightGreyColor),
          //                       ),
          //                       fillColor: lightGreyColor),
          //                   keyboardType: TextInputType.text,
          //                   onSaved: (String val) {
          //                     setState(() {});
          //                   },
          //                   onTap: () async {
          //                     FocusScope.of(context)
          //                         .requestFocus(new FocusNode());
          //
          //                     date = await showDatePicker(
          //                         context: context,
          //                         initialDate: DateTime.now(),
          //                         firstDate: DateTime(1900),
          //                         lastDate: DateTime(2022));
          //
          //                     datePicker.text =
          //                     "${date.year}/${date.month}/${date.day}";
          //
          //                      dateofBirth = datePicker.text;
          //                   },
          //                   validator: (value) {
          //                     if (value.isEmpty) {
          //                       debugPrint("empid :yes");
          //                       return 'Employee Id must not be empty';
          //                     }
          //                     return null;
          //                   },
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Align(
          //         alignment: Alignment(-5.0,0.2),
          //         child: FractionallySizedBox(
          //           widthFactor: 0.75,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: TextWidget(
          //                   text: "Age",
          //                   size: 18,
          //                   weight: FontWeight.w600,
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: TextFormField(
          //                   textInputAction: TextInputAction.next,
          //                   autocorrect: true,
          //                   enableSuggestions: true,
          //                   decoration: InputDecoration(
          //                       border: new OutlineInputBorder(
          //                         borderSide: BorderSide.none,
          //                         borderRadius:
          //                         BorderRadius.only(topRight :Radius.circular(50.0),
          //                             bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                       ),
          //                       enabledBorder: OutlineInputBorder(
          //                         borderRadius:
          //                         BorderRadius.only(topRight :Radius.circular(50.0),
          //                             bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                         borderSide:
          //                         BorderSide(color: lightGreyColor),
          //                       ),
          //                       focusedBorder: OutlineInputBorder(
          //                         borderRadius:
          //                         BorderRadius.only(topRight :Radius.circular(50.0),
          //                             bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                         borderSide:
          //                         BorderSide(color: lightGreyColor),
          //                       ),
          //                       focusedErrorBorder: OutlineInputBorder(
          //                         borderRadius:
          //                         BorderRadius.only(topRight :Radius.circular(50.0),
          //                             bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                         borderSide:
          //                         BorderSide(color: lightGreyColor),
          //                       ),
          //                       errorBorder: OutlineInputBorder(
          //                         borderRadius:
          //                         BorderRadius.only(topRight :Radius.circular(50.0),
          //                             bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                         borderSide:
          //                         BorderSide(color: lightGreyColor),
          //                       ),
          //                       fillColor: lightGreyColor),
          //                   keyboardType: TextInputType.text,
          //                   onSaved: (String val) {
          //                     setState(() {});
          //                   },
          //                   validator: (value) {
          //                     if (value.isEmpty) {
          //                       debugPrint("empid :yes");
          //                       return 'Employee Id must not be empty';
          //                     }
          //                     return null;
          //                   },
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Expanded(
          //       child: Align(
          //         alignment:Alignment.topLeft,
          //         child: FractionallySizedBox(
          //           widthFactor: 0.75,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: TextWidget(
          //                   text: maritalStatus,
          //                   size: 18,
          //                   weight: FontWeight.w600,
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: DropdownButtonFormField<String>(
          //                   isExpanded: true,
          //                   decoration: InputDecoration(
          //                     border: new OutlineInputBorder(
          //                       borderSide: BorderSide.none,
          //                       borderRadius:
          //                       BorderRadius.only(topRight :Radius.circular(50.0),
          //                           bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                     ),
          //                     enabledBorder: OutlineInputBorder(
          //                       borderRadius:
          //                       BorderRadius.only(topRight :Radius.circular(50.0),
          //                           bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                       borderSide:
          //                       BorderSide(color: lightGreyColor),
          //                     ),
          //
          //                     errorBorder: OutlineInputBorder(
          //                       borderRadius:
          //                       BorderRadius.only(topRight :Radius.circular(50.0),
          //                           bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                       borderSide:
          //                       BorderSide(color: lightGreyColor),
          //                     ),
          //                   ),
          //                   //value: _chosenGender,
          //                   validator: (value) => value == null
          //                       ? 'Source Type must not be empty'
          //                       : null,
          //                   // onChanged: (value) =>
          //                   //     setState(() => _chosenGender = value),
          //                   items: <String>[
          //                     'Male',
          //                     'Female',
          //                     'Others',
          //                   ].map<DropdownMenuItem<String>>(
          //                           (String value) {
          //                         return DropdownMenuItem<String>(
          //                           value: value,
          //                           child: TextWidget(
          //                             text: value,
          //                             color: darkColor,
          //                             weight: FontWeight.w400,
          //                             size: 16,
          //                           ),
          //                         );
          //                       }).toList(),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Align(
          //         alignment: Alignment(-3.0,0.2),
          //         child: FractionallySizedBox(
          //           widthFactor: 0.75,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: TextWidget(
          //                   text: bloodGroup,
          //                   size: 18,
          //                   weight: FontWeight.w600,
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: DropdownButtonFormField<String>(
          //                   isExpanded: true,
          //                   decoration: InputDecoration(
          //                     border: new OutlineInputBorder(
          //                       borderSide: BorderSide.none,
          //                       borderRadius:
          //                       BorderRadius.only(topRight :Radius.circular(50.0),
          //                           bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                     ),
          //                     enabledBorder: OutlineInputBorder(
          //                       borderRadius:
          //                       BorderRadius.only(topRight :Radius.circular(50.0),
          //                           bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                       borderSide:
          //                       BorderSide(color: lightGreyColor),
          //                     ),
          //
          //                     errorBorder: OutlineInputBorder(
          //                       borderRadius:
          //                       BorderRadius.only(topRight :Radius.circular(50.0),
          //                           bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
          //                       borderSide:
          //                       BorderSide(color: lightGreyColor),
          //                     ),
          //                   ),
          //                   //value: _chosenGender,
          //                   validator: (value) => value == null
          //                       ? 'Source Type must not be empty'
          //                       : null,
          //                   // onChanged: (value) =>
          //                   //     setState(() => _chosenGender = value),
          //                   items: <String>[
          //                     'Male',
          //                     'Female',
          //                     'Others',
          //                   ].map<DropdownMenuItem<String>>(
          //                           (String value) {
          //                         return DropdownMenuItem<String>(
          //                           value: value,
          //                           child: TextWidget(
          //                             text: value,
          //                             color: darkColor,
          //                             weight: FontWeight.w400,
          //                             size: 16,
          //                           ),
          //                         );
          //                       }).toList(),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Align(
          //         alignment: Alignment(-5.0,0.2),
          //         child: FractionallySizedBox(
          //           widthFactor: 0.75,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: TextWidget(
          //                   text: physicallyChallenged,
          //                   size: 18,
          //                   weight: FontWeight.w600,
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                   child:Row(
          //                     children: [
          //                       Switch(
          //                         onChanged: toggleSwitch,
          //                         value: isSwitched,
          //                         activeColor: Colors.blue,
          //                         activeTrackColor: greyColor,
          //                         inactiveThumbColor: greyColor,
          //                         inactiveTrackColor: greyColor,
          //                       ),
          //                       TextWidget(
          //                         text: "No",
          //                         size: 18,
          //                         weight: FontWeight.w600,
          //                       ),
          //                     ],
          //                   ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
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
                            //value: _chosenGender,
                            validator: (value) => value == null
                                ? 'Source Type must not be empty'
                                : null,
                            // onChanged: (value) =>
                            //     setState(() => _chosenGender = value),
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
                            //value: _chosenGender,
                            validator: (value) => value == null
                                ? 'Source Type must not be empty'
                                : null,
                            // onChanged: (value) =>
                            //     setState(() => _chosenGender = value),
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
                                onChanged: toggleSwitch,
                                value: isSwitched,
                                activeColor: Colors.blue,
                                activeTrackColor: greyColor,
                                inactiveThumbColor: greyColor,
                                inactiveTrackColor: greyColor,
                              ),
                              TextWidget(
                                text: "No",
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
                            //value: _chosenGender,
                            validator: (value) => value == null
                                ? 'Source Type must not be empty'
                                : null,
                            // onChanged: (value) =>
                            //     setState(() => _chosenGender = value),
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
                            //value: _chosenGender,
                            validator: (value) => value == null
                                ? 'Source Type must not be empty'
                                : null,
                            // onChanged: (value) =>
                            //     setState(() => _chosenGender = value),
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
            ],
          ),

        ],
      ),
    );
  }
  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }
}
