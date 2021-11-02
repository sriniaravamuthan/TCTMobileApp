import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/api/request/save_survey_request.dart'
    as SurveyRequest;
import 'package:tct_demographics/api/request/survey_questionnaire_request.dart';
import 'package:tct_demographics/api/response/survey_question_response.dart'
    as SurveyResponse;
import 'package:tct_demographics/api/save_survey_api.dart';
import 'package:tct_demographics/api/survey_questionnaire_api.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/main.dart';
import 'package:tct_demographics/models/widget_models/textfield_list.dart';
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
  String language;
  String dropDownLang;
  var height, width;
  String userName = "";
  String userMail = "";
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var campaignIDController = TextEditingController();
  var arguments;
  List<String> listItem, optionId;
  Future apiSurveyQuestion, apiSync;
  SurveyResponse.Data dataSurveyQues;
  bool isInternet = false, checkedValue = false;
  List<TextEditingController> controllers = [];
  String dropDown = "";
  TextFieldModel textFieldModel = TextFieldModel();
  List<SurveyRequest.Questions> saveQuestion = [];
  List<SurveyRequest.Options> saveOption = [];

  List<Map<String, dynamic>> sectionItems = [];
  SurveyRequest.SaveSurveyRequest saveSurveyRequest =
      SurveyRequest.SaveSurveyRequest();

  @override
  void initState() {
    listItem = [];
    optionId = [];
    saveSurveyRequest.questions = [];
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

    getLanguage();
    super.initState();
  }
  // Get selected language
  void getLanguage() async {
    language = await SharedPref().getStringPref(SharedPref().language);
    debugPrint("language:$language");

    getQuestionnaire();
  }

  // Get family id, Campaign Name, isInternet through argument
  void getQuestionnaire() {
    setState(() {
      arguments = Get.arguments;
      debugPrint("Arguments $arguments");

      debugPrint("isInternet: ${arguments[2]}");
      isInternet = arguments[2];

      if (isInternet) {
        apiSurveyQuestion = getSurveyQuestionAPI(SurveyQuestionnaireRequest(
            familyId: arguments[0],
            campaignId: arguments[1],
            languageCode: language));
      } else {
        apiSync = getOfflineSurveyQuestionAPI(SurveyQuestionnaireRequest(
            familyId: arguments[0],
            campaignId: arguments[1],
            languageCode: language));
      }
      saveSurveyRequest.campaignId = arguments[1].toString();
      saveSurveyRequest.familyId = arguments[0].toString();
      saveSurveyRequest.languageCode = language.toString();
      saveSurveyRequest.villageCode = arguments[3].toString();
    });
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
                    Get.toNamed('/dashBoard');
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
            return FutureBuilder<SurveyResponse.SurveyQuestionnaireResponse>(
              future: isInternet ? apiSurveyQuestion : apiSync,
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (projectSnap.connectionState ==
                    ConnectionState.done) {
                  debugPrint("Survey Response : ${projectSnap.data}");
                  dataSurveyQues = projectSnap.data?.data?.first;
                  saveSurveyRequest.objectiveId =
                      dataSurveyQues.objectiveId.toString();
                  return _portraitMode();
                } else {
                  return Text("Error ${projectSnap.error}");
                }
              },
            );
          } else {
            return FutureBuilder<SurveyResponse.SurveyQuestionnaireResponse>(
              future: isInternet ? apiSurveyQuestion : apiSync,
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (projectSnap.connectionState ==
                    ConnectionState.done) {
                  debugPrint(
                      "Survey Response : ${projectSnap.data.data[0].campaignName}");
                  dataSurveyQues = projectSnap.data?.data?.first;
                  saveSurveyRequest.objectiveId =
                      dataSurveyQues.objectiveId.toString();
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
        header(),
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
                  child: TextWidget(
                    text: dataSurveyQues?.respondentName,
                    size: 14,
                    color: darkColor,
                    weight: FontWeight.w400,
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
        header(),
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

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
      child: Card(
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      SurveyTextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Campaign Name'),
                        size: 14,
                        maxLines: 1,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: SurveyTextWidget(
                          text: dataSurveyQues?.campaignName,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      SurveyTextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Campaign Description'),
                        size: 14,
                        maxLines: 3,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: SurveyTextWidget(
                          text: dataSurveyQues?.campaignDescription,
                          size: 14,
                          color: lightColor,
                          maxLines: 2,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      SurveyTextWidget(
                        text: DemoLocalization.of(context)
                            .translate('Objective Name'),
                        size: 14,
                        maxLines: 1,
                        color: lightColor,
                        weight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: SurveyTextWidget(
                          text: dataSurveyQues?.objectiveName,
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
    );
  }
  // Save Questionnaire
  void mapData() {
    debugPrint("Size ${saveSurveyRequest.toJson()}");
    debugPrint("SaveLanguage:${saveSurveyRequest.languageCode}");
    debugPrint("Length ${saveSurveyRequest.toJson().length}");

    if (isInternet) {
      setSaveSurveyAPI(saveSurveyRequest, context);
    } else {
      setSaveOfflineSurveyAPI(saveSurveyRequest, context);
    }
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
              itemCount: dataSurveyQues?.sections?.length,
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
                                  dataSurveyQues?.sections[index]?.sectionName,
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
    debugPrint("Index: $index");
    // saveSurveyRequest?.sections?.insert(
    //     index,
    //     SurveyRequest.Sections(
    //       sectionId: dataSurveyQues?.sections[index]?.sectionId.toString(),
    //     )
    // );
    List<Widget> list = [];
    // saveSurveyRequest?.questions = [];

    for (var i = 0;
        i < dataSurveyQues?.sections[index]?.questions?.length;
        i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: TextWidget(
            text: dataSurveyQues?.sections[index]?.questions[i]?.questionName,
            color: darkColor,
            weight: FontWeight.w600,
            size: 14,
          ),
        ),
      );
      saveSurveyRequest?.questions?.insert(
          i,
          SurveyRequest.Questions(
            questionId: dataSurveyQues
                ?.sections[index]?.questions[i]?.questionId
                .toString(),
          ));
      for (var j = 0; j < saveSurveyRequest?.questions?.length; j++) {
        debugPrint(
            "saveSurveyRequest${saveSurveyRequest.questions[j].toJson()}");
      }
      list.add(optionWidget(
          dataSurveyQues?.sections[index]?.questions[i], index, i));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  Widget optionWidget(question, index, i) {
    List<Widget> list = [];
    saveSurveyRequest.questions[i].options = [];
    debugPrint("OptionType: ${question.responseType}");
    switch (question.responseType) {
      case "TEXTBOX":
        TextEditingController controller = TextEditingController();
        list.add(TextFieldWidget(
            controller: TextEditingController(text: ""),
            save: saveQuestion,
            object: textFieldModel,
            answer: saveSurveyRequest.questions[i]));
        controllers.add(controller); //adding the current controller to the list

        break;
      case "RADIO BUTTON":
        saveSurveyRequest.questions[i].options = [SurveyRequest.Options()];
        list.add(
            radioList(question, saveSurveyRequest.questions[i].options[0]));
        saveSurveyRequest.questions[i].answerName = "".toString();
        controllers.add(TextEditingController(text: ""));

        break;
      case "CHECKBOX":
        list.add(
            checkBoxList(question, saveSurveyRequest.questions[i].options));

        saveSurveyRequest.questions[i].answerName = "".toString();
        controllers.add(TextEditingController(text: ""));
        break;
      case "DROPDOWN":
        saveSurveyRequest.questions[i].options = [SurveyRequest.Options()];
        list.add(
            dropDownList(question, saveSurveyRequest.questions[i].options[0]));
        saveSurveyRequest.questions[i].answerName = "".toString();
        controllers.add(TextEditingController(text: ""));
        break;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  Widget radioList(question, SurveyRequest.Options option) {
    List<Widget> list = [];
    debugPrint("RadioList:${question.options}");
    list.add(RadioButtonWidget(fList: question.options, option: option));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  Widget checkBoxList(
      SurveyResponse.Questions question, List<SurveyRequest.Options> option) {
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
    }

    list.add(CheckboxWidget(checkList: options, option: option));
    debugPrint("checked:$checkedValue");

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  Widget dropDownList(question, SurveyRequest.Options option) {
    List<Widget> list = [];
    debugPrint("dropDownList:${question.options}");
    list.add(DropDownWidget(listItem: question.options, option: option));
    debugPrint("DropDown:$dropDown");
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  Widget submitButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: OutlinedButton(
            style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all<Color>(
                    Colors.white),
                backgroundColor:
                MaterialStateProperty.all<Color>(
                    Color(0xff005aa8)),
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5.0),
                        side: BorderSide(
                            color: Colors.red)))),
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: TextWidget(
              text: DemoLocalization.of(context)
                  .translate('cancel'),
              color: lightColor,
              weight: FontWeight.w400,
              size: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: OutlinedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
        )
      ],
    );
  }
}
