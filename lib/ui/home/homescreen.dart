/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 5:36 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 5:36 PM by Kanmalai.
 * /
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/models/tabledata_model.dart';
import 'package:tct_demographics/ui/dialog/alert_dialog.dart';
import 'package:tct_demographics/ui/dialog/filter_dialog.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenScreenState createState() => _HomeScreenScreenState();
}

class _HomeScreenScreenState extends State<HomeScreen> {
  CollectionReference demographydata = FirebaseFirestore.instance.collection('users');
  List<Result> users;
  @override
  void initState(){
    super.initState();
    users = Result.getUser();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                          style: TextStyle(fontSize: 18,color: darkGreyColor),),
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
          body: StreamBuilder<QuerySnapshot>(
            stream: demographydata.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              return  Container(
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
                                child: TextWidget(
                                  text: totalRecords + "(360)",
                                  color: darkColor,
                                  weight:  FontWeight.w500,
                                  size: 24,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: (){

                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Colors.black45,
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.search),
                                              SizedBox(width: 10,),
                                              TextWidget(
                                                text: search,
                                                color: darkColor,
                                                weight:  FontWeight.w800,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 30,),
                                    InkWell(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return FilterDialog();
                                            });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Colors.black45,
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.filter_list_sharp),
                                              SizedBox(width: 10,),
                                              TextWidget(
                                                text: filter,
                                                color: darkColor,
                                                weight:  FontWeight.w800,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 30,),
                                    InkWell(
                                      onTap: (){
                                        Get.toNamed('/questionnery');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Colors.black45,
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.add),
                                              SizedBox(width: 10,),
                                              TextWidget(
                                                text: addNew,
                                                color: darkColor,
                                                weight:  FontWeight.w800,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 1,),
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: AspectRatio(
                                aspectRatio: 24/10,
                                child: DataTable(
                                  showCheckboxColumn: false,
                                  columns: [
                                    DataColumn(label: TextWidget(text: familyHead,color: darkColor,size: 16,weight: FontWeight.w700,)),
                                    DataColumn(label: TextWidget(text: age,color: darkColor,size: 16,weight: FontWeight.w700,),numeric: true),
                                    DataColumn(label: TextWidget(text: mobile,color: darkColor,size: 16,weight: FontWeight.w700,),numeric: true),
                                    DataColumn(label: TextWidget(text: villageCode.toUpperCase(),color: darkColor,size: 16,weight: FontWeight.w700,),numeric: true),
                                    DataColumn(label: TextWidget(text: zone.toUpperCase(),color: darkColor,size: 16,weight: FontWeight.w700,),numeric: true),
                                    DataColumn(label: TextWidget(text: status,color: darkColor,size: 16,weight: FontWeight.w700,)),
                                    DataColumn(label: TextWidget(text: action,color: darkColor,size: 16,weight: FontWeight.w700,)),

                                  ],
                                  rows: users.map((usersItem) =>
                                      DataRow(
                                          onSelectChanged: (bool selected) {
                                            if (selected) {
                                              Get.toNamed('/DetailScreen');
                                              debugPrint("${usersItem.familyHead}");
                                            }
                                          },
                                          cells: [
                                            DataCell(
                                                Row(
                                                  children: [
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
                                                    ),
                                                    SizedBox(width: 10,),
                                                    SizedBox(
                                                        width:150,child: TextWidget(text: usersItem.familyHead,color: darkGreyColor,size: 16,weight: FontWeight.w600,))
                                                  ],
                                                )
                                            ),
                                            DataCell(TextWidget(text: usersItem.age,color: darkGreyColor,size: 16,weight: FontWeight.w600,)),
                                            DataCell(TextWidget(text: usersItem.mobile,color: darkGreyColor,size: 16,weight: FontWeight.w600,)),
                                            DataCell(TextWidget(text: usersItem.villageCode,color: darkGreyColor,size: 16,weight: FontWeight.w600,)),
                                            DataCell(TextWidget(text: usersItem.zone,color: darkGreyColor,size: 16,weight: FontWeight.w600,)),
                                            DataCell(TextWidget(text: usersItem.status,color: darkGreyColor,size: 16,weight: FontWeight.w600,)),
                                            DataCell(
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        Get.toNamed('/questionnery');
                                                      },
                                                      child: Icon(Icons.edit),
                                                    ),
                                                    SizedBox(width: 20,),
                                                    InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return  AlertDialogWidget();

                                                              });
                                                          debugPrint("click");
                                                        });
                                                      },
                                                      child: Icon(Icons.delete),
                                                    )
                                                  ],
                                                )
                                            ),
                                          ]
                                      )
                                  ).toList(),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top:38.0),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    // decoration: BoxDecoration(
                    //   borderRadius:
                    //   BorderRadius.all(Radius.circular(50.0),),
                    // ),
                      child: Image.asset(imgLightLogo)),
                )
            ),
          ),
        )
      ],
    );
  }
}
void AlertDialoge(){

}

