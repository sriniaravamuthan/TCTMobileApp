import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/ui/auth/login.dart';
import 'package:tct_demographics/ui/home/detailedUser.dart';
import 'package:tct_demographics/ui/home/homescreen.dart';
import 'package:tct_demographics/ui/questionnairy/questionnaires.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),

        ),
        StreamProvider(
            create: (context)=> context.read<AuthenticationService>().authStateChanges
        )
      ],
      child: GetMaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
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
          GetPage(name: '/loginScreen', page: () => LoginScreen()),
          GetPage(name: '/questionnery', page: () => QuestionnairesScreen()),
          GetPage(name: '/DetailScreen', page: () => DetailScreen()),
        ],
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if(firebaseUser != null){
      return HomeScreen();
    }
    return LoginScreen();
  }
}


