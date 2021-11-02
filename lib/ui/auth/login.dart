import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode mailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String userMail, userPassword;
  var height, width;
  String selectedRadioTile = "English";
  int selectedRadio;
  setSelectedRadioTile(String val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  void initState() {
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
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
            backgroundColor: errorColor,
            elevation: 6,
            content: TextWidget(
              text: 'Tap back again to Exit',
              color: lightColor,
              weight: FontWeight.w600,
              size: 16,
            )),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imgBG),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                  top: (height) * 0.05,
                  left: (width) * 0.22,
                  right: (width) * 0.22,
                  bottom: (height) * 0.05),
              child: Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            height: 70,
                            width: 70,
                            child: SvgPicture.asset(
                              svgTctLogo,
                              semanticsLabel: "Logo",
                              height: height / 12,
                              width: width / 12,
                              fit: BoxFit.contain,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextWidget(
                                  text: userName,
                                  color: darkGreyColor,
                                  size: 14,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                width: width / 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    maxLength: 50,
                                    focusNode: mailFocusNode,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: lightGreyColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: lightGreyColor),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: lightGreyColor),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: lightGreyColor),
                                        ),
                                        fillColor: lightGreyColor),
                                    onSaved: (String val) {
                                      setState(() {
                                        userMail = val;
                                        debugPrint("userMail $userMail");
                                      });
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter a Email!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextWidget(
                                  text: password,
                                  color: darkGreyColor,
                                  size: 14,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                width: width / 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    maxLength: 16,
                                    obscureText: true,
                                    focusNode: passwordFocusNode,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: lightGreyColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: lightGreyColor),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: lightGreyColor),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: lightGreyColor),
                                        ),
                                        fillColor: lightGreyColor),
                                    onSaved: (String val) {
                                      setState(() {
                                        userPassword = val;
                                        debugPrint(
                                            "userPassword $userPassword");
                                      });
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter a  Password!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40.0)),
                                  elevation: 8.0,
                                  color: primaryColor,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (_formKey.currentState.validate()) {
                                          if (_formKey != null) {
                                            _formKey.currentState.save();
                                            context
                                                .read<AuthenticationService>()
                                                .signIn(
                                                    email: userMail.trim(),
                                                    password:
                                                        userPassword.trim());
                                            _changeLanguage(selectedRadioTile);
                                          }
                                        }
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 50,
                                      color: lightColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  //Change App language
  void _changeLanguage(String selectedRadioTile) async {
    setState(() {
      MyApp.setLocale(context, Locale('en', 'US'));
      SharedPref().setStringPref(SharedPref().language, 'en');
    });
  }
}
