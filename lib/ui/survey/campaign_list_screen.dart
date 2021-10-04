import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tct_demographics/api/campaign_list_api.dart';
import 'package:tct_demographics/api/request/search_campaign_request.dart';
import 'package:tct_demographics/api/response/search_campaign_response.dart';
import 'package:tct_demographics/constants/api_constants.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/util/snack_bar.dart';
import 'package:tct_demographics/widgets/survey_text_widget.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class CampaignListScreen extends StatefulWidget {
  CampaignListScreen({Key key}) : super(key: key);

  @override
  _CampaignListScreenState createState() => _CampaignListScreenState();
}

class _CampaignListScreenState extends State<CampaignListScreen> {
  String language;
  String dropDownLang;
  var height, width;
  String userName = "";
  String userMail = "";
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var campaignNameController = TextEditingController();
  var searchController = TextEditingController();
  var arguments;
  bool isInternet;
  Future apiCampaignList, apiSync;
  Data dataCampaign;
  SearchCampaignResponse _searchCampaignResponse;
  int _currentSortColumn = 0;
  bool _isAscending = true;
  List<CampaignList> campaignList;
  int currentPage = 1;
  int totalPages = 0;
  List<CampaignList> campaignLists = [];
  String searchString = "";
  int campaignListLength,searchListLength;

