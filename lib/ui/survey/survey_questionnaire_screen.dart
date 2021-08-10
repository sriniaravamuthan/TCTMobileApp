import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/api/response/survey_question_response.dart';
import 'package:tct_demographics/api/survey_questionnaire_api.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/language_item.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/services/authendication_service.dart';
import 'package:tct_demographics/util/shared_preference.dart';
import 'package:tct_demographics/widgets/checkbox_Widget.dart';
import 'package:tct_demographics/widgets/dropdown_widget.dart';
import 'package:tct_demographics/widgets/radio_widget.dart';
import 'package:tct_demographics/widgets/text_widget.dart';
import 'package:tct_demographics/widgets/textfield_widget.dart';

class SurveyQuestionnaireScreen extends StatefulWidget {
  SurveyQuestionnaireScreen({Key key}) : super(key: key);

  @override
  _SurveyQuestionnaireScreenState createState() =>
      _SurveyQuestionnaireScreenState();
}

class _SurveyQuestionnaireScreenState extends State<SurveyQuestionnaireScreen> {
  Language language;
  String dropDownLang;
  var height, width;
  String userName = "";
  String userMail = "";
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var campaignIDController = TextEditingController();
  var _controller = TextEditingController();
  List<String> listItem;
  Future apiSurveyQuestion;
  Data dataSurveyQues;

  @override
  void initState() {
    if (firebaseAuth.currentUser != null) {
      userName = firebaseAuth.currentUser.displayName;
      userMail = firebaseAuth.currentUser.email;
      debugPrint("userEmail:$userMail");
    }
    apiSurveyQuestion = getSurveyQuestionAPI();

/*     WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getJson();
    });*/

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    listItem = [];
    super.initState();
  }

  String form = json.encode({
    'title': 'Section Name:',
    'fields': [
      {
        'key': 'inputKey',
        'type': 'Input',
        'label': 'How old are you?',
        'value': '',
        'required': true
      },
      {
        'key': 'tareatext1',
        'type': 'TareaText',
        'label': 'TareaText test',
        'placeholder': "hola a todos"
      },
      {
        'key': 'radiobutton1',
        'type': 'RadioButton',
        'label': 'What is your Gender?',
        'value': 2,
        'items': [
          {
            'label': "Male",
            'value': 1,
          },
          {
            'label': "Female",
            'value': 2,
          },
        ]
      },
      {
        'key': 'checkbox1',
        'type': 'Checkbox',
        'label': 'Habits',
        'items': [
          {
            'label': "Smoking Habit",
            'value': true,
          },
          {
            'label': "Drinking Habit",
            'value': false,
          },
          {
            'label': "Tobacco Habit",
            'value': false,
          }
        ]
      },
      {
        'key': 'selectKey',
        'type': 'Select',
        'label': 'Which of your relatives has diabetes?',
        'value': 'Father',
        'items': [
          {
            'label': "Father",
            'value': "Father",
          },
          {
            'label': "Mother",
            'value': "Mother",
          },
          {
            'label': "Grand Father",
            'value': "Grand Father",
          }
        ]
      },
/*
      {
        'key':'date',
        'type':'Date',
        'label': 'Select test'
      }
*/
    ]
  });

