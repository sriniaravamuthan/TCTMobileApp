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
                  Container(
                    height: 500,
                    child: Stepper(
                      type: StepperType.horizontal,
                      currentStep: this._currentStep,
                      onStepTapped: (step) => tapped(step),
                      onStepContinue: continued,
                      onStepCancel: cancel,
                      steps: <Step> [
                        Step(
                          title: TextWidget(
                            text: location,
                            color: darkColor,
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                          content: Form(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        TextWidget(
                                          text: "Form No",
                                          size: 18,
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                        ),
                                        TextFormField(
                                          focusNode: mailFocusNode,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            labelText: userName,
                                            labelStyle: TextStyle(
                                                color: mailFocusNode.hasFocus
                                                    ? primaryColor
                                                    : Colors.black45),
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
                                              borderSide: BorderSide(color: lightGreyColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.only(topRight :Radius.circular(10.0),
                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                              borderSide: BorderSide(color: lightGreyColor),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.only(topRight :Radius.circular(10.0),
                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                              borderSide: BorderSide(color: lightGreyColor),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.only(topRight :Radius.circular(10.0),
                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                              borderSide: BorderSide(color: lightGreyColor),
                                            ),
                                          ),
                                          onSaved: (String val) {
                                            setState(() {

                                            });
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter a  mobile or email!';
                                            }
                                            // else if(value.isNotEmpty){
                                            //     Pattern pattern =
                                            //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                            //     RegExp regex = new RegExp(pattern);
                                            //     if(!regex.hasMatch(value)){
                                            //       return 'Enter a valid mail!';
                                            //     }
                                            // }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        TextWidget(
                                          text: "Project Code",
                                          size: 18,
                                          weight: FontWeight.w400,
                                          color: darkColor,
                                        ),
                                        TextFormField(
                                          focusNode: mailFocusNode,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            labelText: userName,
                                            labelStyle: TextStyle(
                                                color: mailFocusNode.hasFocus
                                                    ? primaryColor
                                                    : Colors.black45),
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
                                              borderSide: BorderSide(color: lightGreyColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.only(topRight :Radius.circular(10.0),
                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                              borderSide: BorderSide(color: lightGreyColor),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.only(topRight :Radius.circular(10.0),
                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                              borderSide: BorderSide(color: lightGreyColor),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.only(topRight :Radius.circular(10.0),
                                                  bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                              borderSide: BorderSide(color: lightGreyColor),
                                            ),
                                          ),
                                          onSaved: (String val) {
                                            setState(() {

                                            });
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter a  mobile or email!';
                                            }
                                            // else if(value.isNotEmpty){
                                            //     Pattern pattern =
                                            //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                            //     RegExp regex = new RegExp(pattern);
                                            //     if(!regex.hasMatch(value)){
                                            //       return 'Enter a valid mail!';
                                            //     }
                                            // }
                                            return null;
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
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
    //setState(() => _currentStep = step);
  }

  continued() {
    // if (_currentStep < 1) {
    //   setState(() {
    //     if (_formKey.currentState.validate()) {
    //       if (_formKey != null) {
    //         _formKey.currentState.save();
    //         _currentStep += 1;
    //       }
    //     }
    //   });
    // } else if (_currentStep >= 1) {
    //   setState(() {
    //     if (_stepTwoKey.currentState.validate()) {
    //       if (_stepTwoKey != null) {
    //         _stepTwoKey.currentState.save();
    //
    //       }
    //     }
    //   });
    // }
    // _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    // _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    // _stepTwoKey.currentState.reset();
    // _formKey.currentState.reset();

  }
}
