/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 5:36 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 5:36 PM by Kanmalai.
 * /
 */

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/models/data_model.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/ui/dialog/alert_dialog.dart';
import 'package:tct_demographics/ui/dialog/search_dialog.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/util/snack_bar.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenScreenState createState() => _HomeScreenScreenState();
}

class _HomeScreenScreenState extends State<HomeScreen> {
  BuildContext context;
  CollectionReference demographydata =
      FirebaseFirestore.instance.collection('users');
  var deleteLength;
  var demoLength = 0;
  List users = [];
  String language;
  String dropDownLang;
  var height, width;
  String userName = "";
  String userMail = "";
  int age = 0;
  String villageRef = "";
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String mobileNo;
  bool loadMore = false;
  bool isLoading = false;
  List<DemographicFamily> _demographicList = [];
  CollectionReference collectionReference;
  Query query;
  List<String> streets = [];
  List<String> documentId = [];
  bool loadData = true;

  @override
  void initState() {
    getLanguage();
    if (firebaseAuth.currentUser != null) {
      userName = firebaseAuth.currentUser.displayName;
      userMail = firebaseAuth.currentUser.email;

      debugPrint("userEmail:${firebaseAuth.currentUser}");
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    query = firestoreInstance.collection('demographicData').limit(30);
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<DocumentSnapshot> getVillageDetail(
      DocumentReference villageCode) async {
    DocumentSnapshot snapShot =
        await FirebaseFirestore.instance.doc(villageCode.path).get();
    return snapShot;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: SvgPicture.asset(
                    svgTctLogo,
                    semanticsLabel: "Logo",
                    height: 40,
                    width: 50,
                    fit: BoxFit.contain,
                    allowDrawingOutsideViewBox: true,
                  ),
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
                                ? Image.asset(user, fit: BoxFit.fill)
                                : Image.network(
                                    firebaseAuth.currentUser.photoURL)),
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
                    AuthenticationService(FirebaseAuth.instance)
                        .signOut(context);
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
      body: StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError && !loadMore) {
            return Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting &&
              !loadMore) {
            return Center(child: CircularProgressIndicator());
          } else {
            var mainDemograpicData =
                snapshot.data.docs.map((doc) => doc).toList();
            if (loadData &&
                snapshot.connectionState == ConnectionState.active) {
              isLoading = false;
              if (!loadMore) {
                streets.clear();
                documentId.clear();
                _demographicList.clear();
                users.clear();
              }

              mainDemograpicData.forEach((element) async {
                HashMap data = new HashMap();
                data["status"] = true; //  True -> Complete, false -> InProgress
                if (element["Location"]["name"] != null) {
                  data["name"] = element["Location"]["name"];
                } else {
                  data["name"] = "";
                }
                data["formNo"] = element["Location"]["formNo"];

                data["mobileNumber"] = element["Location"]["contactNumber"];

                List family = element['familyMembers'];
                for (int i = 0; i < family.length; i++) {
                  if (family[i]["name"] == data["name"]) {
                    data["mobileNumber"] = family[i]["mobileNumber"];
                    break;
                  }
                }
                data["age"] = family.length.toString();
                debugPrint("familylist length:${family.length}");
                if (data["name"] == "") data["name"] = " ";
                if (data["mobileNumber"] == "") data["mobileNumber"] = "-";

                DemographicFamily demographicData = DemographicFamily();
                Location locationList = Location();
                Property propertyList = Property();
                Habits habitsList = Habits();
                List<Family> _familyList = [];
                locationList.contactPerson =
                    element["Location"]["contactPerson"];
                locationList.name = element["Location"]["name"];
                debugPrint("contactPerson:${locationList.contactPerson}");
                locationList.contactNumber =
                    element["Location"]["contactNumber"];
                locationList.doorNumber =
                    element["Location"]["doorNumber"].toString();
                locationList.formNo = element["Location"]["formNo"].toString();
                locationList.noOfFamilyMembers =
                    element["Location"]["noOfFamilyMembers"].toString();
                locationList.projectCode =
                    element["Location"]["projectCode"].toString();
                locationList.streetName = element["Location"]["streetName"];

                data["villageCode"] = "";
                if (element["Location"]["villagesCode"] == "") {
                  locationList.villageName = "";
                  locationList.villagesCode = "";
                } else {
                  var docOrString = element["Location"]["villagesCode"];
                  if (docOrString is String) {
                    data["villageCode"] =
                        element["Location"]["villagesCode"].toString();
                    locationList.villageName =
                        element["Location"]["villageName"].toString();
                    locationList.villagesCode =
                        element["Location"]["villagesCode"].toString();
                    locationList.panchayatCode =
                        element["Location"]["panchayatCode"].toString();
                    locationList.panchayatNo =
                        element["Location"]["panchayatNo"].toString();
                  } else {
                    DocumentSnapshot villageSnapShot =
                        await getVillageDetail(docOrString);
                    data["villageCode"] =
                        villageSnapShot["villageCode"].toString();
                    locationList.panchayatCode =
                        villageSnapShot["panchayatCode"].toString();
                    locationList.panchayatNo =
                        villageSnapShot["panchayatNo"].toString();
                    locationList.villageName =
                        villageSnapShot["villageName"][language].toString();
                    locationList.villagesCode =
                        villageSnapShot["villageCode"].toString();
                  }
                }
                if (element["Location"]["panchayatCode"] == "") {
                  locationList.panchayatCode = "";
                  locationList.panchayatNo = "";
                } else {
                  if (element["Location"]["villagesCode"] == "") {
                    var docOrString = element["Location"]["panchayatCode"];
                    if (docOrString is String) {
                      locationList.panchayatCode =
                          element["Location"]["panchayatCode"].toString();
                      locationList.panchayatNo =
                          element["Location"]["panchayatNo"].toString();
                    } else {
                      DocumentSnapshot villageSnapShot =
                          await getVillageDetail(docOrString);
                      locationList.panchayatCode =
                          villageSnapShot["panchayatCode"].toString();
                      locationList.panchayatNo =
                          villageSnapShot["panchayatNo"].toString();
                    }
                  }
                }

                // demoLength = await totalLength();
                debugPrint("demoLength$demoLength");

                if (data["villageCode"] == "") data["status"] = false;

                if (locationList.streetName == "") data["status"] = false;
                if (locationList.doorNumber == "") data["status"] = false;
                if (locationList.contactPerson == "") data["status"] = false;
                // hasCaste = -1,
                int hasSection = -1, hasRelationShip = -1, hasDob = -1;
                for (int i = 0; i < family.length; i++) {
                  Family _family = Family();
                  _family.position = family[i]["positon"];
                  locationList.formNo = family[i]["familyId"];
                  _family.familyId = family[i]["familyId"];
                  debugPrint("Position:${_family.position}");
                  _family.aadharNumber = family[i]["aadharNumber"];
                  _family.age = family[i]["age"];
                  _family.annualIncome = family[i]["annualIncome"];
                  _family.bloodGroup = family[i]["bloodGroup"];
                  _family.caste = family[i]["caste"];

                  // if (_family.caste != "")
                  //   hasCaste += 1;
                  _family.community = family[i]["community"];
                  if (_family.community != "") hasSection += 1;
                  _family.dob = family[i]["dob"];
                  if (_family.community != "") hasDob += 1;
                  _family.education = family[i]["education"];
                  _family.gender = family[i]["gender"];
                  var isInt = family[i]["govtInsurance"];
                  /*if (isInt is double) {
                 _family.govtInsurance= isInt;
               } else {*/
                  // _family.govtInsurance= isInt.toDouble();
                  _family.govtInsurance = family[i]["govtInsurance"].toDouble();
                  // }
                  _family.mail = family[i]["mail"];
                  if (family[i]["maritalStatus"] == "null")
                    _family.maritalStatus = "";
                  else
                    _family.maritalStatus = family[i]["maritalStatus"];
                  _family.mobileNumber = family[i]["mobileNumber"];
                  _family.name = family[i]["name"];
                  _family.occupation = family[i]["occupation"];
                  _family.oldPension = family[i]["oldPension"] == null
                      ? 0
                      : family[i]["oldPension"].toDouble();
                  _family.photo = family[i]["photo"];
                  _family.physicallyChallenge =
                      family[i]["physicallyChallenge"].toDouble();
                  _family.physical = family[i]["physicallyChallenged"];
                  _family.privateInsurance =
                      family[i]["privateInsurance"].toDouble();
                  _family.relationship = family[i]["relationship"];
                  if (_family.relationship != "") hasRelationShip += 1;
                  _family.retirementPension =
                      family[i]["retirementPension"].toDouble();
                  _family.smartphone = family[i]["smartphone"].toDouble();
                  _family.widowedPension =
                      family[i]["widowedPension"].toDouble();

                  _family.anyMembersWhoDrink =
                      family[i]['anyMembersWhoDrink'].toDouble();
                  _family.anyMembersWhoSmoke =
                      family[i]['anyMembersWhoSmoke'].toDouble();
                  _family.anyMembersWhoUseTobacco =
                      family[i]['anyMembersWhoUseTobacco'].toDouble();
                  _family.firstDose = family[i]['firstDose'];
                  _family.isVaccinationDone =
                      family[i]['isVaccinationDone'].toDouble();
                  _family.secondDose = family[i]['secondDose'];
                  _family.isExpanded = 'Show More';
                  _familyList.sort((a, b) => a.position.compareTo(b.position));

                  _familyList.add(_family);
                  debugPrint("GETFamily______" + _family.education);
                }

                // if (hasCaste < 0)
                //   data["status"] = false;

                if (hasSection < 0) data["status"] = false;

                if (hasRelationShip < 0) data["status"] = false;

                if (hasDob < 0) data["status"] = false;

                propertyList.dryLandInAcres =
                    element["Property"]["dryLandInAcres"];
                propertyList.fourWheeler = element["Property"]["fourWheeler"];
                propertyList.livestockCount =
                    element["Property"]["livestockCount"];
                propertyList.cow = element["Property"]["cow"];
                propertyList.buffalo = element["Property"]["buffalo"];
                propertyList.bull = element["Property"]["bull"];
                propertyList.hen = element["Property"]["hen"];
                propertyList.sheep = element["Property"]["sheep"];
                propertyList.goat = element["Property"]["goat"];
                propertyList.pig = element["Property"]["pig"];
                propertyList.othersLive = element["Property"]["othersLive"];
                propertyList.noOfVehicleOwn =
                    element["Property"]["noOfVehicleOwn"];
                propertyList.others = element["Property"]["others"];
                propertyList.ownLand =
                    element["Property"]["ownLand"].toDouble();
                propertyList.ownLivestocks =
                    element["Property"]["ownLivestocks"].toDouble();
                propertyList.ownVehicle =
                    element["Property"]["ownVehicle"].toDouble();
                propertyList.statusofHouse =
                    element["Property"]["statusofHouse"];
                propertyList.threeWheeler = element["Property"]["threeWheeler"];
                propertyList.toiletFacility =
                    element["Property"]["toiletFacility"].toDouble();
                propertyList.twoWheeler = element["Property"]["twoWheeler"];
                propertyList.typeofHouse = element["Property"]["typeofHouse"];
                propertyList.wetLandInAcres =
                    element["Property"]["wetLandInAcres"];
                demographicData.location = locationList;
                demographicData.family = _familyList;
                demographicData.property = propertyList;
                demographicData.habits = habitsList;

                if (demographicData.location.streetName != "")
                  streets.add(demographicData.location.streetName);

                demographicData.docId = element.id;
                documentId.add(element.id);

                _demographicList.add(demographicData);
                users.add(data);

                if (_demographicList.length == mainDemograpicData.length) {
                  loadData = false;
                  if (isSearch) {
                    isSearch = false;
                    loadMore = true;
                    loadData = true;
                    if (snapshot.data.docs.length > 0) {
                      query = query
                          .startAfterDocument(
                              snapshot.data.docs[snapshot.data.docs.length - 1])
                          .limit(30);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                  // setState(() {});
                }
              });
            }
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgBG),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: (width) * 0.02,
                              right: (width) * 0.02,
                              top: (height) * 0.01,
                              bottom: (height) * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextWidget(
                                  text:
                                      "${DemoLocalization.of(context).translate('TotalRecords')}" +
                                          " " "${(_demographicList.length)}" +
                                          " / $demoLength",
                                  color: darkColor,
                                  weight: FontWeight.w500,
                                  size: 16,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SearchDialog(
                                                  search, clearSearch);
                                              // return _navigateAndDisplaySelection(context);
                                            });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors.black45,
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.search),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              TextWidget(
                                                text:
                                                    DemoLocalization.of(context)
                                                        .translate('Search'),
                                                color: darkColor,
                                                weight: FontWeight.w700,
                                                size: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        loadData = true;
                                        Get.toNamed(
                                          '/questionnery',
                                          arguments: [
                                            new DemographicFamily(),
                                            streets,
                                            "",
                                            false,
                                            makeLoadData
                                          ],
                                        ) /*.then((value) async => {clearSearch()})*/;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors.black45,
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.add),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              TextWidget(
                                                text:
                                                    DemoLocalization.of(context)
                                                        .translate('Add New'),
                                                color: darkColor,
                                                weight: FontWeight.w700,
                                                size: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                DataTable(
                                  columnSpacing: 0.06,
                                  showCheckboxColumn: false,
                                  horizontalMargin: 0.10,
                                  columns: [
                                    DataColumn(
                                        label: SizedBox(
                                      width: 96,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 1.0),
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate('Family Head'),
                                            color: darkColor,
                                            size: 16,
                                            weight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    )),
                                    DataColumn(
                                      label: SizedBox(
                                        width: 72,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 1.0),
                                          child: Center(
                                            child: TextWidget(
                                              text: DemoLocalization.of(context)
                                                  .translate('Total Members'),
                                              color: darkColor,
                                              size: 16,
                                              weight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: 95,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 6.0),
                                          child: Center(
                                            child: TextWidget(
                                              text: DemoLocalization.of(context)
                                                  .translate('Mobile No'),
                                              color: darkColor,
                                              size: 16,
                                              weight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: 96,
                                        child: Center(
                                          child: TextWidget(
                                            text: DemoLocalization.of(context)
                                                .translate('Village Code'),
                                            color: darkColor,
                                            size: 16,
                                            weight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                        label: SizedBox(
                                      width: 66,
                                      child: Center(
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate('Status'),
                                          color: darkColor,
                                          size: 16,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                    )),
                                    DataColumn(
                                        label: SizedBox(
                                      width: 70,
                                      child: Center(
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate('Action'),
                                          color: darkColor,
                                          size: 16,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                    )),
                                  ],
                                  rows: users
                                      .map((usersItem) => DataRow(
                                              onSelectChanged: (bool selected) {
                                                if (selected) {
                                                  int index = 0;
                                                  for (int i = 0;
                                                      i < users.length;
                                                      i++) {
                                                    if (usersItem['name'] ==
                                                            users[i]['name'] &&
                                                        usersItem[
                                                                "mobileNumber"] ==
                                                            users[i][
                                                                "mobileNumber"] &&
                                                        usersItem[
                                                                'villageCode'] ==
                                                            users[i][
                                                                'villageCode']) {
                                                      index = i;
                                                      break;
                                                    }
                                                  }
                                                  Get.toNamed('/DetailScreen',
                                                      arguments: [
                                                        _demographicList[index],
                                                        streets,
                                                        documentId[index],
                                                        true,
                                                        makeLoadData,
                                                        users[index]["status"]
                                                      ]) /*.then((value) => clearSearch())*/;
                                                }
                                              },
                                              cells: [
                                                users.length > 0
                                                    ? DataCell(Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: SizedBox(
                                                            width: 99,
                                                            child: TextWidget(
                                                              text: usersItem[
                                                                  'name'],
                                                              color:
                                                                  darkGreyColor,
                                                              size: 16,
                                                              weight: FontWeight
                                                                  .w600,
                                                            )),
                                                      ))
                                                    : DataCell(TextWidget(
                                                        text: "No data found",
                                                        size: 16,
                                                        weight: FontWeight.w600,
                                                      )),
                                                DataCell(SizedBox(
                                                  width: 55,
                                                  child: Center(
                                                    child: TextWidget(
                                                      text: usersItem['age']
                                                          .toString(),
                                                      color: darkGreyColor,
                                                      size: 16,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )),
                                                DataCell(SizedBox(
                                                  width: 95,
                                                  child: Center(
                                                    child: TextWidget(
                                                      text: usersItem[
                                                          'mobileNumber'],
                                                      color: darkGreyColor,
                                                      size: 16,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )),
                                                DataCell(SizedBox(
                                                  width: 70,
                                                  child: Center(
                                                    child: TextWidget(
                                                      text: usersItem[
                                                          'villageCode'],
                                                      color: darkGreyColor,
                                                      size: 16,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )),
                                                DataCell(SizedBox(
                                                  width: 60,
                                                  child: Center(
                                                    child: usersItem[
                                                                "status"] ==
                                                            true
                                                        ? SvgPicture.asset(
                                                            svgComplete,
                                                            semanticsLabel:
                                                                "Logo",
                                                            height: 27,
                                                            width: 27,
                                                            fit: BoxFit.contain,
                                                            allowDrawingOutsideViewBox:
                                                                true,
                                                          )
                                                        : SvgPicture.asset(
                                                            svgInProgress,
                                                            semanticsLabel:
                                                                "Logo",
                                                            height: 28,
                                                            width: 28,
                                                            fit: BoxFit.contain,
                                                            allowDrawingOutsideViewBox:
                                                                true,
                                                          ),
                                                  ),
                                                )),
                                                DataCell(SizedBox(
                                                  width: 65,
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            int index = 0;
                                                            for (int i = 0;
                                                                i <
                                                                    users
                                                                        .length;
                                                                i++) {
                                                              if (usersItem['name'] == users[i]['name'] &&
                                                                  usersItem[
                                                                          "mobileNumber"] ==
                                                                      users[i][
                                                                          "mobileNumber"] &&
                                                                  usersItem[
                                                                          'villageCode'] ==
                                                                      users[i][
                                                                          'villageCode']) {
                                                                index = i;
                                                                break;
                                                              }
                                                            }
                                                            // makeLoadData();
                                                            Get.toNamed(
                                                              '/questionnery',
                                                              arguments: [
                                                                _demographicList[
                                                                    index],
                                                                streets,
                                                                documentId[
                                                                    index],
                                                                true,
                                                                makeLoadData
                                                              ],
                                                            ) /*.then((value) => clearSearch())*/;
                                                          },
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            int index = 0;
                                                            for (int i = 0;
                                                                i <
                                                                    users
                                                                        .length;
                                                                i++) {
                                                              if (usersItem["age"] == users[i]["age"] &&
                                                                  usersItem[
                                                                          'name'] ==
                                                                      users[i][
                                                                          'name'] &&
                                                                  usersItem[
                                                                          "mobileNumber"] ==
                                                                      users[i][
                                                                          "mobileNumber"] &&
                                                                  usersItem[
                                                                          'villageCode'] ==
                                                                      users[i][
                                                                          'villageCode']) {
                                                                index = i;
                                                                break;
                                                              }
                                                            }
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  debugPrint(
                                                                      "DocumetId:${documentId[index]}");
                                                                  return AlertDialogWidget(
                                                                      deleteDoc,
                                                                      index);
                                                                });
                                                            debugPrint("click");
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: errorColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                              ]))
                                      .toList(),
                                  /* onRowsPerPageChanged: (r) {
                                  setState(() {
                                    _rowPerPage = r;
                                  });
                                },
                                rowsPerPage: _rowPerPage,*/
                                ),
                                InkWell(
                                  onTap: () {
                                    loadMore = true;
                                    loadData = true;
                                    if (snapshot.data.docs.length > 0) {
                                      query = query
                                          .startAfterDocument(snapshot
                                                  .data.docs[
                                              snapshot.data.docs.length - 1])
                                          .limit(30);
                                      setState(() {
                                        isLoading = true;
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      isLoading
                                          ? Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()))
                                          : Container(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 24, bottom: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.black45,
                                              style: BorderStyle.solid,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.more_horiz),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                TextWidget(
                                                  text: DemoLocalization.of(
                                                          context)
                                                      .translate('Show More'),
                                                  color: darkColor,
                                                  weight: FontWeight.w700,
                                                  size: 14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void makeLoadData() {
    setState(() {
      loadData = true;
    });
    totalLength();
  }

  void clearSearch() {
    loadData = true;
    users.clear();
    _demographicList.clear();
    streets.clear();
    documentId.clear();
    query = firestoreInstance.collection('demographicData').limit(30);
    setState(() {});
  }

  bool isSearch = false;

  Future<void> search(String contactPerson, familyHead, mobileNo, villageCode,
      villageName, panchayatCode) async {
    print("GET_______" +
        contactPerson.trim() +
        " " +
        familyHead.trim() +
        " " +
        mobileNo.trim() +
        " " +
        villageCode +
        " " +
        villageName +
        " " +
        panchayatCode);
    loadData = true;
    users.clear();
    _demographicList.clear();
    streets.clear();
    documentId.clear();

    if (contactPerson == "" &&
        familyHead == "" &&
        mobileNo == "" &&
        villageCode == "" &&
        villageName == "" &&
        panchayatCode == "") {
      query = firestoreInstance.collection('demographicData').limit(30);
      setState(() {});
    } else if (familyHead != "" && villageName != "") {
      isSearch = true;
      query = firestoreInstance
          .collection('demographicData')
          .where("Location.name", isEqualTo: familyHead.toString().capitalize)
          .where("Location.villageName", isEqualTo: villageName)
          .limit(30);
      setState(() {});
    } else if (contactPerson != "" && villageName != "") {
      isSearch = true;
      query = firestoreInstance
          .collection('demographicData')
          .where("Location.contactPerson", isEqualTo: contactPerson.capitalize)
          .where("Location.villageName", isEqualTo: villageName)
          .limit(30);
      setState(() {});
    } else if (familyHead != "") {
      isSearch = true;
      query = firestoreInstance
          .collection('demographicData')
          .where(
            "Location.name",
            isGreaterThanOrEqualTo: familyHead.toString().capitalize,
            isLessThan: familyHead
                    .toString()
                    .capitalize
                    .substring(0, familyHead.toString().capitalize.length - 1) +
                String.fromCharCode(familyHead.toString().capitalize.codeUnitAt(
                        familyHead.toString().capitalize.length - 1) +
                    1),
          )
          .limit(30);
      setState(() {});
      debugPrint("familyHead:${query}");
    } else if (contactPerson != "") {
      query = firestoreInstance
          .collection('demographicData')
          .where("Location.contactPerson", isEqualTo: contactPerson.capitalize)
          .limit(30);
      setState(() {});
    } else if (mobileNo != "") {
      query = firestoreInstance
          .collection('demographicData')
          .where("Location.contactNumber", isEqualTo: mobileNo.trim());
      setState(() {});
    } else if (villageCode != "") {
      isSearch = true;
      query = firestoreInstance
          .collection('demographicData')
          .where("Location.villagesCode", isEqualTo: villageCode)
          .limit(30);
      setState(() {});
    } else if (villageName != "") {
      isSearch = true;
      query = firestoreInstance
          .collection('demographicData')
          .where("Location.villageName", isEqualTo: villageName)
          .limit(30);
      setState(() {});
    } else if (panchayatCode != "") {
      isSearch = true;
      query = firestoreInstance
          .collection('demographicData')
          .where("Location.panchayatCode", isEqualTo: panchayatCode)
          .limit(30);
      setState(() {});
    }
  }

  void getLanguage() async {
    language = await SharedPref().getStringPref(SharedPref().language);
    debugPrint("language:$language");
    // demoLength = await totalLength();
    totalLength();
  }

  void deleteDoc(int index) {
    debugPrint("delete DocumetId:${documentId[index]}");
    FirebaseFirestore.instance
        .collection('demographicData')
        .doc(documentId[index])
        .delete()
        .then((value) {
      clearSearch();
      deleteCount();
    });
  }

  void showDeleteSuccess() {
    snackBarAlert(success, "Deleted SuccessFully", successColor);
  }

  deleteCount() async {
    var data =
        await FirebaseFirestore.instance.collection(collectionCount).get();
    for (int i = 0; i < data.docs.length; i++) {
      var totalLength = data.docs[i].data()['length'];
      debugPrint("totalLength$totalLength");
      deleteLength = totalLength - 1;
    }
    FirebaseFirestore.instance
        .collection(collectionCount)
        .doc('ZDuG7E8KkwuadT4WxGGb')
        .update({
      "length": deleteLength,
    }).then((value) {
      makeLoadData();
      showDeleteSuccess();
    }).catchError((error) => false);

    debugPrint("deleteLength$deleteLength");
  }

  totalLength() async {
    var data =
        await FirebaseFirestore.instance.collection(collectionCount).get();
    demoLength = data.docs[0].data()["length"];
    debugPrint("demoLength$demoLength");
    setState(() {});
  }
}
