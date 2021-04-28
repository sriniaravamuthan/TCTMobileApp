import 'package:flutter/material.dart';
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
  int _radioValue = 0;
  String selectedRadioTile = "English";
  int selectedRadio;
  setSelectedRadioTile(String val) {
    setState(() {
      selectedRadioTile = val;
    });
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
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
                top: (height) * 0.05,
                left: (width) * 0.30,
                right: (width) * 0.30,
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
                              height: 76,
                              width: width / 2,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  maxLength: 50,
                                  focusNode: mailFocusNode,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
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
                                    // else if(value.isNotEmpty){
                                    //     Pattern pattern =
                                    //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    //     RegExp regex = new RegExp(pattern);
                                    //     if(!regex.hasMatch(value)){
                                    //       return 'Enter a valid mail!';
                                    //     }
                                    // }
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
                              height: 76,
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
                                      debugPrint("userPassword $userPassword");
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter a  Password!';
                                    }
                                    // else if(value.isNotEmpty){
                                    //     Pattern pattern =
                                    //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    //     RegExp regex = new RegExp(pattern);
                                    //     if(!regex.hasMatch(value)){
                                    //       return 'Enter a valid mail!';
                                    //     }
                                    // }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextWidget(
                                    text: "Select Your Language",
                                    color: darkGreyColor,
                                    size: 14,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor:
                                              Color(0xff005aa8),
                                        ),
                                        child: RadioListTile(
                                          value: "தமிழ்",
                                          groupValue: selectedRadioTile,
                                          title: Text(
                                            "தமிழ்",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: primaryColor),
                                          ),
                                          onChanged: (val) {
                                            print("Radio Tile pressed $val");
                                            setSelectedRadioTile(val);
                                            print(
                                                "radio value: $selectedRadioTile");
                                          },
                                          activeColor: Color(0xff005aa8),
                                          selected: true,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor:
                                              Color(0xff005aa8),
                                        ),
                                        child: RadioListTile(
                                          value: "English",
                                          groupValue: selectedRadioTile,
                                          title: Text(
                                            "English",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: primaryColor),
                                          ),
                                          onChanged: (val) {
                                            print("Radio Tile pressed $val");
                                            setSelectedRadioTile(val);
                                            print(
                                                "radio value: $selectedRadioTile");
                                          },
                                          activeColor: Color(0xff005aa8),
                                          selected: false,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0)),
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
    );
  }

  void _changeLanguage(String selectedRadioTile) async {
    // Locale _temp = await setLocale(language.languageCode);
    // SplashScreen.setLocale(context, _temp);

    if (selectedRadioTile == "தமிழ்") {
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
