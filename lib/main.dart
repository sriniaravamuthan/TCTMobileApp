import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/ui/auth/login.dart';
import 'package:tct_demographics/ui/home/detailedUser.dart';
import 'package:tct_demographics/ui/home/homescreen.dart';
import 'package:tct_demographics/ui/questionnairy/questionnaires.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

import 'localization/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  return false;
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

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges)
      ],
      child: FutureBuilder(
          future: check(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (projectSnap.connectionState == ConnectionState.done) {
              debugPrint("connection : ${projectSnap.connectionState}");
              return projectSnap.data == true
                  ? GetMaterialApp(
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
                      theme: ThemeData(
                          // This is the theme of your application.
                          //
                          // Try running your application with "flutter run". You'll see the
                          // application has a blue toolbar. Then, without quitting the app, try
                          // changing the primarySwatch below to Colors.green and then invoke
                          // "hot reload" (press "r" in the console where you ran "flutter run",
                          // or simply save your changes to "hot reload" in a Flutter IDE).
                          // Notice that the counter didn't reset back to zero; the application
                          // is not restarted.
                          //primaryColor: primaryColor,
                          //accentColor: accentColor,
                          //splashColor: primaryColor,
                          ),
                      home: AuthenticationWrapper(),
                      getPages: [
                        GetPage(name: '/homeScreen', page: () => HomeScreen()),
                        GetPage(
                            name: '/loginScreen', page: () => LoginScreen()),
                        GetPage(
                            name: '/questionnery',
                            page: () => QuestionnairesScreen()),
                        GetPage(
                            name: '/DetailScreen', page: () => DetailScreen()),
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

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider<AuthenticationService>(
//           create: (_) => AuthenticationService(FirebaseAuth.instance),
//         ),
//         StreamProvider(
//             create: (context) =>
//                 context.read<AuthenticationService>().authStateChanges)
//       ],
//       child: FutureBuilder(
//           future: check(),
//           builder: (context, projectSnap) {
//             if (projectSnap.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (projectSnap.connectionState == ConnectionState.done) {
//               debugPrint("connection : ${projectSnap.connectionState}");
//               return projectSnap.data == true
//                   ? GetMaterialApp(
//                       title: appName,
//                       debugShowCheckedModeBanner: false,
//                       theme: ThemeData(
//                           // This is the theme of your application.
//                           //
//                           // Try running your application with "flutter run". You'll see the
//                           // application has a blue toolbar. Then, without quitting the app, try
//                           // changing the primarySwatch below to Colors.green and then invoke
//                           // "hot reload" (press "r" in the console where you ran "flutter run",
//                           // or simply save your changes to "hot reload" in a Flutter IDE).
//                           // Notice that the counter didn't reset back to zero; the application
//                           // is not restarted.
//                           //primaryColor: primaryColor,
//                           //accentColor: accentColor,
//                           //splashColor: primaryColor,
//                           ),
//                       home: AuthenticationWrapper(),
//                       getPages: [
//                         GetPage(name: '/homeScreen', page: () => HomeScreen()),
//                         GetPage(
//                             name: '/loginScreen', page: () => LoginScreen()),
//                         GetPage(
//                             name: '/questionnery',
//                             page: () => QuestionnairesScreen()),
//                         GetPage(
//                             name: '/DetailScreen', page: () => DetailScreen()),
//                       ],
//                     )
//                   : MaterialApp(
//                       title: appName,
//                       debugShowCheckedModeBanner: false,
//                       home: NetworkErrorPage(),
//                     );
//             } else {
//               return Text("Error ${projectSnap.error}");
//             }
//           }),
//     );
//   }
// }

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomeScreen();
    }
    return LoginScreen();
  }
}

class NetworkErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            Container(
              child: Image.asset(imgLightLogo),
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
    );
  }
}
