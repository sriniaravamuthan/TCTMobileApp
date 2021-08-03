import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/language_item.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class SearchCampaignScreen extends StatefulWidget {
  SearchCampaignScreen({Key key}) : super(key: key);

  @override
  _SearchCampaignScreenState createState() => _SearchCampaignScreenState();
}

class _SearchCampaignScreenState extends State<SearchCampaignScreen> {
  Language language;
  String dropDownLang;
  var height, width;
  String userName = "";
  String userMail = "";
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var campaignIDController = TextEditingController();
  var villageCodeController = TextEditingController();
  var campaignNameController = TextEditingController();

  @override
  void initState() {
    if (firebaseAuth.currentUser != null) {
      userName = firebaseAuth.currentUser.displayName;
      userMail = firebaseAuth.currentUser.email;
      debugPrint("userEmail:$userMail");
    }
/*     WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getJson();
    });*/

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
                    Navigator.pop(context);
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
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _portraitMode();
          } else {
            return _landscapeMode();
          }
        },
      ),
    );
  }

  Widget _portraitMode() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.width / 1.3,
        color: Theme.of(context).accentColor,
        margin: EdgeInsets.all(65),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextWidget(
                  text:
                      DemoLocalization.of(context).translate('Search Campaign'),
                  color: Colors.white,
                  size: 18,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Campaign ID'),
                          color: Colors.white,
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        Spacer(flex: 1),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.6,
                          height: MediaQuery.of(context).size.width / 10,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 10, bottom: 8),
                            child: TextFormField(
                              controller: campaignIDController,
                              textInputAction: TextInputAction.next,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                  filled: true,
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
                                  campaignIDController.text = val;
                                });
                              },
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     debugPrint(
                              //         "empid :yes");
                              //     return 'Employee Id must not be empty';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Spacer(),
                        TextWidget(
                          text: DemoLocalization.of(context).translate('Or'),
                          color: Colors.white,
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Campaign Name**'),
                          color: Colors.white,
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        Spacer(flex: 1),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.5,
                          height: MediaQuery.of(context).size.width / 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: campaignNameController,
                              textInputAction: TextInputAction.next,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                  filled: true,
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
                                  campaignNameController.text = val;
                                });
                              },
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     debugPrint(
                              //         "empid :yes");
                              //     return 'Employee Id must not be empty';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Village Codes'),
                          color: Colors.white,
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.4,
                          height: MediaQuery.of(context).size.width / 10,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 20, bottom: 8),
                            child: TextFormField(
                              controller: villageCodeController,
                              textInputAction: TextInputAction.next,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                  filled: true,
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
                                  villageCodeController.text = val;
                                });
                              },
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
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
                                        side: BorderSide(
                                            color: Colors.black45)))),
                            onPressed: () {
                              Get.toNamed('/CampaignListScreen', arguments: [
                                campaignIDController.text.toString(),
                                campaignNameController.text.toString(),
                                villageCodeController.text.toString()
                              ]);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(
                                  width: 10,
                                ),
                                TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Search'),
                                  color: lightColor,
                                  weight: FontWeight.w400,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
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
                              Navigator.pop(context, false);
                            },
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('cancel'),
                              color: lightColor,
                              weight: FontWeight.w400,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _landscapeMode() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Theme.of(context).accentColor,
        margin: EdgeInsets.all(75),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: DemoLocalization.of(context)
                        .translate('Search Campaign'),
                    color: Colors.white,
                    size: 18,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Campaign ID'),
                          color: Colors.white,
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: campaignIDController,
                              textInputAction: TextInputAction.next,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                  filled: true,
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
                                  campaignIDController.text = val;
                                });
                              },
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     debugPrint(
                              //         "empid :yes");
                              //     return 'Employee Id must not be empty';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextWidget(
                            text: DemoLocalization.of(context).translate('Or'),
                            color: Colors.white,
                            size: 16,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Campaign Name**'),
                          color: Colors.white,
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: campaignNameController,
                              textInputAction: TextInputAction.next,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                  filled: true,
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
                                  campaignNameController.text = val;
                                });
                              },
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     debugPrint(
                              //         "empid :yes");
                              //     return 'Employee Id must not be empty';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Village Codes'),
                          color: Colors.white,
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: villageCodeController,
                              textInputAction: TextInputAction.next,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                  filled: true,
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
                                  villageCodeController.text = val;
                                });
                              },
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     debugPrint(
                              //         "empid :yes");
                              //     return 'Employee Id must not be empty';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 14,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
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
                                        side: BorderSide(
                                            color: Colors.black45)))),
                            onPressed: () {
                              Get.toNamed('/CampaignListScreen');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(
                                  width: 10,
                                ),
                                TextWidget(
                                  text: DemoLocalization.of(context)
                                      .translate('Search'),
                                  color: lightColor,
                                  weight: FontWeight.w400,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
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
                              Navigator.pop(context, false);
                            },
                            child: TextWidget(
                              text: DemoLocalization.of(context)
                                  .translate('cancel'),
                              color: lightColor,
                              weight: FontWeight.w400,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
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
}
