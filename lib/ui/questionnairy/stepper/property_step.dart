/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 2/4/21 6:23 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 2/4/21 6:23 PM by Kanmalai.
 * /
 */

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/models/data_model.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class PropertyDetailStep extends StatefulWidget {
  DemographicFamily demographicFamily;

  PropertyDetailStep(this.demographicFamily);

  @override
  _PropertyDetailStepState createState() =>
      _PropertyDetailStepState(demographicFamily);
}

class _PropertyDetailStepState extends State<PropertyDetailStep> {
  GlobalKey<FormState> _stepThreeKey = new GlobalKey<FormState>();
  DemographicFamily demographicFamily;
  Property property = new Property();
  String toilet = "";
  String land = "";
  String vehicle = "";
  String liveStock = "";
  bool isAuto=true;
  bool houseStatus = false, houseType = false;
  var statusHouseController = TextEditingController();
  var typeHouseController = TextEditingController();
  var wetLandController = TextEditingController();
  var dryLandController = TextEditingController();
  var motorVehicleController = TextEditingController();
  var twoWheelerController = TextEditingController();
  var threeWheelerController = TextEditingController();
  var fourWheelerController = TextEditingController();
  var othersController = TextEditingController();
  var stockTypeController = TextEditingController();
  var stockCountController = TextEditingController();

  String statusOfHouseVal, typeofHouseVal, livestockTypeVal;

  String language;
  List statusHouseList;
  List<String> statusHouseListLang;
  List typeHouseList;
  List<String> typeHouseListLang;
  List<int> typeHouseListStr;

  _PropertyDetailStepState(this.demographicFamily);

