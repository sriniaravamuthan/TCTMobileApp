import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/ui/auth/login.dart';
import 'package:tct_demographics/ui/auth/splash_screen.dart';
import 'package:tct_demographics/ui/home/dashboardScreen.dart';
import 'package:tct_demographics/ui/home/detailedUser.dart';
import 'package:tct_demographics/ui/home/homescreen.dart';
import 'package:tct_demographics/ui/questionnaire/questionnaires.dart';
import 'package:tct_demographics/ui/survey/campaign_list_screen.dart';
import 'package:tct_demographics/ui/survey/search_campaign_screen.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

import 'localization/localization.dart';
import 'ui/survey/survey_questionnaire_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) => runApp(MyApp()));
}

Future<bool> check() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return true;
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  bool isLanguage = false;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void getLanguage() async {
    String language = await SharedPref().getStringPref(SharedPref().language);
    debugPrint("language:$language");
    if (language == "ta") {
      _locale = Locale('ta', 'IN');
    } else {
      _locale = Locale('en', 'US');
    }
  }

  @override
  void initState() {
    getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: FutureBuilder(
          future: check(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (projectSnap.connectionState == ConnectionState.done) {
              debugPrint("connection : ${projectSnap.connectionState}");
              return projectSnap.data == true ?
              GetMaterialApp(
                      title: appName,
                      debugShowCheckedModeBanner: false,
                      locale: _locale,
                      supportedLocales: [
                        Locale('en', 'US'),
                        Locale('ta', 'IN'),
                      ],
                      localizationsDelegates: [
                        DemoLocalization.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      localeResolutionCallback: (locale, supportedLocales) {
                        for (var supportedLocaleLanguage in supportedLocales) {
                          if (supportedLocaleLanguage.languageCode ==
                                  locale.languageCode &&
                              supportedLocaleLanguage.countryCode ==
                                  locale.countryCode) {
                            return supportedLocaleLanguage;
                          }
                        }
                        return supportedLocales.first;
                      },
                      theme: ThemeData(),
                      home: SplashScreen(),
                      getPages: [
                        GetPage(
                            name: '/dashBoard', page: () => DashboardScreen()),
                        GetPage(name: '/homeScreen', page: () => HomeScreen()),
                        GetPage(
                            name: '/loginScreen', page: () => LoginScreen()),
                        GetPage(
                            name: '/questionnery',
                            page: () => QuestionnairesScreen()),
                        GetPage(
                            name: '/DetailScreen', page: () => DetailScreen()),
                        GetPage(
                            name: '/SearchCampaignScreen',
                            page: () => SearchCampaignScreen()),
                        GetPage(
                            name: '/CampaignListScreen',
                            page: () => CampaignListScreen()),
                        GetPage(
                            name: '/SurveyQuestionnaire',
                            page: () => SurveyQuestionnaireScreen()),
                      ],
                    )
                  : MaterialApp(
                      title: appName,
                      debugShowCheckedModeBanner: false,
                      home: NetworkErrorPage(),
                    );
            } else {
              return Text("Error ${projectSnap.error}");
            }
          }),
    );
  }
}

class NetworkErrorPage extends StatelessWidget {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgBG),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgTctLogo,
                semanticsLabel: "Logo",
                height: height / 12,
                width: width / 12,
                fit: BoxFit.contain,
                allowDrawingOutsideViewBox: true,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextWidget(
                  text: checkInternet,
                  size: 24,
                  weight: FontWeight.w600,
                  color: lightColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
