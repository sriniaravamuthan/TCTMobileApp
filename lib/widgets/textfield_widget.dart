/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
final String valueText;
final TextEditingController controller;
final List<TextFieldList> textList;


  const TextFieldWidget({Key key, this.valueText, this.controller, this.textList})
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
              widget.controller.text.toString();
            });
          },
          // onSaved: (value) {
          //   setState(() {
          //     debugPrint("Text: $value");
          //     widget.controller.text = value;
          //   });
          // },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
class TextFieldList {
  String name;
  int index;
  TextFieldList({this.name, this.index});
}