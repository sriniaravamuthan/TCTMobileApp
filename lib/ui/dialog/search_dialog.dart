/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 1/4/21 5:39 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 1/4/21 5:39 PM by Kanmalai.
 * /
 */

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class SearchDialog extends StatefulWidget {
  final Function search, clearSearch;

  SearchDialog(this.search, this.clearSearch);

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  var snapShot;
  List<QueryDocumentSnapshot> snap;
  List villageCodeList = [], villageNameList = [];
  List<String> panchayatCodeList = [];
  var mobileNoController = TextEditingController();
  var villageCodeController = TextEditingController();
  var villageNameController = TextEditingController();
  var panchayatCodeController = TextEditingController();
String language;
  @override
  void initState() {
    getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: TextWidget(
        text: DemoLocalization.of(context).translate('Search'),
        size: 16,
        weight: FontWeight.w600,
      ),
      children: [
        Divider(
          thickness: 1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4, top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                              padding: const EdgeInsets.all(4.0),
                              child: TextWidget(
                                text: DemoLocalization.of(context)
                                    .translate('Mobile'),
                                size: 14,
                                weight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 58,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  controller: mobileNoController,
                                  maxLength: 10,
                                  /*onChanged: (value) {
                                    mobileNoController.text = value;
                                  },*/
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
                                  keyboardType: TextInputType.phone,
                                  onSaved: (String val) {
                                    setState(() {
                                      mobileNoController.text=val;
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
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextWidget(
                                text: DemoLocalization.of(context)
                                    .translate('Village Code'),
                                size: 14,
                                weight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 58,
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: AutoCompleteTextField(
                                      controller: villageCodeController,
                                      clearOnSubmit: false,
                                      itemSubmitted: (item) {
                                        villageCodeController.text = item;
                                        for(int i = 0; i < villageCodeList.length; i++) {
                                          if (item == villageCodeList[i]) {
                                            setState(() {
                                              villageNameController.text = villageNameList[i];
                                              panchayatCodeController.text = panchayatCodeList[i];
                                            });
                                            break;
                                          };
                                        }
                                      },
                                      suggestions: villageCodeList,
                                      style: TextStyle(
                                        color: Color(0xFF222222),
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: lightGreyColor),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: lightGreyColor),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: lightGreyColor),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: lightGreyColor),
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
                                        return item
                                            .toLowerCase()
                                            .startsWith(query.toLowerCase());
                                      })),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
              child: Row(
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
                              padding: const EdgeInsets.all(4.0),
                              child: TextWidget(
                                text: DemoLocalization.of(context)
                                    .translate('Village Name'),
                                size: 14,
                                weight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 58,
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: AutoCompleteTextField(
                                      controller: villageNameController,
                                      clearOnSubmit: false,
                                      /*textChanged: (data) {
                                        villageNameController.text = data;
                                        for(int i = 0; i < villageNameList.length; i++) {
                                          if (data == villageNameList[i]) {
                                            setState(() {
                                              villageCodeController.text = villageCodeList[i];
                                              panchayatCodeController.text = panchayatCodeList[i];
                                            });
                                            break;
                                          };
                                        }
                                      },*/
                                      itemSubmitted: (item) {
                                        villageNameController.text = item;
                                        for(int i = 0; i < villageNameList.length; i++) {
                                          if (item == villageNameList[i]) {
                                            setState(() {
                                              villageCodeController.text = villageCodeList[i];
                                              panchayatCodeController.text = panchayatCodeList[i];
                                            });
                                            break;
                                          };
                                        }
                                      },
                                      suggestions: villageNameList,
                                      style: TextStyle(
                                        color: Color(0xFF222222),
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: lightGreyColor),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: lightGreyColor),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: lightGreyColor),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: lightGreyColor),
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
                                        return item
                                            .toLowerCase()
                                            .startsWith(query.toLowerCase());
                                      })),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextWidget(
                                text: DemoLocalization.of(context)
                                    .translate('Panchayat Code'),
                                size: 14,
                                weight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 58,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: AutoCompleteTextField(
                                    controller:
                                    panchayatCodeController,
                                    clearOnSubmit: false,
                                    /*textChanged: (data) {
                                      panchayatCodeController.text = data;
                                    },*/
                                    itemSubmitted: (item) {
                                      panchayatCodeController.text = item;
                                      setState(() {
                                        villageNameController.text = "";
                                        villageCodeController.text = "";
                                        villageCodeList.clear();
                                        villageNameList.clear();
                                        snap.forEach((element) {
                                          if(element.data()["panchayatCode"].toString() == item) {
                                            villageCodeList.add(element.data()["villageCode"].toString());
                                            villageNameList.add(element.data()["villageName"][language].toString());
                                          }
                                        });
                                      });
                                    },
                                    suggestions:
                                    panchayatCodeList,
                                    style: TextStyle(
                                      color: Color(0xFF222222),
                                      fontSize: 16,
                                    ),
                                    decoration: InputDecoration(
                                        border:
                                        OutlineInputBorder(
                                          borderSide:
                                          BorderSide.none,
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius
                                                  .circular(
                                                  10.0)),
                                        ),
                                        enabledBorder:
                                        OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius
                                                  .circular(
                                                  10.0)),
                                          borderSide: BorderSide(
                                              color:
                                              lightGreyColor),
                                        ),
                                        focusedBorder:
                                        OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius
                                                  .circular(
                                                  10.0)),
                                          borderSide: BorderSide(
                                              color:
                                              lightGreyColor),
                                        ),
                                        focusedErrorBorder:
                                        OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius
                                                  .circular(
                                                  10.0)),
                                          borderSide: BorderSide(
                                              color:
                                              lightGreyColor),
                                        ),
                                        errorBorder:
                                        OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius
                                                  .circular(
                                                  10.0)),
                                          borderSide: BorderSide(
                                              color:
                                              lightGreyColor),
                                        ),
                                        fillColor:
                                        lightGreyColor),
                                    itemBuilder:
                                        (context, item) {
                                      return new Padding(
                                          padding:
                                          EdgeInsets.all(
                                              8.0),
                                          child: TextWidget(
                                            text: item,
                                            color: darkColor,
                                            size: 14,
                                            weight:
                                            FontWeight.w600,
                                          ));
                                    },
                                    itemSorter: (a, b) {
                                      return a.compareTo(b);
                                    },
                                    itemFilter: (item, query) {
                                      return item
                                          .toLowerCase()
                                          .startsWith(query
                                          .toLowerCase());
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Expanded(
            //         child: Align(
            //           alignment: Alignment.topLeft,
            //           child: FractionallySizedBox(
            //             widthFactor: 1,
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.all(4.0),
            //                   child: TextWidget(
            //                     text: DemoLocalization.of(context)
            //                         .translate('Zone'),
            //                     size: 14,
            //                     weight: FontWeight.w600,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 58,
            //                   width: 200,
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(4.0),
            //                     child: DropdownButtonFormField<String>(
            //                       isExpanded: true,
            //                       decoration: InputDecoration(
            //                           border: OutlineInputBorder(
            //                             borderSide: BorderSide.none,
            //                             borderRadius: BorderRadius.all(
            //                                 Radius.circular(10.0)),
            //                           ),
            //                           enabledBorder: OutlineInputBorder(
            //                             borderRadius: BorderRadius.all(
            //                                 Radius.circular(10.0)),
            //                             borderSide:
            //                                 BorderSide(color: lightGreyColor),
            //                           ),
            //                           focusedBorder: OutlineInputBorder(
            //                             borderRadius: BorderRadius.all(
            //                                 Radius.circular(10.0)),
            //                             borderSide:
            //                                 BorderSide(color: lightGreyColor),
            //                           ),
            //                           focusedErrorBorder: OutlineInputBorder(
            //                             borderRadius: BorderRadius.all(
            //                                 Radius.circular(10.0)),
            //                             borderSide:
            //                                 BorderSide(color: lightGreyColor),
            //                           ),
            //                           errorBorder: OutlineInputBorder(
            //                             borderRadius: BorderRadius.all(
            //                                 Radius.circular(10.0)),
            //                             borderSide:
            //                                 BorderSide(color: lightGreyColor),
            //                           ),
            //                           fillColor: lightGreyColor),
            //                       value: zoneVal,
            //                       validator: (value) => value == null
            //                           ? 'Source Type must not be empty'
            //                           : null,
            //                       onChanged: (value) =>
            //                           setState(() => zoneVal = value),
            //                       items: <String>[
            //                         'kangeyam',
            //                         'puthupalayam',
            //                         'nallur',
            //                       ].map<DropdownMenuItem<String>>(
            //                           (String value) {
            //                         return DropdownMenuItem<String>(
            //                           value: value,
            //                           child: TextWidget(
            //                             text: value,
            //                             color: darkColor,
            //                             weight: FontWeight.w400,
            //                             size: 14,
            //                           ),
            //                         );
            //                       }).toList(),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)))),
                    onPressed: () {
                      widget.clearSearch();
                      Navigator.pop(context, false);
                    },
                    child: TextWidget(
                      text: DemoLocalization.of(context).translate('cancel'),
                      color: darkColor,
                      weight: FontWeight.w400,
                      size: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff005aa8)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black45)))),
                    onPressed: () {
                      widget.search(
                          mobileNoController.text, villageCodeController.text, villageNameController.text, panchayatCodeController.text);
                      Navigator.pop(context, false);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        TextWidget(
                          text:
                          DemoLocalization.of(context).translate('Search'),
                          color: lightColor,
                          weight: FontWeight.w400,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
  void getLanguage() async {
    language = await SharedPref().getStringPref(SharedPref().language);
    debugPrint("language:$language");
    getVillageDetails(language);
    // getVillageName();
  }

  Future<void> getVillageDetails(String language) async {
    QuerySnapshot querySnapshot =
    await firestoreInstance.collection(collectionVillageName).get();
    setState(() {
      snapShot = querySnapshot.docs;

      snap = querySnapshot.docs;

      var villageCodeDoc = querySnapshot.docs.map((doc) => doc.data()["villageCode"]).toList();
      var villageNameDoc = querySnapshot.docs.map((doc) => doc.data()["villageName"][language]).toList();
      var panchayatCodeDoc = querySnapshot.docs.map((doc) => doc.data()["panchayatCode"]).toList();

      villageCodeDoc.forEach((element) {
        villageCodeList.add(element.toString());
      });
      villageNameDoc.forEach((element) {
        villageNameList.add(element.toString());
      });

      panchayatCodeDoc.forEach((element) {
        panchayatCodeList.add(element.toString());
      });
    });
  }
}
