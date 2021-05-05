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
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/language_item.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/ui/dialog/search_dialog.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenScreenState createState() => _HomeScreenScreenState();
}

class _HomeScreenScreenState extends State<HomeScreen> {
  BuildContext context;
  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;
  CollectionReference demographydata =
      FirebaseFirestore.instance.collection('users');

  // List<Result> users;
  List users = [];
  Language language;
  String dropDownLang;
  var height, width;
  String userName = "";
  String userMail = "";
  int age = 0;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String mobileNo;

  @override
  void initState() {
    if (firebaseAuth.currentUser != null) {
      userName = firebaseAuth.currentUser.displayName;
      userMail = firebaseAuth.currentUser.email;
      debugPrint("userEmail:$userMail");
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        automaticallyImplyLeading: false,
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
              SvgPicture.asset(
                svgTctLogo,
                semanticsLabel: "Logo",
                height: height / 12,
                width: width / 12,
                fit: BoxFit.contain,
                allowDrawingOutsideViewBox: true,
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
                    items: ['தமிழ்', 'English'].map((val) {
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
          if (snapshot.hasError) return Text('Something went wrong');
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          var family = snapshot.data.docs.map((doc) => doc.data()).toList();
          family.forEach((element) {
            final List family = element['familyMembers'];

            final data = new HashMap();
            data["name"] = element["Location"]["contactPerson"];
            data["mobileNumber"] = element["Location"]["contactNumber"];
            data["villageCode"] = element["Location"]["villagesCode"];
            for (int i = 0; i < family.length; i++) {
              if (family[i]["mobileNumber"] == data["mobileNumber"]) {
                data["mobileNumber"] = family[i]["mobileNumber"];
                data["age"] = family[i]["age"];
              }
            }

            if (data != null) {
              users.add(data);
            }
          });
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
                                            return SearchDialog(
                                                search, clearSearch);
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
                                      Get.toNamed('/questionnery');
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
                          child: PaginatedDataTable(
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
                            source: DataTableRow(context, height, width, users),
                            onRowsPerPageChanged: (r) {
                              setState(() {
                                _rowPerPage = r;
                              });
                            },
                            rowsPerPage: _rowPerPage,
                            // rows: users
                            //     .map((usersItem) => DataRow(
                            //             onSelectChanged: (bool selected) {
                            //               if (selected) {
                            //                 Get.toNamed('/DetailScreen');
                            //                 debugPrint(
                            //                     "${usersItem.familyHead}");
                            //               }
                            //             },
                            //             cells: [
                            //               DataCell(Row(
                            //                 children: [
                            //                   // Container(
                            //                   //     padding: EdgeInsets.only(
                            //                   //         left: 8.0),
                            //                   //     height: 30,
                            //                   //     width: 30,
                            //                   //     decoration: new BoxDecoration(
                            //                   //         shape:
                            //                   //             BoxShape.circle,
                            //                   //         image: new DecorationImage(
                            //                   //             fit: BoxFit.fill,
                            //                   //             image:
                            //                   //                 new AssetImage(
                            //                   //                     user)))),
                            //
                            //                   SizedBox(
                            //                       width: 100,
                            //                       child: TextWidget(
                            //                         text: name,
                            //                         color: darkGreyColor,
                            //                         size: 16,
                            //                         weight: FontWeight.w600,
                            //                       ))
                            //                 ],
                            //               )),
                            //               DataCell(SizedBox(
                            //                 width: 100,
                            //                 child: Center(
                            //                   child: TextWidget(
                            //                     text: age.toString(),
                            //                     color: darkGreyColor,
                            //                     size: 16,
                            //                     weight: FontWeight.w600,
                            //                   ),
                            //                 ),
                            //               )),
                            //               DataCell(SizedBox(
                            //                 width: 100,
                            //                 child: Center(
                            //                   child: TextWidget(
                            //                     text: usersItem.mobile,
                            //                     color: darkGreyColor,
                            //                     size: 16,
                            //                     weight: FontWeight.w600,
                            //                   ),
                            //                 ),
                            //               )),
                            //               DataCell(SizedBox(
                            //                 width: 100,
                            //                 child: Center(
                            //                   child: TextWidget(
                            //                     text: usersItem.villageCode,
                            //                     color: darkGreyColor,
                            //                     size: 16,
                            //                     weight: FontWeight.w600,
                            //                   ),
                            //                 ),
                            //               )),
                            //               // DataCell(SizedBox(
                            //               //   width: 100,
                            //               //   child: Center(
                            //               //     child: TextWidget(
                            //               //       text: usersItem.zone,
                            //               //       color: darkGreyColor,
                            //               //       size: 16,
                            //               //       weight: FontWeight.w600,
                            //               //     ),
                            //               //   ),
                            //               // )),
                            //               DataCell(SizedBox(
                            //                 width: 100,
                            //                 child: Center(
                            //                   child: SvgPicture.asset(
                            //                     svgComplete,
                            //                     semanticsLabel: "Logo",
                            //                     height: height / 20,
                            //                     width: width / 20,
                            //                     fit: BoxFit.contain,
                            //                     allowDrawingOutsideViewBox:
                            //                         true,
                            //                   ),
                            //                 ),
                            //               )),
                            //               DataCell(SizedBox(
                            //                 width: 100,
                            //                 child: Center(
                            //                   child: Row(
                            //                     mainAxisAlignment:
                            //                         MainAxisAlignment
                            //                             .spaceEvenly,
                            //                     children: [
                            //                       InkWell(
                            //                         onTap: () {
                            //                           Get.toNamed('/questionnery');
                            //                           // Navigator.pushReplacementNamed(context, "/questionnery");
                            //                         },
                            //                         child: Icon(
                            //                           Icons.edit,
                            //                           color: primaryColor,
                            //                         ),
                            //                       ),
                            //                       InkWell(
                            //                         onTap: () {
                            //                           setState(() {
                            //                             showDialog(
                            //                                 context: context,
                            //                                 builder:
                            //                                     (BuildContext
                            //                                         context) {
                            //                                   return AlertDialogWidget();
                            //                                 });
                            //                             debugPrint("click");
                            //                           });
                            //                         },
                            //                         child: Icon(
                            //                           Icons.delete,
                            //                           color: errorColor,
                            //                         ),
                            //                       )
                            //                     ],
                            //                   ),
                            //                 ),
                            //               )),
                            //             ]))
                            //     .toList(),
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

  void clearSearch() {
    setState(() {});
  }

  void search(String mobileNo, villageCode, villageName, panchayatCode) {
    print("GET_______" +
        mobileNo +
        " " +
        villageCode +
        " " +
        villageName +
        " " +
        panchayatCode);

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("demographicData");
    if (mobileNo != "") {
      // collectionReference.where("family.mobileNumber", arrayContains: mobileNo);
      //  TODO  ::  ::  Need to check this condition
      // collectionReference.orderBy("family").where("mobileNumber", isEqualTo: mobileNo);
      collectionReference.where("location.contactNumber", isEqualTo: mobileNo);
    } else if (villageCode != "") {
      collectionReference.where("location.villagesCode",
          isEqualTo: int.parse(villageCode));
    } else if (panchayatCode != null) {
      collectionReference.where("location.panchayatCode",
          isEqualTo: int.parse(panchayatCode));
    } else {
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
}

class DataTableRow extends DataTableSource {
  List users;
  BuildContext context;
  var height, width;

  DataTableRow(this.context, this.height, this.width, this.users);

  @override
  DataRow getRow(int index) {
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

    debugPrint("FamilyName:${users[index]['name']}");
    return DataRow.byIndex(
        index: index,
        onSelectChanged: (bool selected) {
          if (selected) {
            Get.toNamed('/DetailScreen');
          }
        },
        cells: [
          DataCell(Row(
            children: [
              SizedBox(
                  width: 100,
                  child: TextWidget(
                    text: users[index]['name'],
                    color: darkGreyColor,
                    size: 16,
                    weight: FontWeight.w600,
                  ))
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
            child: Center(
              child: TextWidget(
                text: users[index]['villageCode'],
                color: darkGreyColor,
                size: 16,
                weight: FontWeight.w600,
              ),
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
              child: SvgPicture.asset(
                svgComplete,
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
                      Get.toNamed(
                        '/questionnery',
                      );
                      // Navigator.pushReplacementNamed(context, "/questionnery");
                    },
                    child: Icon(
                      Icons.edit,
                      color: primaryColor,
                    ),
                  ),
                  InkWell(
                    // onTap: () {
                    //   setState(() {
                    //     showDialog(
                    //         context: context,
                    //         builder:
                    //             (BuildContext
                    //         context) {
                    //           return AlertDialogWidget();
                    //         });
                    //     debugPrint("click");
                    //   });
                    // },
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

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
