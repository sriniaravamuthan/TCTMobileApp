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

class RadioButtonWidget extends StatefulWidget {
  final List<Options> fList;
  // final String radioQuestion;
  const RadioButtonWidget({Key key, this.fList})
      : super(key: key);

  @override
  _RadioButtonWidgetState createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  String radioItem;
  String _selectedRadioIndex;

  @override
  Widget build(BuildContext context) {
   return Container(
     width: MediaQuery.of(context).size.width/2,
     child: Column(
        children:
        widget.fList.map((Options data) => RadioListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: TextWidget(
            text: data.optionName,
            color: darkColor,
            size: 14,
            weight: FontWeight.w400,
          ),
          groupValue: _selectedRadioIndex,
          value:data.optionId,
          onChanged: (val) {
            setState(() {
              radioItem = data.optionName ;
              debugPrint("Radio:$radioItem");
              _selectedRadioIndex = val;
            });
          },
        )).toList(),
      ),
   );
  }
}

