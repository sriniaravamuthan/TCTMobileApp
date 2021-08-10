/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:tct_demographics/api/response/survey_question_response.dart';
import 'package:tct_demographics/constants/app_colors.dart';

class DropDownWidget extends StatefulWidget {
  final List<Options> listItem;

  const DropDownWidget({Key key, this.listItem}) : super(key: key);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    String selectedValue;
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width / 2,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        autofocus: true,
        value: selectedValue,
        decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(),

            // border: OutlineInputBorder(
            //   borderSide: BorderSide.none,
            //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //   borderSide: BorderSide(color: lightGreyColor),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //   borderSide: BorderSide(color: lightGreyColor),
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //   borderSide: BorderSide(color: lightGreyColor),
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //   borderSide: BorderSide(color: lightGreyColor),
            // ),
            fillColor: lightGreyColor),
        onChanged: (newVal) {
          // controller.text = newVal;
          this.setState(() {
            selectedValue = newVal;
          });
        },
        items: widget.listItem.map((Options maps) {
          return new DropdownMenuItem(
            value: maps.optionName,
            child: new Text(maps.optionName,
                style: new TextStyle(color: Colors.black)),
          );
        }).toList(),
        // widget.listItem.map<DropdownMenuItem<String>>((String value) {
        //   return DropdownMenuItem<String>(
        //     value: value,
        //     child: TextWidget(
        //       text: value,
        //       color: darkColor,
        //       weight: FontWeight.w400,
        //       size: 14,
        //     ),
        //   );
        // }).toList(),
      ),
    );
  }
}

class DropDownList {
  String name;

  DropDownList({this.name});
}
