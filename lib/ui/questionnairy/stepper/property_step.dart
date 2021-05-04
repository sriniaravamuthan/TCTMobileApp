/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 2/4/21 6:23 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 2/4/21 6:23 PM by Kanmalai.
 * /
 */

import 'dart:collection';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
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
  DemographicFamily demographicFamily;
  Property property = new Property();
  GlobalKey<FormState> _stepThreeKey = new GlobalKey<FormState>();
  String toilet = 'No';
  String land = 'No';
  String vehicle = 'No';
  String liveStock = 'No';

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
  List statusHouseListLang;
  List typeHouseList;
  List typeHouseListLang;

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

      if (property.toiletFacility == 0)
        toilet = "Not Answer";
      else if (property.toiletFacility == 1)
        toilet = "No";
      else
        toilet = "Yes";

      if (property.ownLand == 0)
        land = "Not Answer";
      else if (property.ownLand == 1)
        land = "No";
      else
        land = "Yes";

      if (property.ownVehicle == 0)
        vehicle = "Not Answer";
      else if (property.ownVehicle == 1)
        vehicle = "No";
      else
        vehicle = "Yes";

      if (property.ownLivestocks == 0)
        liveStock = "Not Answer";
      else if (property.ownLivestocks == 1)
        liveStock = "No";
      else
        liveStock = "Yes";

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
                          padding: const EdgeInsets.only(
                              left: 2.0, right: 16.0, top: 2.0, bottom: 2.0),
                          child: AutoCompleteTextField(
                              controller: statusHouseController,
                              clearOnSubmit: false,
                              itemSubmitted: (item) {
                                statusHouseController.text = item;
                                property.statusofHouse = item;
                              },
                              suggestions: statusHouseListLang,
                              style: TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
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
                          padding: const EdgeInsets.only(
                              right: 16.0, top: 2.0, bottom: 2.0),
                          child: AutoCompleteTextField(
                              controller: typeHouseController,
                              clearOnSubmit: false,
                              itemSubmitted: (item) {
                                typeHouseController.text = item;
                                property.typeofHouse = item;
                              },
                              suggestions: typeHouseListLang,
                              style: TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
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
                  widthFactor: 1,
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
                          height: 58,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 2.0, right: 16.0, top: 2.0, bottom: 2.0),
                            child: TextFormField(
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
                        width: 100,
                        height: 58,
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
                            width: 100,
                            height: 58,
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
                            width: 100,
                            height: 58,
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
                          width: 100,
                          height: 58,
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
                          width: 100,
                          height: 58,
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
                          width: 100,
                          height: 58,
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
                    widthFactor: 0.75,
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
                            right: 16.0, top: 2.0, bottom: 2.0),
                        child: SizedBox(
                          height: 58,
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
                          height: 58,
                          child: TextFormField(
                            controller: stockCountController,
                            onChanged: (value) {
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
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
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
        statusHouseListLang.add(statusOfHouseVal);
        debugPrint("stringList:$statusHouseListLang");
      }
    });
  }

  getTypeHouse() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionTypeHouse).get();
    typeHouseList = querySnapshot.docs.map((doc) => doc.data()).toList();
    typeHouseList.forEach((element) {
      LinkedHashMap<String, dynamic> typeHouseData =
          element[collectionTypeHouse];
      debugPrint("typeHouseData:$typeHouseData");
      if (typeHouseData != null) {
        typeofHouseVal = typeHouseData[language];
        typeHouseListLang.add(typeofHouseVal);
        debugPrint("stringList:$typeHouseListLang");
      }
    });
  }

  void getLanguage() async {
    language = await SharedPref().getStringPref(SharedPref().language);
    debugPrint("language:$language");
    getStatusHouse();
    getTypeHouse();
  }

  void toggleToilet(double value) {
    property.toiletFacility = value;
    setState(() {
      if (value == 0)
        toilet = 'Not Answer';
      else if (value == 1)
        toilet = 'No';
      else
        toilet = 'Yes';
    });
  }

  void toggleOwnLand(double value) {
    property.ownLand = value;
    setState(() {
      if (value == 0)
        land = 'Not Answer';
      else if (value == 1)
        land = 'No';
      else
        land = 'Yes';
    });
  }

  void toggleOwnVehicle(double value) {
    property.ownVehicle = value;
    setState(() {
      if (value == 0)
        vehicle = 'Not Answer';
      else if (value == 1)
        vehicle = 'No';
      else
        vehicle = 'Yes';
    });
  }

  void toggleOwnLivestocks(double value) {
    property.ownLivestocks = value;
    setState(() {
      if (value == 0)
        liveStock = 'Not Answer';
      else if (value == 1)
        liveStock = 'No';
      else
        liveStock = 'Yes';
    });
  }
}
