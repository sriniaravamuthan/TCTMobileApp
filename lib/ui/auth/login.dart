import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/widgets/button_widget.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode mailFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top:120.0,left:200.0,right: 200.0,bottom: 120.0),
            child: Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: AspectRatio(
                aspectRatio: 12/14,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                            height: 150,
                            width: 150,
                            child: Image.asset(imgLightLogo)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: userName,
                                color: darkGreyColor,
                                size: 18,
                                weight: FontWeight.w600,
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                focusNode: mailFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  counterText: "",

                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.only(topRight :Radius.circular(50.0),
                                        bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.only(topRight :Radius.circular(50.0),
                                        bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                    borderSide: BorderSide(color: lightGreyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.only(topRight :Radius.circular(10.0),
                                        bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                    borderSide: BorderSide(color: lightGreyColor),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.only(topRight :Radius.circular(10.0),
                                        bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                    borderSide: BorderSide(color: lightGreyColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.only(topRight :Radius.circular(10.0),
                                        bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                    borderSide: BorderSide(color: lightGreyColor),
                                  ),
                                ),
                                onSaved: (String val) {
                                  setState(() {

                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter a  mobile or email!';
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
                              SizedBox(height: 20,),
                              TextWidget(
                                text: password,
                                color: darkGreyColor,
                                size: 18,
                                weight: FontWeight.w600,
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                focusNode: mailFocusNode,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  counterText: "",
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.only(topRight :Radius.circular(50.0),
                                        bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.only(topRight :Radius.circular(50.0),
                                        bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                    borderSide: BorderSide(color: lightGreyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.only(topRight :Radius.circular(10.0),
                                        bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                    borderSide: BorderSide(color: lightGreyColor),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.only(topRight :Radius.circular(10.0),
                                        bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                    borderSide: BorderSide(color: lightGreyColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.only(topRight :Radius.circular(10.0),
                                        bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0) ),
                                    borderSide: BorderSide(color: lightGreyColor),
                                  ),
                                ),
                                onSaved: (String val) {
                                  setState(() {

                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter a  mobile or email!';
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
                              SizedBox(height: 20,),
                              Align(
                                alignment:Alignment.center,
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0)),
                                  elevation: 8.0,
                                  color: primaryColor,
                                  child: InkWell(
                                    onTap: () {

                                    },
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 60,
                                      color: lightColor,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      )
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
}
