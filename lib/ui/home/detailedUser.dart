/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 1/4/21 3:44 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 1/4/21 3:44 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: (){

                },
                child: Row(
                  children: [
                    Icon(Icons.language, size: 24,color: darkColor,),
                    SizedBox(width: 10,),
                    Text("English",
                      style: TextStyle(fontSize: 18,color: darkColor),),
                  ],
                )
            ),
            SizedBox(width: 50,),
            InkWell(
                onTap: (){

                },
                child: Row(
                  children: [
                    Text("Senthil Kumar",
                      style: TextStyle(fontSize: 18,color: darkColor),),
                    SizedBox(width: 10,),
                    Container(
                        padding: EdgeInsets.only(left:8.0),
                        height: 30,
                        width: 30,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new AssetImage(user)
                            )
                        )
                    )
                  ],
                )
            ),

          ],
        ),

      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imgBG),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:24.0,left: 30.0,right: 30.0,bottom: 24.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Colors.black45,
                                        style: BorderStyle.solid,
                                        width: 1.0,
                                      ),
                                    ),
                                      child: Icon(Icons.keyboard_arrow_left,size: 30,)),
                                ),
                                SizedBox(width: 10,),
                                TextWidget(
                                  text: "Senthil Kumar",
                                  color: darkColor,
                                  weight:  FontWeight.w600,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:30.0),
                            child: TextWidget(
                              text: "*IN PROGRESS",
                              color: darkColor,
                              weight:  FontWeight.w600,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 1,),
                      AspectRatio(
                          aspectRatio: 24/10,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:40.0,top: 10.0,bottom: 10.0),
                                     child: TextWidget(
                                       text: location,
                                       size: 20,
                                       weight: FontWeight.w800,
                                     ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 60.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Form No",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "12345",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Door No",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Lalikuppam",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 60.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Project Code",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "12345",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Street Name",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Lalikuppam",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 60.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Village Code",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "12345",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 55,),
                                              Padding(padding: const EdgeInsets.all(8.0),),
                                              Padding(padding: const EdgeInsets.all(8.0),),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 60.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Panchayat No",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "12345",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Village Name",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Lalikuppam",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 60.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Panchayat Code",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "12345",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Contact Person",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Ramasamy",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(thickness: 2,),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:40.0,top: 10.0,bottom: 10.0),
                                      child: TextWidget(
                                        text: "Property Details".toUpperCase(),
                                        size: 20,
                                        weight: FontWeight.w800,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 30.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Status Of House",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Own House",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Vehicle Details",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Two Wheeler-1,Three Wheeler-1",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 30.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Types Of House",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Hut House",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 50,),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),

                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),

                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 30.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Toilet Facility In Home",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Yes",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 55,),
                                              Padding(padding: const EdgeInsets.all(8.0),),
                                              Padding(padding: const EdgeInsets.all(8.0),),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 30.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Wet Land In Acre",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "2",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Live Stock",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "COW-2",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 60.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Dry Land In Acre",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "1",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 85,),


                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(thickness: 2,),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:40.0,top: 10.0,bottom: 10.0),
                                      child: TextWidget(
                                        text: "Habits".toUpperCase(),
                                        size: 20,
                                        weight: FontWeight.w800,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 30.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Any members who smoke?",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "No",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 30.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Any members who Drink?",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Yes",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:30.0,right: 30.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Any members who use Tobacco?",
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "No",
                                                  size: 18,
                                                  weight: FontWeight.w800,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),

                    ],
                  ),
                ),
              )
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right:50.0,bottom: 50.0),
        child: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.edit,size: 30,),
          backgroundColor: primaryColor,
          onPressed: () {
            setState(() {

            });
          },
        ),
      ),
    );
  }
}