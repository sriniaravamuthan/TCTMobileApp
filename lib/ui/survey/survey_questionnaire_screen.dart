import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/api/request/survey_questionnaire_request.dart';
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
import 'package:tct_demographics/widgets/survey_text_widget.dart';
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
  bool checkSelect=false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var campaignIDController = TextEditingController();
  var arguments;
  List<String> listItem;
  Future apiSurveyQuestion, apiSync;
  Data dataSurveyQues;
  bool isInternet;
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    if (firebaseAuth.currentUser != null) {
      userName = firebaseAuth.currentUser.displayName;
      userMail = firebaseAuth.currentUser.email;
      debugPrint("userEmail:$userMail");
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    listItem = [];
    arguments = Get.arguments;
    debugPrint("Arguments $arguments");
    super.initState();
    debugPrint("isInternet: ${arguments[2]}");
    isInternet = arguments[2];
    if (isInternet) {
      apiSurveyQuestion = getSurveyQuestionAPI(SurveyQuestionnaireRequest(
          familyId: arguments[0],
          campaignId: arguments[1],
          languageCode: "ta"));
    } else {
      apiSync = getOfflineSurveyQuestionAPI(SurveyQuestionnaireRequest(
          familyId: arguments[0],
          campaignId: arguments[1],
          languageCode: "ta"));
    }
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    controllers.clear();

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
              future: isInternet ? apiSurveyQuestion : apiSync,
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
              future: isInternet ? apiSurveyQuestion : apiSync,
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
    debugPrint("dataSurveyQues campaignName:${dataSurveyQues?.campaignName}");
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Theme.of(context).accentColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Flexible(
                        flex: 3,
                        child: SurveyTextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Campaign Name'),
                          size: 14,
                          maxLines: 1,
                          color: lightColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: SurveyTextWidget(
                          text: dataSurveyQues?.campaignName,
                          size: 14,
                          color: lightColor,
                          maxLines: 2,
                          weight: FontWeight.w400,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: SurveyTextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Campaign Description'),
                          size: 14,
                          maxLines: 1,
                          color: lightColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: SurveyTextWidget(
                          text: dataSurveyQues?.campaignDescription,
                          size: 14,
                          color: lightColor,
                          maxLines: 3,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8,top:4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: SurveyTextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Objective Name'),
                          size: 14,
                          maxLines: 1,
                          color: lightColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: SurveyTextWidget(
                          text: dataSurveyQues.objectiveName,
                          size: 14,
                          color: lightColor,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextWidget(
                    text: DemoLocalization.of(context)
                        .translate('Respondent Name'),
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
        ),
        questionnaireList(),
        submitButton(),
      ],
    );
  }

  Widget _landscapeMode() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Theme.of(context).accentColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 3,
                          child: SurveyTextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Campaign Name'),
                            size: 14,
                            maxLines: 1,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SurveyTextWidget(
                            text: dataSurveyQues?.campaignName,
                            size: 14,
                            color: lightColor,
                            maxLines: 2,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: SurveyTextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Campaign Description'),
                            size: 14,
                            maxLines: 1,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: SurveyTextWidget(
                            text: dataSurveyQues?.campaignDescription,
                            size: 14,
                            color: lightColor,
                            maxLines: 3,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: SurveyTextWidget(
                            text: DemoLocalization.of(context)
                                .translate('Objective Name'),
                            size: 14,
                            maxLines: 1,
                            color: lightColor,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SurveyTextWidget(
                            text: dataSurveyQues.objectiveName,
                            size: 14,
                            maxLines: 2,
                            color: lightColor,
                            weight: FontWeight.w400,
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
        Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextWidget(
                    text: DemoLocalization.of(context)
                        .translate('Respondent Name'),
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
        ),
        questionnaireList(),
        submitButton(),
      ],
    );
  }

  void mapData() {
    List<Map<String, dynamic>> sectionItems = [];
    dataSurveyQues.sections.forEach((section) {
      Map<String, dynamic> sections = Map();
      sections['sectionId'] = section.sectionId;
      List<Map<String, dynamic>> questionItems = [];
      for (int i = 0; i < section.questions.length; i++) {
        Map<String, dynamic> questions = Map();
        questions['questionId'] = section.questions[i].questionId;
        switch (section.questions[i].optionType) {
          case 'Text':
            questions['answerName'] = controllers[i].text.toString();
            break;
          default:
            questions['answerName'] = "";
            break;
        }
        List<Map<String, dynamic>> optionItems = [];
        section.questions[i].options.forEach((option) {
          Map<String, dynamic> options = Map();
          options['optionId'] = "OptionID";
          optionItems.add(options);
        });
        questions['options'] = optionItems;
        questionItems.add(questions);
      }
      sections['questions'] = questionItems;
      sectionItems.add(sections);
    });
    debugPrint("Survey Result ${sectionItems.asMap().toString()}");
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
        flex: 8,
        child: SingleChildScrollView(
          child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              addAutomaticKeepAlives: false,
              itemCount: dataSurveyQues.sections.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
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
                            TextWidget(
                              text:
                                  dataSurveyQues.sections[index].sectionName,
                              color: darkColor,
                              weight: FontWeight.w600,
                              size: 16,
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
  }

  Widget optionWidget(question) {
    TextEditingController controller = TextEditingController();
    controllers.add(controller); //adding the current controller to the list

    for (int i = 0; i < controllers.length; i++) {
      print(
          controllers[i].text); //printing the values to show that it's working
    }
    List<Widget> list = [];
    debugPrint("OptionType: ${question.optionType}");
    switch (question.optionType) {
      case "Text":
        list = List.from(list)
          ..add(TextFieldWidget(
            controller: controller,
          ));
        // list.add(TextFieldWidget(controller: _controller,));
        break;
      case "Radio":
        list.add(radioList(question));
        controllers.add(TextEditingController(text: ""));
        break;
      case "Check-box":
        list.add(checkBoxList(question));
        controllers.add(TextEditingController(text: ""));
        break;
      case "Drop-Down":
        list.add(dropDownList(question));
        controllers.add(TextEditingController(text: ""));
        break;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  Widget radioList(question) {
    List<Widget> list = [];
    // for (var i = 0; i < question.options.length; i++) {
    debugPrint("RadioList:${question.options}");
    list.add(RadioButtonWidget(fList: question.options));
    // }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  Widget checkBoxList(Questions question) {
    List<Widget> list = [];
    // debugPrint("checkbox:${question.options[i].optionName}");
    List<dynamic> options = [];
    for (int i = 0; i < question.options.length; i++) {
      debugPrint("Old Options ${question.options[i].toJson()}");

      Map<String, dynamic> option = {
        'optionId': question.options[i].optionId,
        'optionName': question.options[i].optionName,
        'optionCheck': false,
      };
      options.add(option);
      debugPrint("New Options ${options[i]}");
    }

    list.add(CheckboxWidget(checkList: options,selectedValue: checkSelect,));
    debugPrint("CheckBox:$checkSelect");

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

 Widget submitButton() {
  return Align(
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
           mapData();
         },
         child: TextWidget(
           text: DemoLocalization.of(context).translate('Submit'),
           color: lightColor,
           weight: FontWeight.w400,
           size: 14,
         ),
       ),
     ),
   );
 }
}
