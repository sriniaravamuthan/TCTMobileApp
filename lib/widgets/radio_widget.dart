/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class RadioButtonWidget extends StatefulWidget {
  // final String radioQuestion,item1Value,item2Value,itemText1,itemText2;
  final List<RadioList> fList;
  // final String radioQuestion;
  const RadioButtonWidget({Key key, this.fList})
      : super(key: key);

  @override
  _RadioButtonWidgetState createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  String radioItem;
  int id = 1;
  @override
  Widget build(BuildContext context) {
   return Column(
      children:
      widget.fList.map((data) => RadioListTile(
        title: Text("${data.name}"),
        groupValue: id,
        value: data.index,
        onChanged: (val) {
          setState(() {
            radioItem = data.name ;
            debugPrint("Radio:$radioItem");
            id = data.index;
          });
        },
      )).toList(),
    );
    // return Padding(
    //     padding: EdgeInsets.all(4),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         TextWidget(text: widget.radioQuestion,size: 14,weight: FontWeight.w400,color: darkColor,),
    //         ListTile(
    //           leading: Radio(
    //             value: widget.item1Value,
    //             groupValue: radioItem,
    //             onChanged: (value) {
    //               setState(() {
    //                radioItem = value;
    //               });
    //             },
    //           ),
    //           title:TextWidget(text: widget.item1Value,size: 14,weight: FontWeight.w400,color: darkColor,),
    //         ),
    //         ListTile(
    //           leading: Radio(
    //             value: widget.item2Value,
    //             groupValue: radioItem,
    //             onChanged: (value) {
    //               setState(() {
    //                 radioItem = value;
    //               });
    //             },
    //           ),
    //           title:TextWidget(text: widget.itemText2,size: 14,weight: FontWeight.w400,color: darkColor,),
    //         ),
    //         SizedBox(height: 25),
    //       ],
    //     )
    // );
  }
}

class RadioList {
  String name;
  int index;
  RadioList({this.name, this.index});
}
