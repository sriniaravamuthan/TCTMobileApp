import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      Navigator.pushNamedAndRemoveUntil(
          context, "/dashBoard", (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, "/loginScreen", (route) => false);
      // Navigator.pushReplacementNamed(context, "/loginScreen");
    }
  }
  @override
  void initState() {
    startTime();

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
            height:150,
            width:150,
            fit: BoxFit.contain,
            allowDrawingOutsideViewBox: true,
          ),
        ),
      ),
    );
  }
}
