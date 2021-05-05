import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/language_item.dart';
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Language language;
  String dropDownLang;
  var height, width;
  String userName = "";
  String userMail = "";
  int age = 0;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
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
      body: Center(
        child: SizedBox(
          width: width / 2,
          height: height / 4,
          child: InkWell(
            onTap: () {
              Get.toNamed('/homeScreen');
            },
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Center(
                child: TextWidget(
                  text: 'Demographics Data',
                  color: primaryColor,
                  weight: FontWeight.w600,
                  size: 20,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
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
}