  SearchCampaignRequest searchCampaignRequest = SearchCampaignRequest();
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    _searchCampaignResponse = SearchCampaignResponse(
        data: List.filled(1, Data(campaignList: List.empty(growable: true))));
    campaignList = [];
    if (firebaseAuth.currentUser != null) {
      userName = firebaseAuth.currentUser.displayName;
      userMail = firebaseAuth.currentUser.email;
      debugPrint("userEmail:$userMail");
    }
    getLanguage();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    arguments = Get.arguments;
    debugPrint("Arguments $arguments");
    searchCampaignRequest = SearchCampaignRequest(
        campaignID: arguments[0],
        campaignName: arguments[1],
        villageCode: arguments[2],
        languageCode: language,
        searchKey: "",
        limit: 10,
        page: currentPage);
    isInternet = arguments[3];
    super.initState();
  }

  Future<bool> setSearchCampaignAPI({bool keyRefresh}) async {
    debugPrint("setSearchCampaignAPI :${searchCampaignRequest.page}");
    if (keyRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }
    // searchCampaignRequest.searchKey ="";
    searchCampaignRequest.languageCode =
        await SharedPref().getStringPref(SharedPref().language);
    debugPrint(
        "SearchCampaign Request : ${searchCampaignRequest.campaignID} ${searchCampaignRequest.campaignName} ${searchCampaignRequest.villageCode} ${searchCampaignRequest.languageCode}");

    debugPrint(
        "searchCampaignRequest.languageCode:${searchCampaignRequest.languageCode}");
    // String token = await SharedPref().getStringPref(SharedPref().token);
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json',
      // 'Access-token': '$token'
    };
    debugPrint("requestHeaders:$requestHeaders");
    Map map = {
      "campaignID": searchCampaignRequest.campaignID,
      "campaignName": searchCampaignRequest.campaignName,
      "villageCode": searchCampaignRequest.villageCode,
      "languageCode": searchCampaignRequest.languageCode,
      "searchKey": searchCampaignRequest.searchKey,
      "limit": searchCampaignRequest.limit,
      "page": currentPage
    };
    String body = json.encode(map);
    debugPrint("Search_body:$body");
    if (isInternet) {
      final response =
          // await http.post(Uri.parse(url), body: body, headers: requestHeaders);
          await http.post(Uri.parse(searchCampaignURL),
              headers: requestHeaders, body: body);
      debugPrint("Search_Datas1 ${response.body}");

      SearchCampaignResponse data =
          SearchCampaignResponse.fromJson(json.decode(response.body));
      debugPrint("Search_Data $data");
      debugPrint("KEYFRESH $keyRefresh");

      if (response.statusCode == 200) {
        debugPrint("Response ${data.toJson()}");
        if (!data.error && data.data != null) {
          if (keyRefresh) {
            setState(() {
              _searchCampaignResponse = data;
              campaignLists = data?.data?.first?.campaignList;
              // dataCampaign = data.data.first;
              debugPrint(
                  "users: ${data.data.first.campaignList.first.familyHeadName}");
            });
          } else {
            setState(() {
              _searchCampaignResponse.data.first.campaignList
                  .addAll(data.data.first.campaignList);

              data.data.first.campaignList.forEach((element) {
                debugPrint("users1: ${element.familyHeadName}");
              });
            });
          }
          currentPage++;
          debugPrint("totalPages: $totalPages");
          totalPages = int.tryParse(data.data.first.totalRecords);
          debugPrint("totalPages: $totalPages");

          setState(() {});
          return true;
        } else {
          debugPrint("Response2 ${data.data}");
          snackBarAlert(error, "${data.message}", errorColor);
          refreshController.loadComplete();
          _noData();
          return false;
        }
      } else {
        debugPrint("Response3 ${data.data}");
        snackBarAlert(
            error, "Server Error - ${response.statusCode}", errorColor);
        return false;
      }
    } else {
      Map<String, dynamic> map = await db
          .collection('campaign_list')
          .doc(searchCampaignRequest.campaignID)
          .get();
      debugPrint("Offline List $map");
      if (map != null) {
        var data = SearchCampaignResponse.fromJson(map);
        if (!data.error) {
          setState(() {
            _searchCampaignResponse = data;
            campaignLists = data?.data?.first?.campaignList;
            // dataCampaign = data.data.first;
            debugPrint(
                "users: ${data.data.first.campaignList.first.familyHeadName}");
          });
          return true;
        } else {
          debugPrint("Response2 ${data.data}");
          snackBarAlert(warning, "API Error", errorColor);
          return false;
        }
      } else {
        refreshController.loadComplete();
        _noData();
      }
    }

    // }
  }

  void getLanguage() async {
    language = await SharedPref().getStringPref(SharedPref().language);
    debugPrint("language:$language");
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
        body: checkOrientation(),
/*
          FutureBuilder(
              future: Future.delayed(Duration(seconds: 5)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  debugPrint(
                      "CampaignList1:${_searchCampaignResponse?.data?.first?.campaignList}");
                  return checkOrientation();
                } else {
                  return Text("Error ${snapshot.error}");
                }
              })
*/
      ),
    );
  }

  Widget checkOrientation() {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _portraitMode();
/*
          return FutureBuilder<SearchCampaignResponse>(
            future: isInternet ? apiCampaignList : apiSync,
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (projectSnap.connectionState == ConnectionState.done) {
                debugPrint("SearchCampaign Response : ${projectSnap.data.data}");

                dataCampaign = projectSnap.data.data.first;
                if (dataCampaign != null) {
                  campaignList = dataCampaign.campaignList;
                  searchList = dataCampaign.campaignList;
                  return _portraitMode();
                } else {
                  campaignList = [];
                  searchList = [];
                  return _noData();
                }
              } else {
                return Text("Error ${projectSnap.error}");
              }
            },
          );
*/
        } else {
          return _landscapeMode();
/*
          return FutureBuilder<SearchCampaignResponse>(
            future: isInternet ? apiCampaignList : apiSync,
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (projectSnap.connectionState == ConnectionState.done) {
                debugPrint("SearchCampaign Response : ${projectSnap.data}");
                dataCampaign = projectSnap.data?.data?.first;
                if (dataCampaign != null) {
                  campaignList = dataCampaign.campaignList;
                  searchList = dataCampaign.campaignList;
                  return _landscapeMode();
                } else {
                  campaignList = [];
                  searchList = [];
                  return _noData();
                }
              } else {
                return Text("Error ${projectSnap.error}");
              }
            },
          );
*/
        }
      },
    );
  }

  Widget _noData() {
    return Center(
      child: TextWidget(
        text: 'No Data',
        weight: FontWeight.w700,
        size: 18,
        color: Colors.black87,
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
      child: Card(
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      SurveyTextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Campaign Name'),
                        size: 14,
                        maxLines: 1,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: SurveyTextWidget(
                          text: _searchCampaignResponse
                              ?.data?.first?.campaignName,
                          size: 14,
                          color: lightColor,
                          maxLines: 3,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      SurveyTextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Campaign Description'),
                        size: 14,
                        maxLines: 3,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: SurveyTextWidget(
                          text: _searchCampaignResponse
                              ?.data?.first?.campaignDescription,
                          size: 14,
                          color: lightColor,
                          maxLines: 2,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      SurveyTextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Objective Name'),
                        size: 14,
                        maxLines: 1,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: SurveyTextWidget(
                          text: _searchCampaignResponse
                              ?.data?.first?.objectiveName,
                          size: 14,
                          maxLines: 2,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      SurveyTextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Campaign Population'),
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: SurveyTextWidget(
                          text: _searchCampaignResponse
                              ?.data?.first?.campaignPopulation,
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      SurveyTextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Completed:'),
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: TextWidget(
                          text: _searchCampaignResponse?.data?.first?.complete,
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      SurveyTextWidget(
                        text:
                            DemoLocalization.of(context).translate('Pending:'),
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: SurveyTextWidget(
                          text: _searchCampaignResponse?.data?.first?.pending,
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
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

  Widget _landscapeMode() {
    debugPrint(
        "CampaignList....:${_searchCampaignResponse?.data?.first?.campaignList?.length}");
    return Column(
      children: [
        header(),
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
                        text:
                            'Showing ${searchString.isNotEmpty? searchListLength : campaignListLength} of ${_searchCampaignResponse.data.first.totalRecords != null ? _searchCampaignResponse.data.first.totalRecords : 0} records',
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _searchCampaignResponse
                                .data.first.campaignList.isNotEmpty &&
                            isInternet != false
                        ? true
                        : false,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainInteractivity: true,
                    maintainState: true,
                    maintainSemantics: true,
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
                                    campaignID: arguments[0],
                                    campaignName: arguments[1],
                                    villageCode: arguments[2],
                                    languageCode: language,
                                    searchKey: ""))
                                .then((value) {
                              debugPrint("SearchCampaignRequest:${value.data}");
                              snackBarAlert(
                                  success,
                                  "Campaign List is ready for Offline",
                                  successColor);
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
                  SizedBox(
                    width: 4,
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
            child: SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: true,
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus status) {
                  Widget body;
                  if (status == LoadStatus.idle) {
                    body = Text("Pull up load");
                  } else if (status == LoadStatus.loading) {
                    body = CircularProgressIndicator.adaptive();
                  } else if (status == LoadStatus.noMore) {
                    body = Text("Release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              onRefresh: () async {
                final result = await setSearchCampaignAPI(keyRefresh: true);
                if (result != null) {
                  debugPrint("onRefresh$result");
                  refreshController.refreshCompleted();
                } else {
                  refreshController.refreshFailed();
                  return _noData();
                }
              },
              onLoading: () async {
                final result = await setSearchCampaignAPI(keyRefresh: false);
                if (result != null) {
                  debugPrint("onLoading$result");
                  refreshController.loadComplete();
                } else {
                  refreshController.loadFailed();
                  return _noData();
                }
                debugPrint("apiCampaignList$apiCampaignList");
              },
              child: DataTable(
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
                            _searchCampaignResponse.data.first.campaignList
                                .sort((a, b) => a.familyHeadName
                                    .compareTo(b.familyHeadName));
                          } else {
                            _isAscending = true;
                            _searchCampaignResponse.data.first.campaignList
                                .sort((a, b) => b.familyHeadName
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
                            _searchCampaignResponse.data.first.campaignList
                                .sort((a, b) => a.respondentName
                                    .compareTo(b.respondentName));
                          } else {
                            _isAscending = true;
                            _searchCampaignResponse.data.first.campaignList
                                .sort((a, b) => b.respondentName
                                    .compareTo(a.respondentName));

                            // sort the product list in Descending, order by Price
                          }
                        });
                      }),
                  DataColumn(
                    label: TextWidget(
                      text: DemoLocalization.of(context).translate('Mobile No'),
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
                            _searchCampaignResponse.data.first.campaignList
                                .sort((a, b) =>
                                    a.villageCode.compareTo(b.villageCode));
                          } else {
                            _isAscending = true;
                            _searchCampaignResponse.data.first.campaignList
                                .sort((a, b) =>
                                    b.villageCode.compareTo(a.villageCode));

                            // sort the product list in Descending, order by Price
                          }
                        });
                      }),
                  DataColumn(
                      label: TextWidget(
                        text: DemoLocalization.of(context).translate('Status'),
                        color: lightColor,
                        size: 15,
                        weight: FontWeight.w700,
                      ),
                      onSort: (columnIndex, _) {
                        setState(() {
                          _currentSortColumn = columnIndex;
                          if (_isAscending == true) {
                            _isAscending = false;
                            _searchCampaignResponse.data.first.campaignList
                                .sort((a, b) => a.status.compareTo(b.status));
                          } else {
                            _isAscending = true;
                            _searchCampaignResponse.data.first.campaignList
                                .sort((a, b) => b.status.compareTo(a.status));

                            // sort the product list in Descending, order by Price
                          }
                        });
                      })
                ],
                rows: _searchCampaignResponse?.data?.first?.campaignList
                    ?.map(
                      (CampaignList campaignList) => DataRow(
                        onSelectChanged: (bool selected) {
                          Get.toNamed('/SurveyQuestionnaire', arguments: [
                            campaignList?.familyId,
                            _searchCampaignResponse?.data?.first?.campaignId,
                            isInternet,
                            arguments[2]
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
                            text: campaignList.mobileNumber ?? "-",
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
                    ?.toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _portraitMode() {
    return Column(
      children: [
        header(),
/*
        Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
            child: Card(
              color: Theme.of(context).accentColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 3,
                          child: SurveyTextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Campaign Name'),
                            size: 14,
                            maxLines: 1,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SurveyTextWidget(
                            text: dataCampaign?.campaignName,
                            size: 14,
                            color: lightColor,
                            maxLines: 3,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: SurveyTextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Campaign Description'),
                            size: 14,
                            maxLines: 1,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SurveyTextWidget(
                            text: dataCampaign?.campaignDescription,
                            size: 14,
                            color: lightColor,
                            maxLines: 3,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8,top:4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 3,
                          child: SurveyTextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Objective Name'),
                            size: 14,
                            maxLines: 2,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SurveyTextWidget(
                            text: dataCampaign?.objectiveName,
                            size: 14,
                            maxLines: 2,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SurveyTextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Campaign Population'),
                            size: 14,
                            maxLines: 2,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Flexible(
                          child: SurveyTextWidget(
                            text: dataCampaign?.campaignPopulation,
                            size: 14,
                            maxLines: 1,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SurveyTextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Completed:'),
                            size: 14,
                            maxLines: 1,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Flexible(
                          child: SurveyTextWidget(
                            text: dataCampaign?.complete,
                            size: 14,
                            maxLines: 2,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SurveyTextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Pending:'),
                            size: 14,
                            maxLines: 2,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Flexible(
                          child: SurveyTextWidget(
                            text: dataCampaign?.pending,
                            size: 14,
                            maxLines: 2,
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
*/
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
                        text:
                            'Showing ${searchString != "" ? searchListLength : "${_searchCampaignResponse?.data?.first?.campaignList?.length}"} of ${_searchCampaignResponse.data.first.totalRecords != null ? _searchCampaignResponse.data.first.totalRecords : 0} records',
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Visibility(
                      visible: _searchCampaignResponse
                                  .data.first.campaignList.isNotEmpty &&
                              isInternet != false
                          ? true
                          : false,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainInteractivity: true,
                      maintainState: true,
                      maintainSemantics: true,
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
                                      campaignID: arguments[0],
                                      campaignName: arguments[1],
                                      villageCode: arguments[2],
                                      languageCode: language,
                                      searchKey: ""))
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
                  SizedBox(
                    width: 4,
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(left: 6.0, right: 6, top: 4),
            child: SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: true,
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus status) {
                  Widget body;
                  if (status == LoadStatus.idle) {
                    body = Text("Pull up load");
                  } else if (status == LoadStatus.loading) {
                    body = CircularProgressIndicator.adaptive();
                  } else if (status == LoadStatus.canLoading) {
                    body = Text("Release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              onRefresh: () async {
                final result = await setSearchCampaignAPI(keyRefresh: true);
                if (result != null) {
                  debugPrint("onRefresh$result");

                  refreshController.refreshCompleted();
                } else {
                  refreshController.refreshFailed();
                  return _noData();
                }
              },
              onLoading: () async {
                final result = await setSearchCampaignAPI(keyRefresh: false);
                if (result != null) {
                  debugPrint("onLoading$result");
                  refreshController.loadComplete();
                } else {
                  refreshController.loadFailed();
                  return _noData();
                }
              },
              child: DataTable(
                columnSpacing: MediaQuery.of(context).size.width / 72,
                sortColumnIndex: _currentSortColumn,
                sortAscending: _isAscending,
                showCheckboxColumn: false,
                horizontalMargin: 0.20,
                showBottomBorder: true,
                dataRowColor: MaterialStateColor.resolveWith(
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
                            _searchCampaignResponse?.data?.first?.campaignList
                                ?.sort((a, b) => a.familyHeadName
                                    .compareTo(b.familyHeadName));
                          } else {
                            _isAscending = true;
                            _searchCampaignResponse?.data?.first?.campaignList
                                ?.sort((a, b) => b.familyHeadName
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
                            _searchCampaignResponse?.data?.first?.campaignList
                                ?.sort((a, b) => a.respondentName
                                    .compareTo(b.respondentName));
                          } else {
                            _isAscending = true;
                            _searchCampaignResponse?.data?.first?.campaignList
                                ?.sort((a, b) => b.respondentName
                                    .compareTo(a.respondentName));

                            // sort the product list in Descending, order by Price
                          }
                        });
                      }),
                  DataColumn(
                    label: Expanded(
                      flex: 1,
                      child: TextWidget(
                        text:
                            DemoLocalization.of(context).translate('Mobile No'),
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
                            _searchCampaignResponse?.data?.first?.campaignList
                                ?.sort((a, b) =>
                                    a.villageCode.compareTo(b.villageCode));
                          } else {
                            _isAscending = true;
                            _searchCampaignResponse?.data?.first?.campaignList
                                ?.sort((a, b) =>
                                    b.villageCode.compareTo(a.villageCode));

                            // sort the product list in Descending, order by Price
                          }
                        });
                      }),
                  DataColumn(
                      label: Expanded(
                        flex: 1,
                        child: TextWidget(
                          text:
                              DemoLocalization.of(context).translate('Status'),
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
                            _searchCampaignResponse?.data?.first?.campaignList
                                ?.sort((a, b) => a.status.compareTo(b.status));
                          } else {
                            _isAscending = true;
                            _searchCampaignResponse?.data?.first?.campaignList
                                ?.sort((a, b) => b.status.compareTo(a.status));

                            // sort the product list in Descending, order by Price
                          }
                        });
                      })
                ],
                rows: _searchCampaignResponse?.data?.first?.campaignList
                    ?.map(
                      (CampaignList campaignList) => DataRow(
                        onSelectChanged: (bool selected) {
                          Get.toNamed('/SurveyQuestionnaire', arguments: [
                            campaignList?.familyId,
                            _searchCampaignResponse?.data?.first?.campaignId,
                            isInternet,
                            arguments[2]
                          ]);
                        },
                        cells: <DataCell>[
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: TextWidget(
                                text: campaignList?.familyHeadName,
                                color: darkColor,
                                size: 14,
                                weight: FontWeight.w400,
                              ),
                            ),
                          ),
                          DataCell(TextWidget(
                            text: campaignList?.respondentName,
                            color: darkColor,
                            size: 14,
                            weight: FontWeight.w400,
                          )),
                          DataCell(TextWidget(
                            text: campaignList.mobileNumber ?? "-",
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
                              text: campaignList?.status,
                              color: darkColor,
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                          )),
                        ],
                      ),
                    )
                    ?.toList(),
              ),
            ),
          ),
        ),
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
            contentPadding:
                EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
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
        onChanged: (String val) {
          setState(() {
            debugPrint("SearchCampaignList: $campaignLists");
            if (val != "") {
              setState(() {
                searchString = val;
                debugPrint("campaignLists!@@:$campaignLists");
                _searchCampaignResponse?.data?.first?.campaignList =
                    campaignLists
                        .where((campaignList) =>
                            campaignList.familyHeadName
                                .contains(val.capitalize) ||
                            campaignList.respondentName
                                .contains(val.capitalize))
                        .toList();
                searchListLength =
                    _searchCampaignResponse?.data?.first?.campaignList?.length;
                debugPrint(
                    "campaignList:${_searchCampaignResponse?.data?.first?.campaignList?.length}");
              });
            } else {
              setState(() {
                refreshController.requestRefresh();
                campaignListLength=_searchCampaignResponse?.data?.first?.campaignList?.length;
              });
            }
          });
        },
      ),
    );
  }

  _customIconTheme(IconThemeData iconTheme) {
    return iconTheme.copyWith(color: lightColor);
  }
}
