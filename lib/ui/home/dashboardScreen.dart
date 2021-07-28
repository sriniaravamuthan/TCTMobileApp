
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List jsonResult;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

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
  dispose(){
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
                height: 40,
                width:50,
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 130,
              child: InkWell(
                onTap: () {
                  Get.toNamed('/homeScreen');
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Center(
                    child: TextWidget(
                      text: 'Demographics App'.toUpperCase(),
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
            SizedBox(
              width: 300,
              height: 130,
              child: InkWell(
                onTap: () {
                  Get.toNamed('/homeScreen');
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Center(
                    child: TextWidget(
                      text: 'Survey App'.toUpperCase(),
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

/*
  getJson() async {
    String data =
        await rootBundle.loadString('assets/json/tct_villagelist.json');
    jsonResult = json.decode(data);
    debugPrint("${jsonResult.length}");
    jsonResult.forEach((element) {
      String villageCode = element['villageCode'];
      int panchayatCode = element['panchayatCode'];
      int panchayatNo = element['panchayatNo'];
      int maxCount=element['maxCount'];
      String villageNameTa = element['villageName']['ta'];
      String villageNameEn = element['villageName']['en'];

      debugPrint("Get_____ :$villageCode");
      // debugPrint("Get_____ :$panchayatCode");
      // debugPrint("Get_____ :$panchayatNo");
      // debugPrint("Get_____ :$villageNameEn");
      // debugPrint("Get_____ :$villageNameTa");

      firestoreInstance
          .collection(collectionVillageName)
          .add({
            "villageCode": villageCode,
            "panchayatCode": panchayatCode,
            "panchayatNo": panchayatNo,
            "maxCount":maxCount,
            "villageName": {"en": villageNameEn, "ta": villageNameTa}
          })
          .then((value) => debugPrint("Village Details Added Successfully"))
          .catchError((error) => debugPrint("Village Details Failed to add"));
    });
  }
*/
}
