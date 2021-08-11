/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tct_demographics/api/response/survey_question_response.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class CheckboxWidget extends StatefulWidget {
  final List<Options> checkList;

  const CheckboxWidget({Key key, this.checkList})
      : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked=false;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller=TextEditingController();
    return Column(
        children: widget.checkList.map((Options options) {
          return CheckboxListTile(
              value: isChecked,
              title:TextWidget(
                text: options.optionName,
                color: darkColor,
                size: 14,
                weight: FontWeight.w400,
              ),
              onChanged: (newValue) {
                setState(() {
                  isChecked= newValue;
                });
              });
        }).toList());
  }
}
class CheckboxList {
  String name;
  int index;
  bool isChecked;
  CheckboxList({this.name, this.index,this.isChecked});
}