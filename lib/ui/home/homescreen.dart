/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 5:36 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 5:36 PM by Kanmalai.
 * /
 */
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/language_item.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/models/tabledata_model.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/ui/dialog/alert_dialog.dart';
import 'package:tct_demographics/ui/dialog/search_dialog.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenScreenState createState() => _HomeScreenScreenState();
}

class _HomeScreenScreenState extends State<HomeScreen> {
  CollectionReference demographydata =
      FirebaseFirestore.instance.collection('users');
  List<Result> users;
  Language language;
  String dropDownLang;
  var height, width;
  String name;
  int age;
  LinkedHashMap<String, dynamic> data;
  @override
  void initState() {
    super.initState();
    users = Result.getUser();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        title: DoubleBackToCloseApp(
          snackBar: SnackBar(
              backgroundColor: errorColor,
              elevation: 6,
              content: TextWidget(
                text: 'Tap back again to Exit',
                color: lightColor,
                weight: FontWeight.w600,
                size: 16,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 60),
                child: Container(
                  child: Image.asset(
                    imgLightLogo,
                    fit: BoxFit.contain,
                    height: height / 11,
                    width: width / 20,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton(
                    underline: SizedBox(),
                    icon: Icon(
                      Icons.language,
                      color: Colors.black87,
                    ),
                    items: ['Tamil', 'English'].map((val) {
                      return new DropdownMenuItem<String>(
                        value: val,
                        child: new Text(val),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        dropDownLang = val;

                        _changeLanguage();
                      });
                      print("Language:$val");
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 8.0),
                              height: 30,
                              width: 30,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage(user)))),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Senthil Kumar",
                            style: TextStyle(fontSize: 16, color: darkColor),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      AuthenticationService(FirebaseAuth.instance).signOut();
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
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreInstance.collection('demographicData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else
            print("dataUser:${snapshot.data.docs}");
          var family = snapshot.data.docs.map((doc) => doc.data()).toList();
          debugPrint("family:$family");
          family.forEach((element) {
            data = element['familyMembers'];
            debugPrint("familyhead2:${data['name']}");

            if (data != null) {
              name = data['name'];
              age = data['age'];
            }

            debugPrint("familyhead:$data");
          });
          // snapshot.data.docs.map((usersItem) {
          //   List<dynamic> markMap = usersItem['familyMembers'];
          //   markMap.forEach((element) {
          //     name = element['name'];
          //     debugPrint("familyhead:$name");
          //   });
          // });
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgBG),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 8,
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
                                        " " "${(350)}",
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
                                            return SearchDialog();
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
                                      Get.toNamed('/questionnery');
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
                          child: DataTable(
                            columnSpacing: 10.0,
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
                                    width: 100,
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
                              DataColumn(
                                  label: SizedBox(
                                    width: 100,
                                    child: Center(
                                      child: TextWidget(
                                        text: DemoLocalization.of(context)
                                            .translate('Zone'),
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
                            rows: users
                                .map((usersItem) => DataRow(
                                        onSelectChanged: (bool selected) {
                                          if (selected) {
                                            Get.toNamed('/DetailScreen');
                                            debugPrint(
                                                "${usersItem.familyHead}");
                                          }
                                        },
                                        cells: [
                                          DataCell(Row(
                                            children: [
                                              // Container(
                                              //     padding: EdgeInsets.only(
                                              //         left: 8.0),
                                              //     height: 30,
                                              //     width: 30,
                                              //     decoration: new BoxDecoration(
                                              //         shape:
                                              //             BoxShape.circle,
                                              //         image: new DecorationImage(
                                              //             fit: BoxFit.fill,
                                              //             image:
                                              //                 new AssetImage(
                                              //                     user)))),

                                              SizedBox(
                                                  width: 100,
                                                  child: Center(
                                                    child: TextWidget(
                                                      text: name,
                                                      color: darkGreyColor,
                                                      size: 16,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ))
                                            ],
                                          )),
                                          DataCell(SizedBox(
                                            width: 100,
                                            child: Center(
                                              child: TextWidget(
                                                text: age.toString(),
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
                                                text: usersItem.mobile,
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
                                                text: usersItem.villageCode,
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
                                                text: usersItem.zone,
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
                                                text: usersItem.status,
                                                color: darkGreyColor,
                                                size: 16,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: 100,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          '/questionnery');
                                                    },
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialogWidget();
                                                            });
                                                        debugPrint("click");
                                                      });
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

    if (dropDownLang == "Tamil") {
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
}
