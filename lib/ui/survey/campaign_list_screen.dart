import 'dart:async';

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
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/localization/language_item.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/util/snack_bar.dart';
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
  var searchController = TextEditingController();
  bool isLoading = false;
  var arguments;

  // StreamSubscription<ConnectivityResult> listenNetwork;
  bool isInternet;
  Future apiCampaignList, apiSync;
  Data dataCampaign;
  int _currentSortColumn = 0;
  bool _isAscending = true;
  List<CampaignList> campaignList;

  @override
  void initState() {
    campaignList = [];
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
    arguments = Get.arguments;
    debugPrint("Arguments $arguments");
    super.initState();
    /*listenNetwork = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // setState(() {
        result == ConnectivityResult.none
            ? isInternet = false
            : isInternet = true;
      // });
      debugPrint("ConnectivityResult $result");
    });*/
    isInternet = arguments[3];
    if (isInternet) {
      apiCampaignList = setSearchCampaignAPI(SearchCampaignRequest(
          campaignId: arguments[0],
          campaignName: arguments[1],
          villageCode: arguments[2],
          languageCode: "ta"));
      debugPrint("apiCampaignList$apiCampaignList");
    } else {
      apiSync = syncSearchCampaignAPI(SearchCampaignRequest(
          campaignId: arguments[0],
          campaignName: arguments[1],
          villageCode: arguments[2],
          languageCode: "ta"));
    }
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
    int _currentSortColumn = 0;
    bool _isAscending = true;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
  theme: _buildShrineTheme(),
      home: Scaffold(
          resizeToAvoidBottomInset: false,
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
          body: checkOrientation()),
    );
  }

  Widget checkOrientation() {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return FutureBuilder<SearchCampaignResponse>(
            future: isInternet ? apiCampaignList : apiSync,
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (projectSnap.connectionState == ConnectionState.done) {
                debugPrint("SearchCampaign Response : ${projectSnap.data}");
                dataCampaign = projectSnap.data?.data;
                campaignList = dataCampaign.campaignList;
                return _portraitMode();
              } else {
                return Text("Error ${projectSnap.error}");
              }
            },
          );
        } else {
          return FutureBuilder<SearchCampaignResponse>(
            future: isInternet ? apiCampaignList : apiSync,
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (projectSnap.connectionState == ConnectionState.done) {
                debugPrint(
                    "SearchCampaign Response : ${projectSnap.data.data.campaignName}");
                dataCampaign = projectSnap.data?.data;
                campaignList = dataCampaign.campaignList;
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
          width: MediaQuery.of(context).size.width,

          // height: MediaQuery.of(context).size.height / 6,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
            child: Card(
              color: Theme.of(context).accentColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Campaign Name'),
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: dataCampaign?.campaignName,
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Campaign Description'),
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: dataCampaign?.campaignDescription,
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Objective Name'),
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextWidget(
                              text: dataCampaign?.objectiveName,
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Expanded(
                            flex: 1,
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
                          padding: const EdgeInsets.all(4.0),
                          child: Expanded(
                            flex: 1,
                            child: TextWidget(
                              text: dataCampaign?.campaignPopulation,
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Expanded(
                            flex: 1,
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Completed:'),
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Expanded(
                            flex: 1,
                            child: TextWidget(
                              text: dataCampaign?.complete,
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Expanded(
                            flex: 1,
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Pending:'),
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Expanded(
                            flex: 1,
                            child: TextWidget(
                              text: dataCampaign?.pending,
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height / 7,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8,
            ),
            child: Card(
              color: Theme.of(context).accentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWidget(
                        text: 'Showing 30 of 210 records',
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isInternet,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff005aa8)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: BorderSide(color: Colors.red)))),
                          onPressed: () {
                            syncSearchCampaignAPI(SearchCampaignRequest(
                                    campaignId: arguments[0],
                                    campaignName: arguments[1],
                                    villageCode: arguments[2],
                                    languageCode: "ta"))
                                .then((value) => {
                                      snackBarAlert(
                                          success,
                                          "Campaign List is ready for Offline",
                                          successColor)
                                    });
                          },
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Start sync'),
                            color: lightColor,
                            weight: FontWeight.w400,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _searchList(),
                  SizedBox(width: 4,)
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                    columnSpacing: 0.04,
                    sortColumnIndex: _currentSortColumn,
                    sortAscending: _isAscending,
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
                          ),
                          onSort: (columnIndex, _) {
                            setState(() {
                              _currentSortColumn = columnIndex;
                              if (_isAscending == true) {
                                _isAscending = false;
                                campaignList.sort((a, b) => a.familyHeadName
                                    .compareTo(b.familyHeadName));
                              } else {
                                _isAscending = true;
                                campaignList.sort((a, b) => b.familyHeadName
                                    .compareTo(a.familyHeadName));

                                // sort the product list in Descending, order by Price
                              }
                            });
                          }),
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
                          onSort: (columnIndex, _) {
                            setState(() {
                              _currentSortColumn = columnIndex;
                              if (_isAscending == true) {
                                _isAscending = false;
                                campaignList.sort((a, b) => a.respondentName
                                    .compareTo(b.respondentName));
                              } else {
                                _isAscending = true;
                                campaignList.sort((a, b) => b.respondentName
                                    .compareTo(a.respondentName));

                                // sort the product list in Descending, order by Price
                              }
                            });
                          }),
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
                          onSort: (columnIndex, _) {
                            setState(() {
                              _currentSortColumn = columnIndex;
                              if (_isAscending == true) {
                                _isAscending = false;
                                campaignList.sort((a, b) =>
                                    a.villageCode.compareTo(b.villageCode));
                              } else {
                                _isAscending = true;
                                campaignList.sort((a, b) =>
                                    b.villageCode.compareTo(a.villageCode));

                                // sort the product list in Descending, order by Price
                              }
                            });
                          }),
                      DataColumn(
                          label: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Status'),
                            color: lightColor,
                            size: 15,
                            weight: FontWeight.w700,
                          ),
                          onSort: (columnIndex, _) {
                            setState(() {
                              _currentSortColumn = columnIndex;
                              if (_isAscending == true) {
                                _isAscending = false;
                                campaignList.sort(
                                    (a, b) => a.status.compareTo(b.status));
                              } else {
                                _isAscending = true;
                                campaignList.sort(
                                    (a, b) => b.status.compareTo(a.status));

                                // sort the product list in Descending, order by Price
                              }
                            });
                          })
                    ],
                    rows: dataCampaign.campaignList
                        .map(
                          (CampaignList campaignList) => DataRow(
                            onSelectChanged: (bool selected) {
                              Get.toNamed('/SurveyQuestionnaire', arguments: [
                                campaignList.familyId,
                                dataCampaign.campaignId,
                                isInternet
                              ]);
                            },
                            cells: <DataCell>[
                              DataCell(
                                TextWidget(
                                  text: campaignList.familyHeadName,
                                  color: darkColor,
                                  size: 14,
                                  weight: FontWeight.w400,
                                ),
                              ),
                              DataCell(TextWidget(
                                text: campaignList.respondentName,
                                color: darkColor,
                                size: 14,
                                weight: FontWeight.w400,
                              )),
                              DataCell(TextWidget(
                                text: campaignList.mobileNumber,
                                color: darkColor,
                                size: 14,
                                weight: FontWeight.w400,
                              )),
                              DataCell(Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: TextWidget(
                                  text: campaignList.villageCode,
                                  color: darkColor,
                                  size: 14,
                                  weight: FontWeight.w400,
                                ),
                              )),
                              DataCell(TextWidget(
                                text: campaignList.status,
                                color: darkColor,
                                size: 14,
                                weight: FontWeight.w400,
                              )),
                            ],
                          ),
                        )
                        .toList(),
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
                        Icon(Icons.more_horiz,color: Colors.black,),
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
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
            child: Card(
              color: Theme.of(context).accentColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 2),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Campaign Name'),
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: dataCampaign?.campaignName,
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Campaign Description'),
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: dataCampaign?.campaignDescription,
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Objective Name'),
                              size: 14,
                              color: lightColor,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextWidget(
                            text: dataCampaign?.objectiveName,
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Campaign Population'),
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: dataCampaign?.campaignPopulation,
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Completed:'),
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: dataCampaign?.complete,
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Pending:'),
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: dataCampaign?.pending,
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8,
            ),
            child: Card(
              color: Theme.of(context).accentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWidget(
                        text: 'Showing 30 of 210 records',
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Visibility(
                      visible: isInternet,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff005aa8)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(color: Colors.red)))),
                            onPressed: () {
                              syncSearchCampaignAPI(SearchCampaignRequest(
                                      campaignId: arguments[0],
                                      campaignName: arguments[1],
                                      villageCode: arguments[2],
                                      languageCode: "ta"))
                                  .then((value) => {
                                        snackBarAlert(
                                            success,
                                            "Campaign List is ready for Offline",
                                            successColor)
                                      });
                            },
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Start sync'),
                              color: lightColor,
                              weight: FontWeight.w400,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _searchList(),
                  SizedBox(width: 4,)
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DataTable(
                    columnSpacing: MediaQuery.of(context).size.width / 72,
                    sortColumnIndex: _currentSortColumn,
                    sortAscending: _isAscending,
                    showCheckboxColumn: false,
                    horizontalMargin: 0.20,
                    showBottomBorder: true,
                    dataRowColor:  MaterialStateColor.resolveWith(
                            (states) => Color(0xFFffffff)),
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xff005aa8)),
                    columns: <DataColumn>[
                      DataColumn(
                          label: Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: TextWidget(
                                text: DemoLocalization.of(context)
                                    .translate('Family Head'),
                                color: lightColor,
                                size: 14,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                          onSort: (columnIndex, _) {
                            setState(() {
                              _currentSortColumn = columnIndex;
                              if (_isAscending == true) {
                                _isAscending = false;
                                campaignList.sort((a, b) => a.familyHeadName
                                    .compareTo(b.familyHeadName));
                              } else {
                                _isAscending = true;
                                campaignList.sort((a, b) => b.familyHeadName
                                    .compareTo(a.familyHeadName));

                                // sort the product list in Descending, order by Price
                              }
                            });
                          }),
                      DataColumn(
                          label: Expanded(
                            flex: 1,
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Respondent Name'),
                              color: lightColor,
                              size: 14,
                              weight: FontWeight.w700,
                            ),
                          ),
                          onSort: (columnIndex, _) {
                            setState(() {
                              _currentSortColumn = columnIndex;
                              if (_isAscending == true) {
                                _isAscending = false;
                                campaignList.sort((a, b) => a.respondentName
                                    .compareTo(b.respondentName));
                              } else {
                                _isAscending = true;
                                campaignList.sort((a, b) => b.respondentName
                                    .compareTo(a.respondentName));

                                // sort the product list in Descending, order by Price
                              }
                            });
                          }),
                      DataColumn(
                        label: Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Mobile No'),
                            color: lightColor,
                            size: 14,
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
                              size: 14,
                              weight: FontWeight.w700,
                            ),
                          ),
                          onSort: (columnIndex, _) {
                            setState(() {
                              _currentSortColumn = columnIndex;
                              if (_isAscending == true) {
                                _isAscending = false;
                                campaignList.sort((a, b) =>
                                    a.villageCode.compareTo(b.villageCode));
                              } else {
                                _isAscending = true;
                                campaignList.sort((a, b) =>
                                    b.villageCode.compareTo(a.villageCode));

                                // sort the product list in Descending, order by Price
                              }
                            });
                          }),
                      DataColumn(
                          label: Expanded(
                            flex: 1,
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('Status'),
                              color: lightColor,
                              size: 14,
                              weight: FontWeight.w700,
                            ),
                          ),
                          onSort: (columnIndex, _) {
                            setState(() {
                              _currentSortColumn = columnIndex;
                              if (_isAscending == true) {
                                _isAscending = false;
                                campaignList.sort(
                                    (a, b) => a.status.compareTo(b.status));
                              } else {
                                _isAscending = true;
                                campaignList.sort(
                                    (a, b) => b.status.compareTo(a.status));

                                // sort the product list in Descending, order by Price
                              }
                            });
                          })
                    ],
                    rows: dataCampaign.campaignList
                        .map(
                          (CampaignList campaignList) => DataRow(
                            onSelectChanged: (bool selected) {
                              Get.toNamed('/SurveyQuestionnaire', arguments: [
                                campaignList.familyId,
                                dataCampaign.campaignId,
                                isInternet
                              ]);
                            },
                            cells: <DataCell>[
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: TextWidget(
                                    text: campaignList.familyHeadName,
                                    color: darkColor,
                                    size: 14,
                                    weight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              DataCell(TextWidget(
                                text: campaignList.respondentName,
                                color: darkColor,
                                size: 14,
                                weight: FontWeight.w400,
                              )),
                              DataCell(TextWidget(
                                text: campaignList.mobileNumber,
                                color: darkColor,
                                size: 14,
                                weight: FontWeight.w400,
                              )),
                              DataCell(Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: TextWidget(
                                  text: campaignList.villageCode,
                                  color: darkColor,
                                  size: 14,
                                  weight: FontWeight.w400,
                                ),
                              )),
                              DataCell(Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: TextWidget(
                                  text: campaignList.status,
                                  color: darkColor,
                                  size: 14,
                                  weight: FontWeight.w400,
                                ),
                              )),
                            ],
                          ),
                        )
                        .toList(),
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
                        Icon(Icons.more_horiz,color: Colors.black,),
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
  ThemeData _buildShrineTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      iconTheme: _customIconTheme(base.iconTheme),
    );
  }
  Widget _searchList() {
    return Expanded(
      flex: 1,
      child: TextFormField(
        maxLines: 1,
        textAlign: TextAlign.start,
        controller: searchController,
        textInputAction: TextInputAction.done,
        enableSuggestions: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: 2.0, horizontal: 2.0),
            filled: true,
            hintText: "Search",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
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
            searchController.text = val;
          });
        },
      ),
    );
  }

  _customIconTheme(IconThemeData iconTheme) {
    return iconTheme.copyWith(color: lightColor);

  }
}
