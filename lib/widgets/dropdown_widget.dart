/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:tct_demographics/api/response/survey_question_response.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class DropDownWidget extends StatefulWidget {
  final List<Options> listItem;
  final StringCallback callback;

  const DropDownWidget({Key key, this.listItem, this.callback}) : super(key: key);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    String selectedValue;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          autofocus: false,
          value: selectedValue,
          decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(),
              fillColor: lightGreyColor),
          onChanged: (newVal) {
            // controller.text = newVal;
            this.setState(() {
              selectedValue = newVal;
              widget.callback(newVal);

            });
          },
          items: widget.listItem.map((Options maps) {
            return new DropdownMenuItem(
              value: maps.optionName,
              child: TextWidget(
                text: maps.optionName,
                color: darkColor,
                size: 14,
                weight: FontWeight.w400,
              ),
            );
          }).toList(),

        ),
      ),
    );
  }
}
