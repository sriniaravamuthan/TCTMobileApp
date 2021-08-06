import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/api/campaign_list_api.dart';
import 'package:tct_demographics/api/request/search_campaign_request.dart';
import 'package:tct_demographics/api/response/search_campaign_response.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/language_item.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class CampaignListScreen extends StatefulWidget {
  CampaignListScreen({Key key}) : super(key: key);

  @override
  _CampaignListScreenState createState() => _CampaignListScreenState();
}

class _CampaignListScreenState extends State<CampaignListScreen> {
  Language language;
  String dropDownLang;
  var height, width;
  String userName = "";
  String userMail = "";
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var campaignNameController = TextEditingController();
  bool isLoading = false;
  var _campaignList = [];
  var arguments;
  StreamSubscription<ConnectivityResult> listenNetwork;
  bool isInternet = false;
  Future apiCampaignList;
  Data dataCampaign;

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
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // setState(() {
    arguments = Get.arguments;
    // });
    debugPrint("Arguments $arguments");
    super.initState();
    /* listenNetwork = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // setState(() {
        result == ConnectivityResult.none
            ? isInternet = false
            : isInternet = true;
      // });
      debugPrint("ConnectivityResult $result");
    });*/
    apiCampaignList = setSearchCampaignAPI(SearchCampaignRequest(
        campaignId: arguments[0],
        campaignName: arguments[1],
        villageCode: arguments[2],
        languageCode: "ta"));
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
    // listenNetwork.cancel();
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
                      Get.toNamed('/dashBoard');
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
        body: checkOrientation());
  }

  Widget checkOrientation() {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return FutureBuilder<SearchCampaignResponse>(
            future: apiCampaignList,
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (projectSnap.connectionState == ConnectionState.done) {
                debugPrint("SearchCampaign Response : ${projectSnap.data}");
                dataCampaign = projectSnap.data?.data;
                return _portraitMode();
              } else {
                return Text("Error ${projectSnap.error}");
              }
            },
          );
        } else {
          return FutureBuilder<SearchCampaignResponse>(
            future: apiCampaignList,
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (projectSnap.connectionState == ConnectionState.done) {
                debugPrint(
                    "SearchCampaign Response : ${projectSnap.data.data.campaignName}");
                dataCampaign = projectSnap.data?.data;
                return _landscapeMode();
              } else {
                return Text("Error ${projectSnap.error}");
              }
            },
          );
        }
      },
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

  Widget _landscapeMode() {
    debugPrint("CampaignList:${dataCampaign?.campaignName}");
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
            child: Card(
              color: Theme.of(context).accentColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Campaign Name'),
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 4,
                        ),
                        child: SizedBox(
                          width: 100,
                          child: TextWidget(
                            // text: dataCampaign?.campaignName,
                            text: "Campaign for Diabetes",
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Campaign Description'),
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 4,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SizedBox(
                            width: 100,
                            child: TextWidget(
                              text: "Diabetes for Women of age > 60",
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Objective Name'),
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 4,
                        ),
                        child: TextWidget(
                          text: "Diabetes",
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Campaign Population'),
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 4.0, bottom: 4, left: 2),
                        child: TextWidget(
                          text: "370",
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Completed:'),
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 4.0, bottom: 4, left: 2),
                        child: TextWidget(
                          text: "60",
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Pending:'),
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 4.0, bottom: 4, left: 2),
                        child: TextWidget(
                          text: "60",
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        width: 250,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 8,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
            child: Card(
              color: Theme.of(context).accentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 16.0, right: 8.0),
                    child: TextWidget(
                      text: 'Showing 30 of 210 records',
                      size: 14,
                      color: lightColor,
                      weight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.7,
                    height: MediaQuery.of(context).size.height / 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: campaignNameController,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                            hintText: "Search",
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            suffixIcon: Icon(Icons.search),
                            fillColor: Colors.white),
                        keyboardType: TextInputType.text,
                        onSaved: (String val) {
                          setState(() {
                            campaignNameController.text = val;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                    columnSpacing: 0.04,
                    showCheckboxColumn: false,
                    showBottomBorder: true,
                    // horizontalMargin: 0.10,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xff005aa8)),
                    columns: <DataColumn>[
                      DataColumn(
                          label: TextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Family Head'),
                        color: lightColor,
                        size: 15,
                        weight: FontWeight.w700,
                      )),
                      DataColumn(
                        label: SizedBox(
                          width: 160,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Respondent Name'),
                            color: lightColor,
                            size: 15,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Mobile No'),
                          color: lightColor,
                          size: 15,
                          weight: FontWeight.w700,
                        ),
                      ),
                      DataColumn(
                        label: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Village Code'),
                          color: lightColor,
                          size: 15,
                          weight: FontWeight.w700,
                        ),
                      ),
                      DataColumn(
                          label: TextWidget(
                        text: DemoLocalization.of(context).translate('Status'),
                        color: lightColor,
                        size: 15,
                        weight: FontWeight.w700,
                      ))
                    ],
                    rows: <DataRow>[
                      DataRow(
                        onSelectChanged: (bool selected) {
                          Get.toNamed(
                            '/SurveyQuestionnaire',
                          );
                        },
                        cells: <DataCell>[
                          DataCell(
                            TextWidget(
                              text: "Mohit".toString(),
                              color: darkGreyColor,
                              size: 16,
                              weight: FontWeight.w400,
                            ),
                          ),
                          DataCell(TextWidget(
                            text: "Mohit".toString(),
                            color: darkGreyColor,
                            size: 16,
                            weight: FontWeight.w400,
                          )),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Akshay')),
                          DataCell(Text('Akshay')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Deepak')),
                          DataCell(Text('Deepak')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Deepak')),
                          DataCell(Text('Deepak')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Deepak')),
                          DataCell(Text('Deepak')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Deepak')),
                          DataCell(Text('Deepak')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Deepak')),
                          DataCell(Text('Deepak')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('')),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
/*
            loadMore = true;
            loadData = true;
            if (snapshot.data.docs.length > 0) {
              query = query
                  .startAfterDocument(snapshot.data.docs[
              snapshot.data.docs.length - 1])
                  .limit(30);
              setState(() {
                isLoading = true;
              });
            }
*/
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              isLoading
                  ? Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Center(child: CircularProgressIndicator()))
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 24, bottom: 8),
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
                        Icon(Icons.more_horiz),
                        SizedBox(
                          width: 5,
                        ),
                        TextWidget(
                          text: DemoLocalization.of(context)
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
    );
  }

  Widget _portraitMode() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 8,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
            child: Card(
              color: Theme.of(context).accentColor,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Campaign Name'),
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 4,
                        ),
                        child: SizedBox(
                          width: 100,
                          child: TextWidget(
                            text: "Campaign for Diabetes",
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 90,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Campaign Description'),
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 4,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SizedBox(
                            width: 130,
                            child: TextWidget(
                              text: "Diabetes for Women of age > 60",
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 100,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Objective Name'),
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                        child: TextWidget(
                          text: "Diabetes",
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 80,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Campaign Population'),
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4.0,
                          bottom: 4,
                        ),
                        child: TextWidget(
                          text: "370",
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Completed:'),
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w700,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                        child: TextWidget(
                          text: "60",
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: 107,
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Pending:'),
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w700,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                        child: TextWidget(
                          text: "60",
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 15,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
            child: Card(
              color: Theme.of(context).accentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 16.0, right: 8.0),
                    child: TextWidget(
                      text: 'Showing 30 of 210 records',
                      size: 14,
                      color: lightColor,
                      weight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.7,
                    height: MediaQuery.of(context).size.height / 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: campaignNameController,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                            hintText: "Search",
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            suffixIcon: Icon(Icons.search),
                            fillColor: Colors.white),
                        keyboardType: TextInputType.text,
                        onSaved: (String val) {
                          setState(() {
                            campaignNameController.text = val;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DataTable(
                    columnSpacing: MediaQuery.of(context).size.width / 40,
                    showCheckboxColumn: false,
                    horizontalMargin: 0.8,
                    showBottomBorder: true,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xff005aa8)),
                    columns: <DataColumn>[
                      DataColumn(
                          label: Padding(
                        padding: const EdgeInsets.only(
                          top: 2.0,
                          bottom: 2.0,
                          left: 4,
                        ),
                        child: Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Family Head'),
                            color: lightColor,
                            size: 15,
                            weight: FontWeight.w700,
                          ),
                        ),
                      )),
                      DataColumn(
                        label: Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Respondent Name'),
                            color: lightColor,
                            size: 15,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Mobile No'),
                            color: lightColor,
                            size: 15,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Village Code'),
                            color: lightColor,
                            size: 15,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                          label: Expanded(
                        flex: 1,
                        child: TextWidget(
                          text:
                              DemoLocalization.of(context).translate('Status'),
                          color: lightColor,
                          size: 15,
                          weight: FontWeight.w700,
                        ),
                      ))
                    ],
                    rows: <DataRow>[
                      DataRow(
                        onSelectChanged: (bool selected) {
                          Get.toNamed(
                            '/SurveyQuestionnaire',
                          );
                        },
                        cells: <DataCell>[
                          DataCell(
                            TextWidget(
                              text: "Mohit".toString(),
                              color: darkGreyColor,
                              size: 16,
                              weight: FontWeight.w400,
                            ),
                          ),
                          DataCell(TextWidget(
                            text: "Mohit Kumar".toString(),
                            color: darkGreyColor,
                            size: 16,
                            weight: FontWeight.w400,
                          )),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('Completed')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Akshay')),
                          DataCell(Text('Akshay')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('Pending')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Deepak')),
                          DataCell(Text('Rajesh')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('Pending')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Deepak')),
                          DataCell(Text('Deepak')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('Completed')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Deepak')),
                          DataCell(Text('Deepak')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('Completed')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Deepak')),
                          DataCell(Text('Deepak Kumar')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('Pending')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Deepak')),
                          DataCell(Text('Deepak')),
                          DataCell(Text('7856589655')),
                          DataCell(Text('CTL')),
                          DataCell(Text('Completed')),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
/*
            loadMore = true;
            loadData = true;
            if (snapshot.data.docs.length > 0) {
              query = query
                  .startAfterDocument(snapshot.data.docs[
              snapshot.data.docs.length - 1])
                  .limit(30);
              setState(() {
                isLoading = true;
              });
            }
*/
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              isLoading
                  ? Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Center(child: CircularProgressIndicator()))
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 24, bottom: 8),
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
                        Icon(Icons.more_horiz),
                        SizedBox(
                          width: 5,
                        ),
                        TextWidget(
                          text: DemoLocalization.of(context)
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
    );
  }
}
