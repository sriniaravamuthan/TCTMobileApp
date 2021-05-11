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
import 'package:tct_demographics/main.dart';
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
  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;
  CollectionReference demographydata = FirebaseFirestore.instance.collection('users');

  // List<Result> users;
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
    ]);

    // collectionReference = firestoreInstance.collection('demographicData');
    query = firestoreInstance.collection('demographicData');

    super.initState();
  }

  /*Future<String> getVillageDetail(DocumentReference villageCode) async {
    DocumentSnapshot snapShot =  await FirebaseFirestore.instance.doc(villageCode.path).get();
    String sac = snapShot["villageCode"].toString();
    print("GET______________" + sac);
    return sac;
  }*/

  Future<DocumentSnapshot> getVillageDetail(DocumentReference villageCode) async {
    DocumentSnapshot snapShot =  await FirebaseFirestore.instance.doc(villageCode.path).get();
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
                                : Image.network(firebaseAuth.currentUser.photoURL)),
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
      body: StreamBuilder<QuerySnapshot>(
        // stream: collectionReference.snapshots(),
        stream: query?.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Something went wrong');
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          var mainDemograpicData = snapshot.data.docs.map((doc) => doc.data()).toList();
          debugPrint("family : ${mainDemograpicData}");

          if (loadData && snapshot.connectionState == ConnectionState.active) {
            streets.clear();
            documentId.clear();
            _demographicList.clear();
            users.clear();
            documentId = snapshot.data.docs.map((e) => e.id).toList();
            mainDemograpicData.forEach((element) async {
              HashMap data = new HashMap();
              data["status"] = true;  //  True -> Complete, false -> InProgress
              data["name"] = element["Location"]["contactPerson"];
              data["formNo"] = element["Location"]["formNo"];

              data["mobileNumber"] = element["Location"]["contactNumber"];

              List family = element['familyMembers'];
              for (int i = 0; i < family.length; i++) {
                if (family[i]["mobileNumber"] == data["mobileNumber"]) {
                  data["mobileNumber"] = family[i]["mobileNumber"];
                  data["age"] = family[i]["age"];
                  break;
                }
              }
              if (data["age"] == null) data["age"] = "";

              DemographicFamily demographicData = DemographicFamily();
              Location locationList = Location();
              Property propertyList = Property();
              Habits habitsList = Habits();
              List<Family> _familyList = [];
              locationList.contactPerson = element["Location"]["contactPerson"];
              locationList.contactNumber = element["Location"]["contactNumber"];
              locationList.doorNumber = element["Location"]["doorNumber"].toString();
              locationList.formNo = element["Location"]["formNo"].toString();
              locationList.noOfFamilyMembers = element["Location"]["noOfFamilyMembers"].toString();
              locationList.projectCode = element["Location"]["projectCode"].toString();
              locationList.streetName = element["Location"]["streetName"];

              data["villageCode"] = "";
              if (element["Location"]["villagesCode"] == "") {
                locationList.villageName = "";
                locationList.villagesCode = "";
              } else {
                DocumentSnapshot villageSnapShot = await getVillageDetail(element["Location"]["villagesCode"]);
                data["villageCode"] = villageSnapShot["villageCode"].toString();
                locationList.panchayatCode =villageSnapShot["panchayatCode"].toString();
                locationList.panchayatNo =villageSnapShot["panchayatNo"].toString() ;
                locationList.villageName =  villageSnapShot["villageName"][language].toString() ;
                locationList.villagesCode = villageSnapShot["villageCode"].toString();
              }
              if (element["Location"]["panchayatCode"] == "") {
                locationList.panchayatCode = "";
                locationList.panchayatNo = "";
              } else {
                if (element["Location"]["villagesCode"] == "") {
                  DocumentSnapshot villageSnapShot = await getVillageDetail(element["Location"]["panchayatCode"]);
                  locationList.panchayatCode = villageSnapShot["panchayatCode"].toString();
                  locationList.panchayatNo = villageSnapShot["panchayatNo"].toString();
                }
              }

              if (data["villageCode"] == "")
                data["status"] = false;

              if (locationList.streetName == "")
                data["status"] = false;
              if (locationList.doorNumber == "")
                data["status"] = false;
              if (locationList.contactPerson == "")
                data["status"] = false;

              int hasCaste = -1, hasSection = -1, hasRelationShip = -1, hasDob = -1;
              for (int i = 0; i < family.length; i++) {
                Family _family = Family();
               _family.aadharNumber= family[i]["aadharNumber"];
               _family.age= family[i]["age"];
               _family.annualIncome= family[i]["annualIncome"];
               _family.bloodGroup=  family[i]["bloodGroup"];
               _family.caste= family[i]["caste"];
               if (_family.caste != "")
                 hasCaste += 1;
               _family.community= family[i]["community"];
               if (_family.community != "")
                 hasSection += 1;
               _family.dob= family[i]["dob"];
               if (_family.community != "")
                 hasDob += 1;
               _family.education= family[i]["education"];
               _family.gender= family[i]["gender"];
               _family.govtInsurance= family[i]["govtInsurance"];
               _family.mail= family[i]["mail"];
               _family.maritalStatus= family[i]["maritalStatus"];
               _family.mobileNumber= family[i]["mobileNumber"];
               _family.name= family[i]["name"];
               _family.occupation= family[i]["occupation"];
               _family.oldPension=  family[i]["oldPension"];
               _family.photo= family[i]["photo"];
               _family.physicallyChallenge=  family[i]["physicallyChallenge"] ;
               _family.privateInsurance=  family[i]["privateInsurance"];
               _family.relationship= family[i]["relationship"];
               if (_family.relationship != "")
                 hasRelationShip += 1;
               _family.retirementPension= family[i]["retirementPension"];
               _family.smartphone= family[i]["smartphone"];
               _family.widowedPension= family[i]["widowedPension"];
                _familyList.add(_family);
              }

              if (hasCaste < 0)
                data["status"] = false;

              if (hasSection < 0)
                data["status"] = false;

              if (hasRelationShip < 0)
                data["status"] = false;

              if (hasDob < 0)
                data["status"] = false;

              propertyList.dryLandInAcres = element["Property"]["dryLandInAcres"];
              propertyList.fourWheeler = element["Property"]["fourWheeler"];
              propertyList.livestockCount = element["Property"]["livestockCount"];
              propertyList.livestockType = element["Property"]["livestockType"];
              propertyList.noOfVehicleOwn = element["Property"]["noOfVehicleOwn"];
              propertyList.others = element["Property"]["others"];
              propertyList.ownLand = element["Property"]["ownLand"];
              propertyList.ownLivestocks = element["Property"]["ownLivestocks"];
              propertyList.ownVehicle = element["Property"]["ownVehicle"];
              propertyList.statusofHouse = element["Property"]["statusofHouse"];
              propertyList.threeWheeler = element["Property"]["threeWheeler"];
              propertyList.toiletFacility = element["Property"]["toiletFacility"];
              propertyList.twoWheeler = element["Property"]["twoWheeler"];
              propertyList.typeofHouse = element["Property"]["typeofHouse"];
              propertyList.wetLandInAcres = element["Property"]["wetLandInAcres"];

              habitsList.anyMembersWhoDrink=element['habit']['anyMembersWhoDrink'];
              habitsList.anyMembersWhoSmoke=element['habit']['anyMembersWhoSmoke'];
              habitsList.anyMembersWhoUseTobacco=element['habit']['anyMembersWhoUseTobacco'];
              habitsList.firstDose=element['habit']['firstDose'];
              habitsList.isVaccinationDone=element['habit']['isVaccinationDone'];
              habitsList.secondDose=element['habit']['secondDose'];
              debugPrint("habits:${ habitsList.anyMembersWhoDrink}");

              debugPrint("demographicData2:${propertyList.dryLandInAcres }");

              demographicData.location = locationList;
              demographicData.family = _familyList;
              demographicData.property = propertyList;
              demographicData.habits = habitsList;

              if (demographicData.location.streetName != "")
                streets.add(demographicData.location.streetName);

              _demographicList.add(demographicData);
              users.add(data);

              if (_demographicList.length == mainDemograpicData.length) {
                loadData = false;
                setState(() {});
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
                                        " " "${(_demographicList.length)}",
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
                                            return SearchDialog(search, clearSearch);
                                            // return _navigateAndDisplaySelection(context);
                                          });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
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
                                              text: DemoLocalization.of(context)
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
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     showDialog(
                                  //         context: context,
                                  //         builder: (BuildContext context) {
                                  //           return FilterDialog();
                                  //         });
                                  //   },
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(50),
                                  //       border: Border.all(
                                  //         color: Colors.black45,
                                  //         style: BorderStyle.solid,
                                  //         width: 1.0,
                                  //       ),
                                  //     ),
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.all(6.0),
                                  //       child: Row(
                                  //         children: [
                                  //           Icon(Icons.filter_list_sharp),
                                  //           SizedBox(
                                  //             width: 5,
                                  //           ),
                                  //           TextWidget(
                                  //             text: DemoLocalization.of(context)
                                  //                 .translate('Filter'),
                                  //             color: darkColor,
                                  //             weight: FontWeight.w800,
                                  //             size: 14,
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Get.toNamed('/questionnery');
                                      loadData = true;
                                      Get.toNamed('/questionnery', arguments: [new DemographicFamily() , streets, "", false],).then((value) async => {clearSearch()});
                                      // Navigator.pushReplacementNamed(context, "/questionnery");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
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
                                              text: DemoLocalization.of(context)
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
                          child: Padding(
                            padding: const EdgeInsets.all(
                              8.0,
                            ),
                            child: PaginatedDataTable(
                              columnSpacing: 22.0,
                              showCheckboxColumn: false,
                              columns: [
                                DataColumn(
                                    label: SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: TextWidget(
                                      text: DemoLocalization.of(context)
                                          .translate('Family Head'),
                                      color: darkColor,
                                      size: 16,
                                      weight: FontWeight.w700,
                                    ),
                                  ),
                                )),
                                DataColumn(
                                    label: SizedBox(
                                      width: 100,
                                      child: Center(
                                        child: TextWidget(
                                          text: DemoLocalization.of(context)
                                              .translate('Age'),
                                          color: darkColor,
                                          size: 16,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    numeric: true),
                                DataColumn(
                                    label: SizedBox(
                                      width: 100,
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
                                    numeric: true),
                                DataColumn(
                                    label: SizedBox(
                                      width: 140,
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
                                    numeric: true),
                                // DataColumn(
                                //     label: SizedBox(
                                //       width: 100,
                                //       child: Center(
                                //         child: TextWidget(
                                //           text: DemoLocalization.of(context)
                                //               .translate('Zone'),
                                //           color: darkColor,
                                //           size: 16,
                                //           weight: FontWeight.w700,
                                //         ),
                                //       ),
                                //     ),
                                //     numeric: true),
                                DataColumn(
                                    label: SizedBox(
                                  width: 100,
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
                                  width: 100,
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
                              source: DataTableRow(context, height, width, users,_demographicList, streets, documentId, clearSearch, makeLoadData),
                              onRowsPerPageChanged: (r) {
                                setState(() {
                                  _rowPerPage = r;
                                });
                              },
                              rowsPerPage: _rowPerPage,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _changeLanguage() async {
    // Locale _temp = await setLocale(language.languageCode);
    // SplashScreen.setLocale(context, _temp);

    if (dropDownLang == "தமிழ்") {
      setState(() {
        MyApp.setLocale(context, Locale('ta', 'IN'));
        SharedPref().setStringPref(SharedPref().language, 'ta');
      });
    } else {
      setState(() {
        MyApp.setLocale(context, Locale('en', 'US'));
        SharedPref().setStringPref(SharedPref().language, 'en');
      });
    }
  }

  void makeLoadData() {
    loadData = true;
  }
  
  void clearSearch() {
    loadData = true;
    users.clear();
    _demographicList.clear();
    streets.clear();
    query = firestoreInstance.collection('demographicData');
    setState(() {});
  }

  Future<void> search(String mobileNo, villageCode, villageName, panchayatCode) async {
    print("GET_______" + mobileNo.trim() + " " + villageCode + " " + villageName + " " + panchayatCode);
    loadData = true;
    users.clear();
    _demographicList.clear();
    streets.clear();

    if (mobileNo == "" && villageCode == "" && villageName == "" && panchayatCode == "") {
      query = firestoreInstance.collection('demographicData');
      setState(() {});
      return;
    } else if (mobileNo != "") {
      query = firestoreInstance.collection('demographicData').where("Location.contactNumber", isEqualTo: mobileNo.trim());
      setState(() {});
      return;
    } else if (villageCode != "") {
      QuerySnapshot querySnapshot = await firestoreInstance.collection(collectionVillageName).where("villageCode", isEqualTo: villageCode).get();
      DocumentReference documentReference;
      if (querySnapshot.docs.isEmpty) {
        query = null;
        setState(() {});
        return;
      }
      documentReference = firestoreInstance.collection(collectionVillageName).doc(querySnapshot.docs[0].id);
      query = firestoreInstance.collection('demographicData').where("Location.villagesCode", isEqualTo: documentReference);
      setState(() {});
      return;
    }else if (villageName != "") {
      QuerySnapshot querySnapshot = await firestoreInstance.collection(collectionVillageName).where("villageName.$language", isEqualTo: villageName).get();
      DocumentReference documentReference;
      if (querySnapshot.docs.isEmpty) {
        query = null;
        setState(() {});
        return;
      }
      documentReference = firestoreInstance.collection(collectionVillageName).doc(querySnapshot.docs[0].id);
      query = firestoreInstance.collection('demographicData').where("Location.villagesCode", isEqualTo: documentReference);
      setState(() {});
      return;
    } else if (panchayatCode != "") {
      QuerySnapshot querySnapshot = await firestoreInstance.collection(collectionVillageName).where("panchayatCode", isEqualTo: int.parse(panchayatCode)).get();
      DocumentReference documentReference;
      if (querySnapshot.docs.isEmpty) {
        query = null;
        setState(() {});
        return;
      }
      documentReference = firestoreInstance.collection(collectionVillageName).doc(querySnapshot.docs[0].id);
      print("GET_________" + documentReference.path);
      query = firestoreInstance.collection('demographicData').where("Location.panchayatCode", isEqualTo: documentReference);
      setState(() {});
      return;
    }

    FutureBuilder<DocumentSnapshot>(
      future: collectionReference.doc().get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          data.forEach((key, value) {
            print("DATAAAAAAAAAA___" + key + " : " + value);
          });
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }
        return Text("loading");
      },
    );
  }
  void getLanguage() async {
    language = await SharedPref().getStringPref(SharedPref().language);
    debugPrint("language:$language");
  }

}

class DataTableRow extends DataTableSource {
  List users;
  BuildContext context;
  var height, width;
  List<DemographicFamily> demographicList;
  List<String> streets;
  List<String> documentId = [];
  Function clearSearch, makeLoadData;

  DataTableRow(this.context, this.height, this.width, this.users, this.demographicList, this.streets, this.documentId, this.clearSearch, this.makeLoadData);

  @override
  DataRow getRow(int index) {
    if (users.isEmpty){
      return DataRow(cells: [
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
        DataCell(TextWidget(
          text: index == 0 ?"No data found": "",
          size: 16,
          weight: FontWeight.w600,
        )),
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
      ]);
    }
    if (index >= users.length)
      return DataRow(cells: [
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
        DataCell(TextWidget(
          text: "",
          size: 16,
          weight: FontWeight.w600,
        )),
      ]);

    return DataRow.byIndex(
        index: index,
        onSelectChanged: (bool selected) {
          if (selected) {
            Get.toNamed('/DetailScreen', arguments: [demographicList[index] , streets, documentId[index], true]).then((value) => clearSearch());
          }
        },
        cells: [
          DataCell(Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                    width: 100,
                    child: TextWidget(
                      text: users[index]['name'],
                      color: darkGreyColor,
                      size: 16,
                      weight: FontWeight.w600,
                    )),
              )
            ],
          )),
          DataCell(SizedBox(
            width: 100,
            child: Center(
              child: TextWidget(
                text: users[index]['age'].toString(),
                color: darkGreyColor,
                size: 16,
                weight: FontWeight.w600,
              ),
            ),
          )),
          DataCell(SizedBox(
            width: 100,
            child: Center(
              child: TextWidget(
                text: users[index]['mobileNumber'],
                color: darkGreyColor,
                size: 16,
                weight: FontWeight.w600,
              ),
            ),
          )),
          DataCell(SizedBox(
            width: 100,
            child: TextWidget(
              text: users[index]['villageCode'],
              color: darkGreyColor,
              size: 16,
              weight: FontWeight.w600,
            ),
          )),
          // DataCell(SizedBox(
          //   width: 100,
          //   child: Center(
          //     child: TextWidget(
          //       text: usersItem.zone,
          //       color: darkGreyColor,
          //       size: 16,
          //       weight: FontWeight.w600,
          //     ),
          //   ),
          // )),
          DataCell(SizedBox(
            width: 100,
            child: Center(
              child:users [index]["status"]==true?SvgPicture.asset(
                svgComplete,
                semanticsLabel: "Logo",
                height: height / 20,
                width: width / 20,
                fit: BoxFit.contain,
                allowDrawingOutsideViewBox: true,
              ):SvgPicture.asset(
                svgInProgress,
                semanticsLabel: "Logo",
                height: height / 20,
                width: width / 20,
                fit: BoxFit.contain,
                allowDrawingOutsideViewBox: true,
              ),
            ),
          )),
          DataCell(SizedBox(
            width: 100,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      // Get.toNamed('/questionnery',);
                      makeLoadData();
                      Get.toNamed('/questionnery', arguments: [demographicList[index] , streets, documentId[index], true],).then((value) => clearSearch());
                      // Navigator.pushReplacementNamed(context, "/questionnery");
                    },
                    child: Icon(
                      Icons.edit,
                      color: primaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {

                        showDialog(
                            context: context,
                            builder:
                                (BuildContext
                            context) {
                              debugPrint("DocumetId:${documentId[index]}");
                              return AlertDialogWidget(deleteDoc, index);
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
        ]);
  }

  @override
  bool get isRowCountApproximate => true;

  void deleteDoc(int index) {
    debugPrint("DocumetId:${documentId[index]}");
    FirebaseFirestore.instance.collection('demographicData').doc(documentId[index]).delete().then((value) {
      clearSearch();
      showDeleteSuccess();
    });
  }

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;

  void showDeleteSuccess() {
    snackBarAlert(success, "Deleted SuccessFully", successColor);

  }
}
