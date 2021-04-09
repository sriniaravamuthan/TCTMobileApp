import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/ui/auth/login.dart';
import 'package:tct_demographics/ui/home/detailedUser.dart';
import 'package:tct_demographics/ui/home/homescreen.dart';
import 'package:tct_demographics/ui/questionnairy/questionnaires.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
      child: FutureBuilder(
          future: check(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }else if (projectSnap.connectionState == ConnectionState.done){
              return  projectSnap.data == true
                  ? GetMaterialApp(
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
              ):Material(
                child: Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imgBG),
                            fit: BoxFit.cover)),
                    child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  child: Image.asset(
                                    imgLightLogo,
                                    fit: BoxFit.cover,
                                    width: 220,
                                    height: 220,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextWidget(
                                    text: checkInternet,
                                    size: 18,

                                    weight: FontWeight.w700),
                              )
                            ]))),
              );
            } else{
              return Text("Error ${projectSnap.error}");
            }
          }
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


