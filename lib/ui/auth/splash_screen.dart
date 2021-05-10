import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tct_demographics/constants/app_images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var height, width;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  navigationPage() async {
    await Firebase.initializeApp();

    User user = FirebaseAuth.instance.currentUser;
    debugPrint("User:$user");

    if (user != null) {
      // Navigator.pushReplacementNamed(context, "/homeScreen");
      Navigator.pushNamedAndRemoveUntil(
          context, "/dashBoard", (route) => false);
      // Get.toNamed('/homeScreen');
    } else {
      // Get.toNamed('/loginScreen');
      Navigator.pushNamedAndRemoveUntil(
          context, "/loginScreen", (route) => false);
      // Navigator.pushReplacementNamed(context, "/loginScreen");
    }
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgBG),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            svgTctLogo,
            semanticsLabel: "Logo",
            height: height / 3,
            width: width / 3,
            fit: BoxFit.contain,
            allowDrawingOutsideViewBox: true,
          ),
        ),
      ),
    );
  }
}