  Map decorations = {
    'inputKey': InputDecoration(
      // labelText: "Enter your age",
      labelStyle: TextStyle(
        fontSize: 14,
      ),
      border: OutlineInputBorder(borderSide: BorderSide()),
    ),
    'selectKey': InputDecoration(
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(30.0),
        ),
      ),
    ),
  };
  dynamic response;

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
      appBar: AppBar(
        backgroundColor: lightColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed('/homeScreen');
                  },
                  child: SvgPicture.asset(
                    svgTctLogo,
                    semanticsLabel: "Logo",
                    height: 40,
                    width: 50,
                    fit: BoxFit.contain,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ],
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
                    AuthenticationService(FirebaseAuth.instance)
                        .signOut(context);
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
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return FutureBuilder<SurveyQuestionnaireResponse>(
              future: apiSurveyQuestion,
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (projectSnap.connectionState ==
                    ConnectionState.done) {
                  debugPrint("SearchCampaign Response : ${projectSnap.data}");
                  dataSurveyQues = projectSnap.data?.data;
                  return _portraitMode();
                } else {
                  return Text("Error ${projectSnap.error}");
                }
              },
            );
          } else {
            return FutureBuilder<SurveyQuestionnaireResponse>(
              future: apiSurveyQuestion,
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (projectSnap.connectionState ==
                    ConnectionState.done) {
                  debugPrint(
                      "SearchCampaign Response : ${projectSnap.data.data.campaignName}");
                  dataSurveyQues = projectSnap.data?.data;
                  return _landscapeMode();
                } else {
                  return Text("Error ${projectSnap.error}");
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget _portraitMode() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 8,
          child: Card(
            color: Theme.of(context).accentColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Campaign Name'),
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: 100,
                        child: TextWidget(
                          text: dataSurveyQues.campaignName,
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Campaign Description'),
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextWidget(
                        text: dataSurveyQues.campaignDescription,
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Objective Name'),
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextWidget(
                        text: dataSurveyQues.objectiveName,
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w400,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextWidget(
                  text:
                      DemoLocalization.of(context).translate('Respondent Name'),
                  size: 14,
                  color: darkColor,
                  weight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 4.0,
                  bottom: 4,
                ),
                child: SizedBox(
                  width: 100,
                  child: TextWidget(
                    text: dataSurveyQues.respondentName,
                    size: 14,
                    color: darkColor,
                    weight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        questionnaireList(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: OutlinedButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff005aa8)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.red)))),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: TextWidget(
                text: DemoLocalization.of(context).translate('Submit'),
                color: lightColor,
                weight: FontWeight.w400,
                size: 14,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _landscapeMode() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 8,
          child: Card(
            color: Theme.of(context).accentColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Campaign Name'),
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4,
                      ),
                      child: SizedBox(
                        width: 100,
                        child: TextWidget(
                          text: dataSurveyQues.campaignName,
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Campaign Description'),
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: SizedBox(
                          width: 100,
                          child: TextWidget(
                            text: dataSurveyQues.campaignDescription,
                            size: 14,
                            color: lightColor,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Objective Name'),
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4,
                      ),
                      child: TextWidget(
                        text: dataSurveyQues.objectiveName,
                        size: 14,
                        color: lightColor,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextWidget(
                  text:
                      DemoLocalization.of(context).translate('Respondent Name'),
                  size: 14,
                  color: darkColor,
                  weight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 4.0,
                  bottom: 4,
                ),
                child: SizedBox(
                  width: 100,
                  child: TextWidget(
                    text: dataSurveyQues.respondentName,
                    size: 14,
                    color: darkColor,
                    weight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        questionnaireList(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: OutlinedButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff005aa8)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.red)))),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: TextWidget(
                text: DemoLocalization.of(context).translate('Submit'),
                color: lightColor,
                weight: FontWeight.w400,
                size: 14,
              ),
            ),
          ),
        )
      ],
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

  questionnaireList() {
    return Expanded(
        child: SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          addAutomaticKeepAlives: false,
          itemCount: dataSurveyQues.sections.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Container(
                  margin: EdgeInsets.only(right: 6, left: 6),
                  decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 8),
                          child: TextWidget(
                            text: dataSurveyQues.sections[index].sectionName,
                            color: darkColor,
                            weight: FontWeight.w600,
                            size: 16,
                          ),
                        ),
                        itemWidget(index),
                      ]),
                ),
              ),
            ); //   key: UniqueKey(),
          }),
    ));
  }

  Widget itemWidget(int index) {
    List<Widget> list = [];
    for (var i = 0; i < dataSurveyQues.sections[index].questions.length; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: TextWidget(
            text: dataSurveyQues.sections[index].questions[i].questionName,
            color: darkColor,
            weight: FontWeight.w600,
            size: 14,
          ),
        ),
      );
      list.add(optionWidget(dataSurveyQues.sections[index].questions[i]));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);

    /*
    DropDownWidget(
    listItem: ["Father", "Mother"],
    ),
                         new JsonSchema(
                            decorations: decorations,
                            form: form,
                            onChanged: (dynamic response) {
                              this.response = response;
                              print(jsonEncode(response));
                            },
                            actionSave: (data) {
                              print(jsonEncode(data));
                            },

                          )*/
  }

  Widget optionWidget(question) {
    List<Widget> list = [];
    debugPrint("OptionType: ${question.optionType}");
    switch (question.optionType) {
      case "Text":
        list.add(TextFieldWidget());
        break;
      case "Radio":
        list.add(radioList(question));
        break;
      case "Check-box":
        list.add(checkBoxList(question));
        break;
      case "Drop-Down":
        list.add(dropDownList(question));
        break;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  Widget radioList(question) {
    List<Widget> list = [];
    // for (var i = 0; i < question.options.length; i++) {
      debugPrint("RadioList:${question.options}");
      list.add(RadioButtonWidget(fList:
       question.options
      ));
    // }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  Widget checkBoxList(question) {
    List<Widget> list = [];
      list.add(CheckboxWidget(checkList:
        question.options
      ));

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  Widget dropDownList(question) {
    List<Widget> list = [];
    // for (var i = 0; i < question.options.length; i++) {
    debugPrint("dropDownList:${question.options}");
    list.add(DropDownWidget(listItem: question.options));
    // }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }
}
