/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tct_demographics/api/request/save_survey_request.dart';
import 'package:tct_demographics/models/widget_models/textfield_list.dart';

class TextFieldWidget extends StatefulWidget {
  final String valueText;
  final TextEditingController controller;
  final TextFieldModel object;
  Questions answer;
  List<Questions> save;

  TextFieldWidget(
      {Key key,
      this.valueText,
      this.controller,
      this.object,
      this.save,
      this.answer})
      : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    // TextEditingController controller=TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width/2,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.text,
          enableSuggestions: true,
          onChanged: (value) {
            setState(() {
              debugPrint("Text: $value");
              widget.object.name = value;
              widget.save.map((save) => save.answerName = value).toList();
              widget.answer.answerName = value.toString();
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
