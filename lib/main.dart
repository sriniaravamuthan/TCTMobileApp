import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/app_strings.dart';
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

    return GetMaterialApp(
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
      home: DetailScreen(),
      getPages: [
        GetPage(name: '/homeScreen', page: () => HomeScreen()),
        GetPage(name: '/loginScreen', page: () => LoginScreen()),
        GetPage(name: '/questionnery', page: () => QuestionnairesScreen()),
        GetPage(name: '/DetailScreen', page: () => DetailScreen()),
      ],
    );
  }
}