  @override
  void initState() {
    statusHouseList = [];
    statusHouseListLang = [];
    typeHouseList = [];
    typeHouseListLang = [];
    getLanguage();

    if (demographicFamily.property != null) {
      property = demographicFamily.property;
      debugPrint("property:${demographicFamily.property}");

      statusHouseController.text = property.statusofHouse;
      typeHouseController.text = property.typeofHouse;

      if(property.statusofHouse != "")
        houseStatus = true;
      if(property.typeofHouse != "")
        houseType = true;

      wetLandController.text = property.wetLandInAcres.toString();
      dryLandController.text = property.dryLandInAcres.toString();
      motorVehicleController.text = property.noOfVehicleOwn.toString();
      twoWheelerController.text = property.twoWheeler.toString();
      threeWheelerController.text = property.threeWheeler.toString();
      fourWheelerController.text = property.fourWheeler.toString();
      othersController.text = property.others.toString();
      stockTypeController.text = property.livestockType.toString();
      stockCountController.text = property.livestockCount.toString();
    } else {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _stepThreeKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
                        padding: const EdgeInsets.all(2.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Status of House'),
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 58,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 16.0,top:1,bottom: 1),

                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              autofocus: true,
                               hint: statusHouseController.text == "" ? Text("") : Text(statusHouseController.text),
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
                              onChanged: (newVal) {
                                statusHouseController.text = newVal;
                                property.statusofHouse = newVal;
                                this.setState(() {});
                              },
                              items: statusHouseListLang.map<DropdownMenuItem<String>>((String value) {
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
                          // child :DropdownButton<String>(
                          //     items: statusHouseListLang.map((String val) {
                          //       return new DropdownMenuItem<String>(
                          //         value: val,
                          //         child: new Text(val),
                          //       );
                          //     }).toList(),
                          //     isExpanded: true,
                          //     hint: statusHouseController.text == "" ? Text("select") : Text(statusHouseController.text),
                          //     onChanged: (newVal) {
                          //       statusHouseController.text = newVal;
                          //       property.statusofHouse = newVal;
                          //       this.setState(() {});
                          //     }),
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
                        padding: const EdgeInsets.all(2.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Type of House'),
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 58,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 2.0, right: 16.0,top:1,bottom: 1),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              autofocus: true,
                              hint: typeHouseController.text == "" ? Text("") : Text(typeHouseController.text),

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
                              // value: communityVal,
                              onChanged: (newVal) {
                                typeHouseController.text = newVal.toString();
                                property.typeofHouse = newVal;
                                this.setState(() {});
                              },
                              items: typeHouseListLang
                                  .map<DropdownMenuItem<String>>(
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
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 1.05,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Toilet Facility at Home'),
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
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 28.0),
                            ),
                            child: Slider(
                              value: property.toiletFacility,
                              min: 0,
                              max: 2,
                              divisions: 2,
                              onChanged: (value) {
                                toggleToilet(value);
                              },
                            ),
                          ),
                          TextWidget(
                            text: toilet,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Own Land'),
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
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 28.0),
                            ),
                            child: Slider(
                              value: property.ownLand,
                              min: 0,
                              max: 2,
                              divisions: 2,
                              onChanged: (value) {
                                toggleOwnLand(value);
                              },
                            ),
                          ),
                          TextWidget(
                            text: land,
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
                                .translate('Wet Land Holding(In Acres)'),
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 2.0, right: 16.0, top: 2.0, bottom: 2.0),
                            child: TextFormField(
                              // autofocus:isAuto,
                              controller: wetLandController,
                              maxLength: 2,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                property.wetLandInAcres = value;
                              },
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
                              // onSaved: (String val) {
                              //   setState(() {
                              //     wetLandInAcresVal =val;
                              //   });
                              // },
                              onSaved: (value) {
                                setState(() {
                                  property.wetLandInAcres = value;
                                  wetLandController.text = value;
                                });
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
                        padding: const EdgeInsets.all(2.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Dry Land Holding(In Acres)'),
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, top: 2.0, bottom: 2.0),
                          child: TextFormField(
                            controller: dryLandController,
                            onChanged: (value) {
                              property.dryLandInAcres = value;
                            },
                            maxLength: 2,
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
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
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
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Own Vehicle'),
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
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 28.0),
                            ),
                            child: Slider(
                              value: property.ownVehicle,
                              min: 0,
                              max: 2,
                              divisions: 2,
                              onChanged: (value) {
                                toggleOwnVehicle(value);
                              },
                            ),
                          ),
                          TextWidget(
                            text: vehicle,
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
                            text: DemoLocalization.of(context).translate(
                                'Number of various Motor vehicles owned'),
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, top: 2.0, bottom: 2.0),
                              child: TextFormField(
                                controller: motorVehicleController,
                                onChanged: (value) {
                                  property.noOfVehicleOwn = value;
                                },
                                maxLength: 2,
                                textInputAction: TextInputAction.next,
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
                                keyboardType: TextInputType.number,
                                onSaved: (String val) {
                                  setState(() {});
                                },
                              ),
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
                                .translate('Two Wheeler'),
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 2.0, right: 16.0, top: 2.0, bottom: 2.0),
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: TextFormField(
                              controller: twoWheelerController,
                              onChanged: (value) {
                                property.twoWheeler = value;
                              },
                              maxLength: 2,
                              textInputAction: TextInputAction.next,
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
                              .translate('Three Wheeler'),
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, top: 2.0, bottom: 2.0),
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: TextFormField(
                            controller: threeWheelerController,
                            onChanged: (value) {
                              property.threeWheeler = value;
                            },
                            maxLength: 2,
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
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
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
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Four Wheeler'),
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, top: 2.0, bottom: 2.0),
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: TextFormField(
                            controller: fourWheelerController,
                            onChanged: (value) {
                              property.fourWheeler = value;
                            },
                            maxLength: 2,
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
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
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
                        child: TextWidget(
                          text:
                              DemoLocalization.of(context).translate('Others'),
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, top: 2.0, bottom: 2.0),
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: TextFormField(
                            controller: othersController,
                            onChanged: (value) {
                              property.others = value;
                            },
                            maxLength: 2,
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
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Livestock Details'),
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
                                value: property.ownLivestocks,
                                min: 0,
                                max: 2,
                                divisions: 2,
                                onChanged: (value) {
                                  toggleOwnLivestocks(value);
                                },
                              ),
                            ),
                            TextWidget(
                              text: liveStock,
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
                child: FractionallySizedBox(
                  widthFactor: 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Livestock Type'),
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0),
                        child: SizedBox(
                          height: 54,
                          width: 250,
                          child: TextFormField(
                            controller: stockTypeController,
                            onChanged: (value) {
                              property.livestockType = value;
                            },
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
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
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
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Livestock Count'),
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, top: 2.0, bottom: 2.0),
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: stockCountController,
                            onChanged: (value) {
                              isAuto=false;
                              property.livestockCount = value;
                            },
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
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: lightGreyColor),
                                ),
                                fillColor: lightGreyColor),
                            keyboardType: TextInputType.number,
                            onSaved: (String val) {
                              setState(() {
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  getStatusHouse() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionStatusHouse).get();
    statusHouseList = querySnapshot.docs.map((doc) => doc.data()).toList();
    statusHouseList.forEach((element) {
      LinkedHashMap<String, dynamic> statusHouseData = element[mapStatusHouse];
      debugPrint("statusHouseData:$statusHouseData");
      if (statusHouseData != null) {
        statusOfHouseVal = statusHouseData[language];
        setState(() {
          statusHouseListLang.add(statusOfHouseVal);
        });
        debugPrint("stringList:$statusHouseListLang");
      }
    });
  }

  getTypeHouse() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionTypeHouse).get();
    typeHouseList = querySnapshot.docs.map((doc) => doc.data()).toList();
    // typeHouseListLang.add("select");
    typeHouseList.forEach((element) {
      LinkedHashMap<String, dynamic> typeHouseData =
          element[collectionTypeHouse];
      debugPrint("typeHouseData:$typeHouseData");
      if (typeHouseData != null) {
        typeofHouseVal = typeHouseData[language];
        setState(() {
          typeHouseListLang.add(typeofHouseVal);

        });
      }
    });

  }

  void getLanguage() async {
    language = await SharedPref().getStringPref(SharedPref().language);
    debugPrint("language:$language");
    toilet = DemoLocalization.of(context).translate('Not Answer');
    land = DemoLocalization.of(context).translate('Not Answer');
    vehicle = DemoLocalization.of(context).translate('Not Answer');
    liveStock = DemoLocalization.of(context).translate('Not Answer');

    if (demographicFamily.property != null) {
      property = demographicFamily.property;
      debugPrint("property:${demographicFamily.property}");

      if (property.toiletFacility == 0)
        toilet = DemoLocalization.of(context).translate('Not Answer');
      else if (property.toiletFacility == 1)
        toilet = DemoLocalization.of(context).translate('No');
      else
        toilet = DemoLocalization.of(context).translate('Yes');

      if (property.ownLand == 0)
        land = DemoLocalization.of(context).translate('Not Answer');
      else if (property.ownLand == 1)
        land = DemoLocalization.of(context).translate('No');
      else
        land = DemoLocalization.of(context).translate('Yes');

      if (property.ownVehicle == 0)
        vehicle = DemoLocalization.of(context).translate('Not Answer');
      else if (property.ownVehicle == 1)
        vehicle = DemoLocalization.of(context).translate('No');
      else
        vehicle = DemoLocalization.of(context).translate('Yes');

      if (property.ownLivestocks == 0)
        liveStock = DemoLocalization.of(context).translate('Not Answer');
      else if (property.ownLivestocks == 1)
        liveStock = DemoLocalization.of(context).translate('No');
      else
        liveStock = DemoLocalization.of(context).translate('Yes');

      statusHouseController.text = property.statusofHouse;
      typeHouseController.text = property.typeofHouse;

      wetLandController.text = property.wetLandInAcres.toString();
      dryLandController.text = property.dryLandInAcres.toString();
      motorVehicleController.text = property.noOfVehicleOwn.toString();
      twoWheelerController.text = property.twoWheeler.toString();
      threeWheelerController.text = property.threeWheeler.toString();
      fourWheelerController.text = property.fourWheeler.toString();
      othersController.text = property.others.toString();
      stockTypeController.text = property.livestockType.toString();
      stockCountController.text = property.livestockCount.toString();
    }

    getStatusHouse();
    getTypeHouse();

    setState(() {});
  }

  void toggleToilet(double value) {
    property.toiletFacility = value;
    setState(() {
      if (value == 0)
        toilet = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        toilet = DemoLocalization.of(context).translate('No');
      else
        toilet = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleOwnLand(double value) {
    property.ownLand = value;
    setState(() {
      if (value == 0)
        land = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        land = DemoLocalization.of(context).translate('No');
      else
        land = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleOwnVehicle(double value) {
    property.ownVehicle = value;
    setState(() {
      if (value == 0)
        vehicle = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        vehicle = DemoLocalization.of(context).translate('No');
      else
        vehicle = DemoLocalization.of(context).translate('Yes');
    });
  }

  void toggleOwnLivestocks(double value) {
    property.ownLivestocks = value;
    setState(() {
      if (value == 0)
        liveStock = DemoLocalization.of(context).translate('Not Answer');
      else if (value == 1)
        liveStock = DemoLocalization.of(context).translate('No');
      else
        liveStock = DemoLocalization.of(context).translate('Yes');
    });
  }

}
